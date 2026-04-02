-- Create a public storage bucket for GRE question images
INSERT INTO storage.buckets (id, name, public)
VALUES ('gre-question-images', 'gre-question-images', true)
ON CONFLICT (id) DO NOTHING;

-- Allow anyone to read (public bucket)
DROP POLICY IF EXISTS "Public read access for gre-question-images" ON storage.objects;
CREATE POLICY "Public read access for gre-question-images"
  ON storage.objects FOR SELECT
  USING (bucket_id = 'gre-question-images');

-- Allow authenticated users to upload/update/delete (admin enforced at API level)
DROP POLICY IF EXISTS "Authenticated upload for gre-question-images" ON storage.objects;
CREATE POLICY "Authenticated upload for gre-question-images"
  ON storage.objects FOR INSERT
  WITH CHECK (bucket_id = 'gre-question-images' AND auth.role() = 'authenticated');

DROP POLICY IF EXISTS "Authenticated update for gre-question-images" ON storage.objects;
CREATE POLICY "Authenticated update for gre-question-images"
  ON storage.objects FOR UPDATE
  USING (bucket_id = 'gre-question-images' AND auth.role() = 'authenticated');

DROP POLICY IF EXISTS "Authenticated delete for gre-question-images" ON storage.objects;
CREATE POLICY "Authenticated delete for gre-question-images"
  ON storage.objects FOR DELETE
  USING (bucket_id = 'gre-question-images' AND auth.role() = 'authenticated');
