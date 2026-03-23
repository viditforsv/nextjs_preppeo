#!/usr/bin/env node

/**
 * Promote QC'd GRE questions from dev Supabase to prod Supabase.
 * Only rows with qc_done = true AND is_active = true are promoted.
 * Reads credentials from .env.local.
 *
 * Usage:
 *   node scripts/promote-gre-questions-dev-to-prod.mjs             # execute
 *   node scripts/promote-gre-questions-dev-to-prod.mjs --dry-run   # preview only
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

const dryRun = process.argv.includes('--dry-run');

const prod = createClient(PROD_URL, PROD_KEY);
const dev  = createClient(DEV_URL, DEV_KEY);

async function main() {
  if (dryRun) console.log('=== DRY RUN — no writes will be made ===\n');

  console.log('Fetching QC-done gre_questions from dev...');
  const { data: rows, error: fetchErr } = await dev
    .from('gre_questions')
    .select('*')
    .eq('qc_done', true)
    .eq('is_active', true)
    .order('section_number')
    .order('set_number');

  if (fetchErr) {
    console.error('Fetch error:', fetchErr.message);
    process.exit(1);
  }

  console.log(`Found ${rows.length} QC-done questions in dev.`);

  if (rows.length === 0) {
    console.log('Nothing to promote.');
    return;
  }

  if (dryRun) {
    const sample = rows.slice(0, 10).map((r) => r.id);
    console.log(`Sample IDs: ${sample.join(', ')}${rows.length > 10 ? ' ...' : ''}`);
    console.log('\nRe-run without --dry-run to write to prod.');
    return;
  }

  const BATCH_SIZE = 50;
  let promoted = 0;

  for (let i = 0; i < rows.length; i += BATCH_SIZE) {
    const batch = rows.slice(i, i + BATCH_SIZE);
    const { error: upsertErr } = await prod
      .from('gre_questions')
      .upsert(batch, { onConflict: 'id' });

    if (upsertErr) {
      console.error(`Upsert error at batch ${i}:`, upsertErr.message);
      process.exit(1);
    }
    promoted += batch.length;
    console.log(`  Promoted ${promoted}/${rows.length}`);
  }

  console.log(`\nDone! ${promoted} questions promoted from dev to prod.`);
}

main();
