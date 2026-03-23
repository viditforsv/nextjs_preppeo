#!/usr/bin/env node

/**
 * One-off script: copy all gre_questions from prod Supabase to dev Supabase.
 * Reads credentials from .env.local.
 *
 * Usage:  node scripts/copy-gre-questions-prod-to-dev.mjs
 */

import { createClient } from '@supabase/supabase-js';
import { config } from 'dotenv';
import { resolve } from 'path';

config({ path: resolve(process.cwd(), '.env.local') });

const PROD_URL = process.env.NEXT_PUBLIC_SUPABASE_URL_PROD;
const PROD_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY_PROD;
const DEV_URL  = process.env.NEXT_PUBLIC_SUPABASE_URL_DEV;
const DEV_KEY  = process.env.SUPABASE_SERVICE_ROLE_KEY_DEV;

if (!PROD_URL || !PROD_KEY || !DEV_URL || !DEV_KEY) {
  console.error('Missing env vars. Need PROD and DEV Supabase credentials in .env.local');
  process.exit(1);
}

const prod = createClient(PROD_URL, PROD_KEY);
const dev  = createClient(DEV_URL, DEV_KEY);

async function main() {
  console.log('Fetching gre_questions from prod...');
  const { data: rows, error: fetchErr } = await prod
    .from('gre_questions')
    .select('*')
    .order('section_number')
    .order('set_number');

  if (fetchErr) {
    console.error('Fetch error:', fetchErr.message);
    process.exit(1);
  }

  console.log(`Fetched ${rows.length} questions from prod.`);

  if (rows.length === 0) {
    console.log('Nothing to copy.');
    return;
  }

  // Strip the id column so dev generates new UUIDs (avoids PK conflicts)
  // Actually, keep the id so references stay stable — upsert by id instead
  const BATCH_SIZE = 50;
  let inserted = 0;

  for (let i = 0; i < rows.length; i += BATCH_SIZE) {
    const batch = rows.slice(i, i + BATCH_SIZE);
    const { error: upsertErr } = await dev
      .from('gre_questions')
      .upsert(batch, { onConflict: 'id' });

    if (upsertErr) {
      console.error(`Upsert error at batch ${i}:`, upsertErr.message);
      process.exit(1);
    }
    inserted += batch.length;
    console.log(`  Upserted ${inserted}/${rows.length}`);
  }

  console.log(`Done! ${inserted} questions copied to dev.`);
}

main();
