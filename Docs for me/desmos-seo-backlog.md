---
context: Play 3 of the 29–31 May organic sprint — "Desmos Calculator Trap" programmatic SEO
related: "[[tasks 29-31 May 2026]]"
---

# Desmos SAT — SEO landing-page backlog

**Strategy:** students search Google for Desmos shortcuts to solve SAT Math in
seconds. Each search term gets a focused landing page: hook → 20-sec looping
demo clip of the hack → step-by-step → practice question → CTA to a free
adaptive mock.

- **Template + data:** `src/lib/seo/desmos-guides.ts` (content) +
  `src/app/sat/desmos/[slug]/page.tsx` (renders it).
- **Live URL pattern:** `preppeo.com/sat/desmos/<slug>`
- Published pages auto-appear in `sitemap.xml`. HowTo structured data is included.

## To ship the next page
1. Fill in `steps`, `proTip`, `practice` for that entry in `desmos-guides.ts`.
2. Record a ~20s screen capture of the hack (Cmd+Shift+5 on Mac). Hand the raw
   `.mov` to the assistant → it encodes `<slug>.mp4` + `<slug>.webm` into
   `public/images/desmos/` → set `videoReady: true`.
3. Set `published: true`. Done — sitemap + static route update automatically.

The clip plays as autoplay/muted/loop video (looks like a GIF, ~5–10× smaller
and sharper). Encode commands are in `public/images/desmos/README.txt`.

## The 10 terms

All 10 are **published/live with their demo clip** (set 2026-06-01). Recording
scripts used to produce them are in `desmos-recording-scripts/`.

| # | Search term | Slug | Status |
|---|-------------|------|--------|
| 1 | SAT Desmos systems of equations | `systems-of-equations` | ✅ live + clip |
| 2 | SAT Desmos number of solutions | `number-of-solutions` | ✅ live + clip |
| 3 | how to use Desmos for the SAT | `how-to-use-desmos` | ✅ live + clip |
| 4 | SAT Desmos quadratic vertex | `quadratics-and-parabolas` | ✅ live + clip |
| 5 | SAT Desmos circle equations | `circle-equations` | ✅ live + clip |
| 6 | SAT Desmos solve for x | `solving-equations` | ✅ live + clip |
| 7 | SAT Desmos systems of inequalities | `systems-of-inequalities` | ✅ live + clip |
| 8 | SAT Desmos line of best fit | `line-of-best-fit` | ✅ live + clip |
| 9 | SAT Desmos mean and median | `statistics-mean-median` | ✅ live + clip |
| 10 | SAT Desmos absolute value equations | `absolute-value` | ✅ live + clip |

## Notes
- **Pilot choice:** "systems of equations" — high intent, easy to rank long-tail,
  and Desmos genuinely trivialises it (graph both, read the intersection). It's
  the example named in the original strategy doc.
- **Higher-volume alternative** if you'd rather lead broad: "how to use Desmos
  for the SAT" (#3) — more traffic but harder to rank and lower conversion.
- The pilot page is **live and indexable now**; only the demo clip is outstanding
  (a dashed placeholder shows until the encoded video is dropped in).
