-- Cache columns for AI-generated explanations and theory
ALTER TABLE sat_questions ADD COLUMN IF NOT EXISTS ai_explanation TEXT;
ALTER TABLE sat_questions ADD COLUMN IF NOT EXISTS ai_theory TEXT;
