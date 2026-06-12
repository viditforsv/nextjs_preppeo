import { createSupabaseApiClient } from '@/lib/supabase/api-client';

/**
 * Server-side mock access gate.
 *
 * Returns true when `userId` holds a valid token that grants access to the
 * given (examType, setNumber): a free token they own, or a paid token they
 * purchased (`owner_id`) or redeemed (`used_by`). The token must be active and,
 * if it carries an expiry, not yet expired.
 *
 * This is the authoritative check — the AccessCodeModal / verify-token call in
 * the browser is only UX. Content-serving and attempt-recording routes must
 * call this before doing anything with a set.
 */
export async function userHasMockAccess(
  userId: string,
  examType: string,
  setNumber: number
): Promise<boolean> {
  if (!userId) return false;

  const supabase = createSupabaseApiClient();

  const { data, error } = await supabase
    .from('test_tokens')
    .select('id, expires_at, owner_id, used_by')
    .eq('exam_type', examType)
    .eq('set_number', setNumber)
    .eq('is_active', true)
    .or(`owner_id.eq.${userId},used_by.eq.${userId}`)
    .limit(50);

  if (error || !data || data.length === 0) return false;

  const now = Date.now();
  return (data as Array<{ expires_at: string | null }>).some(
    (t) => !t.expires_at || new Date(t.expires_at).getTime() >= now
  );
}
