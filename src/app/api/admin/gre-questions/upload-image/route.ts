import { NextRequest, NextResponse } from 'next/server';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';

const BUCKET = 'gre-question-images';
const MAX_SIZE = 5 * 1024 * 1024; // 5 MB

export async function DELETE(request: NextRequest) {
  try {
    const { questionId } = await request.json();
    if (!questionId) {
      return NextResponse.json({ error: 'questionId is required' }, { status: 400 });
    }

    const supabase = createSupabaseApiClient();

    const { data: question } = await supabase
      .from('gre_questions')
      .select('image_url')
      .eq('id', questionId)
      .single();

    if (question?.image_url) {
      const urlPath = new URL(question.image_url).pathname;
      const storagePath = urlPath.split(`/object/public/${BUCKET}/`)[1];
      if (storagePath) {
        await supabase.storage.from(BUCKET).remove([storagePath]);
      }
    }

    await supabase
      .from('gre_questions')
      .update({ image_url: null })
      .eq('id', questionId);

    return NextResponse.json({ success: true });
  } catch (err) {
    console.error('Error in DELETE /api/admin/gre-questions/upload-image:', err);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}

export async function POST(request: NextRequest) {
  try {
    const formData = await request.formData();
    const file = formData.get('file') as File | null;
    const questionId = formData.get('questionId') as string | null;

    if (!file || !questionId) {
      return NextResponse.json(
        { error: 'file and questionId are required' },
        { status: 400 }
      );
    }

    if (!file.type.startsWith('image/')) {
      return NextResponse.json(
        { error: 'Only image files are allowed' },
        { status: 400 }
      );
    }

    if (file.size > MAX_SIZE) {
      return NextResponse.json(
        { error: 'File too large. Maximum size is 5 MB' },
        { status: 400 }
      );
    }

    const ext = file.name.split('.').pop() ?? 'png';
    const filePath = `${questionId}.${ext}`;

    const supabase = createSupabaseApiClient();

    const { error: uploadError } = await supabase.storage
      .from(BUCKET)
      .upload(filePath, file, {
        contentType: file.type,
        upsert: true,
      });

    if (uploadError) {
      console.error('Upload error:', uploadError);
      return NextResponse.json(
        { error: `Upload failed: ${uploadError.message}` },
        { status: 500 }
      );
    }

    const { data: urlData } = supabase.storage
      .from(BUCKET)
      .getPublicUrl(filePath);

    const publicUrl = urlData.publicUrl;

    const { error: updateError } = await supabase
      .from('gre_questions')
      .update({ image_url: publicUrl })
      .eq('id', questionId);

    if (updateError) {
      console.error('DB update error:', updateError);
      return NextResponse.json(
        { error: `Failed to update question: ${updateError.message}` },
        { status: 500 }
      );
    }

    return NextResponse.json({ url: publicUrl });
  } catch (err) {
    console.error('Error in POST /api/admin/gre-questions/upload-image:', err);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}
