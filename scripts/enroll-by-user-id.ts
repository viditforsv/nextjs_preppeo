#!/usr/bin/env tsx
/**
 * Enroll user in GRE course by user ID (UUID)
 * Use this if you have the user's UUID from Supabase Dashboard
 * 
 * Usage:
 *   npx tsx scripts/enroll-by-user-id.ts <user-uuid> [email-for-display]
 */

import { createClient } from '@supabase/supabase-js';
import * as dotenv from 'dotenv';

dotenv.config({ path: '.env.local' });

// Try prod first, then dev
const prodUrl = process.env.NEXT_PUBLIC_SUPABASE_URL_PROD;
const prodKey = process.env.SUPABASE_SERVICE_ROLE_KEY_PROD;

const devUrl = process.env.NEXT_PUBLIC_SUPABASE_URL_DEV || process.env.NEXT_PUBLIC_SUPABASE_URL;
const devKey = process.env.SUPABASE_SERVICE_ROLE_KEY_DEV || process.env.SUPABASE_SERVICE_ROLE_KEY;

// Use prod if available, otherwise dev
const supabaseUrl = prodUrl || devUrl;
const supabaseServiceKey = prodKey || devKey;

if (!supabaseUrl || !supabaseServiceKey) {
  console.error('❌ Missing Supabase credentials');
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseServiceKey);

async function enrollByUserId(userId: string, email?: string) {
  console.log(`🎓 Enrolling user in GRE Quant course...\n`);
  console.log(`📊 Database: ${supabaseUrl.includes('prod') ? 'PROD' : 'DEV'}\n`);

  // Validate UUID format
  const uuidRegex = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;
  if (!uuidRegex.test(userId)) {
    console.error(`❌ Invalid UUID format: ${userId}`);
    console.error(`   UUID should be in format: xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx`);
    process.exit(1);
  }

  // Step 1: Verify user exists
  console.log('1️⃣ Verifying user...');
  const { data: profile, error: profileError } = await supabase
    .from('profiles')
    .select('id, email, first_name, last_name, role')
    .eq('id', userId)
    .maybeSingle();

  if (profileError) {
    console.error(`   ❌ Error: ${profileError.message}`);
    process.exit(1);
  }

  if (!profile) {
    console.error(`   ❌ User not found with ID: ${userId}`);
    console.error(`\n   💡 Make sure:`);
    console.error(`   1. You're using the correct database (check URL above)`);
    console.error(`   2. The user ID is correct`);
    console.error(`   3. The user has a profile in the profiles table`);
    process.exit(1);
  }

  console.log(`   ✅ User found:`);
  console.log(`      ID: ${profile.id}`);
  console.log(`      Email: ${profile.email || email || 'N/A'}`);
  console.log(`      Name: ${profile.first_name || ''} ${profile.last_name || ''}`.trim() || 'N/A');
  console.log(`      Role: ${profile.role}`);

  // Step 2: Find GRE course
  console.log(`\n2️⃣ Finding GRE Quant course...`);
  const { data: courses, error: courseError } = await supabase
    .from('courses')
    .select('id, title, slug, status, price')
    .or('slug.ilike.%gre%,title.ilike.%GRE%')
    .order('slug');

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
  console.log(`\n3️⃣ Checking enrollment...`);
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
      console.log(`   ✅ Already enrolled!`);
      console.log(`      Enrollment ID: ${enrollment.id}`);
      console.log(`      Enrolled at: ${enrollment.enrolled_at}`);
      console.log(`\n✅ User is already enrolled - no action needed.`);
      return;
    } else {
      console.log(`   ⚠️  Inactive enrollment found - reactivating...`);
      const { error: updateError } = await supabase
        .from('courses_enrollments')
        .update({ 
          is_active: true,
          enrolled_at: new Date().toISOString()
        })
        .eq('id', enrollment.id);

      if (updateError) {
        console.error(`   ❌ Error: ${updateError.message}`);
        process.exit(1);
      }

      console.log(`   ✅ Enrollment reactivated!`);
      console.log(`\n✅ Success! Enrollment has been reactivated.`);
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
    console.error(`   Code: ${createError.code}`);
    if (createError.code === '23503') {
      console.error(`\n   💡 Foreign key constraint error. Verify:`);
      console.error(`   - User ID exists in auth.users`);
      console.error(`   - Course ID exists in courses table`);
    }
    process.exit(1);
  }

  console.log(`   ✅ Enrollment created!`);
  console.log(`      Enrollment ID: ${newEnrollment.id}`);
  console.log(`\n✅ Success! User enrolled in GRE Quant course.`);
  console.log(`\n📝 Summary:`);
  console.log(`   User: ${profile.email || email || userId}`);
  console.log(`   User ID: ${userId}`);
  console.log(`   Course: ${greCourse.title}`);
  console.log(`   Enrollment ID: ${newEnrollment.id}`);
}

const userId = process.argv[2];
const email = process.argv[3];

if (!userId) {
  console.error('Usage: npx tsx scripts/enroll-by-user-id.ts <user-uuid> [email]');
  console.error('\nExample:');
  console.error('  npx tsx scripts/enroll-by-user-id.ts 123e4567-e89b-12d3-a456-426614174000');
  console.error('  npx tsx scripts/enroll-by-user-id.ts 123e4567-e89b-12d3-a456-426614174000 aviagr1811@gmail.com');
  console.error('\n💡 To find the user ID:');
  console.error('   1. Go to Supabase Dashboard → Authentication → Users');
  console.error('   2. Find the user by email');
  console.error('   3. Copy their UUID');
  process.exit(1);
}

enrollByUserId(userId, email)
  .then(() => process.exit(0))
  .catch((err) => {
    console.error('\n❌ Error:', err);
    process.exit(1);
  });

