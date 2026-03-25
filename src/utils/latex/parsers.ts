// Detect plaintext data-table patterns in data-interpretation questions.
// Format A (pipe headers):  Data: H1 | H2 | H3: row1; row2. Question
// Format B (em-dash kv):    Data: Title (unit) — K1 V1, K2 V2, ... . Question
// Format C (coordinate):    Data: Title (C1, C2): (v1,v2), (v3,v4). Question
// Format D (kv with colon): Data: Title — K1: V1, K2: V2, ... . Question
export function parseDataTablePrompt(text: string): {
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
