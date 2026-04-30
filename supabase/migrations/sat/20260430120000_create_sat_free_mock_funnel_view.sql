-- 20260430120000_create_sat_free_mock_funnel_view.sql
--
-- Creates `vw_sat_free_mock_funnel`: one row per signed-up user with their
-- progression through the SAT free-mock funnel.
--
-- Funnel states (in order):
--   signed_up_only -> claimed -> started -> completed
--
-- Sources:
--   profiles                : signed-up users (1:1 with auth.users)
--   test_tokens             : free-mock claims (is_free=true, exam_type='sat')
--   sat_test_attempts       : test sessions (started_at, completed_at)
--
-- Used by: src/app/api/admin/analytics/free-mock-funnel/route.ts
-- Read access: granted to authenticated role; admin gate is enforced in the API route.

CREATE OR REPLACE VIEW public.vw_sat_free_mock_funnel AS
WITH free_token AS (
  SELECT
    owner_id AS user_id,
    MIN(created_at) AS claimed_at,
    MIN(used_at)    AS token_used_at,
    COUNT(*)        AS free_tokens_granted
  FROM public.test_tokens
  WHERE is_free = true
    AND exam_type = 'sat'
    AND owner_id IS NOT NULL
  GROUP BY owner_id
),
sat_started AS (
  SELECT
    user_id,
    MIN(started_at) AS first_started_at,
    COUNT(*)        AS attempts_count
  FROM public.sat_test_attempts
  WHERE started_at IS NOT NULL
  GROUP BY user_id
),
sat_completed AS (
  SELECT
    user_id,
    MIN(completed_at)            AS first_completed_at,
    MAX(total_estimated_score)   AS best_total_estimated_score
  FROM public.sat_test_attempts
  WHERE completed_at IS NOT NULL
  GROUP BY user_id
)
SELECT
  p.id              AS user_id,
  p.email,
  p.first_name,
  p.last_name,
  p.role,
  p.created_at      AS signed_up_at,
  ft.claimed_at,
  ft.token_used_at,
  ft.free_tokens_granted,
  ss.first_started_at,
  ss.attempts_count,
  sc.first_completed_at,
  sc.best_total_estimated_score,
  CASE
    WHEN sc.first_completed_at IS NOT NULL THEN 'completed'
    WHEN ss.first_started_at  IS NOT NULL THEN 'started'
    WHEN ft.claimed_at        IS NOT NULL THEN 'claimed'
    ELSE 'signed_up_only'
  END AS funnel_state
FROM public.profiles p
LEFT JOIN free_token    ft ON ft.user_id = p.id
LEFT JOIN sat_started   ss ON ss.user_id = p.id
LEFT JOIN sat_completed sc ON sc.user_id = p.id;

COMMENT ON VIEW public.vw_sat_free_mock_funnel IS
  'Per-user SAT free-mock funnel state. One row per profile. Used by admin analytics dashboard.';

GRANT SELECT ON public.vw_sat_free_mock_funnel TO authenticated, service_role;
