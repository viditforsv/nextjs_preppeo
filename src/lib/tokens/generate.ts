import crypto from 'crypto';

const CHARS = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789'; // no 0/O/1/I to avoid confusion

function randomSegment(length: number): string {
  const bytes = crypto.randomBytes(length);
  return Array.from(bytes)
    .map((b) => CHARS[b % CHARS.length])
    .join('');
}

/**
 * Generates a secure, typeable token code.
 * Format: SAT-X7KM-9RPQ (prefix + two 4-char crypto-random segments)
 * ~40 bits of entropy — computationally infeasible to guess.
 */
export function generateTokenCode(examType: string): string {
  const prefix = examType.toUpperCase();
  return `${prefix}-${randomSegment(4)}-${randomSegment(4)}`;
}

export function generateBulkTokenCodes(examType: string, count: number): string[] {
  const codes = new Set<string>();
  while (codes.size < count) {
    codes.add(generateTokenCode(examType));
  }
  return Array.from(codes);
}
