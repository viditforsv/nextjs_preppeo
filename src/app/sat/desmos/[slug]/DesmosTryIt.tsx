"use client";

import { useEffect, useRef, useState } from "react";
import { RotateCcw, Calculator } from "lucide-react";

export interface TryItConfig {
  prompt: string;
  expressions: string[];
  table?: { columns: { latex: string; values: string[] }[] };
}

// window.Desmos is declared globally in src/components/sat-test/DesmosCalculator.tsx.
interface DesmosCalc {
  setExpression(e: Record<string, unknown>): void;
  setBlank(): void;
  destroy(): void;
}

// Matches the key/version already used by the in-test calculator.
const API_KEY =
  process.env.NEXT_PUBLIC_DESMOS_API_KEY ||
  "7ec567acab5644a88d78433aa0351089";
const SRC = `https://www.desmos.com/api/v1.11/calculator.js?apiKey=${API_KEY}`;

let scriptPromise: Promise<void> | null = null;
function loadDesmos(): Promise<void> {
  if (typeof window === "undefined") return Promise.resolve();
  if (window.Desmos) return Promise.resolve();
  if (scriptPromise) return scriptPromise;
  scriptPromise = new Promise((resolve, reject) => {
    const s = document.createElement("script");
    s.src = SRC;
    s.async = true;
    s.onload = () => resolve();
    s.onerror = () => reject(new Error("Desmos failed to load"));
    document.head.appendChild(s);
  });
  return scriptPromise;
}

export default function DesmosTryIt({ tryIt }: { tryIt: TryItConfig }) {
  const containerRef = useRef<HTMLDivElement>(null);
  const calcRef = useRef<DesmosCalc | null>(null);
  const [visible, setVisible] = useState(false);
  const [error, setError] = useState(false);

  // Only initialise once the section is near the viewport — the Desmos bundle
  // is heavy, so we don't pay for it on a guide the student never scrolls to.
  useEffect(() => {
    const el = containerRef.current;
    if (!el) return;
    const io = new IntersectionObserver(
      (entries) => {
        if (entries[0].isIntersecting) {
          setVisible(true);
          io.disconnect();
        }
      },
      { rootMargin: "250px" }
    );
    io.observe(el);
    return () => io.disconnect();
  }, []);

  useEffect(() => {
    if (!visible) return;
    let calc: DesmosCalc | null = null;
    let cancelled = false;
    loadDesmos()
      .then(() => {
        if (cancelled || !containerRef.current || !window.Desmos) return;
        const c = window.Desmos.GraphingCalculator(containerRef.current, {
          expressions: true,
          settingsMenu: false,
          expressionsTopbar: false,
          border: false,
          lockViewport: false,
          keypad: true,
        }) as unknown as DesmosCalc;
        calc = c;
        calcRef.current = c;
        seed(c, tryIt);
      })
      .catch(() => setError(true));
    return () => {
      cancelled = true;
      if (calc) calc.destroy();
      calcRef.current = null;
    };
  }, [visible, tryIt]);

  return (
    <div>
      <p className="text-sm text-gray-600 mb-3 leading-relaxed">
        {tryIt.prompt}
      </p>
      <div className="relative overflow-hidden rounded-xl border border-gray-200 bg-white shadow-sm">
        <div
          ref={containerRef}
          className="h-[420px] w-full"
          aria-label="Interactive Desmos calculator"
        />
        {!visible && (
          <div className="absolute inset-0 flex flex-col items-center justify-center gap-2 text-gray-400">
            <Calculator className="h-7 w-7" />
            <p className="text-sm">Loading interactive calculator…</p>
          </div>
        )}
        {error && (
          <div className="absolute inset-0 flex flex-col items-center justify-center gap-2 bg-white px-6 text-center text-gray-500">
            <Calculator className="h-7 w-7" />
            <p className="text-sm">Couldn&apos;t load the calculator here.</p>
            <a
              href="https://www.desmos.com/calculator"
              target="_blank"
              rel="noopener noreferrer"
              className="text-sm font-semibold text-cyan-700 hover:underline"
            >
              Open Desmos in a new tab →
            </a>
          </div>
        )}
      </div>
      {visible && !error && (
        <button
          type="button"
          onClick={() => calcRef.current && seed(calcRef.current, tryIt)}
          className="mt-3 inline-flex items-center gap-1.5 text-sm font-semibold text-cyan-700 hover:underline"
        >
          <RotateCcw className="h-3.5 w-3.5" />
          Reset to the example
        </button>
      )}
    </div>
  );
}

function seed(calc: DesmosCalc, tryIt: TryItConfig) {
  calc.setBlank();
  if (tryIt.table) {
    calc.setExpression({ type: "table", columns: tryIt.table.columns });
  }
  tryIt.expressions.forEach((latex, i) =>
    calc.setExpression({ id: `try-${i}`, latex })
  );
}
