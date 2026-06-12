// Groups a course's topics into domain "segments" (Algebra, Advanced Math, …)
// for the curriculum UI. Topics are pre-ordered by sort_order, with each domain
// contiguous, so we group by consecutive runs. Topics with no domain
// (e.g. Introduction, Conclusion) each become their own headerless segment.
//
// Pure module — safe to import from both Server and Client Components.

import type { SatLearnTopicWithItems } from "@/types/sat-learn";

/** Human label for each `sat_questions.domain` key used by SAT Math topics. */
export const DOMAIN_LABEL: Record<string, string> = {
  algebra: "Algebra",
  "advanced-math": "Advanced Math",
  "problem-solving": "Problem-Solving & Data Analysis",
  "geometry-trig": "Geometry & Trigonometry",
};

export interface TopicSegment {
  key: string;
  /** Section header to show, or null for ungrouped topics (intro / conclusion). */
  label: string | null;
  topics: SatLearnTopicWithItems[];
}

export function groupTopicsByDomain(
  topics: SatLearnTopicWithItems[]
): TopicSegment[] {
  const segments: TopicSegment[] = [];
  for (const topic of topics) {
    const domain = topic.domain ?? null;
    const last = segments[segments.length - 1];
    // Same non-null domain as the previous run → extend it; otherwise start anew.
    if (domain !== null && last && last.key === domain) {
      last.topics.push(topic);
    } else {
      segments.push({
        key: domain ?? `none-${segments.length}`,
        label: domain ? DOMAIN_LABEL[domain] ?? domain : null,
        topics: [topic],
      });
    }
  }
  return segments;
}
