/**
 * Practice-mode access logic: free-trial window + effective access tier.
 *
 * Every new account gets 7 days of full ("premium-equivalent") practice access,
 * starting at signup. Accounts that existed before the trial launched all get a
 * fresh 7-day window starting at launch. After the trial expires (and absent a
 * paid subscription) the account falls back to the free daily quota.
 *
 * This is computed purely from the auth user's `created_at` and a single launch
 * constant — no database column or backfill is required, and it is fully
 * reversible by changing the constant.
 */

/**
 * Trial launch moment. Existing accounts (created before this) all get a fresh
 * 7-day trial measured from here; accounts created after this get their trial
 * measured from their own signup time.
 *
 * NOTE: set to the dev/preview launch date. Update to the production launch
 * timestamp when promoting to prod so existing prod users get their fresh window
 * from the real go-live, not earlier.
 */
export const PRACTICE_TRIAL_LAUNCH = new Date('2026-06-01T00:00:00Z');

export const PRACTICE_TRIAL_DAYS = 7;

const TRIAL_MS = PRACTICE_TRIAL_DAYS * 24 * 60 * 60 * 1000;

export interface TrialStatus {
  /** True while the account is inside its free-trial window. */
  inTrial: boolean;
  /** When the trial ends (start of day after the 7th day). */
  endsAt: Date;
  /** Whole days remaining, rounded up; 0 once expired. */
  daysLeft: number;
}

/**
 * Compute trial status from the auth user's signup time.
 *
 * @param createdAt  `user.created_at` (ISO string) from Supabase auth. When
 *                   missing/invalid we fail closed (no trial) so access defaults
 *                   to the free quota rather than accidentally granting premium.
 * @param now        Injectable clock for testing; defaults to current time.
 */
export function getTrialStatus(createdAt: string | null | undefined, now: Date = new Date()): TrialStatus {
  const created = createdAt ? new Date(createdAt) : null;
  const validCreated = created && !Number.isNaN(created.getTime()) ? created : null;

  if (!validCreated) {
    return { inTrial: false, endsAt: new Date(0), daysLeft: 0 };
  }

  // Trial starts at the later of signup or the launch date.
  const start = Math.max(validCreated.getTime(), PRACTICE_TRIAL_LAUNCH.getTime());
  const endsAt = new Date(start + TRIAL_MS);

  const msLeft = endsAt.getTime() - now.getTime();
  const inTrial = msLeft > 0;
  const daysLeft = inTrial ? Math.ceil(msLeft / (24 * 60 * 60 * 1000)) : 0;

  return { inTrial, endsAt, daysLeft };
}
