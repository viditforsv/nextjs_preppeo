-- Add is_flashcard column to distinguish flashcard-only entries
-- from regular practice questions.

ALTER TABLE cbse10_science_questions
  ADD COLUMN IF NOT EXISTS is_flashcard BOOLEAN NOT NULL DEFAULT false;

-- Partial index for efficient flashcard-only queries
CREATE INDEX IF NOT EXISTS idx_cbse10_science_flashcards
  ON cbse10_science_questions (domain, chapter)
  WHERE is_flashcard = true;
