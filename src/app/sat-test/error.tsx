"use client";

import { useEffect } from "react";
import Link from "next/link";
import { captureError } from "@/lib/error-tracking";

export default function SATTestError({
  error,
  reset,
}: {
  error: Error & { digest?: string };
  reset: () => void;
}) {
  useEffect(() => {
    captureError(error, { route: "sat-test" });
  }, [error]);

  return (
    <div className="min-h-screen flex items-center justify-center p-8">
      <div className="text-center max-w-md">
        <h2 className="text-xl font-semibold text-[#1e293b] mb-2">
          SAT test session error
        </h2>
        <p className="text-muted-foreground text-sm mb-6">
          Something went wrong during your test session. Your answers up to this
          point have been saved.
        </p>
        <div className="flex gap-3 justify-center">
          <button
            onClick={reset}
            className="px-4 py-2 bg-[#1a365d] text-white text-sm rounded-sm hover:bg-[#1a365d]/90 transition-colors"
          >
            Try again
          </button>
          <Link
            href="/student"
            className="px-4 py-2 border border-gray-300 text-sm rounded-sm hover:bg-gray-50 transition-colors"
          >
            Go to dashboard
          </Link>
        </div>
      </div>
    </div>
  );
}
