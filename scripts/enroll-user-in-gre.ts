#!/usr/bin/env tsx
/**
 * Script to enroll a user in the GRE Quant course
 * 
 * Usage:
 *   npx tsx scripts/enroll-user-in-gre.ts <user-email-or-id>
 * 
 * Example:
 *   npx tsx scripts/enroll-user-in-gre.ts user@example.com
 *   npx tsx scripts/enroll-user-in-gre.ts 123e4567-e89b-12d3-a456-426614174000
 */

import { createClient } from '@supabase/supabase-js';
import * as dotenv from 'dotenv';

dotenv.config({ path: '.env.local' });

// Prioritize PROD credentials, then fallback to DEV
const supabaseUrl = 
  process.env.NEXT_PUBLIC_SUPABASE_URL_PROD || 
  process.env.NEXT_PUBLIC_SUPABASE_PROD_URL ||
  process.env.NEXT_PUBLIC_SUPABASE_URL_DEV || 
  process.env.NEXT_PUBLIC_SUPABASE_URL;
  
const supabaseServiceKey = 
  process.env.SUPABASE_SERVICE_ROLE_KEY_PROD || 
  process.env.SUPABASE_SERVICE_ROLE_KEY_DEV || 
  process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!supabaseUrl || !supabaseServiceKey) {
  console.error('❌ Missing Supabase credentials');
  console.error('Required: NEXT_PUBLIC_SUPABASE_URL_PROD (or NEXT_PUBLIC_SUPABASE_URL)');
  console.error('         SUPABASE_SERVICE_ROLE_KEY_PROD (or SUPABASE_SERVICE_ROLE_KEY)');
  process.exit(1);
}

// Detect which environment we're using
const isProd = !!(
  process.env.NEXT_PUBLIC_SUPABASE_URL_PROD || 
  process.env.NEXT_PUBLIC_SUPABASE_PROD_URL ||
  supabaseUrl.includes('ootnqmojcqnzfrtvzzec')
);

console.log(`📊 Environment: ${isProd ? 'PRODUCTION' : 'DEV'}`);
console.log(`   Database: ${supabaseUrl}\n`);

const supabase = createClient(supabaseUrl, supabaseServiceKey);

async function enrollUserInGRE(userIdentifier: string) {
  console.log('🎓 Enrolling user in GRE Quant course...\n');

  // Step 1: Find the user
  console.log('1️⃣ Finding user...');
  let userId: string | null = null;

  // Check if it's a UUID (user ID)
  const uuidRegex = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;
  if (uuidRegex.test(userIdentifier)) {
    // It's a UUID, check if user exists in profiles
    const { data: profile, error } = await supabase
      .from('profiles')
      .select('id, email, first_name, last_name')
      .eq('id', userIdentifier)
      .single();

    if (error || !profile) {
      console.error(`   ❌ User not found with ID: ${userIdentifier}`);
      console.error(`   Error: ${error?.message || 'User does not exist'}`);
      process.exit(1);
    }
    userId = profile.id;
    console.log(`   ✅ Found user: ${profile.email || userIdentifier}`);
    if (profile.first_name || profile.last_name) {
      console.log(`      Name: ${profile.first_name || ''} ${profile.last_name || ''}`.trim());
    }
  } else {
    // It's an email, find user by email in profiles table
    const { data: profile, error } = await supabase
      .from('profiles')
      .select('id, email, first_name, last_name')
      .eq('email', userIdentifier)
      .maybeSingle();

    if (error) {
      console.error(`   ❌ Error fetching user: ${error.message}`);
      process.exit(1);
    }

    if (!profile) {
      console.error(`   ❌ User not found with email: ${userIdentifier}`);
      console.error(`   Note: User must have a profile in the profiles table`);
      console.error(`   Try using the user ID instead, or create a profile first`);
      process.exit(1);
    }

    userId = profile.id;
    console.log(`   ✅ Found user: ${profile.email} (${profile.id})`);
    if (profile.first_name || profile.last_name) {
      console.log(`      Name: ${profile.first_name || ''} ${profile.last_name || ''}`.trim());
    }
  }

  // Step 2: Find GRE course
  console.log('\n2️⃣ Finding GRE Quant course...');
  const { data: courses, error: courseError } = await supabase
    .from('courses')
    .select('id, title, slug, status, price')
    .or('slug.ilike.%gre%,title.ilike.%GRE%')
    .limit(5);

  if (courseError) {
    console.error(`   ❌ Error fetching courses: ${courseError.message}`);
    process.exit(1);
  }

  if (!courses || courses.length === 0) {
    console.error('   ❌ No GRE course found');
    console.error('   Please create the GRE course first');
    process.exit(1);
  }

  // Find the GRE Quant course (prefer slug 'gre-quant')
  let greCourse = courses.find(c => c.slug === 'gre-quant');
  if (!greCourse) {
    greCourse = courses.find(c => c.title.toLowerCase().includes('gre quant'));
  }
  if (!greCourse) {
    greCourse = courses[0]; // Use first GRE course found
  }

  console.log(`   ✅ Found course: ${greCourse.title} (${greCourse.slug})`);
  console.log(`      Status: ${greCourse.status}, Price: ${greCourse.price || 0}`);

  // Step 3: Check if already enrolled
  console.log('\n3️⃣ Checking existing enrollment...');
  const { data: existingEnrollment, error: checkError } = await supabase
    .from('courses_enrollments')
    .select('id, is_active, enrolled_at')
    .eq('student_id', userId)
    .eq('course_id', greCourse.id)
    .maybeSingle();

  if (checkError) {
    console.error(`   ❌ Error checking enrollment: ${checkError.message}`);
    process.exit(1);
  }

  if (existingEnrollment) {
    if (existingEnrollment.is_active) {
      console.log(`   ✅ User is already enrolled (enrolled at: ${existingEnrollment.enrolled_at})`);
      console.log(`\n✅ Enrollment already active - no action needed`);
      return;
    } else {
      console.log(`   ⚠️  User has inactive enrollment - reactivating...`);
      // Reactivate enrollment
      const { error: updateError } = await supabase
        .from('courses_enrollments')
        .update({ is_active: true })
        .eq('id', existingEnrollment.id);

      if (updateError) {
        console.error(`   ❌ Error reactivating enrollment: ${updateError.message}`);
        process.exit(1);
      }
      console.log(`   ✅ Enrollment reactivated`);
      return;
    }
  }

  // Step 4: Create enrollment
  console.log('\n4️⃣ Creating enrollment...');
  const { data: enrollment, error: enrollError } = await supabase
    .from('courses_enrollments')
    .insert({
      student_id: userId,
      course_id: greCourse.id,
      is_active: true,
      enrolled_at: new Date().toISOString(),
    })
    .select()
    .single();

  if (enrollError) {
    console.error(`   ❌ Error creating enrollment: ${enrollError.message}`);
    console.error(`   Details:`, enrollError);
    process.exit(1);
  }

  console.log(`   ✅ Enrollment created successfully!`);
  console.log(`      Enrollment ID: ${enrollment.id}`);
  console.log(`      Enrolled at: ${enrollment.enrolled_at}`);

  console.log('\n✅ Success! User is now enrolled in GRE Quant course.');
  console.log(`\n📝 Summary:`);
  console.log(`   User: ${userId}`);
  console.log(`   Course: ${greCourse.title} (${greCourse.slug})`);
  console.log(`   Enrollment ID: ${enrollment.id}`);
}

// Main execution
const userIdentifier = process.argv[2];

if (!userIdentifier) {
  console.error('❌ Missing user identifier');
  console.error('\nUsage:');
  console.error('  npx tsx scripts/enroll-user-in-gre.ts <user-email-or-id>');
  console.error('\nExamples:');
  console.error('  npx tsx scripts/enroll-user-in-gre.ts user@example.com');
  console.error('  npx tsx scripts/enroll-user-in-gre.ts 123e4567-e89b-12d3-a456-426614174000');
  process.exit(1);
}

enrollUserInGRE(userIdentifier)
  .then(() => {
    process.exit(0);
  })
  .catch((err) => {
    console.error('\n❌ Error:', err);
    process.exit(1);
  });

