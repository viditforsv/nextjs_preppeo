Building a CBT (Computer-Based Testing) platform for the Digital SAT Math section requires a precise implementation of the **Multi-Stage Adaptive Testing (MST)** model.

---

## 1. Section Structure

The Math section is strictly divided into two back-to-back modules.

* **Total Questions:** 44 (22 per module).
* **Operational:** 20 questions (count toward score).
* **Pretest:** 2 questions (unscored, used for future calibration).


* **Total Time:** 70 minutes (35 minutes per module).
* **Question Formats:** * **MCQ (75%):** Four-option multiple choice.
* **SPR (25%):** Student-Produced Response (Grid-in).



---

## 2. The Difficulty Matrix

The Digital SAT uses a **2-stage adaptive logic**. Unlike "item-adaptive" tests (like the GMAT) that change after every question, the SAT only adapts **between modules**.

### Module 1: The "Router"

* **Goal:** Determine the student's ability range.
* **Mix:** A broad distribution of **Easy (approx. 25%)**, **Medium (approx. 50%)**, and **Hard (approx. 25%)** questions.

### Module 2: The "Adaptive" Stage

Based on the Module 1 performance, the system routes the student to one of two versions:
| Module 2 Version | Difficulty Profile | Score Potential |
| :--- | :--- | :--- |
| **Lower Difficulty** | Majority Easy/Medium questions. | Capped (Max score ~550–600). |
| **Higher Difficulty** | Majority Hard/Very Hard questions. | Full range (Up to 800). |

---

## 3. Marking Scheme & Scoring Conditions

The scoring does **not** follow a simple "10 points per question" rule. It uses **Item Response Theory (IRT)**.

* **No Negative Marking:** There is no penalty for wrong answers.
* **Weighting:** Every question is assigned a "weight" based on its difficulty and discrimination parameters. A "Hard" question in Module 2 is statistically more valuable for a high score than an "Easy" one.
* **Routing Threshold:** To enter the "Hard" Module 2, a student typically needs to get **approx. 14–15 out of 22** questions correct in Module 1.
* **Section Score:** 200–800 scale.

---

## 4. Question Domains (The "What")

Your database should categorize questions into these four pillars:

1. **Algebra (35%):** Linear equations, systems, and inequalities.
2. **Advanced Math (35%):** Quadratics, polynomials, and nonlinear functions.
3. **Problem Solving & Data Analysis (15%):** Ratios, statistics, and probability.
4. **Geometry & Trigonometry (15%):** Area/volume, circles, and right triangles.

---

## Strategy for Your Platform

To build this correctly, your algorithm must:

1. **Randomize** the 2 pretest questions so students can't identify them.
2. **Lock** Module 1 once submitted; students cannot return to it after starting Module 2.
3. **Integrate** a graphing calculator (like Desmos) as it is allowed for the entire duration.

Would you like me to draft the **pseudocode for the routing logic** that determines if a student moves to the Hard or Easy Module 2?

[Mastering Digital SAT Math](https://www.youtube.com/watch?v=5BLaV52DedU)
This video provides a deep dive into the hardest question types and strategies for the digital adaptive format, which is essential for calibrating your difficulty matrix.