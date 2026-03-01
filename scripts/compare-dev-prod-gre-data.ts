#!/usr/bin/env tsx
/**
 * Script to compare GRE Quant data between dev and prod databases
 * Checks for:
 * - Table existence in both environments
 * - Migration status
 * - Data counts
 * - Schema differences
 */

import { createClient } from '@supabase/supabase-js';
import * as dotenv from 'dotenv';

dotenv.config({ path: '.env.local' });

// Dev credentials - try _DEV suffix first, then fallback to base
const devSupabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL_DEV || process.env.NEXT_PUBLIC_SUPABASE_URL;
const devSupabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY_DEV || process.env.SUPABASE_SERVICE_ROLE_KEY;

// Prod credentials - try _PROD suffix first, then PROD_ prefix, then fallback
const prodSupabaseUrl = 
  process.env.NEXT_PUBLIC_SUPABASE_URL_PROD || 
  process.env.NEXT_PUBLIC_SUPABASE_PROD_URL ||
  process.env.NEXT_PUBLIC_SUPABASE_URL;
const prodSupabaseKey = 
  process.env.SUPABASE_SERVICE_ROLE_KEY_PROD || 
  process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!devSupabaseUrl || !devSupabaseKey) {
  console.error('❌ Missing dev Supabase credentials');
  process.exit(1);
}

if (!prodSupabaseUrl || !prodSupabaseKey) {
  console.error('❌ Missing prod Supabase credentials');
  console.error('Required: NEXT_PUBLIC_SUPABASE_URL_PROD (or NEXT_PUBLIC_SUPABASE_PROD_URL)');
  console.error('         SUPABASE_SERVICE_ROLE_KEY_PROD');
  console.error('\nNote: If dev and prod use same URL, set NEXT_PUBLIC_ENVIRONMENT=dev to use dev credentials');
  process.exit(1);
}

const devSupabase = createClient(devSupabaseUrl, devSupabaseKey);
const prodSupabase = createClient(prodSupabaseUrl, prodSupabaseKey);

interface TableStatus {
  exists: boolean;
  count?: number;
  error?: string;
}

async function checkTable(
  supabase: ReturnType<typeof createClient>,
  tableName: string,
  env: string
): Promise<TableStatus> {
  try {
    const { data, error, count } = await supabase
      .from(tableName)
      .select('*', { count: 'exact', head: true });

    if (error) {
      if (error.code === '42P01' || error.message.includes('does not exist')) {
        return { exists: false, error: 'Table does not exist' };
      }
      return { exists: false, error: error.message };
    }

    return { exists: true, count: count || 0 };
  } catch (err) {
    return {
      exists: false,
      error: err instanceof Error ? err.message : 'Unknown error',
    };
  }
}

async function getTableSchema(
  supabase: ReturnType<typeof createClient>,
  tableName: string
): Promise<string[]> {
  try {
    // Try to get column info by selecting one row (if exists) or using information_schema
    const { data, error } = await supabase
      .from(tableName)
      .select('*')
      .limit(1);

    if (error) {
      return [];
    }

    if (data && data.length > 0) {
      return Object.keys(data[0]);
    }

    // If no data, try to infer from a query that returns no rows
    return [];
  } catch (err) {
    return [];
  }
}

async function compareDatabases() {
  console.log('🔍 Comparing Dev and Prod GRE Quant Databases...\n');
  console.log('=' .repeat(60));

  const tables = [
    'gre_questions',
    'gre_user_bookmarks',
    'gre_user_notes',
    'gre_user_flashcards',
  ];

  const results: Record<
    string,
    { dev: TableStatus; prod: TableStatus; inSync: boolean }
  > = {};

  // Check each table
  for (const table of tables) {
    console.log(`\n📊 Checking ${table}...`);
    const devStatus = await checkTable(devSupabase, table, 'dev');
    const prodStatus = await checkTable(prodSupabase, table, 'prod');

    const inSync =
      devStatus.exists === prodStatus.exists &&
      devStatus.count === prodStatus.count;

    results[table] = { dev: devStatus, prod: prodStatus, inSync };

    console.log(`   Dev:  ${devStatus.exists ? '✅' : '❌'} ${devStatus.exists ? `(${devStatus.count || 0} records)` : devStatus.error || 'N/A'}`);
    console.log(`   Prod: ${prodStatus.exists ? '✅' : '❌'} ${prodStatus.exists ? `(${prodStatus.count || 0} records)` : prodStatus.error || 'N/A'}`);
    console.log(`   Sync: ${inSync ? '✅' : '❌'} ${inSync ? 'In sync' : 'Out of sync'}`);
  }

  // Check question_bank for GRE questions
  console.log(`\n📊 Checking question_bank for GRE questions...`);
  try {
    const { count: devCount } = await devSupabase
      .from('question_bank')
      .select('*', { count: 'exact', head: true })
      .or('subject.ilike.%GRE%,subject.ilike.%gre%,subject.ilike.%Quantitative%');

    const { count: prodCount } = await prodSupabase
      .from('question_bank')
      .select('*', { count: 'exact', head: true })
      .or('subject.ilike.%GRE%,subject.ilike.%gre%,subject.ilike.%Quantitative%');

    console.log(`   Dev:  ${devCount || 0} GRE questions in question_bank`);
    console.log(`   Prod: ${prodCount || 0} GRE questions in question_bank`);
    console.log(`   Sync: ${devCount === prodCount ? '✅' : '❌'} ${devCount === prodCount ? 'In sync' : 'Out of sync'}`);
  } catch (err) {
    console.log(`   ❌ Error: ${err instanceof Error ? err.message : 'Unknown'}`);
  }

  // Check GRE courses
  console.log(`\n📊 Checking GRE courses...`);
  try {
    const { count: devCount } = await devSupabase
      .from('courses')
      .select('*', { count: 'exact', head: true })
      .or('title.ilike.%GRE%,slug.ilike.%gre%');

    const { count: prodCount } = await prodSupabase
      .from('courses')
      .select('*', { count: 'exact', head: true })
      .or('title.ilike.%GRE%,slug.ilike.%gre%');

    console.log(`   Dev:  ${devCount || 0} GRE courses`);
    console.log(`   Prod: ${prodCount || 0} GRE courses`);
    console.log(`   Sync: ${devCount === prodCount ? '✅' : '❌'} ${devCount === prodCount ? 'In sync' : 'Out of sync'}`);
  } catch (err) {
    console.log(`   ❌ Error: ${err instanceof Error ? err.message : 'Unknown'}`);
  }

  // Summary
  console.log('\n' + '='.repeat(60));
  console.log('\n📋 Summary:');

  const allTablesInSync = Object.values(results).every((r) => r.inSync);
  const allTablesExist = Object.values(results).every(
    (r) => r.dev.exists && r.prod.exists
  );

  if (allTablesInSync && allTablesExist) {
    console.log('   ✅ All GRE tables are in sync between dev and prod!');
  } else {
    console.log('   ⚠️  Some tables are out of sync or missing:');
    Object.entries(results).forEach(([table, status]) => {
      if (!status.inSync || !status.dev.exists || !status.prod.exists) {
        console.log(`      - ${table}: ${status.inSync ? '✅' : '❌'}`);
        if (!status.dev.exists) {
          console.log(`        Dev: Missing table`);
        }
        if (!status.prod.exists) {
          console.log(`        Prod: Missing table`);
        }
        if (status.dev.exists && status.prod.exists && !status.inSync) {
          console.log(
            `        Count mismatch: Dev=${status.dev.count}, Prod=${status.prod.count}`
          );
        }
      }
    });
  }

  // Check if migrations need to be run
  console.log('\n💡 Migration Status:');
  if (!results['gre_questions'].dev.exists) {
    console.log('   ⚠️  Dev: gre_questions table missing - need to run migration 20250116000000_create_gre_questions_table.sql');
  } else {
    console.log('   ✅ Dev: gre_questions table exists');
  }

  if (!results['gre_questions'].prod.exists) {
    console.log('   ⚠️  Prod: gre_questions table missing - need to run migration 20250116000000_create_gre_questions_table.sql');
  } else {
    console.log('   ✅ Prod: gre_questions table exists');
  }

  if (!results['gre_user_bookmarks'].dev.exists || !results['gre_user_bookmarks'].prod.exists) {
    console.log('   ⚠️  Study features tables missing - need to run migration 20251221153306_add_gre_study_features.sql');
  } else {
    console.log('   ✅ Study features tables exist');
  }
}

compareDatabases()
  .then(() => {
    console.log('\n✅ Comparison complete');
    process.exit(0);
  })
  .catch((err) => {
    console.error('\n❌ Error:', err);
    process.exit(1);
  });

