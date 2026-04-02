-- Institute mock pricing: base ₹250/mock at 50, then volume discounts
-- 50 mocks: ₹12,500 (₹250/mock)
-- 100 mocks: 5% off → ₹23,750 (₹237.50/mock)
-- 300 mocks: 15% off → ₹63,750 (₹212.50/mock)
-- 500 mocks: 25% off → ₹93,750 (₹187.50/mock)

UPDATE token_packs SET price = 12500  WHERE exam_type = 'sat' AND token_count = 50;
UPDATE token_packs SET price = 23750  WHERE exam_type = 'sat' AND token_count = 100;
UPDATE token_packs SET price = 63750  WHERE exam_type = 'sat' AND token_count = 300;
UPDATE token_packs SET price = 93750  WHERE exam_type = 'sat' AND token_count = 500;
