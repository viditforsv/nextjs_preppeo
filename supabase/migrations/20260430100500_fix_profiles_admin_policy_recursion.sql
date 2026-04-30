-- Fix infinite-recursion in profiles RLS policies.
--
-- Problem: the "Admins can view/update all profiles" policies query
-- public.profiles inside their USING clause to check whether the caller is
-- an admin. That recursive query re-triggers the same policy, producing
-- "infinite recursion detected in policy for relation profiles" on every
-- read. Symptom: middleware sees authed=true but role=(none), so admin
-- routes redirect-loop.
--
-- Fix: move the admin lookup into a SECURITY DEFINER function that runs
-- with owner privileges and so bypasses RLS on the inner SELECT. The
-- "Users can view own profile" (auth.uid() = id) policy is unchanged and
-- still lets every user read their own row directly.

CREATE OR REPLACE FUNCTION public.is_admin(uid uuid)
RETURNS boolean
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
STABLE
AS $$
  SELECT EXISTS (
    SELECT 1 FROM public.profiles WHERE id = uid AND role = 'admin'
  );
$$;

REVOKE EXECUTE ON FUNCTION public.is_admin(uuid) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.is_admin(uuid) TO authenticated, service_role;

DROP POLICY IF EXISTS "Admins can view all profiles" ON public.profiles;
CREATE POLICY "Admins can view all profiles" ON public.profiles
  FOR SELECT
  TO authenticated
  USING (public.is_admin(auth.uid()));

DROP POLICY IF EXISTS "Admins can update all profiles" ON public.profiles;
CREATE POLICY "Admins can update all profiles" ON public.profiles
  FOR UPDATE
  TO authenticated
  USING (public.is_admin(auth.uid()))
  WITH CHECK (public.is_admin(auth.uid()));
