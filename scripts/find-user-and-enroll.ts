#!/usr/bin/env tsx
/**
 * Script to find user in auth.users, create profile if needed, and enroll in GRE
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

// Create admin client for auth operations
const supabaseAdmin = createClient(supabaseUrl, supabaseServiceKey, {
  auth: {
    autoRefreshToken: false,
    persistSession: false
  }
});

const supabase = createClient(supabaseUrl, supabaseServiceKey);

async function findUserAndEnroll(email: string) {
  console.log(`🔍 Finding and enrolling user: ${email}\n`);

  // Step 1: Check profiles first
  console.log('1️⃣ Checking profiles table...');
  const { data: profile } = await supabase
    .from('profiles')
    .select('id, email, first_name, last_name, role')
    .eq('email', email)
    .maybeSingle();

  let userId: string | null = null;

  if (profile) {
    console.log(`   ✅ Found in profiles: ${profile.id}`);
    userId = profile.id;
  } else {
    console.log(`   ⚠️  Not in profiles, checking auth.users...`);
    
    // Try to find in auth.users using admin API
    try {
      // List users and find by email
      const { data: { users }, error: listError } = await supabaseAdmin.auth.admin.listUsers();
      
      if (listError) {
        console.error(`   ❌ Error listing users: ${listError.message}`);
        console.log(`\n💡 Solution: User needs to sign up first at https://courses.preppeo.com/auth`);
        console.log(`   Or manually create profile in Supabase Dashboard`);
        return;
      }

      const authUser = users.find(u => u.email?.toLowerCase() === email.toLowerCase());
      
      if (!authUser) {
        console.error(`   ❌ User not found in auth.users either`);
        console.log(`\n💡 User needs to sign up first:`);
        console.log(`   1. Go to https://courses.preppeo.com/auth`);
        console.log(`   2. Sign up with email: ${email}`);
        console.log(`   3. Then run this script again`);
        return;
      }

      console.log(`   ✅ Found in auth.users: ${authUser.id}`);
      console.log(`   ⚠️  Profile missing - creating profile...`);

      // Create profile
      const { data: newProfile, error: createError } = await supabase
        .from('profiles')
        .insert({
          id: authUser.id,
          email: authUser.email || email,
          role: 'student',
          first_name: authUser.user_metadata?.first_name || null,
          last_name: authUser.user_metadata?.last_name || null,
        })
        .select()
        .single();

      if (createError) {
        console.error(`   ❌ Error creating profile: ${createError.message}`);
        console.error(`   Details:`, createError);
        return;
      }

      console.log(`   ✅ Profile created!`);
      userId = newProfile.id;
    } catch (err) {
      console.error(`   ❌ Error: ${err instanceof Error ? err.message : 'Unknown error'}`);
      return;
    }
  }

  // Step 2: Find GRE course
  console.log('\n2️⃣ Finding GRE Quant course...');
  const { data: courses } = await supabase
    .from('courses')
    .select('id, title, slug, status, price')
    .or('slug.ilike.%gre%,title.ilike.%GRE%')
    .limit(5);

  if (!courses || courses.length === 0) {
    console.error('   ❌ No GRE course found');
    return;
  }

  const greCourse = courses.find(c => c.slug === 'gre-quant') || courses[0];
  console.log(`   ✅ Found: ${greCourse.title} (${greCourse.slug})`);

  // Step 3: Check/Create enrollment
  console.log('\n3️⃣ Checking enrollment...');
  const { data: enrollment } = await supabase
    .from('courses_enrollments')
    .select('id, is_active, enrolled_at')
    .eq('student_id', userId)
    .eq('course_id', greCourse.id)
    .maybeSingle();

  if (enrollment) {
    if (enrollment.is_active) {
      console.log(`   ✅ Already enrolled (${enrollment.enrolled_at})`);
      console.log(`\n✅ User is already enrolled!`);
      return;
    } else {
      console.log(`   ⚠️  Inactive enrollment - reactivating...`);
      await supabase
        .from('courses_enrollments')
        .update({ is_active: true })
        .eq('id', enrollment.id);
      console.log(`   ✅ Reactivated!`);
      return;
    }
  }

  // Create enrollment
  console.log(`   Creating new enrollment...`);
  const { data: newEnrollment, error: enrollError } = await supabase
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
    console.error(`   ❌ Error: ${enrollError.message}`);
    return;
  }

  console.log(`   ✅ Enrollment created!`);
  console.log(`\n✅ Success! User enrolled in GRE Quant course.`);
  console.log(`\n📝 Summary:`);
  console.log(`   User: ${email} (${userId})`);
  console.log(`   Course: ${greCourse.title}`);
  console.log(`   Enrollment ID: ${newEnrollment.id}`);
}

const email = process.argv[2];
if (!email) {
  console.error('Usage: npx tsx scripts/find-user-and-enroll.ts <email>');
  process.exit(1);
}

findUserAndEnroll(email)
  .then(() => process.exit(0))
  .catch((err) => {
    console.error('Error:', err);
    process.exit(1);
  });

