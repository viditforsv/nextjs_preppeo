-- CBSE 10 Science: dev -> prod data migration
-- Upserts all cbse10_science_questions rows from dev to prod
-- Generated: 2026-03-25

INSERT INTO cbse10_science_questions (
  type, prompt, options, correct_answer, explanation,
  domain, difficulty_tier, chapter, subtopic,
  bank_item_id, image_url, is_active, ai_explanation, ai_theory, qc_done,
  is_pyq, pyq_year, correct_answer_b
)
VALUES
  (
    'spr',
    'If the charge on an electron is 1.6 × 10⁻¹⁹ C, find the approximate number of electrons in 1 C.',
    NULL,
    '6.25',
    '1 C charge contains 1 / (1.6 × 10⁻¹⁹) = 6.25 × 10¹⁸ electrons.',
    'electricity',
    'easy',
    'Electricity',
    'Electric Charge and Current',
    'cbse10_ch12_custom_q001',
    NULL,
    true,
    'The correct answer is 6.25 × 10¹⁸, not 6.25|19. The student''s answer seems to have a formatting error. To find the number of electrons in 1 Coulomb (C) of charge, you divide 1 C by the charge of a single electron, which is 1.6 × 10⁻¹⁹ C. This calculation gives you 1 ÷ (1.6 × 10⁻¹⁹) = 6.25 × 10¹⁸ electrons. 

The key step is recognizing that you need to divide the total charge by the charge per electron to find the number of electrons. For similar questions, always ensure you''re using the correct units and performing the division accurately. Double-check your formatting to avoid errors like the one seen here. Keep practicing, and you''ll get the hang of it!',
    NULL,
    true,
    true,
    '2016',
    '18'
  ),
  (
    'mcq',
    'What is the SI unit of electric potential?',
    '[{"id": "a", "text": "Ampere"}, {"id": "b", "text": "Volt"}, {"id": "c", "text": "Ohm"}, {"id": "d", "text": "Watt"}]',
    'b',
    'Volt is the SI unit of electric potential. It is defined as the work done per unit charge (1 V = 1 J/C).',
    'electricity',
    'easy',
    'Electrostatics',
    'Electric Potential',
    'cbse10_ch12_custom_q003',
    NULL,
    true,
    'The correct answer is b) Volt. The volt is the SI unit of electric potential, which measures the potential energy per unit charge. It is defined as one joule per coulomb (1 V = 1 J/C). Your choice, a) Ampere, is actually the unit for electric current, not electric potential.

To solve this, you need to match the concept of electric potential with its correct unit, which is the volt. Remembering that electric potential is about energy per charge can help you recall that it''s measured in volts.

A helpful tip for similar questions is to familiarize yourself with the basic SI units for electricity: volt for electric potential, ampere for current, ohm for resistance, and watt for power. This will make it easier to match terms with their corresponding units. Keep practicing, and you''ll get the hang of it!',
    NULL,
    true,
    true,
    '2016',
    NULL
  ),
  (
    'mcq',
    'When is the potential difference between two points said to be 1 volt?',
    '[{"id": "a", "text": "When 1 J of work is done in moving 1 C charge between them"}, {"id": "b", "text": "When 1 W of power is dissipated between them"}, {"id": "c", "text": "When 1 A of current flows between them"}, {"id": "d", "text": "When 1 Ω of resistance exists between them"}]',
    'a',
    'Potential difference is 1 V when 1 J of work is done in moving 1 C of charge (V = W/Q).',
    'electricity',
    'easy',
    'Electrostatics',
    'Electric Potential',
    'cbse10_ch12_custom_q004',
    NULL,
    true,
    NULL,
    NULL,
    true,
    true,
    '2016',
    NULL
  ),
  (
    'mcq',
    'Which of the following correctly describes how the resistance \(R\) of a conductor depends on its dimensions?',
    '[{"id": "a", "text": "$R \\propto l$ and $R \\propto \\frac{1}{A}$"}, {"id": "b", "text": "$R \\propto \\frac{1}{l}$ and $R \\propto A$"}, {"id": "c", "text": "$R \\propto l$ and $R \\propto A$"}, {"id": "d", "text": "$R \\propto \\frac{1}{l}$ and $R \\propto \\frac{1}{A}$"}]',
    'a',
    'For a conductor, $R = \rho \frac{l}{A}$, so resistance is directly proportional to length and inversely proportional to area of cross-section.
',
    'electricity',
    'easy',
    'Electricity',
    'Resistance',
    'cbse10_ch12_custom_q002',
    NULL,
    true,
    NULL,
    NULL,
    true,
    true,
    '2016',
    NULL
  ),
  (
    'mcq',
    'State Ohm''s law.',
    '[{"id": "a", "text": "Current is inversely proportional to voltage at constant temperature"}, {"id": "b", "text": "Voltage across a conductor is proportional to current when physical conditions remain constant"}, {"id": "c", "text": "Resistance increases linearly with temperature"}, {"id": "d", "text": "Power dissipated is proportional to resistance"}]',
    'b',
    'Ohm''s Law states V = IR — voltage is directly proportional to current when physical conditions (temperature, material) remain constant.',
    'electricity',
    'easy',
    'Current Electricity',
    'Ohm''s Law',
    'cbse10_ch12_custom_q005',
    NULL,
    true,
    'Great job! You got it right. Ohm''s Law is a fundamental principle in electricity that states the voltage (V) across a conductor is directly proportional to the current (I) flowing through it, provided the physical conditions like temperature and material remain constant. This relationship is expressed by the formula V = IR, where R is the resistance. 

To solve this, you needed to identify that the correct statement describes this direct proportionality between voltage and current under constant conditions, which is exactly what option b states. 

For similar questions, remember to focus on the relationship between voltage, current, and resistance, and keep an eye on any conditions mentioned, as they can affect these relationships. Keep practicing, and you''ll continue to do well!',
    NULL,
    true,
    true,
    '2016',
    NULL
  )
ON CONFLICT (bank_item_id) DO UPDATE SET
  type              = EXCLUDED.type,
  prompt            = EXCLUDED.prompt,
  options           = EXCLUDED.options,
  correct_answer    = EXCLUDED.correct_answer,
  explanation       = EXCLUDED.explanation,
  domain            = EXCLUDED.domain,
  difficulty_tier   = EXCLUDED.difficulty_tier,
  chapter           = EXCLUDED.chapter,
  subtopic          = EXCLUDED.subtopic,
  image_url         = EXCLUDED.image_url,
  is_active         = EXCLUDED.is_active,
  ai_explanation    = EXCLUDED.ai_explanation,
  ai_theory         = EXCLUDED.ai_theory,
  qc_done           = EXCLUDED.qc_done,
  is_pyq            = EXCLUDED.is_pyq,
  pyq_year          = EXCLUDED.pyq_year,
  correct_answer_b  = EXCLUDED.correct_answer_b;