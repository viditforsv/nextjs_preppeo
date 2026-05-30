import { redirect } from "next/navigation";

// The old token store is retired. Pricing now lives on /pricing (students) and
// /for-institutes (bulk); viewing/redeeming purchased codes lives under the
// account at /profile/tokens.
export default function TokenStoreRedirect() {
  redirect("/profile/tokens");
}
