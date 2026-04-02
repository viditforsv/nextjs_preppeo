-- Fix rls_policy_always_true warnings
-- Tables: payments, qa_history, qa_questions, test_tokens, token_purchases
--
-- SAFETY NOTE:
-- qa_history, qa_questions, test_tokens, token_purchases are ALL accessed
-- exclusively via service role client which BYPASSES RLS entirely.
-- So tightening these policies has ZERO effect on current app behavior.
--
-- payments verify routes are being switched to service role in this same change,
-- so the tighter policies here also won't break payment flow.

-- ============================================================
-- 1. payments — replace permissive INSERT/UPDATE policies
-- ============================================================
DROP POLICY IF EXISTS "System can insert payments" ON public.payments;
DROP POLICY IF EXISTS "System can update payments" ON public.payments;

CREATE POLICY "Authenticated users insert own payments"
  ON public.payments
  FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Authenticated users update own payments"
  ON public.payments
  FOR UPDATE
  TO authenticated
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- ============================================================
-- 2. qa_history — replace wide-open ALL policy with scoped ones
-- ============================================================
DROP POLICY IF EXISTS "Enable ALL for authenticated users" ON public.qa_history;

CREATE POLICY "Users read own qa_history"
  ON public.qa_history
  FOR SELECT
  TO authenticated
  USING (action_by = auth.uid());

CREATE POLICY "Admin read all qa_history"
  ON public.qa_history
  FOR SELECT
  TO authenticated
  USING (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin'));

CREATE POLICY "Admin manage qa_history"
  ON public.qa_history
  FOR ALL
  TO authenticated
  USING (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin'))
  WITH CHECK (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin'));

-- ============================================================
-- 3. qa_questions — replace wide-open ALL policy with scoped ones
-- ============================================================
DROP POLICY IF EXISTS "Enable ALL for authenticated users" ON public.qa_questions;

CREATE POLICY "Authenticated users read qa_questions"
  ON public.qa_questions
  FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Admin manage qa_questions"
  ON public.qa_questions
  FOR ALL
  TO authenticated
  USING (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin'))
  WITH CHECK (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin'));

-- ============================================================
-- 4. test_tokens — drop permissive ALL policy (service role bypasses RLS)
-- ============================================================
DROP POLICY IF EXISTS "Service manage tokens" ON public.test_tokens;

-- ============================================================
-- 5. token_purchases — drop permissive INSERT/UPDATE policies
-- ============================================================
DROP POLICY IF EXISTS "Service insert purchases" ON public.token_purchases;
DROP POLICY IF EXISTS "Service update purchases" ON public.token_purchases;
