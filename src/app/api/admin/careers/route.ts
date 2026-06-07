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

const ADMIN_REQUIRED = NextResponse.json(
  { error: 'Admin access required' },
  { status: 403 }
);

const EDITABLE_FIELDS = [
  'slug',
  'title',
  'team',
  'location',
  'employment_type',
  'blurb',
  'about_role',
  'responsibilities',
  'requirements',
  'nice_to_have',
  'is_open',
] as const;

function pickEditable(body: Record<string, unknown>) {
  const out: Record<string, unknown> = {};
  for (const f of EDITABLE_FIELDS) {
    if (f in body) out[f] = body[f];
  }
  return out;
}

export async function GET() {
  if (!(await requireAdmin())) return ADMIN_REQUIRED;

  const supabase = createSupabaseApiClient();
  const { data, error } = await supabase
    .from('job_postings')
    .select('*')
    .order('created_at', { ascending: true });

  if (error) {
    return NextResponse.json({ error: error.message }, { status: 500 });
  }
  return NextResponse.json({ postings: data });
}

export async function POST(req: NextRequest) {
  if (!(await requireAdmin())) return ADMIN_REQUIRED;

  const body = await req.json();
  const fields = pickEditable(body);
  if (!fields.slug || !fields.title || !fields.team) {
    return NextResponse.json(
      { error: 'slug, title, and team are required' },
      { status: 400 }
    );
  }

  const supabase = createSupabaseApiClient();
  const { data, error } = await supabase
    .from('job_postings')
    .insert(fields)
    .select()
    .single();

  if (error) {
    return NextResponse.json({ error: error.message }, { status: 500 });
  }
  return NextResponse.json({ posting: data });
}

export async function PATCH(req: NextRequest) {
  if (!(await requireAdmin())) return ADMIN_REQUIRED;

  const body = await req.json();
  const { id } = body as { id?: string };
  if (!id) {
    return NextResponse.json({ error: 'id is required' }, { status: 400 });
  }

  const fields = pickEditable(body);
  if (Object.keys(fields).length === 0) {
    return NextResponse.json({ error: 'No fields to update' }, { status: 400 });
  }
  fields.updated_at = new Date().toISOString();

  const supabase = createSupabaseApiClient();
  const { data, error } = await supabase
    .from('job_postings')
    .update(fields)
    .eq('id', id)
    .select()
    .single();

  if (error) {
    return NextResponse.json({ error: error.message }, { status: 500 });
  }
  return NextResponse.json({ posting: data });
}
