"use client";

import { MathRenderer } from "./MathAtom";
import { renderMathContent } from "./renderMathContent";

export function EnumerateRenderer({ content }: { content: string }) {
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

export function ItemizeRenderer({ content }: { content: string }) {
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

export function AlignRenderer({ content }: { content: string }) {
  return (
    <MathRenderer
      latex={`\\begin{align*}${content}\\end{align*}`}
      displayMode={true}
      className="block my-4 text-center"
    />
  );
}

export function CasesRenderer({ content }: { content: string }) {
  return (
    <MathRenderer
      latex={`\\begin{cases}${content}\\end{cases}`}
      displayMode={true}
      className="block my-4 text-center"
    />
  );
}

export function MatrixRenderer({
  content,
  type,
}: {
  content: string;
  type: string;
}) {
  return (
    <MathRenderer
      latex={`\\begin{${type}}${content}\\end{${type}}`}
      displayMode={true}
      className="block my-4 text-center"
    />
  );
}

export function TasksRenderer({ content }: { content: string }) {
  const parseTasks = (tasksContent: string) => {
    const columnMatch = tasksContent.match(/^\((\d+)\)/);
    const columns = columnMatch ? parseInt(columnMatch[1]) : 1;
    const cleanContent = tasksContent.replace(/^\(\d+\)/, "").trim();

    const taskRegex = /\\task\s+([\s\S]*?)(?=\\task|$)/g;
    const tasks: string[] = [];
    let match;

    while ((match = taskRegex.exec(cleanContent)) !== null) {
      if (match[1].trim()) tasks.push(match[1].trim());
    }

    return { tasks, columns };
  };

  const { tasks, columns } = parseTasks(content);

  if (tasks.length === 0) {
    return <div className="my-4 p-4 bg-gray-100 rounded">No tasks found</div>;
  }

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
              <MathRenderer latex={task} displayMode={false} className="inline" />
            </div>
          </div>
        </div>
      ))}
    </div>
  );
}

export function TabularRenderer({ content }: { content: string }) {
  const parseTabular = (tabularContent: string) => {
    const lines = tabularContent.split("\n").filter((line) => line.trim());
    const rows: string[][] = [];

    for (const line of lines) {
      const trimmed = line.trim();
      if (!trimmed || trimmed === "\\hline") continue;
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
        c = c.replace(/\*\*(.+?)\*\*/g, "\\textbf{$1}");
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
                  <MathRenderer latex={cell} displayMode={false} className="inline" />
                </td>
              ))}
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}

export function PartsRenderer({ content }: { content: string }) {
  const parts: { marks?: number; content: string }[] = [];
  const partRegex = /\\part(?:\[(\d+)\])?\s*([\s\S]*?)(?=\\part|$)/g;
  let match;

  while ((match = partRegex.exec(content)) !== null) {
    const marks = match[1] ? parseInt(match[1]) : undefined;
    const partContent = match[2].trim();
    if (partContent) parts.push({ marks, content: partContent });
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
