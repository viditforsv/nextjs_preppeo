"use client";

import { useEffect, useState } from "react";
import { Maximize2, X } from "lucide-react";

type Props = {
  slug: string;
  mediaAlt: string;
};

/**
 * Inline looping demo clip that the user can click to enlarge.
 * Inline size is capped by the article column (good on phones); on larger
 * screens that column is narrow, so clicking opens a full-viewport lightbox.
 */
export default function DesmosVideo({ slug, mediaAlt }: Props) {
  const [zoomed, setZoomed] = useState(false);

  // Close on Escape, and lock body scroll while the lightbox is open.
  useEffect(() => {
    if (!zoomed) return;
    const onKey = (e: KeyboardEvent) => {
      if (e.key === "Escape") setZoomed(false);
    };
    document.addEventListener("keydown", onKey);
    const prevOverflow = document.body.style.overflow;
    document.body.style.overflow = "hidden";
    return () => {
      document.removeEventListener("keydown", onKey);
      document.body.style.overflow = prevOverflow;
    };
  }, [zoomed]);

  const sources = (
    <>
      <source src={`/images/desmos/${slug}.webm`} type="video/webm" />
      <source src={`/images/desmos/${slug}.mp4`} type="video/mp4" />
    </>
  );

  return (
    <>
      {/* Inline clip — click to enlarge */}
      <button
        type="button"
        onClick={() => setZoomed(true)}
        aria-label="Enlarge demo clip"
        className="group relative block w-full cursor-zoom-in rounded-xl focus:outline-none focus-visible:ring-2 focus-visible:ring-cyan-500"
      >
        <video
          className="w-full rounded-xl border border-gray-200 shadow-sm"
          autoPlay
          muted
          loop
          playsInline
          preload="metadata"
          aria-label={mediaAlt}
        >
          {sources}
        </video>
        <span className="pointer-events-none absolute bottom-3 right-3 flex items-center gap-1.5 rounded-md bg-black/65 px-2.5 py-1.5 text-xs font-medium text-white opacity-90 transition-opacity group-hover:opacity-100">
          <Maximize2 className="h-3.5 w-3.5" />
          Click to enlarge
        </span>
      </button>

      {/* Lightbox overlay */}
      {zoomed && (
        <div
          role="dialog"
          aria-modal="true"
          aria-label="Enlarged demo clip"
          onClick={() => setZoomed(false)}
          className="fixed inset-0 z-50 flex items-center justify-center bg-black/80 p-4 backdrop-blur-sm sm:p-8"
        >
          <button
            type="button"
            onClick={() => setZoomed(false)}
            aria-label="Close enlarged view"
            className="absolute right-4 top-4 flex h-10 w-10 items-center justify-center rounded-full bg-white/10 text-white transition-colors hover:bg-white/20 focus:outline-none focus-visible:ring-2 focus-visible:ring-white"
          >
            <X className="h-5 w-5" />
          </button>
          <video
            className="max-h-[90vh] w-auto max-w-[95vw] cursor-zoom-out rounded-xl shadow-2xl"
            autoPlay
            muted
            loop
            playsInline
            aria-label={mediaAlt}
          >
            {sources}
          </video>
        </div>
      )}
    </>
  );
}
