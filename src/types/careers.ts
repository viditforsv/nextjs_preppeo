export interface JobPosting {
  id: string;
  slug: string;
  title: string;
  team: string;
  location: string;
  employment_type: string;
  blurb: string;
  about_role: string;
  responsibilities: string[];
  requirements: string[];
  nice_to_have: string[];
  is_open: boolean;
  created_at: string;
  updated_at: string;
}
