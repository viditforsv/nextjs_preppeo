"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { Check, Loader2 } from "lucide-react";

const NAVY = "#1a365d";

export function MarkComplete({
  itemId,
  completed,
}: {
  itemId: string;
  completed: boolean;
}) {
  const router = useRouter();
  const [done, setDone] = useState(completed);
  const [loading, setLoading] = useState(false);

  const toggle = async () => {
    setLoading(true);
    try {
      const res = await fetch("/api/sat-learn/progress", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ itemId, completed: !done }),
      });
      if (res.ok) {
        setDone((d) => !d);
        router.refresh(); // re-render sidebar/curriculum checkmarks
      }
    } finally {
      setLoading(false);
    }
  };

  return (
    <button
      onClick={toggle}
      disabled={loading}
      className="inline-flex items-center gap-2 rounded-lg border px-4 py-2 text-sm font-semibold transition-colors disabled:opacity-60"
      style={
        done
          ? { background: "#dcfce7", color: "#16a34a", borderColor: "#bbf7d0" }
          : { background: "white", color: NAVY, borderColor: "#e5e7eb" }
      }
    >
      {loading ? (
        <Loader2 className="h-4 w-4 animate-spin" />
      ) : (
        <Check className="h-4 w-4" />
      )}
      {done ? "Completed" : "Mark complete"}
    </button>
  );
}
