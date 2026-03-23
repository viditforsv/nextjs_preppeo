'use client';

import {
  Target,
  Clock,
  AlertTriangle,
  TrendingUp,
  Zap,
} from 'lucide-react';
import type { NormalizedResponse } from './results-types';

interface Props {
  responses: NormalizedResponse[];
  /** Friendly label map for topics, e.g. { 'algebra': 'Algebra' } */
  topicLabels?: Record<string, string>;
}

interface Recommendation {
  icon: typeof Target;
  color: string;
  bgColor: string;
  title: string;
  detail: string;
}

function generateRecommendations(
  responses: NormalizedResponse[],
  topicLabels: Record<string, string>,
): Recommendation[] {
  const recs: Recommendation[] = [];
  if (responses.length === 0) return recs;

  const totalCorrect = responses.filter((r) => r.isCorrect).length;
  const totalAccuracy = totalCorrect / responses.length;
  const omitted = responses.filter((r) => r.isOmitted);
  const omitRate = omitted.length / responses.length;

  // 1. Weakest topic(s)
  const topicMap = new Map<string, { correct: number; total: number }>();
  for (const r of responses) {
    if (!r.topic) continue;
    const entry = topicMap.get(r.topic) ?? { correct: 0, total: 0 };
    entry.total++;
    if (r.isCorrect) entry.correct++;
    topicMap.set(r.topic, entry);
  }
  const topicStats = [...topicMap.entries()]
    .filter(([, v]) => v.total >= 2)
    .map(([topic, v]) => ({ topic, accuracy: v.correct / v.total, ...v }))
    .sort((a, b) => a.accuracy - b.accuracy);

  if (topicStats.length > 0) {
    const weakest = topicStats[0];
    const label = topicLabels[weakest.topic] ?? weakest.topic;
    const pct = Math.round(weakest.accuracy * 100);
    const overallPct = Math.round(totalAccuracy * 100);
    if (weakest.accuracy < totalAccuracy) {
      recs.push({
        icon: Target,
        color: 'text-red-600',
        bgColor: 'bg-red-50',
        title: `Focus on ${label}`,
        detail: `${pct}% accuracy (${weakest.correct}/${weakest.total}) vs ${overallPct}% overall. Prioritize practice in this area.`,
      });
    }
  }

  // 2. Weakest difficulty tier
  const diffMap = new Map<string, { correct: number; total: number }>();
  for (const r of responses) {
    const entry = diffMap.get(r.difficulty) ?? { correct: 0, total: 0 };
    entry.total++;
    if (r.isCorrect) entry.correct++;
    diffMap.set(r.difficulty, entry);
  }
  const hardStats = diffMap.get('hard');
  if (hardStats && hardStats.total >= 2) {
    const hardAcc = hardStats.correct / hardStats.total;
    if (hardAcc < 0.5) {
      recs.push({
        icon: TrendingUp,
        color: 'text-orange-600',
        bgColor: 'bg-orange-50',
        title: 'Strengthen Hard Questions',
        detail: `${Math.round(hardAcc * 100)}% on hard questions (${hardStats.correct}/${hardStats.total}). Focus on advanced concepts to unlock a higher score.`,
      });
    }
  }

  // 3. Time management — too fast on wrong answers
  const wrongResponses = responses.filter((r) => !r.isCorrect && !r.isOmitted);
  if (wrongResponses.length >= 3) {
    const avgWrongTime = wrongResponses.reduce((s, r) => s + r.timeSpentMs, 0) / wrongResponses.length;
    const correctResponses = responses.filter((r) => r.isCorrect);
    const avgCorrectTime = correctResponses.length > 0
      ? correctResponses.reduce((s, r) => s + r.timeSpentMs, 0) / correctResponses.length
      : avgWrongTime;

    if (avgWrongTime < avgCorrectTime * 0.6) {
      recs.push({
        icon: Clock,
        color: 'text-blue-600',
        bgColor: 'bg-blue-50',
        title: 'Slow Down on Tough Questions',
        detail: `You spent ${Math.round(avgWrongTime / 1000)}s avg on wrong answers vs ${Math.round(avgCorrectTime / 1000)}s on correct ones. Rushing may cost you easy points.`,
      });
    }
  }

  // 4. Slow overall pace
  const totalTimeMs = responses.reduce((s, r) => s + r.timeSpentMs, 0);
  const avgTimeMs = totalTimeMs / responses.length;
  if (avgTimeMs > 120000) {
    recs.push({
      icon: Zap,
      color: 'text-purple-600',
      bgColor: 'bg-purple-50',
      title: 'Improve Speed',
      detail: `Average ${Math.round(avgTimeMs / 1000)}s per question. Try timed practice sets to build speed without sacrificing accuracy.`,
    });
  }

  // 5. High omission rate
  if (omitRate > 0.1 && omitted.length >= 2) {
    recs.push({
      icon: AlertTriangle,
      color: 'text-amber-600',
      bgColor: 'bg-amber-50',
      title: 'Reduce Unanswered Questions',
      detail: `${omitted.length} questions omitted (${Math.round(omitRate * 100)}%). There's no penalty for guessing — always attempt every question.`,
    });
  }

  // Second weakest topic if we have room
  if (recs.length < 4 && topicStats.length >= 2) {
    const second = topicStats[1];
    const label = topicLabels[second.topic] ?? second.topic;
    const pct = Math.round(second.accuracy * 100);
    if (second.accuracy < totalAccuracy) {
      recs.push({
        icon: Target,
        color: 'text-yellow-600',
        bgColor: 'bg-yellow-50',
        title: `Review ${label}`,
        detail: `${pct}% accuracy (${second.correct}/${second.total}). Additional practice here can boost your overall score.`,
      });
    }
  }

  // Positive reinforcement if overall accuracy is good
  if (recs.length < 3 && totalAccuracy >= 0.75) {
    recs.push({
      icon: TrendingUp,
      color: 'text-emerald-600',
      bgColor: 'bg-emerald-50',
      title: 'Strong Performance!',
      detail: `${Math.round(totalAccuracy * 100)}% overall accuracy. Keep practicing to maintain consistency and push for a perfect score.`,
    });
  }

  return recs.slice(0, 5);
}

export default function RecommendationsTab({ responses, topicLabels = {} }: Props) {
  const recs = generateRecommendations(responses, topicLabels);

  if (recs.length === 0) {
    return (
      <div className="bg-white rounded-xl border border-gray-200 p-8 text-center">
        <p className="text-gray-500">Not enough data to generate recommendations. Complete more questions for personalized tips.</p>
      </div>
    );
  }

  return (
    <div className="space-y-3">
      <p className="text-sm text-gray-500 mb-2">
        Based on your test performance, here are your top areas for improvement:
      </p>
      {recs.map((rec, i) => {
        const Icon = rec.icon;
        return (
          <div key={i} className="bg-white rounded-xl border border-gray-200 p-4 flex items-start gap-4">
            <div className={`w-9 h-9 rounded-lg ${rec.bgColor} flex items-center justify-center shrink-0`}>
              <Icon className={`w-4.5 h-4.5 ${rec.color}`} />
            </div>
            <div className="flex-1 min-w-0">
              <h4 className="text-sm font-semibold text-gray-800">{rec.title}</h4>
              <p className="text-sm text-gray-600 mt-0.5">{rec.detail}</p>
            </div>
            <span className="text-xs font-bold text-gray-300 shrink-0">#{i + 1}</span>
          </div>
        );
      })}
    </div>
  );
}
