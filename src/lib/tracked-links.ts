// Shared config for the community link tracker (/links + /l/<slug>).

export const LINK_DESTINATIONS = [
  { key: "home", label: "Homepage", path: "/" },
  { key: "qotd", label: "Question of the Day", path: "/question-of-the-day" },
  { key: "free-mock", label: "Free Mock Test", path: "/sat-free" },
  { key: "pricing", label: "Pricing", path: "/pricing" },
] as const;

export const LINK_SOURCES = [
  { key: "reddit", label: "Reddit" },
  { key: "discord", label: "Discord" },
  { key: "other", label: "Other" },
] as const;

export type DestinationKey = (typeof LINK_DESTINATIONS)[number]["key"];
export type SourceKey = (typeof LINK_SOURCES)[number]["key"];

export function destinationForKey(key: string) {
  return LINK_DESTINATIONS.find((d) => d.key === key) ?? null;
}

// Cookie that ties a click to a later signup (last-touch, 30 days).
export const LINK_REF_COOKIE = "pp_ref";
export const LINK_REF_MAX_AGE = 60 * 60 * 24 * 30;

// Cookie set after the VA enters the passcode on /links.
export const LINK_TOOL_COOKIE = "link_tool_ok";
