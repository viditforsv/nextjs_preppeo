-- Enable RLS on courses table if not already enabled
ALTER TABLE public.courses ENABLE ROW LEVEL SECURITY;

-- Drop existing policies if they exist (to avoid conflicts)
DROP POLICY IF EXISTS "Allow public read access to published courses" ON public.courses;
DROP POLICY IF EXISTS "Allow authenticated users to read all courses" ON public.courses;

-- Policy: Allow public read access to published courses (for course discovery page)
CREATE POLICY "Allow public read access to published courses" 
ON public.courses
FOR SELECT 
USING (status = 'published');

-- Policy: Allow authenticated users to read all courses (including drafts for admins/instructors)
CREATE POLICY "Allow authenticated users to read all courses" 
ON public.courses
FOR SELECT 
TO authenticated
USING (true);

-- Policy: Allow service role to do everything (for admin operations)
CREATE POLICY "Allow service role full access" 
ON public.courses
FOR ALL 
TO service_role
USING (true)
WITH CHECK (true);

