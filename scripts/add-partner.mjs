import { createClient } from '@supabase/supabase-js';
import { config } from 'dotenv';
import { resolve } from 'path';

config({ path: resolve(process.cwd(), '.env.local') });

function getEnv() {
  const e = (process.env.NEXT_PUBLIC_ENVIRONMENT || '').toLowerCase();
  if (e === 'prod' || e === 'production') return 'prod';
  if (e === 'dev' || e === 'development') return 'dev';
  return process.env.NODE_ENV === 'production' ? 'prod' : 'dev';
}

const env = getEnv();
const url = env === 'prod'
  ? (process.env.NEXT_PUBLIC_SUPABASE_URL_PROD || process.env.NEXT_PUBLIC_SUPABASE_URL)
  : (process.env.NEXT_PUBLIC_SUPABASE_URL_DEV || process.env.NEXT_PUBLIC_SUPABASE_URL);
const key = env === 'prod'
  ? (process.env.SUPABASE_SERVICE_ROLE_KEY_PROD || process.env.SUPABASE_SERVICE_ROLE_KEY)
  : (process.env.SUPABASE_SERVICE_ROLE_KEY_DEV || process.env.SUPABASE_SERVICE_ROLE_KEY);

if (!url || !key) {
  console.error('Missing Supabase credentials');
  process.exit(1);
}
console.log(`Using ${env} Supabase: ${url}`);

const supabase = createClient(url, key);

const USER_ID = 'aa9e5a14-6991-41cc-b9e4-5963759084f2';
const REFERRAL_CODE = 'MEG001';
const COMMISSION_RATE = 30;
const DISCOUNT_RATE = 10;

async function main() {
  const { data: profile, error: profileErr } = await supabase
    .from('profiles')
    .select('id, first_name, last_name, email, role')
    .eq('id', USER_ID)
    .single();

  if (profileErr || !profile) {
    console.error('User not found with ID:', USER_ID);
    console.error('Error:', profileErr?.message);
    process.exit(1);
  }

  console.log(`Found user: ${profile.first_name} ${profile.last_name} (${profile.id})`);

  // Check if already a partner
  const { data: existing } = await supabase
    .from('partners')
    .select('id')
    .eq('id', profile.id)
    .single();

  if (existing) {
    console.log('User is already a partner.');
    process.exit(0);
  }

  // Create partner
  const { data: partner, error: partnerErr } = await supabase
    .from('partners')
    .insert({
      id: profile.id,
      referral_code: REFERRAL_CODE,
      commission_rate: COMMISSION_RATE,
      discount_rate: DISCOUNT_RATE,
    })
    .select()
    .single();

  if (partnerErr) {
    console.error('Failed to create partner:', partnerErr.message);
    process.exit(1);
  }

  // Update role to partner if currently student
  if (profile.role === 'student') {
    await supabase.from('profiles').update({ role: 'partner' }).eq('id', profile.id);
    console.log('Updated role to partner.');
  }

  console.log('Partner created successfully!');
  console.log(JSON.stringify(partner, null, 2));
}

main();
