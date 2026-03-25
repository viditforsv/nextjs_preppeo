#!/usr/bin/env node

/**
 * Promote CBSE 10 Science data from dev Supabase to prod (science-related only).
 *
 * - cbse10_science_questions: upsert by id (full row mirror from dev)
 * - Optional: subscription_plans where exam_type = 'cbse10-science' (--with-plans)
 *
 * Prereqs on prod (run once if not already applied):
 *   - Schema/RLS: run SQL migrations under supabase/migrations/cbse10-science/
 *     in filename order (or use Supabase Dashboard SQL for those files only).
 * - Storage: question images live in bucket `cbse10-science-question-images`.
 *   If image_url points to dev host, copy objects separately (not handled here).
 *
 * Reads credentials from .env.local (same vars as promote-gre-questions-dev-to-prod.mjs).
 *
 * Usage:
 *   node scripts/promote-cbse10-science-dev-to-prod.mjs --dry-run
 *   node scripts/promote-cbse10-science-dev-to-prod.mjs
 *   node scripts/promote-cbse10-science-dev-to-prod.mjs --qc-only
 *   node scripts/promote-cbse10-science-dev-to-prod.mjs --with-plans
 */

import { createClient } from '@supabase/supabase-js';
import { config } from 'dotenv';
import { resolve } from 'path';

config({ path: resolve(process.cwd(), '.env.local') });

const PROD_URL = process.env.NEXT_PUBLIC_SUPABASE_URL_PROD;
const PROD_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY_PROD;
const DEV_URL = process.env.NEXT_PUBLIC_SUPABASE_URL_DEV;
const DEV_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY_DEV;

if (!PROD_URL || !PROD_KEY || !DEV_URL || !DEV_KEY) {
  console.error(
    'Missing env vars. Need NEXT_PUBLIC_SUPABASE_URL_DEV, SUPABASE_SERVICE_ROLE_KEY_DEV, NEXT_PUBLIC_SUPABASE_URL_PROD, SUPABASE_SERVICE_ROLE_KEY_PROD in .env.local'
  );
  process.exit(1);
}

const dryRun = process.argv.includes('--dry-run');
const qcOnly = process.argv.includes('--qc-only');
const withPlans = process.argv.includes('--with-plans');

const QUESTIONS_TABLE = 'cbse10_science_questions';
const BATCH_SIZE = 80;

const prod = createClient(PROD_URL, PROD_KEY);
const dev = createClient(DEV_URL, DEV_KEY);

async function promoteQuestions() {
  console.log(
    qcOnly
      ? 'Fetching CBSE10 science questions from dev (qc_done && is_active)...'
      : 'Fetching all CBSE10 science questions from dev...'
  );

  let q = dev.from(QUESTIONS_TABLE).select('*').order('created_at');
  if (qcOnly) {
    q = q.eq('qc_done', true).eq('is_active', true);
  }

  const { data: rows, error: fetchErr } = await q;

  if (fetchErr) {
    console.error('Fetch error:', fetchErr.message);
    process.exit(1);
  }

  console.log(`Found ${rows.length} row(s) in dev.`);

  if (rows.length === 0) {
    console.log('Nothing to promote for questions.');
    return;
  }

  if (dryRun) {
    const sample = rows.slice(0, 5).map((r) => r.id);
    console.log(`Sample IDs: ${sample.join(', ')}${rows.length > 5 ? ' ...' : ''}`);
    return;
  }

  let promoted = 0;
  for (let i = 0; i < rows.length; i += BATCH_SIZE) {
    const batch = rows.slice(i, i + BATCH_SIZE);
    const { error: upsertErr } = await prod
      .from(QUESTIONS_TABLE)
      .upsert(batch, { onConflict: 'id' });

    if (upsertErr) {
      console.error(`Upsert error at batch ${i}:`, upsertErr.message);
      process.exit(1);
    }
    promoted += batch.length;
    console.log(`  Upserted questions ${promoted}/${rows.length}`);
  }

  console.log(`Done: ${promoted} question row(s) upserted to prod.`);
}

async function promotePlans() {
  console.log('\nFetching subscription_plans (exam_type = cbse10-science) from dev...');
  const { data: plans, error } = await dev
    .from('subscription_plans')
    .select('*')
    .eq('exam_type', 'cbse10-science');

  if (error) {
    console.error('Plans fetch error:', error.message);
    process.exit(1);
  }

  console.log(`Found ${plans.length} plan row(s).`);

  if (plans.length === 0) {
    return;
  }

  if (dryRun) {
    console.log('Dry run: would upsert plans:', plans.map((p) => `${p.name} (${p.id})`).join(', '));
    return;
  }

  const { error: upsertErr } = await prod
    .from('subscription_plans')
    .upsert(plans, { onConflict: 'id' });

  if (upsertErr) {
    console.error('Plans upsert error:', upsertErr.message);
    process.exit(1);
  }

  console.log(`Upserted ${plans.length} subscription plan row(s) to prod.`);
}

async function main() {
  if (dryRun) console.log('=== DRY RUN — no writes to prod ===\n');

  await promoteQuestions();

  if (withPlans) {
    await promotePlans();
  } else if (!dryRun) {
    console.log('\nTip: pass --with-plans to also sync subscription_plans for cbse10-science.');
  }

  if (dryRun) {
    console.log('\nRe-run without --dry-run to write to prod.');
  }
}

main();
