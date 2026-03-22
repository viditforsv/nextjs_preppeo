#!/usr/bin/env python3
"""Parse CBSE 10 Science .tex files into SQL INSERT statements."""

import re
import sys
import json
from pathlib import Path

BASE = Path(__file__).resolve().parent.parent / "Docs for me" / "latex_with_rijay" / "cbse_10_science"

DOMAIN_MAP = {
    "01": "chemical-reactions",
    "02": "acids-bases-salts",
    "03": "metals-non-metals",
    "04": "carbon-compounds",
    "05": "periodic-classification",
    "06": "life-processes",
    "07": "control-coordination",
    "08": "reproduction",
    "09": "heredity-evolution",
    "10": "light",
    "11": "human-eye",
    "12": "electricity",
    "13": "magnetic-effects",
    "14": "sources-of-energy",
    "15": "our-environment",
    "16": "sustainable-management",
}

CHAPTER_NAMES = {
    "01": "Chemical Reactions and Equations",
    "02": "Acids, Bases and Salts",
    "03": "Metals and Non-Metals",
    "04": "Carbon and its Compounds",
    "05": "Periodic Classification of Elements",
    "06": "Life Processes",
    "07": "Control and Coordination",
    "08": "How do Organisms Reproduce",
    "09": "Heredity and Evolution",
    "10": "Light - Reflection and Refraction",
    "11": "The Human Eye and the Colourful World",
    "12": "Electricity",
    "13": "Magnetic Effects of Electric Current",
    "14": "Sources of Energy",
    "15": "Our Environment",
    "16": "Sustainable Management of Natural Resources",
}

SOURCE_TAG_MAP = {
    "ncert_exempler": "exemplar",
    "ncert exempler": "exemplar",
    "exemplar": "exemplar",
    "ncert": "ncert",
    "extra questions": "extra",
    "extra": "extra",
    "sv_cbse10": "sv",
    "sv_": "sv",
    "test paper": "test",
    "chapter test": "test",
    "chapter assignment": "assign",
    "mixed": "mixed",
}


def guess_source_tag(filename: str) -> str:
    fn_lower = filename.lower()
    if "exempler" in fn_lower or "exemplar" in fn_lower:
        return "exemplar"
    if "extra" in fn_lower:
        return "extra"
    if fn_lower.startswith("sv_"):
        return "sv"
    if "test" in fn_lower:
        return "test"
    if "ncert" in fn_lower:
        return "ncert"
    if "assignment" in fn_lower or "chapter assignment" in fn_lower:
        return "assign"
    return "misc"


def extract_questions_block(text: str) -> str:
    m = re.search(r'\\begin\{questions\}(.*?)\\end\{questions\}', text, re.DOTALL)
    return m.group(1) if m else ""


def split_questions(block: str) -> list[str]:
    parts = re.split(r'(?=%Q:|\\question)', block)
    questions = []
    current = ""
    for part in parts:
        if re.match(r'\s*%Q:', part) or re.match(r'\s*\\question', part):
            if current.strip():
                questions.append(current.strip())
            current = part
        else:
            current += part
    if current.strip():
        questions.append(current.strip())
    return [q for q in questions if '\\question' in q]


def extract_solution(q_text: str) -> tuple[str, str]:
    """Return (solution_body, text_without_comment_block)."""
    m = re.search(
        r'\\begin\{comment\}\s*\\begin\{solution\}(.*?)\\end\{solution\}\s*\\end\{comment\}',
        q_text, re.DOTALL
    )
    if m:
        sol = m.group(1).strip()
        cleaned = q_text[:m.start()] + q_text[m.end():]
        return sol, cleaned
    return "", q_text


def extract_tasks(text: str) -> list[str] | None:
    """Extract top-level \\task items from \\begin{tasks}...\\end{tasks}."""
    m = re.search(r'\\begin\{tasks\}(?:\(\d+\))?(.*?)\\end\{tasks\}', text, re.DOTALL)
    if not m:
        return None
    tasks_body = m.group(1)
    items = re.split(r'\\task\s+', tasks_body)
    items = [i.strip() for i in items if i.strip()]
    return items if len(items) >= 2 else None


def extract_images(text: str) -> list[str]:
    imgs = []
    for m in re.finditer(r'\\includegraphics(?:\[[^\]]*\])?\{([^}]+)\}', text):
        name = m.group(1).strip()
        basename = name.replace("\\", "/").split("/")[-1].lower()
        if basename.startswith("logo"):
            continue
        imgs.append(m.group(1).strip())
    return imgs


def clean_prompt(text: str) -> str:
    text = re.sub(r'%Q:\s*\d+\s*', '', text)
    text = re.sub(r'\\question(?:\[\d+\])?\s*', '', text, count=1)
    text = re.sub(r'\\droppoints', '', text)
    text = re.sub(r'\\begin\{comment\}.*?\\end\{comment\}', '', text, flags=re.DOTALL)
    text = re.sub(r'\\section\*?\{[^}]*\}', '', text)

    top_tasks = re.search(r'\\begin\{tasks\}(?:\(\d+\))?(.*?)\\end\{tasks\}', text, re.DOTALL)
    if top_tasks and extract_tasks(text):
        text = text[:top_tasks.start()] + text[top_tasks.end():]

    text = text.strip()
    while text.endswith('\n'):
        text = text.rstrip('\n').strip()
    return text


def clean_solution_text(sol: str) -> str:
    sol = re.sub(r'\\newline', '\n', sol)
    sol = sol.strip()
    return sol


def guess_mcq_answer(solution: str, options: list[str]) -> str:
    if not solution:
        return ""
    sol_lower = solution.strip().lower()
    m = re.match(r'^([a-d])[\.\)\s]', sol_lower)
    if m:
        return m.group(1)
    labels = ['a', 'b', 'c', 'd']
    for i, label in enumerate(labels):
        if sol_lower.startswith(f"{label}.") or sol_lower.startswith(f"{label})"):
            return label
    return ""


def sql_escape(s: str) -> str:
    return s.replace("'", "''")


def parse_file(filepath: Path, chapter_num: str, source_tag: str) -> list[dict]:
    text = filepath.read_text(encoding='utf-8', errors='replace')
    block = extract_questions_block(text)
    if not block:
        return []

    raw_questions = split_questions(block)
    results = []

    for idx, q_raw in enumerate(raw_questions, 1):
        solution, q_no_sol = extract_solution(q_raw)
        tasks = extract_tasks(q_no_sol)
        prompt_text = clean_prompt(q_no_sol)
        images = extract_images(q_no_sol)
        sol_images = extract_images(solution) if solution else []

        if tasks and len(tasks) >= 2:
            q_type = "mcq"
            labels = ['a', 'b', 'c', 'd', 'e', 'f']
            options = []
            for i, t in enumerate(tasks):
                lid = labels[i] if i < len(labels) else str(i + 1)
                options.append({"id": lid, "text": t.strip()})

            answer = guess_mcq_answer(solution, tasks)
            explanation = clean_solution_text(solution)
            if answer and explanation.lower().startswith(f"{answer}."):
                explanation = explanation[2:].strip()
            elif answer and explanation.lower().startswith(f"{answer})"):
                explanation = explanation[2:].strip()
        else:
            q_type = "spr"
            options = None
            answer = clean_solution_text(solution) if solution else ""
            explanation = ""

        bank_id = f"cbse10_ch{chapter_num}_{source_tag}_q{idx:03d}"
        domain = DOMAIN_MAP.get(chapter_num, None)
        chapter_name = CHAPTER_NAMES.get(chapter_num, "")
        all_images = images + sol_images
        image_ref = all_images[0] if all_images else None

        results.append({
            "type": q_type,
            "prompt": prompt_text,
            "options": json.dumps(options) if options else None,
            "correct_answer": answer,
            "explanation": explanation,
            "domain": domain,
            "difficulty_tier": "medium",
            "chapter": chapter_name,
            "subtopic": None,
            "bank_item_id": bank_id,
            "image_url": image_ref,
            "qc_done": False,
        })

    return results


def generate_sql(questions: list[dict]) -> str:
    if not questions:
        return ""

    lines = []
    lines.append("INSERT INTO cbse10_science_questions (")
    lines.append("  type, prompt, options, correct_answer, explanation,")
    lines.append("  domain, difficulty_tier, chapter, subtopic,")
    lines.append("  bank_item_id, image_url, qc_done")
    lines.append(")")
    lines.append("VALUES")

    value_blocks = []
    for q in questions:
        prompt_esc = sql_escape(q["prompt"])
        answer_esc = sql_escape(q["correct_answer"])
        expl_esc = sql_escape(q["explanation"])
        chapter_esc = sql_escape(q["chapter"]) if q["chapter"] else ""

        opts = f"'{sql_escape(q['options'])}'::jsonb" if q["options"] else "NULL"
        domain = f"'{q['domain']}'" if q["domain"] else "NULL"
        subtopic = f"'{sql_escape(q['subtopic'])}'" if q["subtopic"] else "NULL"
        image = f"'{sql_escape(q['image_url'])}'" if q["image_url"] else "NULL"

        block = (
            f"  (\n"
            f"    '{q['type']}',\n"
            f"    '{prompt_esc}',\n"
            f"    {opts},\n"
            f"    '{answer_esc}',\n"
            f"    '{expl_esc}',\n"
            f"    {domain},\n"
            f"    '{q['difficulty_tier']}',\n"
            f"    '{chapter_esc}',\n"
            f"    {subtopic},\n"
            f"    '{q['bank_item_id']}',\n"
            f"    {image},\n"
            f"    false\n"
            f"  )"
        )
        value_blocks.append(block)

    lines.append(",\n".join(value_blocks))
    lines.append("ON CONFLICT (bank_item_id) DO NOTHING;")
    return "\n".join(lines) + "\n"


def get_chapter_files(chapter_num: str) -> list[tuple[Path, str]]:
    folder_prefix = f"{chapter_num}_"
    for d in sorted(BASE.iterdir()):
        if d.is_dir() and d.name.startswith(folder_prefix):
            files = sorted(d.glob("*.tex"))
            result = []
            for f in files:
                tag = guess_source_tag(f.name)
                src_count = sum(1 for _, t in result if t == tag)
                final_tag = f"{tag}{src_count + 1}" if src_count > 0 else tag
                result.append((f, final_tag))
            return result
    return []


def get_mixed_files() -> list[tuple[Path, str]]:
    mixed_dir = BASE / "_mixed"
    if not mixed_dir.exists():
        return []
    files = sorted(mixed_dir.glob("*.tex"))
    result = []
    for i, f in enumerate(files, 1):
        result.append((f, f"mixed{i}"))
    return result


def process_batch(chapter_nums: list[str], include_mixed: bool = False) -> str:
    all_questions = []
    for ch in chapter_nums:
        files = get_chapter_files(ch)
        for filepath, source_tag in files:
            qs = parse_file(filepath, ch, source_tag)
            all_questions.extend(qs)

    if include_mixed:
        mixed_files = get_mixed_files()
        for filepath, source_tag in mixed_files:
            qs = parse_file(filepath, "00", source_tag)
            for q in qs:
                q["domain"] = None
                q["chapter"] = "Mixed"
            all_questions.extend(qs)

    ch_label = "_".join(f"ch{c}" for c in chapter_nums)
    if include_mixed:
        ch_label += "_mixed"
    header = f"-- CBSE 10 Science seed: {ch_label}\n"
    header += f"-- Auto-generated from .tex files. All qc_done = false.\n"
    header += f"-- Total questions in this batch: {len(all_questions)}\n\n"

    return header + generate_sql(all_questions), len(all_questions)


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python parse_cbse10_tex.py <chapter_nums> [--mixed]")
        print("  e.g.: python parse_cbse10_tex.py 01,02")
        print("  e.g.: python parse_cbse10_tex.py 15,16 --mixed")
        sys.exit(1)

    chapters = sys.argv[1].split(",")
    include_mixed = "--mixed" in sys.argv

    sql, count = process_batch(chapters, include_mixed)
    print(sql)
    print(f"-- {count} questions generated", file=sys.stderr)
