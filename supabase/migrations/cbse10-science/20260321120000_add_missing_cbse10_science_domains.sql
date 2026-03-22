-- Add missing domains: periodic-classification, sources-of-energy, sustainable-management

ALTER TABLE cbse10_science_questions
  DROP CONSTRAINT IF EXISTS cbse10_science_questions_domain_check;

ALTER TABLE cbse10_science_questions
  ADD CONSTRAINT cbse10_science_questions_domain_check
  CHECK (domain IN (
    'chemical-reactions', 'acids-bases-salts', 'metals-non-metals',
    'carbon-compounds', 'periodic-classification', 'life-processes',
    'control-coordination', 'reproduction', 'heredity-evolution',
    'light', 'human-eye', 'electricity', 'magnetic-effects',
    'sources-of-energy', 'our-environment', 'sustainable-management'
  ));
