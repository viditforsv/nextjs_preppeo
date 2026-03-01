#!/usr/bin/env tsx
/**
 * Count unique units in master_map_quant Google Sheet
 */

import { readFileSync } from "fs";
import { resolve } from "path";

async function main() {
  const jsonPath = resolve(process.cwd(), "scripts/google-sheets-output.json");
  
  const jsonContent = readFileSync(jsonPath, "utf-8");
  const sheetsData = JSON.parse(jsonContent);

  // Get unique units
  const units = new Set<string>();
  const unitChapters = new Map<string, Set<string>>();

  sheetsData.data.forEach((row: any) => {
    const unit = row["Unit"]?.trim();
    const chapter = row["Chapters"]?.trim();
    
    if (unit) {
      units.add(unit);
      
      if (!unitChapters.has(unit)) {
        unitChapters.set(unit, new Set());
      }
      if (chapter) {
        unitChapters.get(unit)!.add(chapter);
      }
    }
  });

  console.log("\n📊 Units in master_map_quant Google Sheet:\n");
  console.log(`Total Units: ${units.size}\n`);

  // Sort units and display with chapter counts
  const sortedUnits = Array.from(units).sort();
  
  sortedUnits.forEach((unit, index) => {
    const chapters = unitChapters.get(unit);
    const chapterCount = chapters ? chapters.size : 0;
    console.log(`${index + 1}. ${unit} (${chapterCount} chapters)`);
    
    if (chapters && chapters.size > 0) {
      Array.from(chapters).sort().forEach((chapter) => {
        console.log(`   - ${chapter}`);
      });
    }
  });

  console.log(`\n📋 Total Lessons: ${sheetsData.data.length}`);
}

main().catch(console.error);
