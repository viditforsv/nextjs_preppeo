// Pure LaTeX preprocessing utilities — no React deps

export function preprocessLatex(latex: string): string {
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

export function processIncludegraphics(content: string): {
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
