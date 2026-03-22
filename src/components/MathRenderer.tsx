"use client";

import type { ReactNode } from "react";
import { useEffect, useRef } from "react";
import Image from "next/image";
import katex from "katex";
import "katex/dist/katex.min.css";

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
        // Preprocess the LaTeX to handle textcolor and other commands
        const processedLatex = preprocessLatex(latex);

        katex.render(processedLatex, mathRef.current, {
          throwOnError: false,
          displayMode,
          strict: false,
          trust: true,
          // Increase font size for better readability
          fleqn: false,
          leqno: false,
        });
      } catch (error) {
        console.error("KaTeX rendering error:", error);
        // Fallback: try rendering without preprocessing
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
          mathRef.current.innerHTML = latex; // Final fallback to raw LaTeX
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

// Helper function to parse and render multi-part questions
export function renderMultiPartQuestion(content: string) {
  // Check if this looks like a multi-part question
  const hasParts =
    content.includes("**Part (") ||
    content.includes("Part (a)") ||
    content.includes("Part (b)");

  if (!hasParts) {
    return renderMixedContent(content);
  }

  // Split content into main question and parts
  const parts = [];
  const partRegex = /\*\*Part \([a-e]\) \[\d+ marks\]\*\*/g;
  let lastIndex = 0;
  let match;

  while ((match = partRegex.exec(content)) !== null) {
    // Add content before this part
    if (match.index > lastIndex) {
      const beforePart = content.slice(lastIndex, match.index).trim();
      if (beforePart) {
        parts.push({
          type: "main",
          content: beforePart,
        });
      }
    }

    // Extract part details
    const partMatch = match[0].match(
      /\*\*Part \(([a-e])\) \[(\d+) marks\]\*\*/
    );
    if (partMatch) {
      const partLetter = partMatch[1];
      const marks = parseInt(partMatch[2]);

      // Find the content of this part (until next part or end)
      const nextPartIndex = content.indexOf(
        "**Part (",
        match.index + match[0].length
      );
      const partContent =
        nextPartIndex === -1
          ? content.slice(match.index + match[0].length).trim()
          : content.slice(match.index + match[0].length, nextPartIndex).trim();

      parts.push({
        type: "part",
        letter: partLetter,
        marks: marks,
        content: partContent,
      });
    }

    lastIndex = match.index + match[0].length;
  }

  // If no parts were found, fall back to regular rendering
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

// Detect plaintext data-table patterns in data-interpretation questions.
// Format A (pipe headers):  Data: H1 | H2 | H3: row1; row2. Question
// Format B (em-dash kv):    Data: Title (unit) — K1 V1, K2 V2, ... . Question
// Format C (coordinate):    Data: Title (C1, C2): (v1,v2), (v3,v4). Question
// Format D (kv with colon): Data: Title — K1: V1, K2: V2, ... . Question
function parseDataTablePrompt(text: string): {
  headers: string[];
  rows: string[][];
  question: string;
} | null {
  // --- Format A: pipe-separated headers, semicolon-separated rows ---
  const pipeMatch = text.match(
    /^Data:\s*(.+?)\s*:\s*(.+?)\.\s+([\s\S]+)$/
  );
  if (pipeMatch) {
    const headers = pipeMatch[1]
      .split("|")
      .map((h) => h.replace(/\\\$/g, "$").trim());
    if (headers.length >= 2) {
      const rowStrings = pipeMatch[2].split(";").map((r) => r.trim());
      const rows = rowStrings.map((rowStr) => {
        const chunks = rowStr.split(", ");
        if (chunks.length === headers.length) {
          return chunks.map((c) => c.trim());
        }
        if (chunks.length > 0 && chunks.length < headers.length) {
          const first = chunks[0];
          const boundary = first.match(/^(.+?)\s+(\d[\d,]*)$/);
          if (boundary) {
            return [boundary[1], boundary[2], ...chunks.slice(1)].map((c) =>
              c.trim()
            );
          }
        }
        return chunks.map((c) => c.trim());
      });
      return { headers, rows, question: pipeMatch[3] };
    }
  }

  // --- Format C: coordinate pairs  ---
  // Matches both "Title (Col1, Col2): (v1,v2), ..." and "Title (unit): (v1,v2), ..."
  const coordMatch = text.match(
    /^Data:\s*(.+?)\(([^)]+)\)\s*:\s*((?:\([^)]+\)(?:,\s*)?)+)\.\s+([\s\S]+)$/
  );
  if (coordMatch) {
    const title = coordMatch[1].trim();
    const parenContent = coordMatch[2].trim();
    const pairStrings = coordMatch[3].match(/\(([^)]+)\)/g) ?? [];
    const rows = pairStrings.map((p) =>
      p.replace(/[()]/g, "").split(",").map((v) => v.trim())
    );
    if (rows.length > 0) {
      const colCount = rows[0].length;
      let headers: string[];
      const parenCols = parenContent.split(",").map((h) => h.trim());
      if (parenCols.length === colCount) {
        headers = parenCols;
      } else {
        // Infer from "X vs Y" in title, with unit from parenthetical
        const vsMatch = title.match(/^(.+?)\s+vs\s+(.+)$/i);
        if (vsMatch && colCount === 2) {
          headers = [
            `${vsMatch[2].trim()} (${parenContent})`,
            vsMatch[1].trim(),
          ];
        } else {
          headers = Array.from({ length: colCount }, (_, i) => `Col ${i + 1}`);
        }
      }
      return { headers, rows, question: coordMatch[4] };
    }
  }

  // --- Format D: em-dash with Key: Value pairs ---
  const kvColonMatch = text.match(
    /^Data:\s*(.+?)\s*—\s*(.+?)\.\s+([\s\S]+)$/
  );
  if (kvColonMatch) {
    const title = kvColonMatch[1].trim();
    const dataStr = kvColonMatch[2].trim();
    const question = kvColonMatch[3];

    // Check for colon-separated key:value  (e.g. "2021: 20, 2022: 35")
    const kvColonPairs = dataStr.split(",").map((s) => s.trim());
    const colonParsed = kvColonPairs.every((p) => p.includes(":"));
    if (colonParsed && kvColonPairs.length >= 2) {
      const labelHeader = title.replace(/\(.*\)/, "").trim() || "Label";
      const unitMatch = title.match(/\(([^)]+)\)/);
      const valueHeader = unitMatch ? unitMatch[1] : "Value";
      const rows = kvColonPairs.map((p) => {
        const [k, ...rest] = p.split(":");
        return [k.trim(), rest.join(":").trim()];
      });
      return { headers: [labelHeader, valueHeader], rows, question };
    }

    // Format B: em-dash with "Key Value" pairs (e.g. "Jan 400, Feb 350")
    const kvPairs = dataStr.split(",").map((s) => s.trim());
    if (kvPairs.length >= 2) {
      const parsed = kvPairs.map((p) => {
        const m = p.match(/^(.+?)\s+([\d,.]+)$/);
        return m ? [m[1].trim(), m[2].trim()] : [p, ""];
      });
      if (parsed.every((r) => r[1] !== "")) {
        const labelHeader = title.replace(/\(.*\)/, "").trim() || "Label";
        const unitMatch = title.match(/\(([^)]+)\)/);
        const valueHeader = unitMatch ? unitMatch[1] : "Value";
        return { headers: [labelHeader, valueHeader], rows: parsed, question };
      }
    }
  }

  return null;
}

function PlaintextDataTable({
  headers,
  rows,
}: {
  headers: string[];
  rows: string[][];
}) {
  return (
    <div className="my-4 overflow-x-auto">
      <table className="min-w-full border-collapse border border-gray-300 rounded-sm">
        <thead>
          <tr className="bg-gray-50">
            {headers.map((h, i) => (
              <th
                key={i}
                className="border border-gray-300 px-4 py-2 text-left text-sm font-semibold text-gray-700"
              >
                {h}
              </th>
            ))}
          </tr>
        </thead>
        <tbody>
          {rows.map((row, ri) => (
            <tr key={ri}>
              {row.map((cell, ci) => (
                <td
                  key={ci}
                  className="border border-gray-300 px-4 py-2 text-sm text-gray-800"
                >
                  {cell}
                </td>
              ))}
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}

// Helper function to render LaTeX strings with mixed content and environments
export function renderMixedContent(content: string): ReactNode {
  // Normalize leaked dollar placeholders from data early
  content = content.replace(/__LITERAL_DOLLAR__/g, '\\$');

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

  // First, handle LaTeX environments (enumerate, itemize, align, etc.)
  // Use a more robust approach to handle multiline environments
  const environmentRegex = /\\begin\{(\w+)\}([\s\S]*?)\\end\{\1\}/g;
  const parts: (string | { type: string; content: string })[] = [];
  let lastIndex = 0;
  let match;

  while ((match = environmentRegex.exec(content)) !== null) {
    // Add text before the environment
    if (match.index > lastIndex) {
      parts.push(content.slice(lastIndex, match.index));
    }

    // Add the environment
    parts.push({
      type: match[1],
      content: match[2],
    });

    lastIndex = match.index + match[0].length;
  }

  // Add remaining text
  if (lastIndex < content.length) {
    parts.push(content.slice(lastIndex));
  }

  return parts.map((part, index) => {
    if (typeof part === "object") {
      // This is an environment
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
          // For other environments, render as display math
          return (
            <MathRenderer
              key={index}
              latex={`\\begin{${type}}${content}\\end{${type}}`}
              displayMode={true}
              className="block my-4"
            />
          );
      }
    } else {
      // Regular content - handle math delimiters
      return renderMathContent(part, index);
    }
  });
}

// Helper function to render math content within regular text
function renderMathContent(content: string, baseIndex: number) {
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
    .replace(/__LITERAL_DOLLAR__/g, '&#36;')
    .replace(/\\\$/g, '&#36;');

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
        // Trim the image URL to prevent Next.js errors about trailing spaces
        const trimmedUrl = image.url.trim();
        if (!trimmedUrl) {
          return null; // Skip if URL is empty after trimming
        }
        
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
              style={{
                width: imageWidth,
              }}
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
      // Display math with $$
      return (
        <MathRenderer
          key={`${baseIndex}-${index}`}
          latex={part.slice(2, -2)}
          displayMode={true}
          className="block my-4 text-center"
        />
      );
    } else if (part.startsWith("\\[") && part.endsWith("\\]")) {
      // Display math with \[ \]
      return (
        <MathRenderer
          key={`${baseIndex}-${index}`}
          latex={part.slice(2, -2)}
          displayMode={true}
          className="block my-4 text-center"
        />
      );
    } else if (part.startsWith("$") && part.endsWith("$")) {
      // Inline math with $
      return (
        <MathRenderer
          key={`${baseIndex}-${index}`}
          latex={part.slice(1, -1)}
          displayMode={false}
          className="inline"
        />
      );
    } else if (part.startsWith("\\(") && part.endsWith("\\)")) {
      // Inline math with \( \)
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
        .replace(/\\textbf\{([^{}]*(?:\{[^{}]*\}[^{}]*)*)\}/g, '<strong>$1</strong>')
        .replace(/\\textit\{([^{}]*(?:\{[^{}]*\}[^{}]*)*)\}/g, '<em>$1</em>')
        .replace(/\\underline\{([^{}]*(?:\{[^{}]*\}[^{}]*)*)\}/g, '<u>$1</u>')
        .replace(/\\emph\{([^{}]*(?:\{[^{}]*\}[^{}]*)*)\}/g, '<em>$1</em>');
      return (
        <span
          key={`${baseIndex}-${index}`}
          dangerouslySetInnerHTML={{ __html: html }}
        />
      );
    }
  });
}

// Helper function to preprocess LaTeX content for better textcolor handling
function preprocessLatex(latex: string): string {
  // Normalize double-escaped backslash commands (e.g. \\circ → \circ).
  // This happens when data is inserted with an extra escaping pass, leaving
  // \\command (two backslashes + word) where LaTeX expects \command (one backslash).
  // We only collapse when \\ is immediately followed by a letter so that a lone
  // \\ (line-break in display environments) is left untouched.
  latex = latex.replace(/\\\\([a-zA-Z])/g, '\\$1');

  // Handle textcolor commands - convert to KaTeX compatible format
  // Use a more robust regex that handles nested braces
  return (
    latex
      .replace(
        /\\textcolor\{red\}\{([^{}]*(?:\{[^{}]*\}[^{}]*)*)\}/g,
        "\\color{red}{$1}"
      )
      .replace(
        /\\textcolor\{blue\}\{([^{}]*(?:\{[^{}]*\}[^{}]*)*)\}/g,
        "\\color{blue}{$1}"
      )
      .replace(
        /\\textcolor\{green\}\{([^{}]*(?:\{[^{}]*\}[^{}]*)*)\}/g,
        "\\color{green}{$1}"
      )
      .replace(
        /\\textcolor\{([^{}]+)\}\{([^{}]*(?:\{[^{}]*\}[^{}]*)*)\}/g,
        "\\color{$1}{$2}"
      )
      // Convert \cfrac to \frac (KaTeX doesn't support \cfrac)
      .replace(/\\cfrac/g, "\\frac")
      // Handle enumerate environments - convert to HTML lists
      .replace(/\\begin\{enumerate\}/g, "")
      .replace(/\\end\{enumerate\}/g, "")
      .replace(/\\item\[(\d+)\]/g, "$1. ")
      .replace(/\\item/g, "• ")
      // Handle other common LaTeX commands that might not be supported
      .replace(/\\centering/g, "")
      .replace(/\\vspace\{[^}]*\}/g, "")
      .replace(/\\hspace\{[^}]*\}/g, "")
  );
}

// Helper function to extract and replace includegraphics commands
function processIncludegraphics(content: string): {
  processedContent: string;
  images: Array<{ url: string; options: string }>;
} {
  const images: Array<{ url: string; options: string }> = [];
  const includegraphicsPattern =
    /\\includegraphics(?:\[([^\]]*)\])?\{([^}]+)\}/g;

  const processedContent = content.replace(
    includegraphicsPattern,
    (match, options, url) => {
      // Trim the URL to prevent Next.js errors about trailing spaces
      const trimmedUrl = url.trim();
      const imageIndex = images.length;
      images.push({ url: trimmedUrl, options: options || "" });

      console.log(
        `🖼️ Found includegraphics: ${trimmedUrl} with options: ${options || "none"}`
      );

      // Replace with a placeholder that we'll handle in the renderer
      return `__INCLUDEGRAPHICS_PLACEHOLDER_${imageIndex}__`;
    }
  );

  if (images.length > 0) {
    console.log(`🖼️ Processed ${images.length} images in content`);
  }

  return { processedContent, images };
}

// Enumerate environment renderer
function EnumerateRenderer({ content }: { content: string }) {
  // Split by \item and filter out empty items
  const items = content
    .split("\\item")
    .map((item) => item.trim())
    .filter((item) => item.length > 0);

  return (
    <ol className="list-decimal list-inside my-4 space-y-2 ml-4">
      {items.map((item, index) => (
        <li key={index} className="prose max-w-none">
          {renderMathContent(item, index)}
        </li>
      ))}
    </ol>
  );
}

// Itemize environment renderer
function ItemizeRenderer({ content }: { content: string }) {
  // Split by \item and filter out empty items
  const items = content
    .split("\\item")
    .map((item) => item.trim())
    .filter((item) => item.length > 0);

  return (
    <ul className="list-disc list-inside my-4 space-y-2 ml-4">
      {items.map((item, index) => (
        <li key={index} className="prose max-w-none">
          {renderMathContent(item, index)}
        </li>
      ))}
    </ul>
  );
}

// Align environment renderer
function AlignRenderer({ content }: { content: string }) {
  // The content should already have proper LaTeX formatting
  // Just pass it through to KaTeX with the correct environment
  return (
    <MathRenderer
      latex={`\\begin{align*}${content}\\end{align*}`}
      displayMode={true}
      className="block my-4 text-center"
    />
  );
}

// Cases environment renderer
function CasesRenderer({ content }: { content: string }) {
  return (
    <MathRenderer
      latex={`\\begin{cases}${content}\\end{cases}`}
      displayMode={true}
      className="block my-4 text-center"
    />
  );
}

// Matrix environment renderer
function MatrixRenderer({ content, type }: { content: string; type: string }) {
  return (
    <MathRenderer
      latex={`\\begin{${type}}${content}\\end{${type}}`}
      displayMode={true}
      className="block my-4 text-center"
    />
  );
}

// Tasks environment renderer for LaTeX tasks/exercises
function TasksRenderer({ content }: { content: string }) {
  // Parse the tasks content to extract individual tasks
  const parseTasks = (tasksContent: string) => {
    // Handle the optional parameter for number of columns (e.g., \begin{tasks}(2))
    const columnMatch = tasksContent.match(/^\((\d+)\)/);
    const columns = columnMatch ? parseInt(columnMatch[1]) : 1;

    // Remove the column parameter from content
    const cleanContent = tasksContent.replace(/^\(\d+\)/, "").trim();

    // Split by \task commands
    const taskRegex = /\\task\s+([\s\S]*?)(?=\\task|$)/g;
    const tasks: string[] = [];
    let match;

    while ((match = taskRegex.exec(cleanContent)) !== null) {
      if (match[1].trim()) {
        tasks.push(match[1].trim());
      }
    }

    return { tasks, columns };
  };

  const { tasks, columns } = parseTasks(content);

  if (tasks.length === 0) {
    return <div className="my-4 p-4 bg-gray-100 rounded">No tasks found</div>;
  }

  // Create grid layout based on number of columns
  const gridCols =
    columns === 1
      ? "grid-cols-1"
      : columns === 2
      ? "grid-cols-1 md:grid-cols-2"
      : columns === 3
      ? "grid-cols-1 md:grid-cols-2 lg:grid-cols-3"
      : "grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4";

  return (
    <div className={`my-4 grid ${gridCols} gap-4`}>
      {tasks.map((task, index) => (
        <div
          key={index}
          className="border border-gray-200 rounded-sm p-4 bg-white"
        >
          <div className="flex items-start gap-3">
            <span className="flex-shrink-0 w-6 h-6 bg-orange-100 text-orange-800 rounded-full flex items-center justify-center text-sm font-medium">
              {index + 1}
            </span>
            <div className="flex-1">
              <MathRenderer
                latex={task}
                displayMode={false}
                className="inline"
              />
            </div>
          </div>
        </div>
      ))}
    </div>
  );
}

// Tabular environment renderer for LaTeX tables
function TabularRenderer({ content }: { content: string }) {
  const parseTabular = (tabularContent: string) => {
    const lines = tabularContent.split("\n").filter((line) => line.trim());
    const rows: string[][] = [];

    for (const line of lines) {
      const trimmed = line.trim();
      if (!trimmed || trimmed === "\\hline") continue;
      // Skip column spec lines like {|c|c|} or {lrr}
      if (/^\{[|clrp{}\d. ]+\}$/.test(trimmed)) continue;

      let cleanLine = line;
      if (line.includes("\\hline") && line.includes("&")) {
        cleanLine = line.replace(/^\\hline\s*/, "").replace(/\s*\\hline$/, "");
      }

      const cells = cleanLine.split("&").map((cell) => {
        let c = cell
          .replace(/\\hline/g, "")
          .replace(/\\\\/g, "")
          .trim();
        // Convert markdown bold to LaTeX \textbf
        c = c.replace(/\*\*(.+?)\*\*/g, "\\textbf{$1}");
        // Unwrap $...$ since MathRenderer already treats input as LaTeX
        c = c.replace(/^\$(.+)\$$/, "$1");
        return c;
      });

      if (cells.length > 0 && cells.some((cell) => cell.length > 0)) {
        rows.push(cells);
      }
    }

    return rows;
  };

  const rows = parseTabular(content);

  if (rows.length === 0) {
    return <div className="my-4 p-4 bg-gray-100 rounded">Empty table</div>;
  }

  return (
    <div className="my-4 overflow-x-auto">
      <table className="min-w-full border-collapse border border-gray-300 rounded-sm">
        <tbody>
          {rows.map((row, rowIndex) => (
            <tr
              key={rowIndex}
              className={rowIndex === 0 ? "bg-gray-50 font-semibold" : ""}
            >
              {row.map((cell, cellIndex) => (
                <td
                  key={cellIndex}
                  className="border border-gray-300 px-3 py-2 text-center"
                >
                  <MathRenderer
                    latex={cell}
                    displayMode={false}
                    className="inline"
                  />
                </td>
              ))}
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}

// Parts environment renderer for multi-part questions
function PartsRenderer({ content }: { content: string }) {
  const parts: { marks?: number; content: string }[] = [];

  // Use a more precise regex to match \part commands and their content
  const partRegex = /\\part(?:\[(\d+)\])?\s*([\s\S]*?)(?=\\part|$)/g;
  let match;

  while ((match = partRegex.exec(content)) !== null) {
    const marks = match[1] ? parseInt(match[1]) : undefined;
    const partContent = match[2].trim();

    if (partContent) {
      parts.push({ marks, content: partContent });
    }
  }

  return (
    <ol className="list-decimal list-inside my-4 space-y-3 ml-4">
      {parts.map((part, index) => (
        <li key={index} className="prose max-w-none">
          {part.marks && (
            <span className="text-sm text-gray-600 bg-gray-100 px-2 py-1 rounded-sm mr-2">
              [{part.marks} marks]
            </span>
          )}
          {renderMathContent(part.content, index)}
        </li>
      ))}
    </ol>
  );
}
