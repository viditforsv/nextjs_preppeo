import { redirect } from "next/navigation";

// Stale page — replaced by /sat/learn. Redirect any visitors to the new page.
export default function EnrolledCoursesPage() {
  redirect("/sat/learn");
}
