#!/usr/bin/env node

/**
 * Copy exam_types, token_packs, and free test_tokens from prod to dev Supabase.
 * Reads credentials from .env.local.
 *
 * Usage:  node scripts/seed-mock-tokens-dev.mjs
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

async function copyTable(table, filter, conflictKey, transform) {
  console.log(`\nFetching ${table} from prod...`);
  let query = prod.from(table).select('*');
  if (filter) query = filter(query);

  const { data: rawRows, error: fetchErr } = await query;
  if (fetchErr) {
    console.error(`  Fetch error (${table}):`, fetchErr.message);
    process.exit(1);
  }

  const rows = transform ? rawRows.map(transform) : rawRows;

  console.log(`  Fetched ${rows.length} rows.`);
  if (rows.length === 0) return 0;

  const BATCH_SIZE = 50;
  let upserted = 0;

  for (let i = 0; i < rows.length; i += BATCH_SIZE) {
    const batch = rows.slice(i, i + BATCH_SIZE);
    const { error: upsertErr } = await dev
      .from(table)
      .upsert(batch, { onConflict: conflictKey });

    if (upsertErr) {
      console.error(`  Upsert error (${table}) at batch ${i}:`, upsertErr.message);
      process.exit(1);
    }
    upserted += batch.length;
    console.log(`  Upserted ${upserted}/${rows.length}`);
  }
  return upserted;
}

async function main() {
  // 1. exam_types (must go first — other tables reference it via FK)
  await copyTable('exam_types', (q) => q.eq('is_active', true), 'id');

  // 2. token_packs
  await copyTable('token_packs', (q) => q.eq('is_active', true), 'id');

  // 3. free test_tokens only (upsert on code since it has a unique constraint)
  // Null out user FKs that won't exist in dev
  await copyTable(
    'test_tokens',
    (q) => q.eq('is_free', true).eq('is_active', true),
    'code',
    (row) => ({ ...row, owner_id: null, used_by: null, purchase_id: null }),
  );

  console.log('\nDone! Mock token data seeded in dev.');
}

main();
