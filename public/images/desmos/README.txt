Demo clips for the Desmos SAT landing pages.

Each published guide expects a short looping demo named <slug>.mp4 and <slug>.webm
(e.g. systems-of-equations.mp4 / systems-of-equations.webm). Once both exist,
set `videoReady: true` for that entry in src/lib/seo/desmos-guides.ts.

The page plays them as autoplay/muted/loop video (no audio needed).

Encoding (from a raw screen recording <slug>.mov), reference commands:
  # scale + strip audio -> web-optimized MP4 (H.264)
  ffmpeg -i <slug>.mov -an -vf "scale=720:-2:flags=lanczos" -movflags +faststart \
         -c:v libx264 -crf 24 -preset slow -pix_fmt yuv420p <slug>.mp4
  # VP9 WebM (smaller, modern browsers)
  ffmpeg -i <slug>.mov -an -vf "scale=720:-2:flags=lanczos" \
         -c:v libvpx-vp9 -b:v 0 -crf 34 <slug>.webm

Just hand the raw recording to the assistant — it runs these for you.
