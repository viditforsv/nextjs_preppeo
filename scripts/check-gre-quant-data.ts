#!/usr/bin/env tsx
/**
 * Script to check GRE Quant data in Supabase
 * Checks for:
 * - gre_questions table existence
 * - Data in gre_questions table
 * - Related tables (bookmarks, notes, flashcards)
 * - Question bank data with GRE subject
 */

import { createClient } from '@supabase/supabase-js';
import * as dotenv from 'dotenv';

dotenv.config({ path: '.env.local' });

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!supabaseUrl || !supabaseServiceKey) {
  console.error('❌ Missing Supabase credentials');
  console.error('Required: NEXT_PUBLIC_SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY');
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseServiceKey);

async function checkGreQuantData() {
  console.log('🔍 Checking GRE Quant data in Supabase...\n');

  // 1. Check if gre_questions table exists
  console.log('1️⃣ Checking if gre_questions table exists...');
  try {
    const { data, error } = await supabase
      .from('gre_questions')
      .select('count')
      .limit(1);

    if (error) {
      if (error.code === '42P01') {
        console.log('   ❌ gre_questions table does NOT exist');
        console.log('   ⚠️  This is the main issue - the table was never created!');
      } else {
        console.log(`   ⚠️  Error checking table: ${error.message}`);
      }
    } else {
      console.log('   ✅ gre_questions table exists');
      
      // Count questions
      const { count } = await supabase
        .from('gre_questions')
        .select('*', { count: 'exact', head: true });
      
      console.log(`   📊 Total GRE questions: ${count || 0}`);
    }
  } catch (err) {
    console.log(`   ❌ Error: ${err instanceof Error ? err.message : 'Unknown error'}`);
  }

  // 2. Check question_bank for GRE-related questions
  console.log('\n2️⃣ Checking question_bank for GRE-related questions...');
  try {
    const { data, error } = await supabase
      .from('question_bank')
      .select('id, question_text, subject, topic, created_at')
      .or('subject.ilike.%GRE%,subject.ilike.%gre%,subject.ilike.%Quantitative%')
      .limit(10);

    if (error) {
      console.log(`   ⚠️  Error: ${error.message}`);
    } else {
      console.log(`   📊 Found ${data?.length || 0} GRE-related questions in question_bank`);
      if (data && data.length > 0) {
        console.log('   Sample questions:');
        data.slice(0, 3).forEach((q, i) => {
          console.log(`   ${i + 1}. Subject: ${q.subject}, Topic: ${q.topic || 'N/A'}`);
        });
      }
    }
  } catch (err) {
    console.log(`   ❌ Error: ${err instanceof Error ? err.message : 'Unknown error'}`);
  }

  // 3. Check for GRE course
  console.log('\n3️⃣ Checking for GRE course...');
  try {
    const { data, error } = await supabase
      .from('courses')
      .select('id, title, slug, subject, curriculum')
      .or('title.ilike.%GRE%,slug.ilike.%gre%')
      .limit(5);

    if (error) {
      console.log(`   ⚠️  Error: ${error.message}`);
    } else {
      console.log(`   📊 Found ${data?.length || 0} GRE-related courses`);
      if (data && data.length > 0) {
        data.forEach((course) => {
          console.log(`   - ${course.title} (${course.slug})`);
        });
      }
    }
  } catch (err) {
    console.log(`   ❌ Error: ${err instanceof Error ? err.message : 'Unknown error'}`);
  }

  // 4. Check related tables (bookmarks, notes, flashcards)
  console.log('\n4️⃣ Checking GRE-related user tables...');
  
  const tables = ['gre_user_bookmarks', 'gre_user_notes', 'gre_user_flashcards'];
  
  for (const table of tables) {
    try {
      const { data, error } = await supabase
        .from(table)
        .select('count')
        .limit(1);

      if (error) {
        if (error.code === '42P01') {
          console.log(`   ❌ ${table} does NOT exist`);
        } else {
          console.log(`   ⚠️  ${table}: ${error.message}`);
        }
      } else {
        const { count } = await supabase
          .from(table)
          .select('*', { count: 'exact', head: true });
        console.log(`   ✅ ${table} exists (${count || 0} records)`);
      }
    } catch (err) {
      console.log(`   ❌ ${table}: ${err instanceof Error ? err.message : 'Unknown error'}`);
    }
  }

  // 5. Check migration status
  console.log('\n5️⃣ Summary of issues:');
  console.log('   📋 Migration file: 20251221153306_add_gre_study_features.sql');
  console.log('   ⚠️  This migration tries to ALTER gre_questions table');
  console.log('   ❌ But gre_questions table was never created!');
  console.log('\n   💡 Solution: Create gre_questions table first, then run the migration');
}

checkGreQuantData()
  .then(() => {
    console.log('\n✅ Check complete');
    process.exit(0);
  })
  .catch((err) => {
    console.error('\n❌ Error:', err);
    process.exit(1);
  });

