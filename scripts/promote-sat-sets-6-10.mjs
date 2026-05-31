// One-off: promote QC'd SAT mock sets 6–10 from dev → prod.
// Reconciles by bank_item_id (unique) to handle dev/prod id divergence:
//   • Group A — dev row's bank_item_id already on prod (in pool): UPDATE that
//     prod row by bank_item_id, keeping prod's id (avoids the unique collision).
//   • Group B — no bank_item_id match: INSERT/UPDATE by id.
// Verified beforehand: 0 of these questions are in prod's live sets 1–5.
import { createClient } from "@supabase/supabase-js";
import { readFileSync } from "node:fs";

for (const line of readFileSync(".env.local", "utf8").split("\n")) {
  const m = line.match(/^([A-Z0-9_]+)=(.*)$/);
  if (m && !process.env[m[1]]) process.env[m[1]] = m[2].replace(/^["']|["']$/g, "");
}
const dev = createClient(process.env.NEXT_PUBLIC_SUPABASE_URL, process.env.SUPABASE_SERVICE_ROLE_KEY, { auth: { persistSession: false } });
const prod = createClient(process.env.NEXT_PUBLIC_SUPABASE_URL_PROD, process.env.SUPABASE_SERVICE_ROLE_KEY_PROD, { auth: { persistSession: false } });

const summarize = (rows) => {
  const by = {};
  for (const r of rows) by[r.set_number] = (by[r.set_number] || 0) + 1;
  return by;
};

const { data: devRows, error: devErr } = await dev.from("sat_questions").select("*").gte("set_number", 6).lte("set_number", 10);
if (devErr) throw devErr;
console.log(`dev: ${devRows.length} rows`, summarize(devRows));

// Which dev bank_item_ids already exist on prod?
const bankIds = devRows.map((r) => r.bank_item_id).filter(Boolean);
const prodBank = new Set();
for (let i = 0; i < bankIds.length; i += 200) {
  const { data, error } = await prod.from("sat_questions").select("bank_item_id").in("bank_item_id", bankIds.slice(i, i + 200));
  if (error) throw error;
  for (const r of data) prodBank.add(r.bank_item_id);
}

const groupA = devRows.filter((r) => r.bank_item_id && prodBank.has(r.bank_item_id)); // update by bank_item_id (strip id)
const groupB = devRows.filter((r) => !(r.bank_item_id && prodBank.has(r.bank_item_id))); // upsert by id
console.log(`group A (by bank_item_id, keep prod id): ${groupA.length}`);
console.log(`group B (by id, insert/update): ${groupB.length}`);

const upsert = async (rows, onConflict, stripId) => {
  let done = 0;
  for (let i = 0; i < rows.length; i += 100) {
    const batch = rows.slice(i, i + 100).map((r) => {
      if (!stripId) return r;
      const { id, ...rest } = r; // drop id so the matched prod row keeps its own
      void id;
      return rest;
    });
    const { error } = await prod.from("sat_questions").upsert(batch, { onConflict });
    if (error) throw error;
    done += batch.length;
    console.log(`  ${onConflict}: ${done}/${rows.length}`);
  }
};

await upsert(groupA, "bank_item_id", true);
await upsert(groupB, "id", false);

const { data: after, error: afterErr } = await prod.from("sat_questions").select("set_number, qc_done, is_active").gte("set_number", 6).lte("set_number", 10);
if (afterErr) throw afterErr;
console.log(`prod (after): ${after.length} rows in sets 6–10`, summarize(after));
console.log(`  qc_done=true: ${after.filter((r) => r.qc_done).length}, is_active=true: ${after.filter((r) => r.is_active).length}`);
console.log("DONE");
