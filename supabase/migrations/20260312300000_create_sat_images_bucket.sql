-- Create public storage bucket for SAT question images
INSERT INTO storage.buckets (id, name, public)
VALUES ('sat-question-images', 'sat-question-images', true)
ON CONFLICT (id) DO NOTHING;

-- Anyone can read images
CREATE POLICY "Public read sat-question-images"
  ON storage.objects FOR SELECT
  USING (bucket_id = 'sat-question-images');

-- Authenticated users can upload
CREATE POLICY "Auth insert sat-question-images"
  ON storage.objects FOR INSERT
  WITH CHECK (bucket_id = 'sat-question-images' AND auth.role() = 'authenticated');
