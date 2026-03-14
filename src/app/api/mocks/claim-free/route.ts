import { NextRequest, NextResponse } from 'next/server';
import { createClient } from '@/lib/supabase/server';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';
import { generateTokenCode } from '@/lib/tokens/generate';

/**
 * POST /api/mocks/claim-free
 * Body: { examType, referralCode? }
 * Generates and assigns a free token for Set 1 to the authenticated user.
 * If a valid referralCode is provided, awards bonus tokens to both parties.
 * Idempotent — returns existing token if already claimed.
 */
export async function POST(request: NextRequest) {
  try {
    const authClient = await createClient();
    const { data: { user } } = await authClient.auth.getUser();
    if (!user) {
      return NextResponse.json({ error: 'Authentication required' }, { status: 401 });
    }

    const { examType, referralCode } = await request.json();
    if (!examType || typeof examType !== 'string') {
      return NextResponse.json({ error: 'examType is required' }, { status: 400 });
    }

    const supabase = createSupabaseApiClient();

    // Check if user already has a free token for this exam
    const { data: existing } = await supabase
      .from('test_tokens')
      .select('id, code, set_number')
      .eq('exam_type', examType)
      .eq('is_free', true)
      .eq('owner_id', user.id)
      .limit(1)
      .maybeSingle();

    if (existing) {
      return NextResponse.json({
        success: true,
        alreadyClaimed: true,
        code: existing.code,
        setNumber: existing.set_number,
      });
    }

    // Verify exam type exists
    const { data: exam } = await supabase
      .from('exam_types')
      .select('id')
      .eq('id', examType)
      .eq('is_active', true)
      .single();

    if (!exam) {
      return NextResponse.json({ error: 'Invalid or inactive exam type' }, { status: 400 });
    }

    // Generate a personal free token for Set 1
    const code = generateTokenCode(examType);
    const { data: freeToken, error: insertError } = await supabase
      .from('test_tokens')
      .insert({
        code,
        exam_type: examType,
        set_number: 1,
        is_free: true,
        owner_id: user.id,
        is_active: true,
      })
      .select('id')
      .single();

    if (insertError || !freeToken) {
      console.error('Failed to create free token:', insertError);
      return NextResponse.json({ error: 'Failed to generate token' }, { status: 500 });
    }

    // Handle referral bonus
    let bonusAwarded = false;
    if (referralCode && typeof referralCode === 'string') {
      try {
        bonusAwarded = await processReferralBonus(
          supabase, user.id, referralCode.trim().toUpperCase(), examType
        );
      } catch (err) {
        console.error('Referral bonus processing failed (non-blocking):', err);
      }
    }

    return NextResponse.json({
      success: true,
      alreadyClaimed: false,
      code,
      setNumber: 1,
      bonusAwarded,
    });
  } catch (error) {
    console.error('Error in POST /api/mocks/claim-free:', error);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}

async function processReferralBonus(
  supabase: ReturnType<typeof createSupabaseApiClient>,
  friendId: string,
  referralCode: string,
  examType: string,
): Promise<boolean> {
  const { data: referrer } = await supabase
    .from('profiles')
    .select('id')
    .eq('referral_code', referralCode)
    .single();

  if (!referrer) return false;
  if (referrer.id === friendId) return false;

  const { data: existingReferral } = await supabase
    .from('student_referrals')
    .select('id')
    .eq('referrer_id', referrer.id)
    .eq('referred_id', friendId)
    .maybeSingle();

  if (existingReferral) return false;

  // Friend's bonus is awarded first and unconditionally.
  // If the referrer's account is deleted between lookup and insert,
  // the friend still gets their bonus token.
  const friendBonusSet = await findNextAvailableSet(supabase, friendId, examType, 2);
  const friendBonusCode = generateTokenCode(examType);
  const { data: friendToken } = await supabase
    .from('test_tokens')
    .insert({
      code: friendBonusCode,
      exam_type: examType,
      set_number: friendBonusSet,
      is_free: true,
      owner_id: friendId,
      is_active: true,
    })
    .select('id')
    .single();

  // Referrer bonus — best-effort; failure does not revoke friend's bonus
  let referrerTokenId: string | null = null;
  try {
    const referrerBonusSet = await findNextAvailableSet(supabase, referrer.id, examType, 2);
    const referrerBonusCode = generateTokenCode(examType);
    const { data: referrerToken } = await supabase
      .from('test_tokens')
      .insert({
        code: referrerBonusCode,
        exam_type: examType,
        set_number: referrerBonusSet,
        is_free: true,
        owner_id: referrer.id,
        is_active: true,
      })
      .select('id')
      .single();
    referrerTokenId = referrerToken?.id ?? null;
  } catch (err) {
    console.error('Referrer bonus token failed (friend still gets theirs):', err);
  }

  await supabase.from('student_referrals').insert({
    referrer_id: referrer.id,
    referred_id: friendId,
    referrer_token_id: referrerTokenId,
    referred_token_id: friendToken?.id ?? null,
  });

  return true;
}

async function findNextAvailableSet(
  supabase: ReturnType<typeof createSupabaseApiClient>,
  userId: string,
  examType: string,
  startFrom: number,
): Promise<number> {
  const { data: owned } = await supabase
    .from('test_tokens')
    .select('set_number')
    .eq('owner_id', userId)
    .eq('exam_type', examType);

  const usedSets = new Set((owned ?? []).map((t) => t.set_number));
  let set = startFrom;
  while (usedSets.has(set)) set++;
  return set;
}
