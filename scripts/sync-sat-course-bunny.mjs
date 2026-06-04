/**
 * Sync compiled SAT-course PDFs → Bunny CDN storage.
 *
 * Walks `Docs for me/latex_with_rijay/2. Preppeo/sat_maths_self_learn_course/**.pdf`, uploads each
 * to the Bunny storage zone under `sat-learn/<relative-path>`, and prints the
 * public CDN URL plus ready-to-paste SQL for `sat_learn_items.pdf_url`.
 *
 * Local → Bunny mapping (1:1):
 *   sat_maths_self_learn_course/sat-math/linear-equations/x.pdf
 *     → storage:  sat-learn/sat-math/linear-equations/x.pdf
 *     → url:      https://shrividhyaclasses.b-cdn.net/sat-learn/sat-math/linear-equations/x.pdf
 *
 * Usage (from nextjs_preppeo repo root):
 *   node scripts/sync-sat-course-bunny.mjs            # upload all PDFs
 *   node scripts/sync-sat-course-bunny.mjs --dry-run  # list what would upload, no writes
 *   node scripts/sync-sat-course-bunny.mjs --sql      # also emit UPDATE statements
 *
 * Reads from .env.local: bunny_storage_zone, bunny_storage_host, bunny_storage_password.
 * The pull zone is referer-locked, so this script does NOT fetch-verify URLs;
 * the app serves these through /api/pdf-proxy. A 201 on upload is success.
 */

import { config } from "dotenv";
import { resolve, relative, join, sep } from "path";
import { readdirSync, statSync, readFileSync } from "fs";
import { fileURLToPath } from "url";

const __dirname = resolve(fileURLToPath(import.meta.url), "..");
const ROOT = resolve(__dirname, "..");
config({ path: resolve(ROOT, ".env.local") });

const SOURCE_DIR = resolve(
  ROOT,
  "Docs for me/latex_with_rijay/2. Preppeo/sat_maths_self_learn_course"
);
const STORAGE_PREFIX = "sat-learn"; // Bunny path root for self-paced SAT content
const PUBLIC_BASE = "https://shrividhyaclasses.b-cdn.net";

const args = new Set(process.argv.slice(2));
const DRY_RUN = args.has("--dry-run");
const EMIT_SQL = args.has("--sql");

const zone = process.env.bunny_storage_zone;
const host = process.env.bunny_storage_host;
const pass = process.env.bunny_storage_password;

if (!zone || !host || !pass) {
  console.error(
    "Missing Bunny storage env vars. Need bunny_storage_zone, bunny_storage_host, bunny_storage_password in .env.local"
  );
  process.exit(1);
}

/** Recursively collect all *.pdf paths under dir. */
function findPdfs(dir) {
  const out = [];
  let entries;
  try {
    entries = readdirSync(dir);
  } catch {
    return out;
  }
  for (const name of entries) {
    const full = join(dir, name);
    const st = statSync(full);
    if (st.isDirectory()) out.push(...findPdfs(full));
    else if (name.toLowerCase().endsWith(".pdf")) out.push(full);
  }
  return out;
}

const pdfs = findPdfs(SOURCE_DIR);

if (pdfs.length === 0) {
  console.log(`No PDFs found under ${SOURCE_DIR}`);
  console.log("Compile some .tex first (see sat_maths_self_learn_course/README.md), then re-run.");
  process.exit(0);
}

console.log(
  `${DRY_RUN ? "[dry-run] " : ""}Found ${pdfs.length} PDF(s) under sat_maths_self_learn_course/\n`
);

const uploaded = [];

for (const pdfPath of pdfs) {
  // Relative path under sat_maths_self_learn_course/, normalised to forward slashes.
  const rel = relative(SOURCE_DIR, pdfPath).split(sep).join("/");
  const storagePath = `${STORAGE_PREFIX}/${rel}`;
  const publicUrl = `${PUBLIC_BASE}/${storagePath}`;

  if (DRY_RUN) {
    console.log(`would upload  ${rel}\n           →  ${publicUrl}\n`);
    uploaded.push({ rel, publicUrl });
    continue;
  }

  const body = readFileSync(pdfPath);
  const res = await fetch(`https://${host}/${zone}/${storagePath}`, {
    method: "PUT",
    headers: { AccessKey: pass, "Content-Type": "application/pdf" },
    body,
  });

  if (res.status === 201 || res.status === 200) {
    console.log(`✓ uploaded  ${rel}\n          →  ${publicUrl}\n`);
    uploaded.push({ rel, publicUrl });
  } else {
    console.error(
      `✗ FAILED   ${rel}  (${res.status} ${res.statusText})\n           ${await res.text()}\n`
    );
  }
}

console.log(
  `\nDone. ${uploaded.length}/${pdfs.length} ${DRY_RUN ? "would sync" : "synced"}.`
);

if (EMIT_SQL && uploaded.length > 0) {
  console.log(
    "\n-- Paste into a migration; match each file to its item slug.\n" +
      "-- course/topic/item slugs come from the path; verify against sat_learn_items.\n"
  );
  for (const { rel, publicUrl } of uploaded) {
    // rel = <course-slug>/<topic-slug>/<file>.pdf
    const [course, topic] = rel.split("/");
    console.log(
      `-- ${rel}\n` +
        `UPDATE public.sat_learn_items i\n` +
        `   SET pdf_url = '${publicUrl}'\n` +
        `  FROM public.sat_learn_topics t, public.sat_learn_courses c\n` +
        ` WHERE i.topic_id = t.id AND t.course_id = c.id\n` +
        `   AND c.slug = '${course ?? ""}' AND t.slug = '${topic ?? ""}'\n` +
        `   AND i.type = 'pdf' /* AND i.slug = '<item-slug>' */;\n`
    );
  }
}
