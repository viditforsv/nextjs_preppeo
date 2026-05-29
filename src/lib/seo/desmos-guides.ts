// Programmatic-SEO content for the "Desmos calculator hack" landing pages
// (Play 3 of the organic-marketing sprint). Each entry targets one search term
// students actually type into Google. The pilot (`published: true`) renders a
// live page at /sat/desmos/<slug>; the rest are an authored backlog — flip
// `published` to true (and add the GIF) to ship the next one.
//
// To ship a backlog page:
//   1. Fill in `steps`, `proTip`, and `practice`.
//   2. Record a ~20s screen capture of the hack. Hand the raw video to the
//      encoder step, which produces public/images/desmos/<slug>.mp4 (+ .webm);
//      then set `videoReady: true`.
//   3. Set `published: true`. It auto-appears in the sitemap and static params.

export interface DesmosStep {
  title: string;
  body: string;
}

export interface DesmosGuide {
  slug: string;
  /** The search term this page targets. */
  keyword: string;
  published: boolean;
  /** Used for <title> and the H1. */
  title: string;
  metaDescription: string;
  intro: string;
  /** true once public/images/desmos/<slug>.mp4 (+ .webm) exists. Until then a placeholder shows. */
  videoReady: boolean;
  /** Caption / aria-label describing what the clip shows. */
  mediaAlt: string;
  steps: DesmosStep[];
  proTip?: string;
  practice?: { question: string; answer: string; desmosWay: string };
}

export const DESMOS_GUIDES: DesmosGuide[] = [
  // ── PILOT (live) ───────────────────────────────────────────────
  {
    slug: "systems-of-equations",
    keyword: "SAT Desmos systems of equations",
    published: true,
    title: "How to Solve SAT Systems of Equations with Desmos (in 5 seconds)",
    metaDescription:
      "Skip substitution and elimination. Type both equations into the Bluebook Desmos calculator and read the intersection. Step-by-step with a practice question.",
    intro:
      "Systems of equations are one of the most common Digital SAT Math question types — and the built-in Desmos calculator turns them into a 5-second read. Instead of grinding through substitution or elimination, you graph both equations and let Desmos find where they cross.",
    videoReady: true,
    mediaAlt:
      "Typing two equations into the Bluebook Desmos calculator and clicking the intersection point to read the solution.",
    steps: [
      {
        title: "Open the Desmos calculator",
        body: "In Bluebook, tap the calculator icon in the top toolbar. The full Desmos graphing calculator opens right inside the test — no separate device needed.",
      },
      {
        title: "Type the first equation exactly as written",
        body: "Desmos accepts any form. You can enter y = 2x + 1, or 3x + 2y = 12, or even 4x − y = 7 — you do NOT need to rearrange into y = form first.",
      },
      {
        title: "Type the second equation on the next line",
        body: "Add the second equation below the first. Both lines graph instantly.",
      },
      {
        title: "Click the intersection point",
        body: "The solution to the system is exactly where the two lines cross. Click that point and Desmos shows the precise (x, y) coordinates.",
      },
      {
        title: "Answer what the question actually asks",
        body: "If it asks for x, read the x-coordinate. If it asks for x + y or 2y, read both coordinates and compute. Always re-check the question.",
      },
    ],
    proTip:
      "Asked for the NUMBER of solutions? Parallel lines that never cross = no solution. Lines that land exactly on top of each other = infinitely many solutions. One crossing = exactly one solution.",
    practice: {
      question:
        "If y = 3x − 4 and 2x + y = 16, what is the value of x ?",
      answer: "x = 4",
      desmosWay:
        "Type both equations into Desmos and click where they meet — the intersection is (4, 8), so x = 4. (Algebra check: 2x + (3x − 4) = 16 → 5x = 20 → x = 4.)",
    },
  },

  // ── BACKLOG (authored, not yet published) ──────────────────────
  {
    slug: "number-of-solutions",
    keyword: "SAT Desmos number of solutions",
    published: false,
    title: "SAT Desmos Trick: Find the Number of Solutions Instantly",
    metaDescription:
      "No solution, one solution, or infinitely many? Graph the system in Bluebook's Desmos calculator and read the answer off the screen. Step-by-step guide.",
    intro:
      "“How many solutions does this system have?” is a classic Digital SAT trap. Desmos makes it trivial: graph both equations and count the intersections.",
    videoReady: false,
    mediaAlt: "Graphing a system in Desmos to count intersection points.",
    steps: [],
  },
  {
    slug: "how-to-use-desmos",
    keyword: "how to use Desmos for the SAT",
    published: false,
    title: "How to Use Desmos on the Digital SAT: The Complete Guide",
    metaDescription:
      "The Bluebook Desmos calculator can solve equations, graph functions, find intercepts, and more. Here's how to use it to save time on SAT Math.",
    intro:
      "The Digital SAT ships with the full Desmos graphing calculator built into Bluebook. Used well, it can shortcut a huge share of the Math section.",
    videoReady: false,
    mediaAlt: "Overview of the Bluebook Desmos calculator features.",
    steps: [],
  },
  {
    slug: "quadratics-and-parabolas",
    keyword: "SAT Desmos quadratic vertex",
    published: false,
    title: "Find a Parabola's Vertex & Roots on the SAT with Desmos",
    metaDescription:
      "Graph any quadratic in Bluebook's Desmos calculator to read the vertex, x-intercepts (roots), and y-intercept directly — no factoring required.",
    intro:
      "Quadratics show up everywhere on SAT Math. Desmos hands you the vertex, the roots, and the y-intercept without any factoring or the quadratic formula.",
    videoReady: false,
    mediaAlt: "Reading a parabola's vertex and roots in Desmos.",
    steps: [],
  },
  {
    slug: "circle-equations",
    keyword: "SAT Desmos circle equations",
    published: false,
    title: "SAT Circle Equations Made Easy with Desmos",
    metaDescription:
      "Graph circle equations in Bluebook's Desmos calculator to find the center, radius, and intersections — even from the expanded (non-standard) form.",
    intro:
      "SAT circle questions often hide the center and radius inside an expanded equation. Desmos graphs it instantly so you can read the geometry off the screen.",
    videoReady: false,
    mediaAlt: "Graphing a circle equation in Desmos to find center and radius.",
    steps: [],
  },
  {
    slug: "solving-equations",
    keyword: "SAT Desmos solve for x",
    published: false,
    title: "Solve Any SAT Equation for x Using Desmos",
    metaDescription:
      "Set an equation equal to zero, graph it in Bluebook's Desmos calculator, and read the x-intercepts — the solutions — directly.",
    intro:
      "Stuck solving for x by hand? Move everything to one side, graph it, and the x-intercepts are your answers.",
    videoReady: false,
    mediaAlt: "Finding x-intercepts in Desmos to solve an equation.",
    steps: [],
  },
  {
    slug: "systems-of-inequalities",
    keyword: "SAT Desmos systems of inequalities",
    published: false,
    title: "SAT Systems of Inequalities: The Desmos Shading Trick",
    metaDescription:
      "Graph inequalities in Bluebook's Desmos calculator and let the overlapping shaded region show which points satisfy the system.",
    intro:
      "Inequality questions ask which point lies in a region. Desmos shades each inequality, and the overlap is your answer set.",
    videoReady: false,
    mediaAlt: "Shaded overlap region of a system of inequalities in Desmos.",
    steps: [],
  },
  {
    slug: "line-of-best-fit",
    keyword: "SAT Desmos line of best fit",
    published: false,
    title: "SAT Line of Best Fit & Regression with Desmos",
    metaDescription:
      "Drop a data table into Bluebook's Desmos calculator and run a regression to get the line of best fit — slope, intercept, and predictions.",
    intro:
      "When the SAT gives you a table of data, Desmos can fit a line (or curve) and hand you the equation in seconds.",
    videoReady: false,
    mediaAlt: "Running a linear regression on a data table in Desmos.",
    steps: [],
  },
  {
    slug: "statistics-mean-median",
    keyword: "SAT Desmos mean and median",
    published: false,
    title: "Mean, Median & Statistics on the SAT with Desmos",
    metaDescription:
      "Enter a data set into Bluebook's Desmos calculator and use mean(), median(), and stdev() to compute statistics instantly.",
    intro:
      "Desmos has built-in statistics functions. Type your data into a list and call mean(), median(), or stdev() for an instant answer.",
    videoReady: false,
    mediaAlt: "Using Desmos list functions to compute mean and median.",
    steps: [],
  },
  {
    slug: "absolute-value",
    keyword: "SAT Desmos absolute value equations",
    published: false,
    title: "Solve SAT Absolute Value Equations with Desmos",
    metaDescription:
      "Graph absolute value equations in Bluebook's Desmos calculator and read both solutions off the intersection points — no case-splitting.",
    intro:
      "Absolute value equations usually have two answers and trip students up. Graph both sides in Desmos and read off the intersections.",
    videoReady: false,
    mediaAlt: "Graphing an absolute value equation in Desmos to find both solutions.",
    steps: [],
  },
];

export function getPublishedDesmosGuides(): DesmosGuide[] {
  return DESMOS_GUIDES.filter((g) => g.published);
}

export function getDesmosGuide(slug: string): DesmosGuide | undefined {
  return DESMOS_GUIDES.find((g) => g.slug === slug && g.published);
}
