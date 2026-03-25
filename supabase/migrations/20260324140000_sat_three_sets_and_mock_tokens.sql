-- SAT full mocks use set_number 1–3 in sat_questions; align exam_types for token tooling.
-- Adds three paid-style tokens (is_free = false), one per set. Rotate codes if this file is public.
UPDATE public.exam_types SET total_sets = 3 WHERE id = 'sat';

INSERT INTO public.test_tokens (code, exam_type, set_number, is_free, is_active, batch_id)
SELECT v.code, v.exam_type, v.set_number, v.is_free, v.is_active, b.batch_id
FROM (SELECT gen_random_uuid() AS batch_id) b
CROSS JOIN (VALUES
  ('SAT-K8WQ-5RJH'::text, 'sat'::text, 1, false, true),
  ('SAT-7TPM-2NXZ'::text, 'sat'::text, 2, false, true),
  ('SAT-4VBC-9LGF'::text, 'sat'::text, 3, false, true)
) AS v(code, exam_type, set_number, is_free, is_active)
ON CONFLICT (code) DO NOTHING;
