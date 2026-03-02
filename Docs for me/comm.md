import { useState, useRef, useEffect } from "react";

const COURSE_DATA = [
  {
    id: "algebra", title: "Algebra", icon: "∑", count: 13, expanded: true,
    sections: [
      {
        id: "linear", title: "Linear Equations", count: 6, expanded: true,
        lessons: [
          { id: "l1", title: "Solving Linear Equations", done: true, active: true },
          { id: "l2", title: "Linear Equation Word Problems", done: false },
          { id: "l3", title: "Number of Solutions (Zero, One, Infinite)", done: false },
          { id: "l4", title: "Slope-Intercept & Standard Form", done: false },
          { id: "l5", title: "Graphing Linear Equations", done: false },
          { id: "l6", title: "Interpreting Linear Models", done: false },
        ]
      },
      {
        id: "systems", title: "Systems of Equations", count: 4, expanded: false,
        lessons: [
          { id: "s1", title: "Solving by Substitution", done: false },
          { id: "s2", title: "Solving by Elimination", done: false },
          { id: "s3", title: "Word Problems with Systems", done: false },
          { id: "s4", title: "No/Infinite Solutions", done: false },
        ]
      }
    ]
  },
  {
    id: "geometry", title: "Geometry", icon: "△", count: 11, expanded: false,
    sections: [
      {
        id: "triangles", title: "Triangles", count: 5, expanded: false,
        lessons: [
          { id: "g1", title: "Triangle Properties", done: false },
          { id: "g2", title: "Pythagorean Theorem", done: false },
        ]
      }
    ]
  }
];

const THEORY = {
  title: "Solving Linear Equations",
  concept: `A **linear equation** is an equation where the variable appears to the first power. The goal is always to isolate the variable on one side.

**Standard form:** ax + b = c

**Key principle:** Whatever you do to one side of the equation, you must do to the other side.`,
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
    options: ["A) 2", "B) 4", "C) 6", "D) 8"],
    correctIndex: 1,
    hint: "Subtract 4 from both sides first, then divide by 2.",
    explanation: "Subtract 4 from both sides: 2x = 8. Then divide by 2: x = 4. The answer is (B)."
  },
  {
    id: "q2", difficulty: "Easy",
    text: "Which value of x satisfies the equation 3x − 9 = 0?",
    options: ["A) −3", "B) 0", "C) 3", "D) 9"],
    correctIndex: 2,
    hint: "Add 9 to both sides, then divide by 3.",
    explanation: "Add 9: 3x = 9. Divide by 3: x = 3. The answer is (C)."
  },
  {
    id: "q3", difficulty: "Medium",
    text: "If 5x − 3 = 2x + 9, what is the value of x?",
    options: ["A) 2", "B) 3", "C) 4", "D) 6"],
    correctIndex: 2,
    hint: "Move all x-terms to the left and constants to the right.",
    explanation: "Subtract 2x from both sides: 3x − 3 = 9. Add 3: 3x = 12. Divide by 3: x = 4. The answer is (C)."
  },
  {
    id: "q4", difficulty: "Medium",
    text: "If 3(x + 2) = 21, what is the value of x + 2?",
    options: ["A) 5", "B) 6", "C) 7", "D) 9"],
    correctIndex: 2,
    hint: "Don't expand — divide both sides by 3 directly to find (x + 2).",
    explanation: "Divide both sides by 3: x + 2 = 7. Notice the question asks for x + 2, not x. The answer is (C)."
  },
  {
    id: "q5", difficulty: "Hard",
    text: "In the equation ax + 3 = 2x + b, if x = 5 is the only solution, which of the following must be true?",
    options: ["A) a = 2 and b = 3", "B) a ≠ 2 and b = 5a − 7", "C) a = 2 and b ≠ 3", "D) a ≠ 2 and b = 5(a − 2) + 3"],
    correctIndex: 3,
    hint: "For a unique solution, coefficients of x must differ (a ≠ 2). Then plug x = 5 to find the relationship between a and b.",
    explanation: "For a unique solution: a ≠ 2 (otherwise infinite or no solutions). Plug x = 5: 5a + 3 = 10 + b → b = 5a − 7 = 5(a−2) + 3. The answer is (D)."
  },
  {
    id: "q6", difficulty: "Hard",
    text: "A store sells notebooks for $3 each and pens for $1.50 each. Maya spent $18 total and bought twice as many pens as notebooks. How many notebooks did she buy?",
    options: ["A) 2", "B) 3", "C) 4", "D) 6"],
    correctIndex: 1,
    hint: "Let n = notebooks. Then pens = 2n. Write the equation: 3n + 1.5(2n) = 18.",
    explanation: "Let n = notebooks, 2n = pens. Equation: 3n + 1.5(2n) = 18 → 3n + 3n = 18 → 6n = 18 → n = 3. The answer is (B)."
  },
];

const DIFF_COLOR = { Easy: "#22c55e", Medium: "#f59e0b", Hard: "#ef4444" };

const INITIAL_MESSAGES = [
  { role: "assistant", content: "Hi! I'm your AI tutor for **Solving Linear Equations**. Ask me anything — I can explain concepts, walk through problems step by step, or quiz you. What would you like to explore?" }
];

export default function App() {
  const [courseData, setCourseData] = useState(COURSE_DATA);
  const [activeLesson, setActiveLesson] = useState("l1");
  const [sidebarOpen, setSidebarOpen] = useState(true);
  const [activeTab, setActiveTab] = useState("theory"); // theory | questions
  const [selectedOptions, setSelectedOptions] = useState({});
  const [submittedQuestions, setSubmittedQuestions] = useState({});
  const [revealedHints, setRevealedHints] = useState({});
  const [revealedExplanations, setRevealedExplanations] = useState({});
  const [messages, setMessages] = useState(INITIAL_MESSAGES);
  const [input, setInput] = useState("");
  const [loading, setLoading] = useState(false);
  const [expandedCategories, setExpandedCategories] = useState({ algebra: true });
  const [expandedSections, setExpandedSections] = useState({ linear: true });
  const chatEndRef = useRef(null);
  const inputRef = useRef(null);

  useEffect(() => { chatEndRef.current?.scrollIntoView({ behavior: "smooth" }); }, [messages]);

  async function sendMessage(text) {
    if (!text.trim() || loading) return;
    const userMsg = { role: "user", content: text };
    setMessages(m => [...m, userMsg]);
    setInput("");
    setLoading(true);

    try {
      const res = await fetch("https://api.anthropic.com/v1/messages", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          model: "claude-sonnet-4-20250514",
          max_tokens: 1000,
          system: `You are an expert SAT math tutor helping a student with "${THEORY.title}". Be concise, encouraging, and pedagogically sound. Use simple examples. Format math expressions clearly. Keep responses focused and under 200 words unless the student needs a detailed walkthrough.`,
          messages: [...messages, userMsg].map(m => ({ role: m.role, content: m.content }))
        })
      });
      const data = await res.json();
      const reply = data.content?.[0]?.text ?? "Sorry, I couldn't process that. Try again!";
      setMessages(m => [...m, { role: "assistant", content: reply }]);
    } catch {
      setMessages(m => [...m, { role: "assistant", content: "Connection issue. Please try again." }]);
    }
    setLoading(false);
  }

  function quickPrompt(p) { sendMessage(p); }

  function renderMd(text) {
    return text
      .replace(/\*\*(.+?)\*\*/g, '<strong>$1</strong>')
      .replace(/\n/g, '<br/>');
  }

  const progress = 1;
  const total = 52;

  return (
    <>
      <style>{`
        @import url('https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&family=Fira+Code:wght@400;500&display=swap');
        *, *::before, *::after { box-sizing:border-box; margin:0; padding:0; }
        body { font-family:'Plus Jakarta Sans',sans-serif; background:#f4f3f0; color:#1a1a2e; height:100vh; overflow:hidden; }
        ::-webkit-scrollbar { width:4px; height:4px; }
        ::-webkit-scrollbar-track { background:transparent; }
        ::-webkit-scrollbar-thumb { background:#d4d0c8; border-radius:2px; }

        .root { display:flex; height:100vh; overflow:hidden; }

        /* ── SIDEBAR ── */
        .sidebar {
          width:${sidebarOpen ? 268 : 0}px;
          min-width:${sidebarOpen ? 268 : 0}px;
          background:#fff;
          border-right:1px solid #eae8e2;
          display:flex; flex-direction:column;
          transition:width .25s ease, min-width .25s ease;
          overflow:hidden; flex-shrink:0;
        }
        .sidebar-inner { width:268px; display:flex; flex-direction:column; height:100%; }

        .sidebar-top {
          padding:16px 16px 12px;
          border-bottom:1px solid #f0ede8;
          flex-shrink:0;
        }
        .back-link {
          display:flex; align-items:center; gap:6px;
          font-size:12px; color:#8b8880; cursor:pointer;
          margin-bottom:12px; transition:color .12s;
        }
        .back-link:hover { color:#1a1a2e; }

        .sidebar-search {
          display:flex; align-items:center; gap:8px;
          background:#f4f3f0; border:1px solid #eae8e2; border-radius:8px;
          padding:8px 10px; margin-bottom:12px;
        }
        .sidebar-search input {
          background:none; border:none; outline:none;
          font-family:'Plus Jakarta Sans',sans-serif; font-size:12px; color:#1a1a2e; width:100%;
        }
        .sidebar-search input::placeholder { color:#aaa; }

        .progress-box {
          background:#faf9f6; border:1px solid #eae8e2; border-radius:10px; padding:10px 12px;
        }
        .progress-top { display:flex; justify-content:space-between; align-items:center; margin-bottom:6px; }
        .progress-top span:first-child { font-size:12px; font-weight:600; color:#1a1a2e; }
        .progress-top span:last-child { font-size:12px; font-weight:700; color:#f59207; }
        .progress-track { height:4px; background:#eae8e2; border-radius:2px; overflow:hidden; }
        .progress-fill { height:100%; background:linear-gradient(90deg,#f59207,#fbbf24); border-radius:2px; }
        .progress-sub { font-size:11px; color:#8b8880; margin-top:5px; display:flex; align-items:center; gap:4px; }

        .sidebar-lessons { flex:1; overflow-y:auto; padding:8px 0; }

        .cat-header {
          display:flex; align-items:center; gap:8px;
          padding:8px 16px; cursor:pointer;
          font-size:13px; font-weight:700; color:#1a1a2e;
          transition:background .12s; user-select:none;
        }
        .cat-header:hover { background:#faf9f6; }
        .cat-icon { width:24px; height:24px; border-radius:6px; background:#fff3e0; display:flex; align-items:center; justify-content:center; font-size:13px; font-weight:700; color:#f59207; flex-shrink:0; }
        .cat-count { margin-left:auto; background:#f4f3f0; border-radius:4px; padding:2px 6px; font-size:11px; color:#8b8880; font-weight:600; }
        .chevron { color:#8b8880; font-size:10px; transition:transform .2s; }
        .chevron.open { transform:rotate(90deg); }

        .section-header {
          display:flex; align-items:center; gap:8px;
          padding:6px 16px 6px 32px; cursor:pointer;
          font-size:12px; font-weight:600; color:#5a5860;
          transition:background .12s; user-select:none;
        }
        .section-header:hover { background:#faf9f6; }
        .section-count { margin-left:auto; font-size:11px; color:#aaa; }

        .lesson-item {
          display:flex; align-items:flex-start; gap:8px;
          padding:7px 16px 7px 44px; cursor:pointer;
          transition:background .12s; position:relative;
        }
        .lesson-item:hover { background:#faf9f6; }
        .lesson-item.active { background:#fff8ee; }
        .lesson-item.active::before {
          content:''; position:absolute; left:0; top:0; bottom:0; width:3px;
          background:#f59207; border-radius:0 2px 2px 0;
        }
        .lesson-dot { width:14px; height:14px; border-radius:50%; border:1.5px solid #d4d0c8; flex-shrink:0; margin-top:2px; display:flex; align-items:center; justify-content:center; }
        .lesson-dot.done { background:#22c55e; border-color:#22c55e; }
        .lesson-dot.done::after { content:'✓'; color:#fff; font-size:8px; font-weight:700; }
        .lesson-dot.active { border-color:#f59207; background:#fff8ee; }
        .lesson-title { font-size:12px; color:#3a3840; line-height:1.4; font-weight:500; }
        .lesson-title.active { color:#f59207; font-weight:600; }
        .lesson-num { font-size:10px; color:#aaa; margin-top:2px; }

        .toggle-sidebar {
          position:absolute; top:50%; transform:translateY(-50%);
          left:${sidebarOpen ? 254 : 4}px;
          width:24px; height:48px; background:#fff; border:1px solid #eae8e2;
          border-radius:0 8px 8px 0; display:flex; align-items:center; justify-content:center;
          cursor:pointer; font-size:11px; color:#8b8880; z-index:10;
          transition:left .25s ease; box-shadow:2px 0 8px #0000000a;
        }
        .toggle-sidebar:hover { background:#faf9f6; color:#1a1a2e; }

        /* ── MAIN ── */
        .main { flex:1; display:flex; flex-direction:column; overflow:hidden; min-width:0; }

        .topbar {
          height:50px; display:flex; align-items:center; gap:0;
          padding:0 20px; background:#fff; border-bottom:1px solid #eae8e2;
          flex-shrink:0;
        }
        .topbar-title { font-size:15px; font-weight:700; color:#1a1a2e; margin-right:auto; }
        .topbar-breadcrumb { font-size:12px; color:#8b8880; display:flex; align-items:center; gap:6px; margin-right:auto; }
        .topbar-breadcrumb span { color:#1a1a2e; font-weight:600; }

        /* ── CONTENT PANELS ── */
        .panels { flex:1; display:flex; overflow:hidden; gap:0; }

        /* LEFT PANEL */
        .left-panel {
          flex:1.1; display:flex; flex-direction:column;
          border-right:1px solid #eae8e2; overflow:hidden; min-width:0;
          background:#f9f8f5;
        }

        .panel-tabs {
          display:flex; border-bottom:1px solid #eae8e2; background:#fff; flex-shrink:0;
        }
        .panel-tab {
          flex:1; padding:13px 16px; font-size:13px; font-weight:600;
          color:#8b8880; cursor:pointer; text-align:center;
          border-bottom:2px solid transparent; transition:all .15s;
          display:flex; align-items:center; justify-content:center; gap:6px;
        }
        .panel-tab:hover { color:#1a1a2e; background:#faf9f6; }
        .panel-tab.active { color:#f59207; border-bottom-color:#f59207; background:#fff; }

        .left-content { flex:1; overflow-y:auto; padding:20px; }

        /* Theory */
        .theory-title { font-size:20px; font-weight:800; color:#1a1a2e; margin-bottom:16px; letter-spacing:-.02em; }
        .concept-box {
          background:#fff; border:1px solid #eae8e2; border-radius:12px;
          padding:18px 20px; margin-bottom:16px; line-height:1.7;
          font-size:13.5px; color:#3a3840;
        }
        .concept-box strong { color:#1a1a2e; }

        .steps-title { font-size:13px; font-weight:700; color:#1a1a2e; margin-bottom:10px; text-transform:uppercase; letter-spacing:.06em; }
        .steps-list { display:flex; flex-direction:column; gap:8px; margin-bottom:20px; }
        .step-card {
          display:flex; align-items:flex-start; gap:12px;
          background:#fff; border:1px solid #eae8e2; border-radius:10px; padding:12px 14px;
        }
        .step-num {
          width:26px; height:26px; border-radius:50%; background:#f59207;
          color:#fff; font-size:12px; font-weight:800;
          display:flex; align-items:center; justify-content:center; flex-shrink:0;
        }
        .step-body h4 { font-size:13px; font-weight:700; color:#1a1a2e; margin-bottom:2px; }
        .step-body p { font-size:12px; color:#6b6870; }

        .example-box {
          background:linear-gradient(135deg,#fff8ee,#fff);
          border:1px solid #fde9b8; border-radius:12px; padding:18px 20px;
        }
        .example-label { font-size:11px; font-weight:700; color:#f59207; text-transform:uppercase; letter-spacing:.08em; margin-bottom:10px; }
        .example-problem { font-size:18px; font-weight:800; color:#1a1a2e; font-family:'Fira Code',monospace; margin-bottom:12px; }
        .solution-steps { display:flex; flex-direction:column; gap:4px; }
        .sol-step { font-family:'Fira Code',monospace; font-size:13px; color:#3a3840; padding:4px 10px; background:#fff; border-radius:6px; border-left:2px solid #f59207; }

        /* Questions */
        .questions-list { display:flex; flex-direction:column; gap:14px; }
        .question-card {
          background:#fff; border:1px solid #eae8e2; border-radius:12px;
          padding:18px 20px; transition:box-shadow .15s;
        }
        .question-card:hover { box-shadow:0 4px 20px #0000000a; }
        .question-top { display:flex; align-items:center; gap:8px; margin-bottom:10px; }
        .diff-badge { font-size:11px; font-weight:700; padding:3px 8px; border-radius:20px; }
        .question-num { font-size:11px; color:#8b8880; font-weight:600; }
        .question-text { font-size:14px; font-weight:600; color:#1a1a2e; margin-bottom:14px; line-height:1.5; }
        .question-actions { display:flex; gap:8px; }
        .q-btn {
          padding:7px 14px; border-radius:8px; font-family:'Plus Jakarta Sans',sans-serif;
          font-size:12px; font-weight:600; cursor:pointer; transition:all .12s; border:1px solid;
        }
        .q-btn.hint { background:#f4f3f0; border-color:#d4d0c8; color:#5a5860; }
        .q-btn.hint:hover { background:#eae8e2; }
        .q-btn.answer { background:#f59207; border-color:#f59207; color:#fff; }
        .q-btn.answer:hover { background:#e08a00; }
        .q-btn.ask-ai { background:#eef2ff; border-color:#c7d2fe; color:#4338ca; }
        .q-btn.ask-ai:hover { background:#e0e7ff; }
        .reveal-box {
          margin-top:12px; padding:10px 14px; border-radius:8px;
          font-size:13px; font-weight:600; font-family:'Fira Code',monospace;
          animation:fadeSlide .2s ease;
        }
        .reveal-hint { background:#f4f3f0; color:#5a5860; border:1px solid #d4d0c8; }
        .reveal-answer { background:#f0fdf4; color:#16a34a; border:1px solid #bbf7d0; }
        @keyframes fadeSlide { from { opacity:0; transform:translateY(-6px); } to { opacity:1; transform:translateY(0); } }

        /* ── RIGHT PANEL (Chat) ── */
        .right-panel {
          width:360px; min-width:320px; display:flex; flex-direction:column;
          background:#fff; overflow:hidden; flex-shrink:0;
        }

        .chat-header {
          padding:14px 20px; border-bottom:1px solid #eae8e2; flex-shrink:0;
          display:flex; align-items:center; gap:10px;
        }
        .chat-avatar {
          width:32px; height:32px; border-radius:50%; background:linear-gradient(135deg,#f59207,#fbbf24);
          display:flex; align-items:center; justify-content:center; font-size:14px; flex-shrink:0;
        }
        .chat-header-info h3 { font-size:14px; font-weight:700; color:#1a1a2e; }
        .chat-header-info p { font-size:11px; color:#8b8880; }
        .online-dot { width:8px; height:8px; border-radius:50%; background:#22c55e; margin-left:auto; box-shadow:0 0 0 2px #dcfce7; }

        .chat-messages { flex:1; overflow-y:auto; padding:16px; display:flex; flex-direction:column; gap:12px; }

        .msg { display:flex; gap:8px; align-items:flex-start; animation:fadeSlide .2s ease; }
        .msg.user { flex-direction:row-reverse; }
        .msg-avatar { width:26px; height:26px; border-radius:50%; flex-shrink:0; display:flex; align-items:center; justify-content:center; font-size:11px; font-weight:700; margin-top:2px; }
        .msg-ai-av { background:linear-gradient(135deg,#f59207,#fbbf24); color:#fff; }
        .msg-user-av { background:#1a1a2e; color:#fff; }
        .msg-bubble {
          max-width:82%; padding:10px 13px; border-radius:14px;
          font-size:13px; line-height:1.6; color:#1a1a2e;
        }
        .msg.assistant .msg-bubble { background:#f4f3f0; border-radius:4px 14px 14px 14px; }
        .msg.user .msg-bubble { background:#1a1a2e; color:#fff; border-radius:14px 4px 14px 14px; }

        .typing { display:flex; align-items:center; gap:4px; padding:12px 14px; }
        .typing span { width:6px; height:6px; border-radius:50%; background:#d4d0c8; animation:bounce .9s infinite; }
        .typing span:nth-child(2) { animation-delay:.15s; }
        .typing span:nth-child(3) { animation-delay:.3s; }
        @keyframes bounce { 0%,60%,100%{transform:translateY(0)} 30%{transform:translateY(-6px)} }

        .quick-prompts { padding:0 16px 10px; display:flex; flex-wrap:wrap; gap:6px; flex-shrink:0; }
        .quick-chip {
          padding:5px 11px; border-radius:20px; font-size:11px; font-weight:600;
          background:#fff8ee; border:1px solid #fde9b8; color:#b45309;
          cursor:pointer; transition:all .12s; white-space:nowrap;
        }
        .quick-chip:hover { background:#fde9b8; }

        .chat-input-area {
          padding:12px 16px; border-top:1px solid #eae8e2; flex-shrink:0;
          display:flex; align-items:flex-end; gap:8px;
        }
        .chat-input {
          flex:1; background:#f4f3f0; border:1px solid #eae8e2; border-radius:10px;
          padding:10px 12px; font-family:'Plus Jakarta Sans',sans-serif; font-size:13px;
          color:#1a1a2e; outline:none; resize:none; min-height:40px; max-height:100px;
          transition:border-color .15s; line-height:1.4;
        }
        .chat-input:focus { border-color:#f59207; background:#fff; }
        .chat-input::placeholder { color:#aaa; }
        .send-btn {
          width:38px; height:38px; border-radius:10px; border:none;
          background:#f59207; color:#fff; font-size:16px; cursor:pointer;
          display:flex; align-items:center; justify-content:center;
          transition:all .12s; flex-shrink:0;
        }
        .send-btn:hover { background:#e08a00; transform:scale(1.05); }
        .send-btn:disabled { background:#d4d0c8; cursor:default; transform:none; }
      `}</style>

      <div className="root" style={{ position: "relative" }}>
        {/* Toggle button */}
        <div className="toggle-sidebar" onClick={() => setSidebarOpen(o => !o)}>
          {sidebarOpen ? "‹" : "›"}
        </div>

        {/* ── SIDEBAR ── */}
        <div className="sidebar">
          <div className="sidebar-inner">
            <div className="sidebar-top">
              <div className="back-link">
                ← Back to SAT Quant (Learn)
              </div>
              <div className="sidebar-search">
                <span style={{fontSize:12, color:"#aaa"}}>🔍</span>
                <input placeholder="Search lessons…" />
              </div>
              <div className="progress-box">
                <div className="progress-top">
                  <span>Course Progress</span>
                  <span>{Math.round((progress/total)*100)}%</span>
                </div>
                <div className="progress-track">
                  <div className="progress-fill" style={{width:`${(progress/total)*100}%`}} />
                </div>
                <div className="progress-sub">
                  <span style={{color:"#22c55e"}}>✓</span>
                  {progress} / {total} completed
                </div>
              </div>
            </div>

            <div className="sidebar-lessons">
              {COURSE_DATA.map(cat => (
                <div key={cat.id}>
                  <div className="cat-header" onClick={() => setExpandedCategories(e => ({...e,[cat.id]:!e[cat.id]}))}>
                    <span className="cat-icon">{cat.icon}</span>
                    {cat.title}
                    <span className="cat-count">{cat.count}</span>
                    <span className={`chevron ${expandedCategories[cat.id]?"open":""}`}>▶</span>
                  </div>
                  {expandedCategories[cat.id] && cat.sections.map(sec => (
                    <div key={sec.id}>
                      <div className="section-header" onClick={() => setExpandedSections(e => ({...e,[sec.id]:!e[sec.id]}))}>
                        <span style={{fontSize:11}}>📄</span>
                        {sec.title}
                        <span className="section-count">{sec.count}</span>
                        <span className={`chevron ${expandedSections[sec.id]?"open":""}`}>▶</span>
                      </div>
                      {expandedSections[sec.id] && sec.lessons.map((les, i) => (
                        <div
                          key={les.id}
                          className={`lesson-item ${les.id === activeLesson ? "active" : ""}`}
                          onClick={() => setActiveLesson(les.id)}
                        >
                          <div className={`lesson-dot ${les.done?"done":les.id===activeLesson?"active":""}`} />
                          <div>
                            <div className={`lesson-title ${les.id===activeLesson?"active":""}`}>{les.title}</div>
                            <div className="lesson-num">Lesson {i+1}</div>
                          </div>
                        </div>
                      ))}
                    </div>
                  ))}
                </div>
              ))}
            </div>
          </div>
        </div>

        {/* ── MAIN ── */}
        <div className="main">
          <div className="topbar">
            <div className="topbar-breadcrumb">
              Algebra &rsaquo; Linear Equations &rsaquo; <span>Solving Linear Equations</span>
            </div>
            <div style={{display:"flex",gap:8}}>
              <button style={{padding:"6px 14px",borderRadius:8,border:"1px solid #eae8e2",background:"#f4f3f0",fontSize:12,fontWeight:600,color:"#5a5860",cursor:"pointer",fontFamily:"'Plus Jakarta Sans',sans-serif"}}>‹ Prev</button>
              <button style={{padding:"6px 14px",borderRadius:8,border:"none",background:"#f59207",fontSize:12,fontWeight:600,color:"#fff",cursor:"pointer",fontFamily:"'Plus Jakarta Sans',sans-serif"}}>Next ›</button>
            </div>
          </div>

          <div className="panels">
            {/* ── LEFT PANEL ── */}
            <div className="left-panel">
              <div className="panel-tabs">
                <div className={`panel-tab ${activeTab==="theory"?"active":""}`} onClick={() => setActiveTab("theory")}>
                  📖 Theory
                </div>
                <div className={`panel-tab ${activeTab==="questions"?"active":""}`} onClick={() => setActiveTab("questions")}>
                  ✏️ Practice Questions
                </div>
              </div>

              <div className="left-content">
                {activeTab === "theory" ? (
                  <>
                    <div className="theory-title">{THEORY.title}</div>
                    <div className="concept-box" dangerouslySetInnerHTML={{__html: renderMd(THEORY.concept)}} />

                    <div className="steps-title">Step-by-step method</div>
                    <div className="steps-list">
                      {THEORY.steps.map(s => (
                        <div key={s.step} className="step-card">
                          <div className="step-num">{s.step}</div>
                          <div className="step-body">
                            <h4>{s.title}</h4>
                            <p>{s.desc}</p>
                          </div>
                        </div>
                      ))}
                    </div>

                    <div className="example-box">
                      <div className="example-label">Worked Example</div>
                      <div className="example-problem">{THEORY.example.problem}</div>
                      <div className="solution-steps">
                        {THEORY.example.solution.map((s,i) => (
                          <div key={i} className="sol-step">{s}</div>
                        ))}
                      </div>
                    </div>
                  </>
                ) : (
                  <div className="questions-list">
                    {/* Score summary */}
                    {Object.keys(submittedQuestions).length > 0 && (
                      <div style={{background:"#fff",border:"1px solid #eae8e2",borderRadius:12,padding:"12px 16px",marginBottom:4,display:"flex",alignItems:"center",gap:12}}>
                        <span style={{fontSize:20}}>📊</span>
                        <div>
                          <div style={{fontSize:13,fontWeight:700,color:"#1a1a2e"}}>
                            {Object.values(submittedQuestions).filter(v=>v).length} / {Object.keys(submittedQuestions).length} correct
                          </div>
                          <div style={{fontSize:11,color:"#8b8880"}}>{QUESTIONS.length - Object.keys(submittedQuestions).length} questions remaining</div>
                        </div>
                        <div style={{marginLeft:"auto",display:"flex",gap:4}}>
                          {QUESTIONS.map(q => {
                            const sub = submittedQuestions[q.id];
                            return <div key={q.id} style={{width:8,height:8,borderRadius:"50%",background: sub===undefined?"#d4d0c8":sub?"#22c55e":"#ef4444"}} />;
                          })}
                        </div>
                      </div>
                    )}

                    {QUESTIONS.map((q, i) => {
                      const selected = selectedOptions[q.id];
                      const submitted = submittedQuestions[q.id] !== undefined;
                      const isCorrect = submittedQuestions[q.id] === true;

                      return (
                        <div key={q.id} className="question-card" style={submitted ? {borderColor: isCorrect?"#bbf7d0":"#fecaca"} : {}}>
                          <div className="question-top">
                            <span className="diff-badge" style={{background:DIFF_COLOR[q.difficulty]+"18", color:DIFF_COLOR[q.difficulty]}}>
                              {q.difficulty}
                            </span>
                            <span className="question-num">Q{i+1} of {QUESTIONS.length}</span>
                            {submitted && (
                              <span style={{marginLeft:"auto",fontSize:12,fontWeight:700,color:isCorrect?"#16a34a":"#dc2626",display:"flex",alignItems:"center",gap:4}}>
                                {isCorrect ? "✓ Correct" : "✗ Incorrect"}
                              </span>
                            )}
                          </div>

                          <div className="question-text">{q.text}</div>

                          {/* MCQ Options */}
                          <div style={{display:"flex",flexDirection:"column",gap:8,marginBottom:14}}>
                            {q.options.map((opt, oi) => {
                              let bg = "#f4f3f0", border = "#eae8e2", color = "#3a3840", fw = "500";
                              if (!submitted && selected === oi) { bg="#fff8ee"; border="#f59207"; color="#92400e"; fw="600"; }
                              if (submitted) {
                                if (oi === q.correctIndex) { bg="#f0fdf4"; border="#86efac"; color="#15803d"; fw="700"; }
                                else if (oi === selected && oi !== q.correctIndex) { bg="#fef2f2"; border="#fca5a5"; color="#dc2626"; fw="600"; }
                              }
                              return (
                                <div
                                  key={oi}
                                  onClick={() => !submitted && setSelectedOptions(s => ({...s,[q.id]:oi}))}
                                  style={{
                                    display:"flex",alignItems:"center",gap:10,
                                    padding:"10px 14px",borderRadius:10,
                                    border:`1.5px solid ${border}`,background:bg,
                                    cursor:submitted?"default":"pointer",
                                    transition:"all .12s",color,fontWeight:fw,fontSize:13,
                                  }}
                                >
                                  <div style={{
                                    width:22,height:22,borderRadius:"50%",flexShrink:0,
                                    border:`1.5px solid ${border}`,
                                    display:"flex",alignItems:"center",justifyContent:"center",
                                    fontSize:11,fontWeight:700,background:"#fff",color,
                                  }}>
                                    {submitted && oi === q.correctIndex ? "✓" : submitted && oi === selected && oi !== q.correctIndex ? "✗" : String.fromCharCode(65+oi)}
                                  </div>
                                  {opt.substring(3)} {/* strip "A) " prefix */}
                                </div>
                              );
                            })}
                          </div>

                          {/* Action row */}
                          <div className="question-actions" style={{flexWrap:"wrap",gap:6}}>
                            {!submitted && (
                              <button
                                className="q-btn answer"
                                style={{opacity:selected===undefined?0.45:1,cursor:selected===undefined?"not-allowed":"pointer"}}
                                disabled={selected===undefined}
                                onClick={() => {
                                  if (selected !== undefined) {
                                    setSubmittedQuestions(s => ({...s,[q.id]:selected===q.correctIndex}));
                                    if (selected !== q.correctIndex) setRevealedExplanations(e => ({...e,[q.id]:true}));
                                  }
                                }}
                              >
                                ✓ Submit Answer
                              </button>
                            )}
                            <button className="q-btn hint" onClick={() => setRevealedHints(h => ({...h,[q.id]:!h[q.id]}))}>
                              💡 {revealedHints[q.id] ? "Hide Hint" : "Hint"}
                            </button>
                            {submitted && (
                              <button className="q-btn hint" onClick={() => setRevealedExplanations(e => ({...e,[q.id]:!e[q.id]}))}>
                                📖 {revealedExplanations[q.id] ? "Hide" : "Explanation"}
                              </button>
                            )}
                            <button className="q-btn ask-ai" onClick={() => sendMessage(`Can you walk me through this SAT problem step by step?\n\n"${q.text}"\n\nOptions: ${q.options.join(", ")}`)}>
                              🤖 Ask AI
                            </button>
                            {submitted && (
                              <button
                                className="q-btn"
                                style={{background:"#f4f3f0",borderColor:"#d4d0c8",color:"#5a5860"}}
                                onClick={() => {
                                  setSubmittedQuestions(s => { const n={...s}; delete n[q.id]; return n; });
                                  setSelectedOptions(s => { const n={...s}; delete n[q.id]; return n; });
                                  setRevealedExplanations(e => { const n={...e}; delete n[q.id]; return n; });
                                  setRevealedHints(h => { const n={...h}; delete n[q.id]; return n; });
                                }}
                              >
                                ↺ Retry
                              </button>
                            )}
                          </div>

                          {revealedHints[q.id] && <div className="reveal-box reveal-hint" style={{marginTop:10}}>💡 {q.hint}</div>}
                          {revealedExplanations[q.id] && <div className="reveal-box reveal-answer" style={{marginTop:8,fontFamily:"'Plus Jakarta Sans',sans-serif",fontWeight:500,lineHeight:1.6}}>📖 {q.explanation}</div>}
                        </div>
                      );
                    })}
                  </div>
                )}
              </div>
            </div>

            {/* ── RIGHT PANEL (AI Chat) ── */}
            <div className="right-panel">
              <div className="chat-header">
                <div className="chat-avatar">🎓</div>
                <div className="chat-header-info">
                  <h3>AI Tutor</h3>
                  <p>Preppeo · SAT Math</p>
                </div>
                <div className="online-dot" />
              </div>

              <div className="chat-messages">
                {messages.map((m, i) => (
                  <div key={i} className={`msg ${m.role}`}>
                    <div className={`msg-avatar ${m.role==="assistant"?"msg-ai-av":"msg-user-av"}`}>
                      {m.role==="assistant" ? "🎓" : "VA"}
                    </div>
                    <div className="msg-bubble" dangerouslySetInnerHTML={{__html: renderMd(m.content)}} />
                  </div>
                ))}
                {loading && (
                  <div className="msg assistant">
                    <div className="msg-avatar msg-ai-av">🎓</div>
                    <div className="msg-bubble" style={{padding:"6px 12px"}}>
                      <div className="typing">
                        <span/><span/><span/>
                      </div>
                    </div>
                  </div>
                )}
                <div ref={chatEndRef} />
              </div>

              <div className="quick-prompts">
                {["Explain this concept", "Give me an example", "What's the formula?", "I'm confused about…"].map(p => (
                  <div key={p} className="quick-chip" onClick={() => quickPrompt(p)}>{p}</div>
                ))}
              </div>

              <div className="chat-input-area">
                <textarea
                  ref={inputRef}
                  className="chat-input"
                  placeholder="Ask anything about this lesson…"
                  value={input}
                  onChange={e => setInput(e.target.value)}
                  onKeyDown={e => { if(e.key==="Enter" && !e.shiftKey) { e.preventDefault(); sendMessage(input); } }}
                  rows={1}
                />
                <button className="send-btn" onClick={() => sendMessage(input)} disabled={!input.trim() || loading}>
                  ➤
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </>
  );
}