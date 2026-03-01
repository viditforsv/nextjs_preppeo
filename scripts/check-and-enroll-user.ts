#!/usr/bin/env tsx
/**
 * Script to check if user exists and enroll them in GRE course
 * Handles cases where user might exist in auth but not in profiles
 */

import { createClient } from '@supabase/supabase-js';
import * as dotenv from 'dotenv';

dotenv.config({ path: '.env.local' });

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL_DEV || process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY_DEV || process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!supabaseUrl || !supabaseServiceKey) {
  console.error('❌ Missing Supabase credentials');
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseServiceKey);

async function checkAndEnrollUser(email: string) {
  console.log(`🔍 Checking user: ${email}\n`);

  // Step 1: Check if user exists in profiles
  console.log('1️⃣ Checking profiles table...');
  const { data: profile, error: profileError } = await supabase
    .from('profiles')
    .select('id, email, first_name, last_name, role')
    .eq('email', email)
    .maybeSingle();

  if (profileError && profileError.code !== 'PGRST116') {
    console.error(`   ❌ Error: ${profileError.message}`);
    process.exit(1);
  }

  let userId: string | null = null;

  if (profile) {
    console.log(`   ✅ User found in profiles table`);
    console.log(`      ID: ${profile.id}`);
    console.log(`      Email: ${profile.email}`);
    console.log(`      Role: ${profile.role}`);
    userId = profile.id;
  } else {
    console.log(`   ⚠️  User not found in profiles table`);
    console.log(`   Checking auth.users...`);
    
    // Try to find user in auth.users by checking all users
    // Note: This requires admin access
    try {
      // Since we can't directly query auth.users, we'll try to create a profile
      // First, let's check if we can find them via a sign-in attempt or create profile manually
      console.log(`   ℹ️  User may need to sign up first, or profile creation may have failed`);
      console.log(`   💡 Options:`);
      console.log(`      1. User should sign up at https://courses.preppeo.com/auth`);
      console.log(`      2. Or provide the user's UUID if they already exist`);
      console.log(`      3. Or we can try to create a profile if you have their user ID`);
      
      // Ask for user ID
      console.log(`\n   Please provide the user's UUID (from auth.users table)`);
      console.log(`   You can find it in Supabase Dashboard → Authentication → Users`);
      return;
    } catch (err) {
      console.error(`   ❌ Error: ${err instanceof Error ? err.message : 'Unknown error'}`);
      return;
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
    console.error(`   ❌ Error: ${courseError.message}`);
    process.exit(1);
  }

  if (!courses || courses.length === 0) {
    console.error('   ❌ No GRE course found');
    process.exit(1);
  }

  const greCourse = courses.find(c => c.slug === 'gre-quant') || courses[0];
  console.log(`   ✅ Found: ${greCourse.title} (${greCourse.slug})`);

  // Step 3: Check enrollment
  console.log('\n3️⃣ Checking enrollment...');
  const { data: enrollment, error: enrollError } = await supabase
    .from('courses_enrollments')
    .select('id, is_active, enrolled_at')
    .eq('student_id', userId)
    .eq('course_id', greCourse.id)
    .maybeSingle();

  if (enrollError && enrollError.code !== 'PGRST116') {
    console.error(`   ❌ Error: ${enrollError.message}`);
    process.exit(1);
  }

  if (enrollment) {
    if (enrollment.is_active) {
      console.log(`   ✅ Already enrolled (enrolled: ${enrollment.enrolled_at})`);
      console.log(`\n✅ User is already enrolled in GRE Quant course!`);
      return;
    } else {
      console.log(`   ⚠️  Inactive enrollment found - reactivating...`);
      const { error: updateError } = await supabase
        .from('courses_enrollments')
        .update({ is_active: true })
        .eq('id', enrollment.id);

      if (updateError) {
        console.error(`   ❌ Error: ${updateError.message}`);
        process.exit(1);
      }
      console.log(`   ✅ Enrollment reactivated`);
      return;
    }
  }

  // Step 4: Create enrollment
  console.log(`\n4️⃣ Creating enrollment...`);
  const { data: newEnrollment, error: createError } = await supabase
    .from('courses_enrollments')
    .insert({
      student_id: userId,
      course_id: greCourse.id,
      is_active: true,
      enrolled_at: new Date().toISOString(),
    })
    .select()
    .single();

  if (createError) {
    console.error(`   ❌ Error: ${createError.message}`);
    console.error(`   Details:`, createError);
    process.exit(1);
  }

  console.log(`   ✅ Enrollment created!`);
  console.log(`      Enrollment ID: ${newEnrollment.id}`);
  console.log(`\n✅ Success! User enrolled in GRE Quant course.`);
}

const email = process.argv[2];
if (!email) {
  console.error('Usage: npx tsx scripts/check-and-enroll-user.ts <email>');
  process.exit(1);
}

checkAndEnrollUser(email)
  .then(() => process.exit(0))
  .catch((err) => {
    console.error('Error:', err);
    process.exit(1);
  });

