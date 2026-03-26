/** Ordered prompt figure URLs: imageUrls wins when non-empty; else single imageUrl. */
export function satPromptImageUrls(q: {
  imageUrls?: string[];
  imageUrl?: string;
}): string[] {
  if (q.imageUrls?.length) return q.imageUrls;
  if (q.imageUrl) return [q.imageUrl];
  return [];
}
