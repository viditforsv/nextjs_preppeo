#!/usr/bin/env tsx
/**
 * Accurately count chapters in master_map_quant Google Sheet
 */

import { readFileSync } from "fs";
import { resolve } from "path";

async function main() {
  const jsonPath = resolve(process.cwd(), "scripts/google-sheets-output.json");
  
  const jsonContent = readFileSync(jsonPath, "utf-8");
  const sheetsData = JSON.parse(jsonContent);

  // Get unique chapters per unit
  const unitChapters = new Map<string, Map<string, number>>();

  sheetsData.data.forEach((row: any) => {
    const unit = row["Unit"]?.trim();
    const chapter = row["Chapters"]?.trim();
    
    if (unit && chapter) {
      if (!unitChapters.has(unit)) {
        unitChapters.set(unit, new Map());
      }
      
      const chapters = unitChapters.get(unit)!;
      if (!chapters.has(chapter)) {
        chapters.set(chapter, 0);
      }
      chapters.set(chapter, chapters.get(chapter)! + 1);
    }
  });

  console.log("\n📊 Chapters in master_map_quant Google Sheet:\n");

  let totalChapters = 0;
  const sortedUnits = Array.from(unitChapters.keys()).sort();
  
  sortedUnits.forEach((unit, unitIndex) => {
    const chapters = unitChapters.get(unit)!;
    const sortedChapters = Array.from(chapters.keys()).sort();
    
    console.log(`${unitIndex + 1}. ${unit} (${sortedChapters.length} chapters)`);
    sortedChapters.forEach((chapter, chapterIndex) => {
      const lessonCount = chapters.get(chapter)!;
      console.log(`   ${chapterIndex + 1}. ${chapter} (${lessonCount} lessons)`);
    });
    console.log();
    
    totalChapters += sortedChapters.length;
  });

  console.log(`📋 Total Chapters: ${totalChapters}`);
  console.log(`📋 Total Lessons: ${sheetsData.data.length}`);
}

main().catch(console.error);
