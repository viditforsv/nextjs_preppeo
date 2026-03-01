#!/usr/bin/env tsx
/**
 * Direct enrollment script - finds user and enrolls in GRE
 * More robust search to handle edge cases
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

async function directEnroll(email: string) {
  console.log(`🔍 Searching for user: ${email}\n`);

  // Step 1: Search profiles with case-insensitive
  console.log('1️⃣ Searching profiles table...');
  const { data: allProfiles, error: profileError } = await supabase
    .from('profiles')
    .select('id, email, first_name, last_name, role')
    .ilike('email', email);

  if (profileError) {
    console.error(`   ❌ Error: ${profileError.message}`);
    process.exit(1);
  }

  if (!allProfiles || allProfiles.length === 0) {
    // Try exact match
    const { data: exactProfile } = await supabase
      .from('profiles')
      .select('id, email, first_name, last_name, role')
      .eq('email', email)
      .maybeSingle();

    if (!exactProfile) {
      console.error(`   ❌ User not found in profiles table`);
      console.log(`\n   Available profiles: ${allProfiles?.length || 0}`);
      console.log(`   Try checking Supabase Dashboard → Table Editor → profiles`);
      process.exit(1);
    }

    console.log(`   ✅ Found user:`);
    console.log(`      ID: ${exactProfile.id}`);
    console.log(`      Email: ${exactProfile.email}`);
    console.log(`      Name: ${exactProfile.first_name || ''} ${exactProfile.last_name || ''}`.trim() || 'N/A');
    console.log(`      Role: ${exactProfile.role}`);
    
    await enrollUser(exactProfile.id, exactProfile.email);
    return;
  }

  // Found multiple or one
  const profile = allProfiles.find(p => p.email?.toLowerCase() === email.toLowerCase()) || allProfiles[0];
  
  console.log(`   ✅ Found user:`);
  console.log(`      ID: ${profile.id}`);
  console.log(`      Email: ${profile.email}`);
  console.log(`      Name: ${profile.first_name || ''} ${profile.last_name || ''}`.trim() || 'N/A');
  console.log(`      Role: ${profile.role}`);

  await enrollUser(profile.id, profile.email);
}

async function enrollUser(userId: string, userEmail: string) {
  // Step 2: Find GRE course
  console.log('\n2️⃣ Finding GRE Quant course...');
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

  // Prefer gre-quant slug, otherwise first GRE course
  const greCourse = courses.find(c => c.slug === 'gre-quant') || courses[0];
  console.log(`   ✅ Found course: ${greCourse.title}`);
  console.log(`      Slug: ${greCourse.slug}`);
  console.log(`      Status: ${greCourse.status}`);
  console.log(`      Price: ${greCourse.price || 0}`);

  // Step 3: Check existing enrollment
  console.log('\n3️⃣ Checking enrollment status...');
  const { data: enrollment, error: enrollError } = await supabase
    .from('courses_enrollments')
    .select('id, is_active, enrolled_at, course_id')
    .eq('student_id', userId)
    .eq('course_id', greCourse.id)
    .maybeSingle();

  if (enrollError && enrollError.code !== 'PGRST116') {
    console.error(`   ❌ Error: ${enrollError.message}`);
    process.exit(1);
  }

  if (enrollment) {
    if (enrollment.is_active) {
      console.log(`   ✅ User is already enrolled!`);
      console.log(`      Enrollment ID: ${enrollment.id}`);
      console.log(`      Enrolled at: ${enrollment.enrolled_at}`);
      console.log(`\n✅ No action needed - user is already enrolled.`);
      return;
    } else {
      console.log(`   ⚠️  Found inactive enrollment - reactivating...`);
      const { error: updateError } = await supabase
        .from('courses_enrollments')
        .update({ 
          is_active: true,
          enrolled_at: new Date().toISOString()
        })
        .eq('id', enrollment.id);

      if (updateError) {
        console.error(`   ❌ Error reactivating: ${updateError.message}`);
        process.exit(1);
      }

      console.log(`   ✅ Enrollment reactivated!`);
      console.log(`\n✅ Success! User enrollment has been reactivated.`);
      return;
    }
  }

  // Step 4: Create new enrollment
  console.log(`\n4️⃣ Creating new enrollment...`);
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
    console.error(`   ❌ Error creating enrollment: ${createError.message}`);
    console.error(`   Code: ${createError.code}`);
    console.error(`   Details:`, createError);
    
    // Check if it's a foreign key constraint
    if (createError.code === '23503') {
      console.error(`\n   💡 This might be a foreign key constraint issue.`);
      console.error(`   Verify that:`);
      console.error(`   - User ID ${userId} exists in auth.users`);
      console.error(`   - Course ID ${greCourse.id} exists in courses table`);
    }
    
    process.exit(1);
  }

  console.log(`   ✅ Enrollment created successfully!`);
  console.log(`      Enrollment ID: ${newEnrollment.id}`);
  console.log(`      Enrolled at: ${newEnrollment.enrolled_at}`);

  console.log(`\n✅ Success! User has been enrolled in GRE Quant course.`);
  console.log(`\n📝 Summary:`);
  console.log(`   User: ${userEmail} (${userId})`);
  console.log(`   Course: ${greCourse.title} (${greCourse.slug})`);
  console.log(`   Enrollment ID: ${newEnrollment.id}`);
}

const email = process.argv[2];
if (!email) {
  console.error('Usage: npx tsx scripts/direct-enroll-gre.ts <email>');
  process.exit(1);
}

directEnroll(email)
  .then(() => process.exit(0))
  .catch((err) => {
    console.error('\n❌ Error:', err);
    process.exit(1);
  });

