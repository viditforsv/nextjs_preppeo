#!/usr/bin/env tsx
/**
 * List users and enroll specific user in GRE
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

async function listAndEnroll(searchEmail: string) {
  console.log(`🔍 Database: ${supabaseUrl}\n`);
  console.log(`🔍 Searching for: ${searchEmail}\n`);

  // List all profiles
  console.log('1️⃣ Listing all profiles...');
  const { data: profiles, error } = await supabase
    .from('profiles')
    .select('id, email, first_name, last_name, role, created_at')
    .order('created_at', { ascending: false })
    .limit(50);

  if (error) {
    console.error(`   ❌ Error: ${error.message}`);
    process.exit(1);
  }

  console.log(`   Found ${profiles?.length || 0} profiles\n`);

  if (profiles && profiles.length > 0) {
    console.log('   Recent profiles:');
    profiles.slice(0, 10).forEach((p, i) => {
      const match = p.email?.toLowerCase().includes(searchEmail.toLowerCase()) ? ' ⭐' : '';
      console.log(`   ${i + 1}. ${p.email} (${p.id})${match}`);
    });
  }

  // Search for exact match
  const matchingProfile = profiles?.find(p => 
    p.email?.toLowerCase() === searchEmail.toLowerCase()
  );

  if (!matchingProfile) {
    // Try partial match
    const partialMatch = profiles?.find(p => 
      p.email?.toLowerCase().includes(searchEmail.toLowerCase())
    );

    if (partialMatch) {
      console.log(`\n   ⚠️  Found partial match: ${partialMatch.email}`);
      console.log(`   Using this profile...`);
      await enrollUser(partialMatch.id, partialMatch.email);
      return;
    }

    console.log(`\n   ❌ User not found: ${searchEmail}`);
    console.log(`\n   💡 Options:`);
    console.log(`   1. Check if you're using the correct database (dev vs prod)`);
    console.log(`   2. Verify the email in Supabase Dashboard`);
    console.log(`   3. The user might be in a different database`);
    return;
  }

  console.log(`\n   ✅ Found exact match: ${matchingProfile.email}`);
  await enrollUser(matchingProfile.id, matchingProfile.email);
}

async function enrollUser(userId: string, userEmail: string) {
  console.log(`\n2️⃣ Finding GRE Quant course...`);
  const { data: courses } = await supabase
    .from('courses')
    .select('id, title, slug, status, price')
    .or('slug.ilike.%gre%,title.ilike.%GRE%')
    .order('slug');

  if (!courses || courses.length === 0) {
    console.error('   ❌ No GRE course found');
    return;
  }

  const greCourse = courses.find(c => c.slug === 'gre-quant') || courses[0];
  console.log(`   ✅ Found: ${greCourse.title} (${greCourse.slug})`);

  console.log(`\n3️⃣ Checking enrollment...`);
  const { data: enrollment } = await supabase
    .from('courses_enrollments')
    .select('id, is_active, enrolled_at')
    .eq('student_id', userId)
    .eq('course_id', greCourse.id)
    .maybeSingle();

  if (enrollment) {
    if (enrollment.is_active) {
      console.log(`   ✅ Already enrolled (${enrollment.enrolled_at})`);
      return;
    } else {
      console.log(`   ⚠️  Reactivating...`);
      await supabase
        .from('courses_enrollments')
        .update({ is_active: true })
        .eq('id', enrollment.id);
      console.log(`   ✅ Reactivated!`);
      return;
    }
  }

  console.log(`   Creating enrollment...`);
  const { data: newEnrollment, error } = await supabase
    .from('courses_enrollments')
    .insert({
      student_id: userId,
      course_id: greCourse.id,
      is_active: true,
      enrolled_at: new Date().toISOString(),
    })
    .select()
    .single();

  if (error) {
    console.error(`   ❌ Error: ${error.message}`);
    return;
  }

  console.log(`   ✅ Enrollment created!`);
  console.log(`\n✅ Success! User enrolled in GRE Quant course.`);
  console.log(`   User: ${userEmail}`);
  console.log(`   Course: ${greCourse.title}`);
  console.log(`   Enrollment ID: ${newEnrollment.id}`);
}

const email = process.argv[2];
if (!email) {
  console.error('Usage: npx tsx scripts/list-users-and-enroll.ts <email>');
  process.exit(1);
}

listAndEnroll(email)
  .then(() => process.exit(0))
  .catch((err) => {
    console.error('Error:', err);
    process.exit(1);
  });

