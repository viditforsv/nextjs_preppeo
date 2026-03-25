"use client";

import type { ReactNode } from "react";
import Image from "next/image";
import { MathRenderer } from "./MathAtom";
import {
  preprocessLatex,
  processIncludegraphics,
} from "@/utils/latex/preprocessor";

export function renderMathContent(
  content: string,
  baseIndex: number
): ReactNode {
  // First, process includegraphics commands
  const { processedContent, images } = processIncludegraphics(content);

  // Then preprocess textcolor commands in the entire content
  const preprocessedContent = preprocessLatex(processedContent);

  // Then handle LaTeX line breaks
  const finalContent = preprocessedContent
    .replace(/\\\\/g, "<br>")
    .replace(/\\newline/g, "<br>")
    .replace(/\\par/g, "<br><br>");

  // Convert escaped dollars (\$) and leaked placeholders to HTML entity
  // so they render as $ without confusing math delimiter parsing
  const contentWithSafeDollars = finalContent
    .replace(/__LITERAL_DOLLAR__/g, "&#36;")
    .replace(/\\\$/g, "&#36;");

  const parts = contentWithSafeDollars.split(
    /(\$\$[\s\S]*?\$\$|\$[^$\n]*?\$|\\\[[\s\S]*?\\\]|\\\([^\\]*?\\\))/g
  );

  return parts.map((part, index) => {
    // Check for image placeholders first
    const imagePlaceholderMatch = part.match(
      /__INCLUDEGRAPHICS_PLACEHOLDER_(\d+)__/
    );
    if (imagePlaceholderMatch) {
      const imageIndex = parseInt(imagePlaceholderMatch[1]);
      const image = images[imageIndex];
      if (image) {
        const trimmedUrl = image.url.trim();
        if (!trimmedUrl) return null;

        const imageWidth = image.options.includes("width")
          ? image.options.match(/width=([^,}]+)/)?.[1] || "auto"
          : "auto";

        return (
          <div key={`${baseIndex}-${index}`} className="my-4 text-center">
            <Image
              src={trimmedUrl}
              alt="Question diagram"
              width={imageWidth === "auto" ? 800 : parseInt(imageWidth) || 800}
              height={600}
              className="max-w-full h-auto"
              style={{ width: imageWidth }}
              onError={(e) => {
                console.error("Image failed to load:", trimmedUrl);
                const target = e.target as HTMLImageElement;
                target.style.display = "none";
              }}
            />
          </div>
        );
      }
    }

    if (part.startsWith("$$") && part.endsWith("$$")) {
      return (
        <MathRenderer
          key={`${baseIndex}-${index}`}
          latex={part.slice(2, -2)}
          displayMode={true}
          className="block my-4 text-center"
        />
      );
    } else if (part.startsWith("\\[") && part.endsWith("\\]")) {
      return (
        <MathRenderer
          key={`${baseIndex}-${index}`}
          latex={part.slice(2, -2)}
          displayMode={true}
          className="block my-4 text-center"
        />
      );
    } else if (part.startsWith("$") && part.endsWith("$")) {
      return (
        <MathRenderer
          key={`${baseIndex}-${index}`}
          latex={part.slice(1, -1)}
          displayMode={false}
          className="inline"
        />
      );
    } else if (part.startsWith("\\(") && part.endsWith("\\)")) {
      return (
        <MathRenderer
          key={`${baseIndex}-${index}`}
          latex={part.slice(2, -2)}
          displayMode={false}
          className="inline"
        />
      );
    } else {
      // Regular text - convert LaTeX formatting commands to HTML
      const html = part
        .replace(
          /\\textbf\{([^{}]*(?:\{[^{}]*\}[^{}]*)*)\}/g,
          "<strong>$1</strong>"
        )
        .replace(
          /\\textit\{([^{}]*(?:\{[^{}]*\}[^{}]*)*)\}/g,
          "<em>$1</em>"
        )
        .replace(
          /\\underline\{([^{}]*(?:\{[^{}]*\}[^{}]*)*)\}/g,
          "<u>$1</u>"
        )
        .replace(
          /\\emph\{([^{}]*(?:\{[^{}]*\}[^{}]*)*)\}/g,
          "<em>$1</em>"
        );
      return (
        <span
          key={`${baseIndex}-${index}`}
          dangerouslySetInnerHTML={{ __html: html }}
        />
      );
    }
  });
}
