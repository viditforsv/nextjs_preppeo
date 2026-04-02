-- Institute bulk token packs for SAT with volume discounts
-- Individual pricing: 3 @ ₹299 (~₹100/test), 5 @ ₹449 (~₹90/test)
-- Institute pricing: volume discount tiers
INSERT INTO token_packs (exam_type, name, token_count, price) VALUES
  ('sat', '50 SAT Mock Tests — Institute', 50, 3500),
  ('sat', '100 SAT Mock Tests — Institute', 100, 6000),
  ('sat', '500 SAT Mock Tests — Institute', 500, 25000);
