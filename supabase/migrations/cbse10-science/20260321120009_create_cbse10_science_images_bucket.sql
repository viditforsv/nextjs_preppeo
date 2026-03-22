-- Create public storage bucket for CBSE 10 Science question images
INSERT INTO storage.buckets (id, name, public)
VALUES ('cbse10-science-question-images', 'cbse10-science-question-images', true)
ON CONFLICT (id) DO NOTHING;

CREATE POLICY "Public read cbse10-science-question-images"
  ON storage.objects FOR SELECT
  USING (bucket_id = 'cbse10-science-question-images');

CREATE POLICY "Auth insert cbse10-science-question-images"
  ON storage.objects FOR INSERT
  WITH CHECK (bucket_id = 'cbse10-science-question-images' AND auth.role() = 'authenticated');
