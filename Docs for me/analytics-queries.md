# Analytics SQL — Reusable Queries

Reusable SQL for analytics work. All queries assume `public` schema unless noted.

## Free-mock funnel (SAT)

### View definition

`vw_sat_free_mock_funnel` — created by migration `supabase/migrations/sat/20260430120000_create_sat_free_mock_funnel_view.sql`.

One row per profile. Columns:

| Column | Source | Notes |
|---|---|---|
| `user_id` | `profiles.id` | Same as `auth.users.id` |
| `email`, `first_name`, `last_name`, `role` | `profiles` | |
| `signed_up_at` | `profiles.created_at` | 1:1 with `auth.users.created_at` (verified on dev 2026-04-30) |
| `claimed_at` | `MIN(test_tokens.created_at)` | filter `is_free=true AND exam_type='sat'` |
| `token_used_at` | `MIN(test_tokens.used_at)` | first use of the free token |
| `free_tokens_granted` | `COUNT(test_tokens)` | should be 1 normally |
| `first_started_at` | `MIN(sat_test_attempts.started_at)` | |
| `attempts_count` | `COUNT(sat_test_attempts)` | total attempts (any section) |
| `first_completed_at` | `MIN(sat_test_attempts.completed_at)` | |
| `best_total_estimated_score` | `MAX(total_estimated_score)` | best score across all attempts |
| `funnel_state` | derived | `signed_up_only` < `claimed` < `started` < `completed` |

### Funnel summary for a date range

```sql
SELECT
  funnel_state,
  COUNT(*) AS users
FROM public.vw_sat_free_mock_funnel
WHERE signed_up_at >= $1 AND signed_up_at <= $2
GROUP BY funnel_state
ORDER BY funnel_state;
```

### Drop-off by step (cumulative)

```sql
SELECT
  COUNT(*) FILTER (WHERE TRUE)                              AS signed_up,
  COUNT(*) FILTER (WHERE claimed_at IS NOT NULL)            AS claimed,
  COUNT(*) FILTER (WHERE first_started_at IS NOT NULL)      AS started,
  COUNT(*) FILTER (WHERE first_completed_at IS NOT NULL)    AS completed
FROM public.vw_sat_free_mock_funnel
WHERE signed_up_at >= $1 AND signed_up_at <= $2;
```

### Stuck-in-funnel users (signed up but never claimed in 7+ days)

```sql
SELECT user_id, email, signed_up_at
FROM public.vw_sat_free_mock_funnel
WHERE funnel_state = 'signed_up_only'
  AND signed_up_at < now() - INTERVAL '7 days'
ORDER BY signed_up_at DESC;
```

### Time-to-claim distribution

```sql
SELECT
  EXTRACT(EPOCH FROM (claimed_at - signed_up_at)) / 60 AS minutes_to_claim
FROM public.vw_sat_free_mock_funnel
WHERE claimed_at IS NOT NULL
ORDER BY minutes_to_claim;
```

## Notes

- The view is safe for `authenticated` and `service_role`. The admin gate is enforced in the API route (`src/app/api/admin/analytics/free-mock-funnel/route.ts`) by checking `profiles.role = 'admin'`.
- Dev branch has 1 user with `funnel_state='completed'` but `claimed_at IS NULL` — this is **expected test data** seeded directly for marketing purposes (not a data-quality issue).
