#!/usr/bin/env node
/**
 * Prints SQL to insert 3 SAT mock tokens (set_number 1..3) with fresh random codes.
 * Run: node scripts/print-sat-set-tokens-sql.mjs
 * Paste output into Supabase SQL editor (or use after migration that sets total_sets = 3).
 */
import crypto from 'crypto';

const CHARS = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';

function randomSegment(length) {
  const bytes = crypto.randomBytes(length);
  return Array.from(bytes, (b) => CHARS[b % CHARS.length]).join('');
}

const codes = [1, 2, 3].map((set) => ({
  set,
  code: `SAT-${randomSegment(4)}-${randomSegment(4)}`,
}));

const batchId = crypto.randomUUID();

console.log(`-- batch_id: ${batchId}\n`);
console.log(
  `INSERT INTO public.test_tokens (code, exam_type, set_number, is_free, is_active, batch_id)\nVALUES`
);
console.log(
  codes
    .map(
      ({ set, code }) =>
        `  ('${code}', 'sat', ${set}, false, true, '${batchId}'::uuid)`
    )
    .join(',\n') + '\nON CONFLICT (code) DO NOTHING;'
);
console.log('\n-- Codes:');
codes.forEach(({ set, code }) => console.log(`--   Set ${set}: ${code}`));
