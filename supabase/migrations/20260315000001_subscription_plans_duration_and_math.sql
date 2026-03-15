-- Fix subscription plan: 14,999 is for 2 months (not 3).
-- Complete Prep — 3 Months stays at 19,999 (3 months + 3 mocks complimentary).

UPDATE subscription_plans
SET name = 'Practice Mode — 2 Months', duration_days = 60
WHERE exam_type = 'sat' AND name = 'Practice Mode — 3 Months' AND duration_days = 90 AND price = 14999;
