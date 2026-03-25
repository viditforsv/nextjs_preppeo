"use client";

import type { ReactNode } from "react";
import { MathRenderer as MathRendererAtom } from "./math/MathAtom";
import { renderMathContent } from "./math/renderMathContent";
import { parseDataTablePrompt } from "@/utils/latex/parsers";
import { PlaintextDataTable } from "./math/PlaintextDataTable";
import {
  EnumerateRenderer,
  ItemizeRenderer,
  AlignRenderer,
  CasesRenderer,
  MatrixRenderer,
  PartsRenderer,
  TabularRenderer,
  TasksRenderer,
} from "./math/environments";

// Re-export the core KaTeX component
export { MathRendererAtom as MathRenderer };

// Helper function to render LaTeX strings with mixed content and environments
export function renderMixedContent(content: string): ReactNode {
  // Normalize leaked dollar placeholders from data early
  content = content.replace(/__LITERAL_DOLLAR__/g, "\\$");

  // Convert \$...\$ pairs to $...$ when content contains math operators,
  // so they render as math. Standalone \$ (currency like \$15) is left for later.
  content = content.replace(/\\\$([^$\\\n]+?)\\\$/g, (match, inner) => {
    if (/[=<>+\-*/^]/.test(inner)) return `$${inner}$`;
    return match;
  });

  // Detect plaintext data tables before any other processing
  const dataTable = parseDataTablePrompt(content);
  if (dataTable) {
    return (
      <>
        <PlaintextDataTable headers={dataTable.headers} rows={dataTable.rows} />
        {renderMixedContent(dataTable.question)}
      </>
    );
  }

  // Handle LaTeX environments (enumerate, itemize, align, etc.)
  const environmentRegex = /\\begin\{(\w+)\}([\s\S]*?)\\end\{\1\}/g;
  const parts: (string | { type: string; content: string })[] = [];
  let lastIndex = 0;
  let match;

  while ((match = environmentRegex.exec(content)) !== null) {
    if (match.index > lastIndex) {
      parts.push(content.slice(lastIndex, match.index));
    }
    parts.push({ type: match[1], content: match[2] });
    lastIndex = match.index + match[0].length;
  }

  if (lastIndex < content.length) {
    parts.push(content.slice(lastIndex));
  }

  return parts.map((part, index) => {
    if (typeof part === "object") {
      const { type, content } = part;

      switch (type) {
        case "enumerate":
          return <EnumerateRenderer key={index} content={content} />;
        case "itemize":
          return <ItemizeRenderer key={index} content={content} />;
        case "align":
        case "alignat":
        case "eqnarray":
        case "align*":
        case "alignat*":
        case "eqnarray*":
          return <AlignRenderer key={index} content={content} />;
        case "cases":
          return <CasesRenderer key={index} content={content} />;
        case "matrix":
        case "pmatrix":
        case "bmatrix":
        case "vmatrix":
        case "Vmatrix":
          return <MatrixRenderer key={index} content={content} type={type} />;
        case "parts":
          return <PartsRenderer key={index} content={content} />;
        case "tabular":
          return <TabularRenderer key={index} content={content} />;
        case "center":
          return (
            <div key={index} className="text-center my-4">
              {renderMixedContent(content)}
            </div>
          );
        case "tasks":
          return <TasksRenderer key={index} content={content} />;
        default:
          return (
            <MathRendererAtom
              key={index}
              latex={`\\begin{${type}}${content}\\end{${type}}`}
              displayMode={true}
              className="block my-4"
            />
          );
      }
    } else {
      return renderMathContent(part, index);
    }
  });
}

// Helper function to parse and render multi-part questions
export function renderMultiPartQuestion(content: string) {
  const hasParts =
    content.includes("**Part (") ||
    content.includes("Part (a)") ||
    content.includes("Part (b)");

  if (!hasParts) {
    return renderMixedContent(content);
  }

  const parts = [];
  const partRegex = /\*\*Part \([a-e]\) \[\d+ marks\]\*\*/g;
  let lastIndex = 0;
  let match;

  while ((match = partRegex.exec(content)) !== null) {
    if (match.index > lastIndex) {
      const beforePart = content.slice(lastIndex, match.index).trim();
      if (beforePart) {
        parts.push({ type: "main", content: beforePart });
      }
    }

    const partMatch = match[0].match(/\*\*Part \(([a-e])\) \[(\d+) marks\]\*\*/);
    if (partMatch) {
      const partLetter = partMatch[1];
      const marks = parseInt(partMatch[2]);
      const nextPartIndex = content.indexOf("**Part (", match.index + match[0].length);
      const partContent =
        nextPartIndex === -1
          ? content.slice(match.index + match[0].length).trim()
          : content.slice(match.index + match[0].length, nextPartIndex).trim();

      parts.push({ type: "part", letter: partLetter, marks, content: partContent });
    }

    lastIndex = match.index + match[0].length;
  }

  if (parts.length === 0) {
    return renderMixedContent(content);
  }

  return (
    <div className="space-y-6">
      {parts.map((part, index) => {
        if (part.type === "main") {
          return (
            <div key={index} className="prose max-w-none">
              {renderMixedContent(part.content)}
            </div>
          );
        } else if (part.type === "part") {
          return (
            <div key={index} className="border-l-4 border-blue-500 pl-4 py-2">
              <div className="flex items-center gap-2 mb-2">
                <span className="font-semibold text-blue-700">
                  Part ({part.letter})
                </span>
                <span className="text-sm text-gray-600 bg-gray-100 px-2 py-1 rounded">
                  {part.marks} marks
                </span>
              </div>
              <div className="prose max-w-none">
                {renderMixedContent(part.content)}
              </div>
            </div>
          );
        }
        return null;
      })}
    </div>
  );
}
