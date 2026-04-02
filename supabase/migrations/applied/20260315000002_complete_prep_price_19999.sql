-- Complete Prep — 3 Months: ₹19,999 (3 months + 3 mocks complimentary)
UPDATE subscription_plans
SET price = 19999
WHERE exam_type = 'sat' AND name = 'Complete Prep — 3 Months' AND mock_tokens_included = 3;
