import crypto from 'crypto';

const CHARS = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789'; // no 0/O/1/I to avoid confusion

function randomCode(length: number): string {
  const bytes = crypto.randomBytes(length);
  return Array.from(bytes)
    .map((b) => CHARS[b % CHARS.length])
    .join('');
}

export function generateTokenCode(examType: string): string {
  const prefix = examType.toUpperCase();
  const year = new Date().getFullYear();
  const suffix = randomCode(6);
  return `${prefix}-${year}-${suffix}`;
}

export function generateBulkTokenCodes(examType: string, count: number): string[] {
  const codes = new Set<string>();
  while (codes.size < count) {
    codes.add(generateTokenCode(examType));
  }
  return Array.from(codes);
}
