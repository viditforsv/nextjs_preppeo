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
    published: true,
    title: "SAT Desmos Trick: Find the Number of Solutions Instantly",
    metaDescription:
      "No solution, one solution, or infinitely many? Graph the system in Bluebook's Desmos calculator and read the answer off the screen. Step-by-step guide.",
    intro:
      "“How many solutions does this system have?” is a classic Digital SAT trap. Desmos makes it trivial: graph both equations and count the intersections.",
    videoReady: true,
    mediaAlt:
      "Graphing y = x² with a line in Desmos and changing the line's constant to show two, one, and zero intersection points.",
    steps: [
      {
        title: "Graph both equations",
        body: "In Bluebook, open the Desmos calculator and type each equation on its own line, exactly as given — no rearranging needed.",
      },
      {
        title: "Count where the graphs cross",
        body: "Each crossing point is one solution. Two lines crossing once = one solution; a line and a parabola can cross twice = two solutions.",
      },
      {
        title: "Spot the 'no solution' case",
        body: "If the graphs never touch — for example, two parallel lines — the system has no solution.",
      },
      {
        title: "Spot the 'infinitely many' case",
        body: "If the two graphs land exactly on top of each other, every point is shared — infinitely many solutions.",
      },
      {
        title: "Zoom out to be sure",
        body: "Scroll or pinch to zoom out so you don't miss a crossing that sits off the visible screen.",
      },
    ],
    proTip:
      "For two straight lines you can often answer without graphing: same slope + different intercept = no solution; same slope + same intercept = infinitely many; different slopes = exactly one solution.",
    practice: {
      question: "How many solutions does the equation x² = 4x − 4 have?",
      answer: "Exactly one",
      desmosWay:
        "Graph y = x² and y = 4x − 4. The parabola just touches the line at a single point, (2, 4), so there is exactly one solution. (Algebra check: x² − 4x + 4 = 0 → (x − 2)² = 0 → one repeated root.)",
    },
  },
  {
    slug: "how-to-use-desmos",
    keyword: "how to use Desmos for the SAT",
    published: true,
    title: "How to Use Desmos on the Digital SAT: The Complete Guide",
    metaDescription:
      "The Bluebook Desmos calculator can solve equations, graph functions, find intercepts, and more. Here's how to use it to save time on SAT Math.",
    intro:
      "The Digital SAT ships with the full Desmos graphing calculator built into Bluebook. Used well, it can shortcut a huge share of the Math section.",
    videoReady: true,
    mediaAlt: "Overview of the Bluebook Desmos calculator features.",
    steps: [
      {
        title: "Open the calculator inside Bluebook",
        body: "Tap the calculator icon in the top toolbar to open the full Desmos graphing calculator — it lives right inside the test, no separate device.",
      },
      {
        title: "Graph equations to solve them",
        body: "Type any equation and Desmos graphs it. Where two graphs cross = the solution to a system; where a graph crosses the x-axis = the solution to an equation.",
      },
      {
        title: "Click special points",
        body: "Click a curve and Desmos highlights its key points — intercepts, the vertex of a parabola, and intersection points — with exact coordinates.",
      },
      {
        title: "Use tables for data questions",
        body: "Add a table, type your data, and Desmos can plot the points and fit a line of best fit.",
      },
      {
        title: "Use built-in functions",
        body: "Functions like mean(), median(), and stdev() compute statistics from a list instantly.",
      },
    ],
    proTip:
      "Desmos accepts equations in ANY form — you never have to rearrange into y = first. Type it exactly as written and let the graph do the work.",
    practice: {
      question: "Use Desmos to find the x-intercept of y = 2x − 7.",
      answer: "x = 3.5",
      desmosWay:
        "Graph y = 2x − 7 and click where the line crosses the x-axis — Desmos shows (3.5, 0).",
    },
  },
  {
    slug: "quadratics-and-parabolas",
    keyword: "SAT Desmos quadratic vertex",
    published: true,
    title: "Find a Parabola's Vertex & Roots on the SAT with Desmos",
    metaDescription:
      "Graph any quadratic in Bluebook's Desmos calculator to read the vertex, x-intercepts (roots), and y-intercept directly — no factoring required.",
    intro:
      "Quadratics show up everywhere on SAT Math. Desmos hands you the vertex, the roots, and the y-intercept without any factoring or the quadratic formula.",
    videoReady: true,
    mediaAlt: "Reading a parabola's vertex and roots in Desmos.",
    steps: [
      {
        title: "Graph the quadratic as written",
        body: "Type y = ax² + bx + c (e.g. y = x² − 6x + 5) on one line. Desmos draws the parabola instantly — no factoring.",
      },
      {
        title: "Click the vertex",
        body: "Click the lowest (or highest) point of the curve. Desmos labels the exact vertex (h, k) — that's your minimum or maximum value.",
      },
      {
        title: "Click the x-intercepts for the roots",
        body: "Click each point where the parabola crosses the x-axis. Those x-values are the solutions (roots) of the quadratic.",
      },
      {
        title: "Read the y-intercept",
        body: "Click where the curve crosses the y-axis to read the constant term / starting value.",
      },
      {
        title: "Answer what's asked",
        body: "Minimum value? Read the vertex's y. Roots? Read the x-intercepts. Axis of symmetry? It's the vertex's x.",
      },
    ],
    proTip:
      "A parabola opens up when a > 0 (it has a minimum) and down when a < 0 (a maximum). The vertex's x-coordinate is always the axis of symmetry, x = −b / 2a.",
    practice: {
      question: "For f(x) = x² − 6x + 5, what is the minimum value of f ?",
      answer: "−4",
      desmosWay:
        "Graph it and click the lowest point: the vertex is (3, −4), so the minimum value is −4. (Algebra check: x = −b/2a = 3, and f(3) = 9 − 18 + 5 = −4.)",
    },
  },
  {
    slug: "circle-equations",
    keyword: "SAT Desmos circle equations",
    published: true,
    title: "SAT Circle Equations Made Easy with Desmos",
    metaDescription:
      "Graph circle equations in Bluebook's Desmos calculator to find the center, radius, and intersections — even from the expanded (non-standard) form.",
    intro:
      "SAT circle questions often hide the center and radius inside an expanded equation. Desmos graphs it instantly so you can read the geometry off the screen.",
    videoReady: true,
    mediaAlt: "Graphing a circle equation in Desmos to find center and radius.",
    steps: [
      {
        title: "Type the equation exactly as given",
        body: "Desmos graphs implicit equations, so paste the circle as-is — standard form (x − 3)² + (y + 4)² = 25 OR expanded form x² + y² − 6x + 8y = 0. No completing the square needed.",
      },
      {
        title: "Let Desmos draw the circle",
        body: "The full circle appears on screen immediately.",
      },
      {
        title: "Find the center",
        body: "The center sits in the middle. Click the far-left and far-right points — the center's x is halfway between them; the top and bottom points give the center's y.",
      },
      {
        title: "Find the radius",
        body: "The radius is the distance from the center to any edge — for example, half the horizontal width: (rightmost x − leftmost x) ÷ 2.",
      },
      {
        title: "Answer the question",
        body: "Center, radius, or whether a point is inside / on the circle — all readable straight off the graph.",
      },
    ],
    proTip:
      "If the equation is already in standard form (x − h)² + (y − k)² = r², read the center (h, k) and radius r directly — but watch signs: (x − 3)² means h = +3, and (y + 4)² means k = −4.",
    practice: {
      question: "x² + y² − 6x + 8y = 0. What is the radius of the circle?",
      answer: "5",
      desmosWay:
        "Graph the equation as-is. The circle's leftmost point is (−2, −4) and rightmost is (8, −4), so the diameter is 10 and the radius is 5. (Algebra check: complete the square → (x − 3)² + (y + 4)² = 25, so r = 5.)",
    },
  },
  {
    slug: "solving-equations",
    keyword: "SAT Desmos solve for x",
    published: true,
    title: "Solve Any SAT Equation for x Using Desmos",
    metaDescription:
      "Set an equation equal to zero, graph it in Bluebook's Desmos calculator, and read the x-intercepts — the solutions — directly.",
    intro:
      "Stuck solving for x by hand? Move everything to one side, graph it, and the x-intercepts are your answers.",
    videoReady: true,
    mediaAlt: "Finding x-intercepts in Desmos to solve an equation.",
    steps: [
      {
        title: "Graph each side as its own line",
        body: "For an equation like 2(x − 3) = x + 1, type y = 2(x − 3) and y = x + 1 on two separate lines.",
      },
      {
        title: "Click the intersection",
        body: "Where the two graphs cross, the x-value is your solution. Desmos shows the exact point.",
      },
      {
        title: "Or use the one-line method",
        body: "Move everything to one side and graph y = (left side − right side). The x-intercept — where it crosses the x-axis — is the solution.",
      },
      {
        title: "Read off x",
        body: "Click the crossing point and read the x-coordinate.",
      },
      {
        title: "Check for multiple or no solutions",
        body: "More than one crossing = more than one solution; no crossing = no real solution.",
      },
    ],
    proTip:
      "The one-line 'set it to zero and find the x-intercept' method works for any equation — linear, quadratic, or messy — so it's the most reliable Desmos habit to build.",
    practice: {
      question: "Solve 2(x − 3) = x + 1 for x.",
      answer: "x = 7",
      desmosWay:
        "Graph y = 2(x − 3) and y = x + 1; they cross at (7, 8), so x = 7. (Algebra check: 2x − 6 = x + 1 → x = 7.)",
    },
  },
  {
    slug: "systems-of-inequalities",
    keyword: "SAT Desmos systems of inequalities",
    published: true,
    title: "SAT Systems of Inequalities: The Desmos Shading Trick",
    metaDescription:
      "Graph inequalities in Bluebook's Desmos calculator and let the overlapping shaded region show which points satisfy the system.",
    intro:
      "Inequality questions ask which point lies in a region. Desmos shades each inequality, and the overlap is your answer set.",
    videoReady: true,
    mediaAlt: "Shaded overlap region of a system of inequalities in Desmos.",
    steps: [
      {
        title: "Type each inequality on its own line",
        body: "Use <, >, ≤, or ≥ exactly as written — e.g. y > x + 1 and y < −x + 5. Desmos shades each one.",
      },
      {
        title: "Find the overlap",
        body: "The region shaded by BOTH inequalities — the darker, double-shaded area — is the solution set. Every point there satisfies the whole system.",
      },
      {
        title: "Test a point",
        body: "To check whether a given point is a solution, just see if it lands inside the double-shaded region.",
      },
      {
        title: "Watch solid vs dashed edges",
        body: "A solid boundary (≤ or ≥) includes the line; a dashed boundary (< or >) does not.",
      },
      {
        title: "Answer the question",
        body: "Which point is a solution, or which region is described — both are visible at a glance.",
      },
    ],
    proTip:
      "When the question gives you answer-choice points, skip the algebra — just see which point sits inside the overlap region.",
    practice: {
      question:
        "Which point satisfies both y > x + 1 and y < −x + 5: (0, 4) or (3, 3)?",
      answer: "(0, 4)",
      desmosWay:
        "Graph both inequalities; (0, 4) sits in the double-shaded overlap and (3, 3) does not. (Check: at (3, 3), 3 > 3 + 1 is false.)",
    },
  },
  {
    slug: "line-of-best-fit",
    keyword: "SAT Desmos line of best fit",
    published: true,
    title: "SAT Line of Best Fit & Regression with Desmos",
    metaDescription:
      "Drop a data table into Bluebook's Desmos calculator and run a regression to get the line of best fit — slope, intercept, and predictions.",
    intro:
      "When the SAT gives you a table of data, Desmos can fit a line (or curve) and hand you the equation in seconds.",
    videoReady: false,
    mediaAlt: "Running a linear regression on a data table in Desmos.",
    steps: [
      {
        title: "Add a table",
        body: "In Desmos, add a table and enter the data: x-values in the first column (x₁), y-values in the second (y₁).",
      },
      {
        title: "Type the regression line",
        body: "On a new line type: y₁ ~ a x₁ + b — using the ~ ('tilde'), NOT an equals sign. This tells Desmos to fit a line.",
      },
      {
        title: "Read the slope and intercept",
        body: "Desmos shows the best-fit values of a (the slope) and b (the y-intercept) in a results box.",
      },
      {
        title: "Use it to predict",
        body: "Plug an x into a·x + b to predict a y, or read it straight off the fitted line on the graph.",
      },
      {
        title: "Answer the question",
        body: "Slope, intercept, predicted value, or the line's equation — all come from the a and b Desmos found.",
      },
    ],
    proTip:
      "The ~ (tilde) is the whole trick: y₁ = a x₁ + b graphs nothing useful, but y₁ ~ a x₁ + b runs the regression. For curved data, try y₁ ~ a x₁² + b x₁ + c.",
    practice: {
      question:
        "Data: (1, 2), (2, 5), (3, 7), (4, 10). What is the slope of the line of best fit, to the nearest tenth?",
      answer: "2.6",
      desmosWay:
        "Put the points in a table as x₁, y₁, then type y₁ ~ a x₁ + b. Desmos returns a ≈ 2.6.",
    },
  },
  {
    slug: "statistics-mean-median",
    keyword: "SAT Desmos mean and median",
    published: true,
    title: "Mean, Median & Statistics on the SAT with Desmos",
    metaDescription:
      "Enter a data set into Bluebook's Desmos calculator and use mean(), median(), and stdev() to compute statistics instantly.",
    intro:
      "Desmos has built-in statistics functions. Type your data into a list and call mean(), median(), or stdev() for an instant answer.",
    videoReady: true,
    mediaAlt: "Using Desmos list functions to compute mean and median.",
    steps: [
      {
        title: "Type the data as a list",
        body: "On one line, name a list and enter the numbers in brackets — e.g. L = [4, 8, 6, 10, 7]. Order doesn't matter.",
      },
      {
        title: "Call mean(L)",
        body: "On a new line type mean(L) and Desmos returns the average instantly.",
      },
      {
        title: "Call median(L)",
        body: "Type median(L) for the middle value — Desmos sorts the list for you, so you don't have to.",
      },
      {
        title: "Other built-ins",
        body: "stdev(L) for standard deviation, total(L) for the sum, length(L) for how many values.",
      },
      {
        title: "Answer the question",
        body: "Read the value Desmos prints — no adding or sorting by hand.",
      },
    ],
    proTip:
      "For a frequency table (a value plus how many times it appears), just repeat values in the list — e.g. [5, 5, 5, 8, 8] for three 5s and two 8s — and mean() / median() still work.",
    practice: {
      question: "Data set: 4, 8, 6, 10, 7. What is the median?",
      answer: "7",
      desmosWay:
        "Type L = [4, 8, 6, 10, 7] then median(L) → 7. (Sorted: 4, 6, 7, 8, 10 — the middle value is 7.)",
    },
  },
  {
    slug: "absolute-value",
    keyword: "SAT Desmos absolute value equations",
    published: true,
    title: "Solve SAT Absolute Value Equations with Desmos",
    metaDescription:
      "Graph absolute value equations in Bluebook's Desmos calculator and read both solutions off the intersection points — no case-splitting.",
    intro:
      "Absolute value equations usually have two answers and trip students up. Graph both sides in Desmos and read off the intersections.",
    videoReady: true,
    mediaAlt: "Graphing an absolute value equation in Desmos to find both solutions.",
    steps: [
      {
        title: "Type the absolute value with bars",
        body: "Enter the equation using | | — e.g. y = |2x − 3|. Desmos draws the V-shape.",
      },
      {
        title: "Graph the other side too",
        body: "Type the right-hand side as its own line — e.g. y = 5, a horizontal line.",
      },
      {
        title: "Click both intersections",
        body: "An absolute value usually meets a horizontal line at TWO points. Click each — the x-values are your two solutions.",
      },
      {
        title: "Watch for 0, 1, or 2 solutions",
        body: "If the line is below the V's tip, there's no solution; right at the tip, exactly one; above it, two.",
      },
      {
        title: "Answer the question",
        body: "Read the x-coordinates of the intersection points.",
      },
    ],
    proTip:
      "You can also solve it the one-line way: graph y = |2x − 3| − 5 and read the two x-intercepts. Either method gives both answers without splitting into cases.",
    practice: {
      question: "Solve |2x − 3| = 5.",
      answer: "x = 4 or x = −1",
      desmosWay:
        "Graph y = |2x − 3| and y = 5; they meet at (4, 5) and (−1, 5), so x = 4 or x = −1. (Algebra check: 2x − 3 = 5 → x = 4; 2x − 3 = −5 → x = −1.)",
    },
  },
];

export function getPublishedDesmosGuides(): DesmosGuide[] {
  return DESMOS_GUIDES.filter((g) => g.published);
}

export function getDesmosGuide(slug: string): DesmosGuide | undefined {
  return DESMOS_GUIDES.find((g) => g.slug === slug && g.published);
}
