import { NextRequest, NextResponse } from "next/server";
import { PaymentService } from "@/lib/payments";
import { createClient } from "@/lib/supabase/server";
import { createSupabaseApiClient } from "@/lib/supabase/api-client";
import { sendTransactionalEmail } from "@/lib/email/send";
import { coursePurchaseEmail } from "@/lib/email/templates";

export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    const { provider, paymentData } = body;

    // Validate required fields
    if (!provider || !paymentData) {
      return NextResponse.json(
        { error: "Missing required fields: provider, paymentData" },
        { status: 400 }
      );
    }

    // Get user from session (optional for testing)
    const supabase = await createClient();
    const {
      data: { user },
      error: authError,
    } = await supabase.auth.getUser();

    // Use test user data if not authenticated (for testing purposes)
    let userId = "test-user-123";
    if (user && !authError) {
      userId = user.id;
    }

    // Verify payment
    const verificationResult = await PaymentService.verifyPayment(
      provider,
      paymentData
    );

    if (!verificationResult.success) {
      return NextResponse.json(
        { error: verificationResult.error || "Payment verification failed" },
        { status: 400 }
      );
    }

    // Extract course and payment info from payment data
    let courseId: string;
    let paymentId: string;
    let amount: number;
    let currency: string;

    if (provider === "razorpay") {
      courseId =
        paymentData.courseId ||
        (verificationResult.paymentDetails?.notes as Record<string, unknown>)?.courseId as string;
      paymentId = paymentData.razorpayPaymentId;
      amount = verificationResult.paymentDetails?.amount
        ? (verificationResult.paymentDetails.amount as number) / 100
        : 0;
      currency =
        (verificationResult.paymentDetails?.currency as string)?.toUpperCase() || "INR";
    } else {
      courseId =
        paymentData.courseId ||
        (verificationResult.paymentDetails?.metadata as Record<string, unknown>)?.courseId as string;
      paymentId = paymentData.paymentIntentId;
      amount = verificationResult.paymentDetails?.amount
        ? (verificationResult.paymentDetails.amount as number) / 100
        : 0;
      currency =
        (verificationResult.paymentDetails?.currency as string)?.toUpperCase() || "USD";
    }

    // Create enrollment record(s) (only if user is authenticated)
    if (user && !authError) {
      const serviceClient = createSupabaseApiClient();

      // Handle multiple course IDs (comma-separated for cart checkout)
      const courseIds = courseId.includes(",") 
        ? courseId.split(",") 
        : [courseId];

      const enrollments = courseIds.map(id => ({
        student_id: user.id,
        course_id: id,
        is_active: true,
        enrolled_at: new Date().toISOString(),
      }));

      const { error: enrollmentError } = await serviceClient
        .from("courses_enrollments")
        .insert(enrollments);

      if (enrollmentError) {
        console.error("Enrollment creation error:", enrollmentError);
        return NextResponse.json(
          { error: "Failed to create enrollment" },
          { status: 500 }
        );
      }

      const { error: paymentRecordError } = await serviceClient
        .from("payments")
        .insert({
          user_id: user.id,
          course_id: courseId,
          amount: amount,
          currency: currency,
          provider: provider,
          payment_id: paymentId,
          status: "completed",
          created_at: new Date().toISOString(),
        });

      if (paymentRecordError) {
        console.error("Payment record creation error:", paymentRecordError);
      }

      // Fire-and-forget: send purchase confirmation email
      (async () => {
        try {
          const [profileRes, coursesRes] = await Promise.all([
            serviceClient.from('profiles').select('first_name, email').eq('id', user.id).single(),
            serviceClient.from('courses').select('title').in('id', courseIds),
          ]);

          const firstName = profileRes.data?.first_name || '';
          const email = profileRes.data?.email || user.email || '';
          const courseTitles = (coursesRes.data || []).map(c => c.title);

          if (email && courseTitles.length > 0) {
            const { subject, html } = coursePurchaseEmail(firstName, courseTitles, amount, currency);
            await sendTransactionalEmail({ to: email, toName: firstName || undefined, subject, htmlBody: html });
          }
        } catch (err) {
          console.error('Purchase email failed (non-blocking):', err);
        }
      })();
    }

    return NextResponse.json({
      success: true,
      message: "Payment verified successfully",
      enrollment: {
        courseId,
        userId,
        enrolledAt: new Date().toISOString(),
      },
    });
  } catch (error) {
    console.error("Payment verification error:", error);
    return NextResponse.json(
      { error: "Internal server error" },
      { status: 500 }
    );
  }
}
