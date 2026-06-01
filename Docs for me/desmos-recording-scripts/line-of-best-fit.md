# Recording script — Line of Best Fit & Regression

- **Slug:** `line-of-best-fit` · **Target:** SAT Desmos line of best fit
- **Output:** `public/images/desmos/line-of-best-fit.{mp4,webm}` · ~20s · autoplay/muted/loop (no audio)
- **Demo problem:** Data (1, 2), (2, 5), (3, 7), (4, 10). Slope of the best-fit line, to the nearest tenth? **(Answer: 2.6)**

## Exact Desmos input
1. Add a **table** (the `+` button → Table). Fill it:

   | x₁ | y₁ |
   |----|----|
   | 1  | 2  |
   | 2  | 5  |
   | 3  | 7  |
   | 4  | 10 |

2. On a new expression line, type the regression with a **tilde `~`** (not `=`):
```
y_1 ~ a x_1 + b
```

## Shot list (~20s, silent)
- **0:00** Blank Desmos calculator.
- **0:02** Add table, type the 4 (x₁, y₁) rows — points appear.
- **0:11** New line: type `y_1 ~ a x_1 + b` — best-fit line draws through the points.
- **0:15** Desmos shows a results box with **a ≈ 2.6** and b; point/circle **a ≈ 2.6**.
- **0:18** Hold on the results box, loop.

## Final frame must show
The regression results box with **a ≈ 2.6** (the slope, the answer) visible, line fitted through the 4 points.

## Note
The **`~` (tilde) is the whole trick** — `=` graphs nothing useful. Make the tilde clearly visible as you type.

## After recording
Save as `public/Videos/line-of-best-fit.mov` and hand it to me.
