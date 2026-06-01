# Desmos guide — recording scripts

One script per unpublished-clip guide. All 7 pages are **live now** with a
"Demo clip coming soon" placeholder; record the clips one at a time and each
page upgrades to the real video.

## How to use these
1. Pick a script (e.g. `circle-equations.md`).
2. Open the **Bluebook Desmos calculator** (or [desmos.com/calculator](https://www.desmos.com/calculator) — looks the same).
3. Start a screen recording (Mac: **Cmd+Shift+5**, record just the calculator panel).
4. Follow the shot list exactly. Aim for **~20 seconds**, end on the answer highlighted.
5. No narration needed — clips play **autoplay / muted / loop** (like a GIF).
6. Save the raw file as `public/Videos/<slug>.mov` and hand it to me.

## What I do after you record
- Encode `<slug>.mov` → `public/images/desmos/<slug>.mp4` + `.webm`
  (commands in `public/images/desmos/README.txt`).
- Flip `videoReady: true` for that slug in `src/lib/seo/desmos-guides.ts`.
- The placeholder is replaced by the real clip — no other change needed.

## Status

| # | Slug | Demo problem | Recorded? |
|---|------|--------------|-----------|
| 4 | `quadratics-and-parabolas` | min of f(x)=x²−6x+5 | ✅ done |
| 5 | `circle-equations` | radius of x²+y²−6x+8y=0 | ✅ done |
| 6 | `solving-equations` | solve 2(x−3)=x+1 | ✅ done |
| 7 | `systems-of-inequalities` | which point fits both inequalities | ✅ done |
| 8 | `line-of-best-fit` | slope of best-fit line | ✅ done |
| 9 | `statistics-mean-median` | median of a data set | ✅ done |
| 10 | `absolute-value` | solve \|2x−3\|=5 | ✅ done |

Tip: keep all 7 visually consistent — same zoom level, type at a steady pace,
pause ~1s on the highlighted answer before the loop restarts.
