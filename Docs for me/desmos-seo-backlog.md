---
context: Play 3 of the 29–31 May organic sprint — "Desmos Calculator Trap" programmatic SEO
related: "[[tasks 29-31 May 2026]]"
---

# Desmos SAT — SEO landing-page backlog

**Strategy:** students search Google for Desmos shortcuts to solve SAT Math in
seconds. Each search term gets a focused landing page: hook → 20-sec GIF of the
hack → step-by-step → practice question → CTA to a free adaptive mock.

- **Template + data:** `src/lib/seo/desmos-guides.ts` (content) +
  `src/app/sat/desmos/[slug]/page.tsx` (renders it).
- **Live URL pattern:** `preppeo.com/sat/desmos/<slug>`
- Published pages auto-appear in `sitemap.xml`. HowTo structured data is included.

## To ship the next page
1. Fill in `steps`, `proTip`, `practice` for that entry in `desmos-guides.ts`.
2. Record a ~20s screen GIF of the hack → save as
   `public/images/desmos/<slug>.gif` → set `gifReady: true`.
3. Set `published: true`. Done — sitemap + static route update automatically.

## The 10 terms

| # | Search term | Slug | Status |
|---|-------------|------|--------|
| 1 | SAT Desmos systems of equations | `systems-of-equations` | ✅ **PILOT — live** (needs GIF) |
| 2 | SAT Desmos number of solutions | `number-of-solutions` | 📝 backlog (authored stub) |
| 3 | how to use Desmos for the SAT | `how-to-use-desmos` | 📝 backlog (broad / high volume) |
| 4 | SAT Desmos quadratic vertex | `quadratics-and-parabolas` | 📝 backlog |
| 5 | SAT Desmos circle equations | `circle-equations` | 📝 backlog |
| 6 | SAT Desmos solve for x | `solving-equations` | 📝 backlog |
| 7 | SAT Desmos systems of inequalities | `systems-of-inequalities` | 📝 backlog |
| 8 | SAT Desmos line of best fit | `line-of-best-fit` | 📝 backlog |
| 9 | SAT Desmos mean and median | `statistics-mean-median` | 📝 backlog |
| 10 | SAT Desmos absolute value equations | `absolute-value` | 📝 backlog |

## Notes
- **Pilot choice:** "systems of equations" — high intent, easy to rank long-tail,
  and Desmos genuinely trivialises it (graph both, read the intersection). It's
  the example named in the original strategy doc.
- **Higher-volume alternative** if you'd rather lead broad: "how to use Desmos
  for the SAT" (#3) — more traffic but harder to rank and lower conversion.
- The pilot page is **live and indexable now**; only the demo GIF is outstanding
  (a dashed placeholder shows until you drop the recording in).
