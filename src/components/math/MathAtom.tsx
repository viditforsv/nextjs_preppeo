"use client";

import { useEffect, useRef } from "react";
import katex from "katex";
import "katex/dist/katex.min.css";
import { preprocessLatex } from "@/utils/latex/preprocessor";

interface MathRendererProps {
  latex: string;
  displayMode?: boolean;
  className?: string;
}

export function MathRenderer({
  latex,
  displayMode = false,
  className = "",
}: MathRendererProps) {
  const mathRef = useRef<HTMLSpanElement>(null);

  useEffect(() => {
    if (mathRef.current && latex) {
      try {
        const processedLatex = preprocessLatex(latex);

        katex.render(processedLatex, mathRef.current, {
          throwOnError: false,
          displayMode,
          strict: false,
          trust: true,
          fleqn: false,
          leqno: false,
        });
      } catch (error) {
        console.error("KaTeX rendering error:", error);
        try {
          katex.render(latex, mathRef.current, {
            throwOnError: false,
            displayMode,
            strict: false,
            trust: true,
            fleqn: false,
            leqno: false,
          });
        } catch (fallbackError) {
          console.error("KaTeX fallback rendering error:", fallbackError);
          mathRef.current.innerHTML = latex;
        }
      }
    }
  }, [latex, displayMode]);

  return (
    <span
      ref={mathRef}
      className={`${className} ${
        displayMode ? "text-lg" : "text-base"
      } katex-math`}
    />
  );
}
