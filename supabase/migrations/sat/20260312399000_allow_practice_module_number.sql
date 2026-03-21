-- Allow module_number = 0 for practice-only questions
ALTER TABLE sat_questions DROP CONSTRAINT IF EXISTS sat_questions_module_number_check;
ALTER TABLE sat_questions ADD CONSTRAINT sat_questions_module_number_check CHECK (module_number >= 0);
