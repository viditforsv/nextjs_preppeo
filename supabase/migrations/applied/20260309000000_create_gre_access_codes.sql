-- ============================================================================
-- CREATE GRE ACCESS CODES TABLE
-- Stores predefined access codes that gate Test Mode on the GRE test page.
-- Codes are validated server-side via /api/gre/verify-code.
-- ============================================================================

CREATE TABLE IF NOT EXISTS public.gre_access_codes (
  code text NOT NULL,
  is_active boolean NOT NULL DEFAULT true,
  used_at timestamp with time zone,
  created_at timestamp with time zone DEFAULT now(),
  CONSTRAINT gre_access_codes_pkey PRIMARY KEY (code)
);

COMMENT ON TABLE public.gre_access_codes IS 'Predefined access codes required to start GRE Test Mode';
COMMENT ON COLUMN public.gre_access_codes.is_active IS 'Set to false to revoke a code without deleting it';
COMMENT ON COLUMN public.gre_access_codes.used_at IS 'Timestamp when the code was last used (nullable for reusable codes)';

ALTER TABLE public.gre_access_codes ENABLE ROW LEVEL SECURITY;

-- No public/authenticated read — all validation goes through the API route
-- using the service role client, which bypasses RLS.
