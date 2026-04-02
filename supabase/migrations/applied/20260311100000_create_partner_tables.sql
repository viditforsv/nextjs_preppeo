-- ============================================================
-- Partner Referral System: partners, partner_commissions, alter token_purchases
-- ============================================================

-- 1. Partners table
CREATE TABLE IF NOT EXISTS partners (
  id UUID PRIMARY KEY REFERENCES profiles(id) ON DELETE CASCADE,
  referral_code TEXT NOT NULL UNIQUE,
  commission_rate NUMERIC NOT NULL DEFAULT 30.0,
  discount_rate NUMERIC NOT NULL DEFAULT 10.0,
  is_active BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_partners_referral_code ON partners(referral_code);

ALTER TABLE partners ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Admin manage partners"
  ON partners FOR ALL
  USING (
    EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin')
  );

CREATE POLICY "Partners read own row"
  ON partners FOR SELECT
  USING (id = auth.uid());

CREATE POLICY "Public read active partners for code validation"
  ON partners FOR SELECT
  USING (is_active = true);

-- 2. Alter token_purchases to track referrals
ALTER TABLE token_purchases
  ADD COLUMN IF NOT EXISTS referral_code TEXT,
  ADD COLUMN IF NOT EXISTS partner_id UUID REFERENCES partners(id) ON DELETE SET NULL,
  ADD COLUMN IF NOT EXISTS discount_applied DECIMAL(10, 2) NOT NULL DEFAULT 0;

-- 3. Partner commissions table
CREATE TABLE IF NOT EXISTS partner_commissions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  partner_id UUID NOT NULL REFERENCES partners(id) ON DELETE CASCADE,
  purchase_id UUID NOT NULL REFERENCES token_purchases(id) ON DELETE CASCADE,
  student_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  original_amount DECIMAL(10, 2) NOT NULL,
  paid_amount DECIMAL(10, 2) NOT NULL,
  commission_amount DECIMAL(10, 2) NOT NULL,
  status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'paid')),
  paid_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_partner_commissions_partner ON partner_commissions(partner_id);
CREATE INDEX idx_partner_commissions_status ON partner_commissions(status);

ALTER TABLE partner_commissions ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Admin manage commissions"
  ON partner_commissions FOR ALL
  USING (
    EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin')
  );

CREATE POLICY "Partners read own commissions"
  ON partner_commissions FOR SELECT
  USING (partner_id = auth.uid());
