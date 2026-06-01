import { NextResponse } from 'next/server';
import { createClient } from '@/lib/supabase/server';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';

/**
 * GET /api/sat/practice-analytics
 *
 * Cumulative practice-mode performance for the signed-in user, aggregated from
 * `practice_answers` (every revealed practice question is logged there).
 * Auth required. SAT course only.
 *
 * `practice_answers` has no `section` column, so section is inferred from the
 * domain. Time metrics use only rows with a recorded `time_spent_ms`.
 */

const MATH_DOMAINS = ['algebra', 'advanced-math', 'problem-solving', 'geometry-trig'];

const DOMAIN_LABELS: Record<string, string> = {
  algebra: 'Algebra',
  'advanced-math': 'Advanced Math',
  'problem-solving': 'Problem Solving & Data',
  'geometry-trig': 'Geometry & Trig',
  'craft-structure': 'Craft & Structure',
  'information-ideas': 'Information & Ideas',
  'standard-english': 'Standard English',
  'expression-of-ideas': 'Expression of Ideas',
};

// Domain ordering for stable display (math first, then R&W).
const DOMAIN_ORDER = [...MATH_DOMAINS, 'craft-structure', 'information-ideas', 'standard-english', 'expression-of-ideas'];

const TIERS = ['easy', 'medium', 'hard'] as const;

// Min attempts before a topic is eligible for "weakest" / "slowest" lists, so a
// single unlucky question doesn't dominate the recommendations.
const MIN_TOPIC_ATTEMPTS = 3;

type Row = {
  is_correct: boolean;
  domain: string | null;
  chapter: string | null;
  subtopic: string | null;
  difficulty_tier: string | null;
  time_spent_ms: number | null;
};

function sectionOf(domain: string | null): 'math' | 'rw' | 'unknown' {
  if (!domain) return 'unknown';
  return MATH_DOMAINS.includes(domain) ? 'math' : 'rw';
}

function pct(correct: number, total: number): number {
  return total > 0 ? Math.round((correct / total) * 100) : 0;
}

export async function GET() {
  try {
    const authClient = await createClient();
    const { data: { user } } = await authClient.auth.getUser();
    if (!user) {
      return NextResponse.json({ error: 'Authentication required' }, { status: 401 });
    }

    const supabase = createSupabaseApiClient();
    const { data, error } = await supabase
      .from('practice_answers')
      .select('is_correct, domain, chapter, subtopic, difficulty_tier, time_spent_ms')
      .eq('user_id', user.id)
      .eq('course', 'sat');

    if (error) {
      console.error('Error fetching practice analytics:', error);
      return NextResponse.json({ error: 'Failed to fetch analytics' }, { status: 500 });
    }

    const rows = (data ?? []) as Row[];

    // Overall
    const total = rows.length;
    const correct = rows.filter((r) => r.is_correct).length;
    const timed = rows.filter((r) => typeof r.time_spent_ms === 'number' && r.time_spent_ms! > 0);
    const totalTimeMs = timed.reduce((sum, r) => sum + (r.time_spent_ms ?? 0), 0);
    const avgTimeS = timed.length > 0 ? Math.round(totalTimeMs / timed.length / 1000) : null;

    // By domain
    const domainMap = new Map<string, { correct: number; total: number; timeMs: number; timed: number }>();
    // By difficulty
    const tierMap = new Map<string, { correct: number; total: number }>();
    // By section
    const sectionMap = new Map<string, { correct: number; total: number }>();
    // By subtopic (for weakest + slowest)
    const subtopicMap = new Map<string, { domain: string; correct: number; total: number; timeMs: number; timed: number }>();

    for (const r of rows) {
      const dKey = r.domain ?? 'unknown';
      const d = domainMap.get(dKey) ?? { correct: 0, total: 0, timeMs: 0, timed: 0 };
      d.total++;
      if (r.is_correct) d.correct++;
      if (typeof r.time_spent_ms === 'number' && r.time_spent_ms > 0) { d.timeMs += r.time_spent_ms; d.timed++; }
      domainMap.set(dKey, d);

      if (r.difficulty_tier) {
        const t = tierMap.get(r.difficulty_tier) ?? { correct: 0, total: 0 };
        t.total++;
        if (r.is_correct) t.correct++;
        tierMap.set(r.difficulty_tier, t);
      }

      const sKey = sectionOf(r.domain);
      const s = sectionMap.get(sKey) ?? { correct: 0, total: 0 };
      s.total++;
      if (r.is_correct) s.correct++;
      sectionMap.set(sKey, s);

      if (r.subtopic) {
        const st = subtopicMap.get(r.subtopic) ?? { domain: dKey, correct: 0, total: 0, timeMs: 0, timed: 0 };
        st.total++;
        if (r.is_correct) st.correct++;
        if (typeof r.time_spent_ms === 'number' && r.time_spent_ms > 0) { st.timeMs += r.time_spent_ms; st.timed++; }
        subtopicMap.set(r.subtopic, st);
      }
    }

    const byDomain = DOMAIN_ORDER
      .filter((d) => domainMap.has(d))
      .map((d) => {
        const s = domainMap.get(d)!;
        return {
          domain: d,
          label: DOMAIN_LABELS[d] ?? d,
          section: sectionOf(d),
          correct: s.correct,
          total: s.total,
          pct: pct(s.correct, s.total),
          avgTimeS: s.timed > 0 ? Math.round(s.timeMs / s.timed / 1000) : null,
        };
      });

    const byDifficulty = TIERS
      .filter((t) => tierMap.has(t))
      .map((t) => {
        const s = tierMap.get(t)!;
        return { tier: t, correct: s.correct, total: s.total, pct: pct(s.correct, s.total) };
      });

    const bySection = (['math', 'rw'] as const)
      .filter((sec) => sectionMap.has(sec))
      .map((sec) => {
        const s = sectionMap.get(sec)!;
        return { section: sec, correct: s.correct, total: s.total, pct: pct(s.correct, s.total) };
      });

    const subtopics = [...subtopicMap.entries()].map(([name, s]) => ({
      subtopic: name,
      domain: s.domain,
      domainLabel: DOMAIN_LABELS[s.domain] ?? s.domain,
      correct: s.correct,
      total: s.total,
      pct: pct(s.correct, s.total),
      avgTimeS: s.timed > 0 ? Math.round(s.timeMs / s.timed / 1000) : null,
    }));

    // Weakest topics: lowest accuracy among topics with enough attempts.
    const weakestTopics = subtopics
      .filter((s) => s.total >= MIN_TOPIC_ATTEMPTS)
      .sort((a, b) => a.pct - b.pct || b.total - a.total)
      .slice(0, 5);

    // Time sinks: slowest topics among those with timing data and enough attempts.
    const timeSinks = subtopics
      .filter((s) => s.avgTimeS !== null && s.total >= MIN_TOPIC_ATTEMPTS)
      .sort((a, b) => (b.avgTimeS ?? 0) - (a.avgTimeS ?? 0))
      .slice(0, 5);

    return NextResponse.json({
      overall: {
        total,
        correct,
        pct: pct(correct, total),
        avgTimeS,
        totalTimeMin: Math.round(totalTimeMs / 60000),
        timedCount: timed.length,
      },
      byDomain,
      byDifficulty,
      bySection,
      weakestTopics,
      timeSinks,
    });
  } catch (error) {
    console.error('Error in GET /api/sat/practice-analytics:', error);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}
