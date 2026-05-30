-- ============================================================================
-- Dedupe token_packs — make the DB the single source of truth
-- ----------------------------------------------------------------------------
-- token_packs has duplicate rows: every (exam_type, token_count) appears twice
-- across SAT/GRE/GMAT. /pricing and /for-institutes now both read packs from
-- this table, so duplicates must go.
--
-- Strategy: keep ONE active row per (exam_type, token_count) — the earliest by
-- created_at — and DEACTIVATE the rest (is_active = false). We deactivate
-- rather than DELETE because token_purchases.pack_id may reference these rows.
--
-- Target: DEV branch (dxhxpfouzjlzpeazwrqo) ONLY. Promote to prod after QC.
-- ============================================================================

WITH ranked AS (
  SELECT
    id,
    row_number() OVER (
      PARTITION BY exam_type, token_count
      ORDER BY created_at, id
    ) AS rn
  FROM public.token_packs
  WHERE is_active = true
)
UPDATE public.token_packs t
SET is_active = false
FROM ranked r
WHERE t.id = r.id
  AND r.rn > 1;
