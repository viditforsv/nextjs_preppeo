import { useState, useRef, useEffect } from "react";

// ─── Data ────────────────────────────────────────────────────────────────────

const COURSE_DATA = [
  {
    id: "algebra", title: "Algebra", icon: "∑", count: 13,
    sections: [
      {
        id: "linear", title: "Linear Equations", count: 6,
        lessons: [
          { id: "l1", title: "Solving Linear Equations", done: true },
          { id: "l2", title: "Linear Equation Word Problems", done: false, locked: true },
          { id: "l3", title: "Number of Solutions (Zero, One, Infinite)", done: false, locked: true },
          { id: "l4", title: "Slope-Intercept & Standard Form", done: false, locked: true },
          { id: "l5", title: "Graphing Linear Equations", done: false, locked: true },
          { id: "l6", title: "Interpreting Linear Models", done: false, locked: true },
        ]
      },
      {
        id: "systems", title: "Systems of Equations", count: 4,
        lessons: [
          { id: "s1", title: "Solving by Substitution", done: false, locked: true },
          { id: "s2", title: "Solving by Elimination", done: false, locked: true },
          { id: "s3", title: "Word Problems with Systems", done: false, locked: true },
          { id: "s4", title: "No/Infinite Solutions", done: false, locked: true },
        ]
      }
    ]
  },
  {
    id: "geometry", title: "Geometry", icon: "△", count: 11,
    sections: [
      {
        id: "triangles", title: "Triangles", count: 5,
        lessons: [
          { id: "g1", title: "Triangle Properties", done: false, locked: true },
          { id: "g2", title: "Pythagorean Theorem", done: false, locked: true },
        ]
      }
    ]
  }
];

const THEORY = {
  title: "Solving Linear Equations",
  concept: `A **linear equation** is an equation where the variable appears to the first power. The goal is always to isolate the variable on one side.\n\n**Standard form:** ax + b = c\n\n**Key principle:** Whatever you do to one side of the equation, you must do to the other side.`,
  steps: [
    { step: 1, title: "Simplify both sides", desc: "Distribute and combine like terms on each side." },
    { step: 2, title: "Move variable terms", desc: "Add or subtract to get all variable terms on one side." },
    { step: 3, title: "Move constants", desc: "Add or subtract to get all constants on the other side." },
    { step: 4, title: "Divide/Multiply", desc: "Divide both sides by the coefficient to isolate x." },
  ],
  example: { problem: "3x + 7 = 22", solution: ["3x = 22 − 7", "3x = 15", "x = 15 ÷ 3", "x = 5"] },
};

const QUESTIONS = [
  {
    id: "q1", difficulty: "Easy",
    text: "If 2x + 4 = 12, what is the value of x?",
    options: ["2", "4", "6", "8"],
    correctIndex: 1,
    hint: "Subtract 4 from both sides first, then divide by 2.",
    explanation: "Subtract 4 from both sides: 2x = 8. Then divide by 2: x = 4. Answer: (B)."
  },
  {
    id: "q2", difficulty: "Easy",
    text: "Which value of x satisfies 3x − 9 = 0?",
    options: ["−3", "0", "3", "9"],
    correctIndex: 2,
    hint: "Add 9 to both sides, then divide by 3.",
    explanation: "Add 9: 3x = 9. Divide by 3: x = 3. Answer: (C)."
  },
  {
    id: "q3", difficulty: "Medium",
    text: "If 3(x + 2) = 21, find x.",
    options: ["x = 3", "x = 5", "x = 6", "x = 7"],
    correctIndex: 1,
    hint: "Divide both sides by 3 first, then subtract 2.",
    explanation: "Divide by 3: x + 2 = 7. Subtract 2: x = 5. Answer: (B)."
  },
  {
    id: "q4", difficulty: "Medium",
    text: "If 5x − 3 = 2x + 9, what is the value of x?",
    options: ["2", "3", "4", "6"],
    correctIndex: 2,
    hint: "Move all x-terms to the left and constants to the right.",
    explanation: "Subtract 2x: 3x − 3 = 9. Add 3: 3x = 12. Divide by 3: x = 4. Answer: (C)."
  },
  {
    id: "q5", difficulty: "Hard",
    text: "In ax + 3 = 2x + b, if x = 5 is the only solution, which must be true?",
    options: ["a = 2 and b = 3", "a ≠ 2 and b = 5a − 7", "a = 2 and b ≠ 3", "a ≠ 2 and b = 5(a−2)+3"],
    correctIndex: 3,
    hint: "For a unique solution, coefficients of x must differ (a ≠ 2). Then plug x = 5.",
    explanation: "Need a ≠ 2 for a unique solution. Plugging x=5: 5a+3=10+b → b=5a−7=5(a−2)+3. Answer: (D)."
  },
  {
    id: "q6", difficulty: "Hard",
    text: "Maya buys notebooks ($3 each) and pens ($1.50 each), spending $18 total with twice as many pens as notebooks. How many notebooks did she buy?",
    options: ["2", "3", "4", "6"],
    correctIndex: 1,
    hint: "Let n = notebooks, pens = 2n. Write: 3n + 1.5(2n) = 18.",
    explanation: "3n + 3n = 18 → 6n = 18 → n = 3. Answer: (B)."
  },
];

const DIFF = {
  Easy:   { text: "#15803d", bg: "#f0fdf4", border: "#86efac" },
  Medium: { text: "#b45309", bg: "#fffbeb", border: "#fcd34d" },
  Hard:   { text: "#dc2626", bg: "#fef2f2", border: "#fca5a5" },
};

const INITIAL_MESSAGES = [
  { role: "assistant", content: `Hi! I'm your **AI Tutor** for SAT Quant (Learn).\n\nI can help you with **Solving Linear Equations** — ask me to explain a concept, walk through any question step by step, or share a quick tip. What would you like help with?` }
];

function renderMd(text) {
  if (!text) return "";
  return text.replace(/\*\*(.+?)\*\*/g, "<strong>$1</strong>").replace(/\n/g, "<br/>");
}

// ─── App ──────────────────────────────────────────────────────────────────────

export default function App() {
  const [activeLesson, setActiveLesson]       = useState("l1");
  const [sidebarOpen, setSidebarOpen]         = useState(true);
  const [activeTab, setActiveTab]             = useState("questions");
  const [activeQIdx, setActiveQIdx]           = useState(0);
  const [selectedOpts, setSelectedOpts]       = useState({});
  const [submittedQ, setSubmittedQ]           = useState({});
  const [skippedQ, setSkippedQ]               = useState({});
  const [hints, setHints]                     = useState({});
  const [explanations, setExplanations]       = useState({});
  const [messages, setMessages]               = useState(INITIAL_MESSAGES);
  const [input, setInput]                     = useState("");
  const [loading, setLoading]                 = useState(false);
  const [expandedCat, setExpandedCat]         = useState({ algebra: true });
  const [expandedSec, setExpandedSec]         = useState({ linear: true });
  const [elapsed, setElapsed]                 = useState(0);
  const chatEndRef = useRef(null);
  const timerRef   = useRef(null);

  const q         = QUESTIONS[activeQIdx];
  const selected  = selectedOpts[q.id];
  const submitted = submittedQ[q.id] !== undefined;
  const correct   = submittedQ[q.id] === true;
  const totalDone    = Object.keys(submittedQ).length;
  const totalCorrect = Object.values(submittedQ).filter(Boolean).length;
  const totalSkipped = Object.keys(skippedQ).filter(id => submittedQ[id] === undefined).length;

  useEffect(() => {
    setElapsed(0);
    clearInterval(timerRef.current);
    if (!submittedQ[QUESTIONS[activeQIdx].id]) {
      timerRef.current = setInterval(() => setElapsed(e => e + 1), 1000);
    }
    return () => clearInterval(timerRef.current);
  }, [activeQIdx]);

  useEffect(() => {
    if (submitted) clearInterval(timerRef.current);
  }, [submitted]);

  useEffect(() => { chatEndRef.current?.scrollIntoView({ behavior: "smooth" }); }, [messages, loading]);

  function fmtTime(s) {
    const m = Math.floor(s/60), sec = s%60;
    return `${m}:${String(sec).padStart(2,"0")}`;
  }

  function submitAnswer() {
    if (selected === undefined) return;
    clearInterval(timerRef.current);
    const ok = selected === q.correctIndex;
    setSubmittedQ(s => ({...s,[q.id]:ok}));
    if (!ok) setExplanations(e => ({...e,[q.id]:true}));
  }

  function retryQ() {
    ["submittedQ","selectedOpts","explanations","hints"].forEach(() => {});
    setSubmittedQ(s => { const n={...s}; delete n[q.id]; return n; });
    setSelectedOpts(s => { const n={...s}; delete n[q.id]; return n; });
    setExplanations(e => { const n={...e}; delete n[q.id]; return n; });
    setHints(h => { const n={...h}; delete n[q.id]; return n; });
    setSkippedQ(s => { const n={...s}; delete n[q.id]; return n; });
    setElapsed(0);
    timerRef.current = setInterval(() => setElapsed(e => e+1), 1000);
  }

  async function sendMessage(text) {
    if (!text.trim() || loading) return;
    const userMsg = { role: "user", content: text };
    setMessages(m => [...m, userMsg]);
    setInput(""); setLoading(true);
    try {
      const res = await fetch("https://api.anthropic.com/v1/messages", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          model: "claude-sonnet-4-20250514",
          max_tokens: 1000,
          system: `You are a concise, encouraging SAT Math tutor for the lesson "${THEORY.title}". Keep replies under 160 words. Use numbered steps when walking through problems. Be warm but efficient.`,
          messages: [...messages, userMsg].map(m => ({ role: m.role, content: m.content }))
        })
      });
      const data = await res.json();
      setMessages(m => [...m, { role: "assistant", content: data.content?.[0]?.text ?? "Sorry, try again." }]);
    } catch {
      setMessages(m => [...m, { role: "assistant", content: "Connection issue — please retry." }]);
    }
    setLoading(false);
  }

  const SB_W = sidebarOpen ? 256 : 0;

  const css = `
    @import url('https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&family=Fira+Code:wght@400;500;600&display=swap');
    *, *::before, *::after { box-sizing:border-box; margin:0; padding:0; }
    html,body,#root { height:100%; overflow:hidden; }
    body { font-family:'Plus Jakarta Sans',sans-serif; background:#f5f4f1; color:#1c1b1f; font-size:13px; }
    ::-webkit-scrollbar{width:4px} ::-webkit-scrollbar-thumb{background:#d8d5ce;border-radius:4px}

    .root { display:flex; height:100vh; }

    /* SIDEBAR */
    .sb { width:${SB_W}px; min-width:${SB_W}px; background:#fff; border-right:1px solid #ebe8e1; display:flex; flex-direction:column; overflow:hidden; transition:width .22s,min-width .22s; flex-shrink:0; position:relative; }
    .sb-inner { width:256px; height:100%; display:flex; flex-direction:column; }
    .sb-top { padding:12px 14px 10px; border-bottom:1px solid #f0ede6; flex-shrink:0; }
    .sb-back { display:flex; align-items:center; gap:5px; font-size:11px; color:#9a9690; cursor:pointer; margin-bottom:9px; transition:color .12s; }
    .sb-back:hover { color:#1c1b1f; }
    .sb-search { display:flex; align-items:center; gap:7px; background:#f5f4f1; border:1px solid #ebe8e1; border-radius:7px; padding:6px 10px; margin-bottom:9px; }
    .sb-search input { background:none; border:none; outline:none; font-family:inherit; font-size:12px; width:100%; color:#1c1b1f; }
    .sb-search input::placeholder { color:#b8b5ae; }
    .sb-prog { background:#fdfcfa; border:1px solid #ebe8e1; border-radius:9px; padding:9px 11px; }
    .sb-prog-top { display:flex; justify-content:space-between; margin-bottom:5px; }
    .sb-prog-top span:first-child { font-size:11.5px; font-weight:600; }
    .sb-prog-pct { font-size:11.5px; font-weight:800; color:#f59207; }
    .sb-prog-track { height:4px; background:#ebe8e1; border-radius:3px; overflow:hidden; }
    .sb-prog-fill { height:100%; background:linear-gradient(90deg,#f59207,#fbbf24); border-radius:3px; }
    .sb-prog-sub { display:flex; align-items:center; gap:4px; font-size:10.5px; color:#9a9690; margin-top:5px; }
    .sb-expand { display:flex; align-items:center; justify-content:center; gap:5px; margin:6px 12px; padding:6px; border-radius:7px; border:1px solid #ebe8e1; background:#fafaf8; font-size:11px; font-weight:600; color:#6b6966; cursor:pointer; transition:all .12s; }
    .sb-expand:hover { background:#f0ede6; }
    .sb-lessons { flex:1; overflow-y:auto; }
    .cat-hdr { display:flex; align-items:center; gap:8px; padding:7px 14px; cursor:pointer; }
    .cat-hdr:hover { background:#fdfcfa; }
    .cat-icon { width:22px; height:22px; border-radius:6px; background:#fff3e0; display:flex; align-items:center; justify-content:center; font-size:11px; font-weight:800; color:#f59207; flex-shrink:0; }
    .cat-title { font-size:12px; font-weight:700; flex:1; }
    .cat-count { background:#f0ede6; border-radius:4px; padding:1px 5px; font-size:10px; font-weight:700; color:#9a9690; }
    .chev { color:#c0bdb6; font-size:9px; transition:transform .18s; }
    .chev.open { transform:rotate(90deg); }
    .sec-hdr { display:flex; align-items:center; gap:7px; padding:5px 14px 5px 28px; cursor:pointer; }
    .sec-hdr:hover { background:#fdfcfa; }
    .sec-title { font-size:11px; font-weight:600; color:#6b6966; flex:1; }
    .les-row { display:flex; align-items:flex-start; gap:8px; padding:6px 14px 6px 42px; cursor:pointer; position:relative; transition:background .12s; }
    .les-row:hover { background:#fdfcfa; }
    .les-row.act { background:#fffbf0; }
    .les-row.act::before { content:''; position:absolute; left:0; top:0; bottom:0; width:3px; background:#f59207; border-radius:0 2px 2px 0; }
    .les-dot { width:14px; height:14px; border-radius:50%; border:1.5px solid #d8d5ce; flex-shrink:0; margin-top:1px; display:flex; align-items:center; justify-content:center; font-size:7px; }
    .les-dot.done { background:#22c55e; border-color:#22c55e; color:#fff; font-size:8px; }
    .les-dot.act { border-color:#f59207; }
    .les-title { font-size:11.5px; color:#3c3a38; line-height:1.35; font-weight:500; }
    .les-title.act { color:#c47c00; font-weight:600; }
    .les-num { font-size:10px; color:#b8b5ae; margin-top:1px; }
    .sb-toggle { position:absolute; right:-13px; top:50%; transform:translateY(-50%); width:26px; height:26px; background:#fff; border:1px solid #ebe8e1; border-radius:50%; display:flex; align-items:center; justify-content:center; cursor:pointer; font-size:11px; color:#9a9690; z-index:20; box-shadow:0 1px 4px #00000010; transition:all .12s; }
    .sb-toggle:hover { color:#1c1b1f; }

    /* MAIN */
    .main { flex:1; display:flex; flex-direction:column; overflow:hidden; min-width:0; }

    /* TOPBAR */
    .topbar { height:44px; display:flex; align-items:center; padding:0 18px; background:#fff; border-bottom:1px solid #ebe8e1; flex-shrink:0; gap:0; }
    .breadcrumb { display:flex; align-items:center; gap:5px; font-size:11.5px; color:#9a9690; flex:1; min-width:0; overflow:hidden; white-space:nowrap; }
    .breadcrumb b { color:#1c1b1f; font-weight:700; }
    .bc-sep { color:#ccc; margin:0 1px; }
    .topbar-nav { display:flex; gap:7px; flex-shrink:0; }
    .tnav-btn { display:flex; align-items:center; gap:4px; padding:5px 13px; border-radius:8px; font-family:inherit; font-size:12px; font-weight:600; cursor:pointer; transition:all .12s; }
    .tnav-prev { background:#fff; border:1px solid #ebe8e1; color:#6b6966; }
    .tnav-prev:hover { background:#f5f4f1; }
    .tnav-next { background:#f59207; border:1px solid #f59207; color:#fff; box-shadow:0 2px 8px #f5920730; }
    .tnav-next:hover { background:#e08a00; }

    /* TABBAR */
    .tabbar { display:flex; align-items:stretch; background:#fff; border-bottom:1px solid #ebe8e1; flex-shrink:0; height:42px; }
    .tab { display:flex; align-items:center; justify-content:center; gap:6px; padding:0 20px; font-size:13px; font-weight:600; color:#9a9690; cursor:pointer; border-bottom:2px solid transparent; transition:all .15s; white-space:nowrap; }
    .tab:hover { color:#1c1b1f; background:#fdfcfa; }
    .tab.act { color:#f59207; border-bottom-color:#f59207; }
    .tabbar-sep { width:1px; background:#ebe8e1; margin:8px 0; }

    /* CONTENT */
    .content { flex:1; display:flex; overflow:hidden; }

    /* THEORY */
    .theory { flex:1; overflow-y:auto; padding:24px 28px; }
    .th-h1 { font-size:21px; font-weight:800; letter-spacing:-.02em; margin-bottom:16px; }
    .th-concept { background:#fff; border:1px solid #ebe8e1; border-radius:12px; padding:16px 18px; margin-bottom:16px; font-size:13.5px; line-height:1.7; color:#3c3a38; }
    .th-stitle { font-size:10px; font-weight:800; text-transform:uppercase; letter-spacing:.08em; color:#9a9690; margin-bottom:9px; }
    .th-steps { display:flex; flex-direction:column; gap:7px; margin-bottom:18px; }
    .th-step { display:flex; align-items:flex-start; gap:11px; background:#fff; border:1px solid #ebe8e1; border-radius:10px; padding:11px 13px; }
    .th-badge { width:25px; height:25px; border-radius:50%; background:#f59207; color:#fff; font-size:11px; font-weight:800; display:flex; align-items:center; justify-content:center; flex-shrink:0; }
    .th-step-txt h4 { font-size:12.5px; font-weight:700; margin-bottom:2px; }
    .th-step-txt p { font-size:12px; color:#6b6966; }
    .th-example { background:linear-gradient(135deg,#fffbf0,#fff); border:1px solid #fde9b8; border-radius:12px; padding:16px 18px; }
    .th-ex-tag { font-size:10px; font-weight:800; text-transform:uppercase; letter-spacing:.1em; color:#f59207; margin-bottom:8px; }
    .th-ex-prob { font-family:'Fira Code',monospace; font-size:17px; font-weight:600; margin-bottom:10px; }
    .th-ex-steps { display:flex; flex-direction:column; gap:4px; }
    .th-ex-step { font-family:'Fira Code',monospace; font-size:12.5px; padding:4px 10px; background:#fff; border-radius:6px; border-left:3px solid #f59207; color:#3c3a38; }

    /* Q PANEL */
    .q-panel { display:flex; flex:1; overflow:hidden; }

    /* Q NAV */
    .q-nav { width:176px; flex-shrink:0; background:#fff; border-right:1px solid #ebe8e1; display:flex; flex-direction:column; overflow:hidden; }
    .q-nav-hdr { padding:11px 13px 8px; border-bottom:1px solid #f0ede6; flex-shrink:0; }
    .q-nav-title { font-size:12px; font-weight:700; margin-bottom:7px; display:flex; align-items:center; justify-content:space-between; }
    .q-filter-icon { display:flex; align-items:center; gap:4px; font-size:10px; font-weight:600; color:#9a9690; cursor:pointer; padding:2px 7px; border-radius:5px; border:1px solid #ebe8e1; transition:all .12s; }
    .q-filter-icon:hover { background:#f5f4f1; }
    .q-score-row { display:flex; align-items:center; gap:6px; }
    .q-score-bar { flex:1; height:3px; background:#ebe8e1; border-radius:3px; overflow:hidden; }
    .q-score-fill { height:100%; background:linear-gradient(90deg,#22c55e,#4ade80); border-radius:3px; transition:width .4s; }
    .q-score-txt { font-size:10px; font-weight:700; color:#22c55e; }
    .q-diff-filters { display:flex; gap:4px; padding:7px 10px; border-bottom:1px solid #f0ede6; flex-wrap:wrap; }
    .diff-tag { padding:2px 7px; border-radius:20px; font-size:10px; font-weight:700; cursor:pointer; transition:all .12s; border:1px solid; }
    .q-list { flex:1; overflow-y:auto; padding:6px; }
    .q-item { display:flex; align-items:center; gap:7px; padding:8px 9px; border-radius:8px; cursor:pointer; border:1.5px solid transparent; transition:all .12s; margin-bottom:2px; }
    .q-item:hover { background:#fdfcfa; border-color:#ebe8e1; }
    .q-item.qi-act { background:#fffbf0; border-color:#fde9b8; }
    .q-item.qi-ok { border-color:#86efac; background:#f0fdf4; }
    .q-item.qi-bad { border-color:#fca5a5; background:#fef2f2; }
    .q-item.qi-skip { border-color:#fcd34d; background:#fffbeb; }
    .qi-num { font-size:11px; font-weight:700; color:#9a9690; width:20px; flex-shrink:0; }
    .q-item.qi-act .qi-num { color:#f59207; }
    .qi-label { font-size:11px; color:#6b6966; flex:1; line-height:1.3; overflow:hidden; display:-webkit-box; -webkit-line-clamp:2; -webkit-box-orient:vertical; }
    .q-item.qi-act .qi-label { color:#1c1b1f; font-weight:600; }
    .qi-status { font-size:13px; flex-shrink:0; }

    /* Q VIEWER */
    .q-viewer { flex:1; display:flex; flex-direction:column; overflow:hidden; background:#f5f4f1; min-width:0; }
    .q-viewer-scroll { flex:1; overflow-y:auto; padding:22px 26px; }

    .q-meta-row { display:flex; align-items:center; gap:8px; margin-bottom:14px; flex-wrap:wrap; }
    .q-counter { font-size:11.5px; font-weight:700; color:#9a9690; }
    .q-timer { font-family:'Fira Code',monospace; font-size:11px; color:#9a9690; background:#fff; border:1px solid #ebe8e1; padding:3px 8px; border-radius:6px; display:flex; align-items:center; gap:4px; }
    .q-timer.warn { color:#dc2626; border-color:#fca5a5; background:#fef2f2; }
    .q-dpill { padding:2px 8px; border-radius:20px; font-size:10px; font-weight:800; border:1px solid; }
    .q-result { display:flex; align-items:center; gap:4px; padding:4px 10px; border-radius:20px; font-size:11.5px; font-weight:700; margin-left:auto; border:1px solid; }

    .q-text { font-size:15.5px; font-weight:600; color:#1c1b1f; line-height:1.6; margin-bottom:20px; letter-spacing:-.01em; }

    /* OPTIONS */
    .options { display:flex; flex-direction:column; gap:9px; margin-bottom:18px; }
    .opt {
      display:flex; align-items:center; gap:12px;
      padding:13px 16px; border-radius:11px;
      border:1.5px solid #e0ddd6; background:#fff;
      cursor:pointer; transition:all .15s;
      position:relative;
    }
    .opt:hover:not(.opt-locked) { border-color:#c8b87a; background:#fdfcfa; transform:translateX(3px); box-shadow:0 2px 8px #0000000a; }
    .opt.opt-sel { border-color:#f59207; background:#fffbf0; box-shadow:0 0 0 3px #f5920715; }
    .opt.opt-correct { border-color:#22c55e; background:#f0fdf4; box-shadow:0 0 0 3px #22c55e18; }
    .opt.opt-wrong { border-color:#ef4444; background:#fef2f2; box-shadow:0 0 0 3px #ef444418; }
    .opt.opt-locked { cursor:default; }
    .opt.opt-dim { opacity:.45; }
    .opt-letter {
      width:28px; height:28px; border-radius:8px; flex-shrink:0;
      display:flex; align-items:center; justify-content:center;
      font-size:12px; font-weight:800;
      background:#f5f4f1; color:#6b6966; border:1.5px solid #e0ddd6;
      transition:all .15s;
    }
    .opt.opt-sel .opt-letter { background:#f59207; color:#fff; border-color:#f59207; }
    .opt.opt-correct .opt-letter { background:#22c55e; color:#fff; border-color:#22c55e; }
    .opt.opt-wrong .opt-letter { background:#ef4444; color:#fff; border-color:#ef4444; }
    .opt-text { font-size:13.5px; font-weight:500; color:#2c2a28; transition:color .15s; }
    .opt.opt-sel .opt-text { color:#92400e; font-weight:600; }
    .opt.opt-correct .opt-text { color:#15803d; font-weight:600; }
    .opt.opt-wrong .opt-text { color:#dc2626; font-weight:600; }

    /* ACTIONS */
    .actions { display:flex; align-items:center; gap:7px; flex-wrap:wrap; }
    .abtn { display:flex; align-items:center; gap:5px; padding:8px 14px; border-radius:9px; font-family:inherit; font-size:12px; font-weight:600; cursor:pointer; transition:all .12s; border:1.5px solid; white-space:nowrap; }
    .abtn:active { transform:scale(.97); }
    .a-submit { background:#f59207; border-color:#f59207; color:#fff; box-shadow:0 2px 6px #f5920728; }
    .a-submit:hover:not(:disabled) { background:#e08a00; box-shadow:0 3px 10px #f5920740; }
    .a-submit:disabled { background:#e0ddd6; border-color:#e0ddd6; color:#b8b5ae; cursor:not-allowed; box-shadow:none; }
    .a-skip { background:#fff; border-color:#e0ddd6; color:#6b6966; }
    .a-skip:hover { background:#f5f4f1; }
    .a-hint { background:#fffbf0; border-color:#fde9b8; color:#b45309; }
    .a-hint:hover { background:#fef3c7; }
    .a-explain { background:#f0fdf4; border-color:#86efac; color:#15803d; }
    .a-explain:hover { background:#dcfce7; }
    .a-ai { background:#eef2ff; border-color:#c7d2fe; color:#4338ca; }
    .a-ai:hover { background:#e0e7ff; }
    .a-retry { background:#fff; border-color:#e0ddd6; color:#6b6966; }
    .a-retry:hover { background:#f5f4f1; }

    /* INFO BOXES */
    .ibox { border-radius:10px; padding:11px 14px; margin-top:11px; font-size:12.5px; line-height:1.65; animation:slideDown .18s ease; }
    @keyframes slideDown { from{opacity:0;transform:translateY(-5px)} to{opacity:1;transform:translateY(0)} }
    .ibox-hint { background:#fffbf0; border:1px solid #fde9b8; color:#78350f; }
    .ibox-expl { background:#f0fdf4; border:1px solid #86efac; color:#14532d; }

    /* FOOTER */
    .q-footer { flex-shrink:0; display:flex; align-items:center; justify-content:space-between; padding:11px 26px; background:#fff; border-top:1px solid #ebe8e1; }
    .qf-btn { display:flex; align-items:center; gap:5px; padding:7px 15px; border-radius:9px; font-family:inherit; font-size:12px; font-weight:600; cursor:pointer; transition:all .12s; border:1.5px solid; }
    .qf-prev { background:#fff; border-color:#e0ddd6; color:#6b6966; }
    .qf-prev:hover:not(:disabled) { background:#f5f4f1; }
    .qf-prev:disabled { opacity:.4; cursor:not-allowed; }
    .qf-next { background:#f59207; border-color:#f59207; color:#fff; }
    .qf-next:hover:not(:disabled) { background:#e08a00; }
    .qf-next:disabled { background:#e0ddd6; border-color:#e0ddd6; color:#b8b5ae; cursor:not-allowed; }
    .dots { display:flex; gap:7px; align-items:center; }
    .dot { width:8px; height:8px; border-radius:50%; cursor:pointer; transition:all .15s; }
    .dot-idle { background:#e0ddd6; }
    .dot-act { background:#f59207; transform:scale(1.3); }
    .dot-ok { background:#22c55e; }
    .dot-bad { background:#ef4444; }
    .dot-skip { background:#f59e0b; }

    /* AI PANEL */
    .ai { width:288px; flex-shrink:0; background:#fff; border-left:1px solid #ebe8e1; display:flex; flex-direction:column; overflow:hidden; }
    .ai-hdr { padding:11px 13px; border-bottom:1px solid #f0ede6; display:flex; align-items:center; gap:9px; flex-shrink:0; }
    .ai-av { width:28px; height:28px; border-radius:50%; background:linear-gradient(135deg,#f59207,#fbbf24); display:flex; align-items:center; justify-content:center; font-size:13px; flex-shrink:0; }
    .ai-hdr-txt h3 { font-size:12.5px; font-weight:700; }
    .ai-hdr-txt p { font-size:10px; color:#9a9690; }
    .ai-dot { width:7px; height:7px; border-radius:50%; background:#22c55e; box-shadow:0 0 0 2px #dcfce7; margin-left:auto; }
    .ai-msgs { flex:1; overflow-y:auto; padding:11px; display:flex; flex-direction:column; gap:9px; }
    .ai-msg { display:flex; gap:6px; align-items:flex-start; animation:slideDown .18s ease; }
    .ai-msg.user { flex-direction:row-reverse; }
    .ai-msg-av { width:22px; height:22px; border-radius:50%; flex-shrink:0; display:flex; align-items:center; justify-content:center; font-size:10px; font-weight:700; margin-top:2px; }
    .bot-av { background:linear-gradient(135deg,#f59207,#fbbf24); color:#fff; font-size:11px; }
    .user-av { background:#1c1b1f; color:#fff; }
    .ai-bubble { max-width:90%; padding:8px 11px; border-radius:11px; font-size:12px; line-height:1.65; }
    .ai-msg.assistant .ai-bubble { background:#f5f4f1; border-radius:3px 11px 11px 11px; }
    .ai-msg.user .ai-bubble { background:#1c1b1f; color:#fff; border-radius:11px 3px 11px 11px; }
    .typing-wrap { display:flex; gap:6px; align-items:flex-start; }
    .typing { display:flex; align-items:center; gap:3px; padding:9px 11px; background:#f5f4f1; border-radius:3px 11px 11px 11px; }
    .typing span { width:5px; height:5px; border-radius:50%; background:#c8c5be; animation:typeBounce .8s infinite; }
    .typing span:nth-child(2) { animation-delay:.12s; }
    .typing span:nth-child(3) { animation-delay:.24s; }
    @keyframes typeBounce { 0%,60%,100%{transform:translateY(0)} 30%{transform:translateY(-5px)} }
    .ai-quick { padding:7px 9px; display:flex; flex-wrap:wrap; gap:4px; border-top:1px solid #f0ede6; flex-shrink:0; }
    .ai-chip { display:flex; align-items:center; gap:3px; padding:4px 8px; border-radius:20px; border:1px solid #e0ddd6; background:#fdfcfa; font-size:10.5px; font-weight:600; color:#6b6966; cursor:pointer; transition:all .12s; white-space:nowrap; }
    .ai-chip:hover { background:#fffbf0; border-color:#fde9b8; color:#b45309; }
    .ai-input-row { padding:9px 11px; border-top:1px solid #f0ede6; display:flex; gap:6px; align-items:flex-end; flex-shrink:0; }
    .ai-input { flex:1; background:#f5f4f1; border:1px solid #e0ddd6; border-radius:8px; padding:8px 10px; font-family:inherit; font-size:12px; color:#1c1b1f; outline:none; resize:none; min-height:34px; max-height:80px; transition:border-color .15s; line-height:1.4; }
    .ai-input:focus { border-color:#f59207; background:#fff; }
    .ai-input::placeholder { color:#b8b5ae; }
    .ai-send { width:32px; height:32px; border-radius:8px; border:none; background:#f59207; color:#fff; font-size:13px; cursor:pointer; display:flex; align-items:center; justify-content:center; transition:all .12s; flex-shrink:0; }
    .ai-send:hover:not(:disabled) { background:#e08a00; }
    .ai-send:disabled { background:#e0ddd6; cursor:not-allowed; }
  `;

  return (
    <>
      <style>{css}</style>
      <div className="root">

        {/* ── SIDEBAR ── */}
        <div className="sb">
          <div className="sb-inner">
            <div className="sb-top">
              <div className="sb-back">← Back to SAT Quant (Learn)</div>
              <div className="sb-search">
                <svg width="12" height="12" viewBox="0 0 16 16" fill="none" stroke="#b8b5ae" strokeWidth="2"><circle cx="6.5" cy="6.5" r="5"/><path d="M11 11l3 3"/></svg>
                <input placeholder="Search lessons…"/>
              </div>
              <div className="sb-prog">
                <div className="sb-prog-top"><span>Course Progress</span><span className="sb-prog-pct">2%</span></div>
                <div className="sb-prog-track"><div className="sb-prog-fill" style={{width:"2%"}}/></div>
                <div className="sb-prog-sub"><span style={{color:"#22c55e",fontSize:11}}>✓</span> 1 / 52 completed</div>
              </div>
            </div>
            <button className="sb-expand">⊞ Expand All</button>
            <div className="sb-lessons">
              {COURSE_DATA.map(cat => (
                <div key={cat.id}>
                  <div className="cat-hdr" onClick={() => setExpandedCat(e => ({...e,[cat.id]:!e[cat.id]}))}>
                    <div className="cat-icon">{cat.icon}</div>
                    <span className="cat-title">{cat.title}</span>
                    <span className="cat-count">{cat.count}</span>
                    <span className={`chev ${expandedCat[cat.id]?"open":""}`}>▶</span>
                  </div>
                  {expandedCat[cat.id] && cat.sections.map(sec => (
                    <div key={sec.id}>
                      <div className="sec-hdr" onClick={() => setExpandedSec(e => ({...e,[sec.id]:!e[sec.id]}))}>
                        <span style={{fontSize:10}}>📄</span>
                        <span className="sec-title">{sec.title}</span>
                        <span style={{fontSize:10,color:"#b8b5ae",marginLeft:"auto"}}>{sec.count}</span>
                        <span className={`chev ${expandedSec[sec.id]?"open":""}`}>▶</span>
                      </div>
                      {expandedSec[sec.id] && sec.lessons.map((les,i) => (
                        <div key={les.id} className={`les-row ${les.id===activeLesson?"act":""}`} onClick={() => !les.locked && setActiveLesson(les.id)}>
                          <div className={`les-dot ${les.done?"done":les.id===activeLesson?"act":""}`}>{les.done?"✓":les.locked?"🔒":""}</div>
                          <div>
                            <div className={`les-title ${les.id===activeLesson?"act":""}`}>{les.title}</div>
                            <div className="les-num">Lesson {i+1}</div>
                          </div>
                        </div>
                      ))}
                    </div>
                  ))}
                </div>
              ))}
            </div>
          </div>
          <div className="sb-toggle" onClick={() => setSidebarOpen(o=>!o)}>{sidebarOpen?"‹":"›"}</div>
        </div>

        {/* ── MAIN ── */}
        <div className="main">
          <div className="topbar">
            <div className="breadcrumb">
              SAT Quant (Learn) <span className="bc-sep">›</span> Algebra <span className="bc-sep">›</span> Linear Equations <span className="bc-sep">›</span> <b>Solving Linear Equations</b>
            </div>
            <div className="topbar-nav">
              <button className="tnav-btn tnav-prev">‹ Prev</button>
              <button className="tnav-btn tnav-next">Next ›</button>
            </div>
          </div>

          <div className="tabbar">
            <div className={`tab ${activeTab==="theory"?"act":""}`} onClick={()=>setActiveTab("theory")}>
              📖 Theory
            </div>
            <div className="tabbar-sep"/>
            <div className={`tab ${activeTab==="questions"?"act":""}`} onClick={()=>setActiveTab("questions")}>
              ✏️ Practice Questions
            </div>
          </div>

          <div className="content">
            {activeTab==="theory" ? (
              /* ── THEORY ── */
              <div className="theory">
                <div className="th-h1">{THEORY.title}</div>
                <div className="th-concept" dangerouslySetInnerHTML={{__html:renderMd(THEORY.concept)}}/>
                <div className="th-stitle">Step-by-Step Method</div>
                <div className="th-steps">
                  {THEORY.steps.map(s=>(
                    <div key={s.step} className="th-step">
                      <div className="th-badge">{s.step}</div>
                      <div className="th-step-txt"><h4>{s.title}</h4><p>{s.desc}</p></div>
                    </div>
                  ))}
                </div>
                <div className="th-example">
                  <div className="th-ex-tag">Worked Example</div>
                  <div className="th-ex-prob">{THEORY.example.problem}</div>
                  <div className="th-ex-steps">
                    {THEORY.example.solution.map((s,i)=><div key={i} className="th-ex-step">{s}</div>)}
                  </div>
                </div>
              </div>
            ) : (
              /* ── QUESTIONS ── */
              <div className="q-panel">
                {/* Q NAV */}
                <div className="q-nav">
                  <div className="q-nav-hdr">
                    <div className="q-nav-title">
                      Questions
                      <span className="q-filter-icon">
                        <svg width="10" height="10" viewBox="0 0 16 16" fill="none" stroke="currentColor" strokeWidth="2"><path d="M2 4h12M4 8h8M6 12h4"/></svg>
                        Filters
                      </span>
                    </div>
                    <div className="q-score-row">
                      <div className="q-score-bar">
                        <div className="q-score-fill" style={{width:`${(totalCorrect/QUESTIONS.length)*100}%`}}/>
                      </div>
                      <span className="q-score-txt">{totalCorrect}/{QUESTIONS.length}</span>
                      {totalSkipped > 0 && <span style={{fontSize:10,fontWeight:700,color:"#b45309"}}>⏭{totalSkipped}</span>}
                    </div>
                  </div>
                  <div className="q-diff-filters">
                    {["Easy","Medium","Hard"].map(d=>(
                      <span key={d} className="diff-tag" style={{background:DIFF[d].bg,color:DIFF[d].text,borderColor:DIFF[d].border}}>{d}</span>
                    ))}
                  </div>
                  <div className="q-list">
                    {QUESTIONS.map((qq,i)=>{
                      const st = submittedQ[qq.id];
                      const skipped = skippedQ[qq.id];
                      const cls = `q-item ${i===activeQIdx?"qi-act":""} ${st===true?"qi-ok":st===false?"qi-bad":skipped?"qi-skip":""}`;
                      return (
                        <div key={qq.id} className={cls} onClick={()=>setActiveQIdx(i)}>
                          <span className="qi-num">Q{i+1}</span>
                          <span className="qi-label">{qq.text}</span>
                          <span className="qi-status">{st===true?"✅":st===false?"❌":skipped?"⏭":i===activeQIdx?"▶":""}</span>
                        </div>
                      );
                    })}
                  </div>
                </div>

                {/* Q VIEWER */}
                <div className="q-viewer">
                  <div className="q-viewer-scroll" key={`q-${activeQIdx}`}>
                    {/* Meta */}
                    <div className="q-meta-row">
                      <span className="q-counter">Q{activeQIdx+1} of {QUESTIONS.length}</span>
                      {!submitted && (
                        <span className={`q-timer ${elapsed>90?"warn":""}`}>⏱ {fmtTime(elapsed)}</span>
                      )}
                      <span className="q-dpill" style={{background:DIFF[q.difficulty].bg,color:DIFF[q.difficulty].text,borderColor:DIFF[q.difficulty].border}}>
                        {q.difficulty}
                      </span>
                      {submitted && (
                        <div className="q-result" style={{background:correct?"#f0fdf4":"#fef2f2",color:correct?"#15803d":"#dc2626",borderColor:correct?"#86efac":"#fca5a5"}}>
                          {correct?"✓ Correct!":"✗ Incorrect"}
                        </div>
                      )}
                    </div>

                    {/* Question */}
                    <div className="q-text">{q.text}</div>

                    {/* Options */}
                    <div className="options">
                      {q.options.map((opt,oi)=>{
                        let cls = "opt";
                        if (submitted) {
                          cls += " opt-locked";
                          if (oi===q.correctIndex) cls += " opt-correct";
                          else if (oi===selected) cls += " opt-wrong";
                          else cls += " opt-dim";
                        } else {
                          if (oi===selected) cls += " opt-sel";
                        }
                        return (
                          <div key={oi} className={cls} onClick={()=>!submitted&&setSelectedOpts(s=>({...s,[q.id]:oi}))}>
                            <div className="opt-letter">
                              {submitted&&oi===q.correctIndex?"✓"
                               :submitted&&oi===selected&&oi!==q.correctIndex?"✗"
                               :String.fromCharCode(65+oi)}
                            </div>
                            <span className="opt-text">{opt}</span>
                          </div>
                        );
                      })}
                    </div>

                    {/* Action bar */}
                    <div className="actions">
                      {!submitted ? (
                        <>
                          <button className="abtn a-submit" disabled={selected===undefined} onClick={submitAnswer}>✓ Submit Answer</button>
                          <button className="abtn a-skip" onClick={()=>{ setSkippedQ(s=>({...s,[q.id]:true})); setActiveQIdx(i=>Math.min(i+1,QUESTIONS.length-1)); }}>Skip</button>
                        </>
                      ) : (
                        <button className="abtn a-retry" onClick={retryQ}>↺ Retry</button>
                      )}
                      <button className="abtn a-hint" onClick={()=>setHints(h=>({...h,[q.id]:!h[q.id]}))}>
                        💡 {hints[q.id]?"Hide Hint":"Hint"}
                      </button>
                      {submitted && (
                        <button className="abtn a-explain" onClick={()=>setExplanations(e=>({...e,[q.id]:!e[q.id]}))}>
                          📖 {explanations[q.id]?"Hide":"Explanation"}
                        </button>
                      )}
                      <button
                        className="abtn a-ai"
                        onClick={()=>{
                          sendMessage(`Walk me through this SAT question:\n"${q.text}"\nOptions: ${q.options.map((o,i)=>String.fromCharCode(65+i)+") "+o).join("  ")}`);
                        }}
                      >
                        🤖 Ask AI
                      </button>
                    </div>

                    {hints[q.id] && <div className="ibox ibox-hint">💡 <strong>Hint:</strong> {q.hint}</div>}
                    {explanations[q.id] && <div className="ibox ibox-expl">📖 <strong>Explanation:</strong> {q.explanation}</div>}
                  </div>

                  {/* Footer */}
                  <div className="q-footer">
                    <button className="qf-btn qf-prev" disabled={activeQIdx===0} onClick={()=>setActiveQIdx(i=>Math.max(i-1,0))}>‹ Previous</button>
                    <div className="dots">
                      {QUESTIONS.map((_,i)=>{
                        const st = submittedQ[QUESTIONS[i].id];
                        const sk = skippedQ[QUESTIONS[i].id];
                        const cls = `dot ${i===activeQIdx?"dot-act":st===true?"dot-ok":st===false?"dot-bad":sk?"dot-skip":"dot-idle"}`;
                        return <div key={i} className={cls} onClick={()=>setActiveQIdx(i)} title={`Q${i+1}`}/>;
                      })}
                    </div>
                    <button className="qf-btn qf-next" disabled={activeQIdx===QUESTIONS.length-1} onClick={()=>setActiveQIdx(i=>Math.min(i+1,QUESTIONS.length-1))}>Next ›</button>
                  </div>
                </div>
              </div>
            )}

            {/* ── AI PANEL ── */}
            <div className="ai">
              <div className="ai-hdr">
                <div className="ai-av">🎓</div>
                <div className="ai-hdr-txt"><h3>AI Tutor</h3><p>Preppeo · SAT Math</p></div>
                <div className="ai-dot"/>
              </div>
              <div className="ai-msgs">
                {messages.map((m,i)=>(
                  <div key={i} className={`ai-msg ${m.role}`}>
                    <div className={`ai-msg-av ${m.role==="assistant"?"bot-av":"user-av"}`}>{m.role==="assistant"?"🎓":"VA"}</div>
                    <div className="ai-bubble" dangerouslySetInnerHTML={{__html:renderMd(m.content)}}/>
                  </div>
                ))}
                {loading && (
                  <div className="typing-wrap">
                    <div className="ai-msg-av bot-av" style={{width:22,height:22,borderRadius:"50%",flexShrink:0,display:"flex",alignItems:"center",justifyContent:"center",fontSize:11,background:"linear-gradient(135deg,#f59207,#fbbf24)",color:"#fff"}}>🎓</div>
                    <div className="typing"><span/><span/><span/></div>
                  </div>
                )}
                <div ref={chatEndRef}/>
              </div>
              <div className="ai-quick">
                {[{i:"📖",l:"Explain this"},{i:"💡",l:"Give a tip"},{i:"📐",l:"The formula?"},{i:"✏️",l:`Help with Q${activeQIdx+1}`}].map(p=>(
                  <div key={p.l} className="ai-chip" onClick={()=>sendMessage(p.l=== `Help with Q${activeQIdx+1}` ? `Can you walk me through Question ${activeQIdx+1}? "${q.text}" Options: ${q.options.map((o,i)=>String.fromCharCode(65+i)+") "+o).join("  ")}` : p.l)}>{p.i} {p.l}</div>
                ))}
              </div>
              <div className="ai-input-row">
                <textarea
                  className="ai-input"
                  placeholder="Ask anything…"
                  value={input}
                  onChange={e=>setInput(e.target.value)}
                  onKeyDown={e=>{if(e.key==="Enter"&&!e.shiftKey){e.preventDefault();sendMessage(input);}}}
                  rows={1}
                />
                <button className="ai-send" onClick={()=>sendMessage(input)} disabled={!input.trim()||loading}>➤</button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </>
  );
}