/**
 * Admin CRUD for promo coupons.
 *   GET   — list all coupons with live redemption counts.
 *   POST  — create a coupon { code, discount_percent, max_redemptions, description?, expires_at? }.
 *   PATCH — toggle is_active { id, is_active }.
 */
import { NextRequest, NextResponse } from 'next/server';
import { createClient } from '@/lib/supabase/server';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';

async function requireAdmin() {
  const authClient = await createClient();
  const { data: { user } } = await authClient.auth.getUser();
  if (!user) return null;

  const supabase = createSupabaseApiClient();
  const { data: profile } = await supabase
    .from('profiles')
    .select('role')
    .eq('id', user.id)
    .single();

  if (profile?.role !== 'admin') return null;
  return user;
}

export async function GET() {
  const admin = await requireAdmin();
  if (!admin) return NextResponse.json({ error: 'Admin access required' }, { status: 403 });

  const supabase = createSupabaseApiClient();
  const { data, error } = await supabase
    .from('coupons')
    .select('id, code, description, discount_percent, max_redemptions, redeemed_count, is_active, is_public, terms, expires_at, created_at')
    .order('created_at', { ascending: false });

  if (error) return NextResponse.json({ error: error.message }, { status: 500 });
  return NextResponse.json({ data: data ?? [] });
}

export async function POST(request: NextRequest) {
  const admin = await requireAdmin();
  if (!admin) return NextResponse.json({ error: 'Admin access required' }, { status: 403 });

  let body: {
    code?: string;
    description?: string;
    terms?: string;
    discount_percent?: number;
    max_redemptions?: number;
    expires_at?: string | null;
    is_public?: boolean;
  };
  try {
    body = await request.json();
  } catch {
    return NextResponse.json({ error: 'Invalid request body' }, { status: 400 });
  }

  const code = (body.code ?? '').trim().toUpperCase();
  const discount = Number(body.discount_percent);
  const maxRedemptions = Number(body.max_redemptions);

  if (!code || !/^[A-Z0-9_-]{3,40}$/.test(code)) {
    return NextResponse.json({ error: 'Code must be 3–40 chars: A–Z, 0–9, - or _' }, { status: 400 });
  }
  if (!Number.isFinite(discount) || discount <= 0 || discount > 100) {
    return NextResponse.json({ error: 'Discount must be between 1 and 100%' }, { status: 400 });
  }
  if (!Number.isInteger(maxRedemptions) || maxRedemptions <= 0) {
    return NextResponse.json({ error: 'Max redemptions must be a positive whole number' }, { status: 400 });
  }

  const supabase = createSupabaseApiClient();
  const { data, error } = await supabase
    .from('coupons')
    .insert({
      code,
      description: body.description?.trim() || null,
      terms: body.terms?.trim() || null,
      discount_percent: discount,
      max_redemptions: maxRedemptions,
      expires_at: body.expires_at || null,
      is_public: body.is_public === true,
    })
    .select('id, code, description, discount_percent, max_redemptions, redeemed_count, is_active, is_public, terms, expires_at, created_at')
    .single();

  if (error) {
    const conflict = error.code === '23505';
    return NextResponse.json(
      { error: conflict ? 'A coupon with that code already exists' : error.message },
      { status: conflict ? 409 : 500 },
    );
  }
  return NextResponse.json({ data });
}

export async function PATCH(request: NextRequest) {
  const admin = await requireAdmin();
  if (!admin) return NextResponse.json({ error: 'Admin access required' }, { status: 403 });

  let body: { id?: string; is_active?: boolean; is_public?: boolean; terms?: string };
  try {
    body = await request.json();
  } catch {
    return NextResponse.json({ error: 'Invalid request body' }, { status: 400 });
  }

  if (!body.id) {
    return NextResponse.json({ error: 'id is required' }, { status: 400 });
  }

  const update: Record<string, unknown> = {};
  if (typeof body.is_active === 'boolean') update.is_active = body.is_active;
  if (typeof body.is_public === 'boolean') update.is_public = body.is_public;
  if (typeof body.terms === 'string') update.terms = body.terms.trim() || null;

  if (Object.keys(update).length === 0) {
    return NextResponse.json({ error: 'Nothing to update' }, { status: 400 });
  }

  const supabase = createSupabaseApiClient();
  const { data, error } = await supabase
    .from('coupons')
    .update(update)
    .eq('id', body.id)
    .select('id, is_active, is_public, terms')
    .single();

  if (error) return NextResponse.json({ error: error.message }, { status: 500 });
  return NextResponse.json({ data });
}
