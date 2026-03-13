ALTER TABLE test_tokens ADD COLUMN IF NOT EXISTS batch_id UUID;
CREATE INDEX IF NOT EXISTS idx_test_tokens_batch ON test_tokens(batch_id) WHERE batch_id IS NOT NULL;
