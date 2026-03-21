-- Add missing 22nd question for SAT Set 1, Module 1
INSERT INTO sat_questions (type, prompt, options, correct_answer, explanation, domain, difficulty_tier, module_number, set_number) VALUES
('mcq', 'A car travels 180 miles in 3 hours. If it continues at the same speed, how far will it travel in 5 hours?', '[{"id":"a","text":"200"},{"id":"b","text":"250"},{"id":"c","text":"300"},{"id":"d","text":"360"}]'::jsonb, 'c', 'Speed = 180/3 = 60 mph. In 5 hours: 60 × 5 = 300 miles.', 'problem-solving', 'medium', 1, 1);
