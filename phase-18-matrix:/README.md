# Phase 18 — Matrix (Problems 232–234)

Swift solutions for the Matrix phase of my DSA roadmap. Every problem includes
step-by-step comments, debug logs, traps, and tests. Covers the four basics
files (creation, traversal, directions, in-place updates), the transpose +
reverse composition, the shrinking-boundary walk, and the first-row/column
flag trick that turns O(m+n) space into O(1).


## Problems

| # | Problem | LeetCode | Approach | Complexity |
|---|---------|----------|----------|------------|
| 232 | Rotate Image ⭐ | LC 48 | Transpose across main diagonal (inner bound `row+1`); reverse each row | O(n²) time, O(1) space |
| 233 | Spiral Matrix ⭐ | LC 54 | Four shrinking boundaries; guards re-checked before the bottom and left passes | O(m·n) time, O(1) extra |
| 234 | Set Matrix Zeroes ⭐ | LC 73 | Row 0 and column 0 as flag storage; `firstColumnHasZero` breaks the `[0][0]` tie | O(m·n) time, O(1) space |

## Basics

| File | Covers |
|------|--------|
| 01_Matrix_Basics | `[[Int]]` declaration, safe row/column derivation, runtime zero grids, `printMatrix`, `isValid`, value semantics |
| 02_Traversal | Row-wise, column-wise, main and anti-diagonal, clockwise boundary walk, reverse traversal |
| 03_Directions | 4- and 8-direction offset arrays, neighbour enumeration, directional walk to the grid edge |
| 04_InPlace_Update | In-place transpose, row reversal, row-order reversal, cell swap — all via `inout` |

## Core Patterns

- **Non-square grids are step 0** — every basics file uses 3×4, never 3×3;
  a square grid makes `rows` and `columns` interchangeable, so an index
  swap passes silently and only fails on the real input (basics)
- **Loop order flips, subscript order does not** — column-wise traversal
  puts `columns` on the outer loop but still reads `matrix[row][col]`;
  writing `matrix[col][row]` here is the most common matrix bug (02)
- **Offsets are `(rowDelta, colDelta)`** — "right" is `(0, 1)`, not
  `(1, 0)`; the wrong tuple order silently rotates every traversal
  sideways instead of crashing (03)
- **Fresh constants inside the neighbour loop** — `newRow`/`newCol`
  computed from the origin each iteration; mutating `row`/`col` in place
  makes each direction step off the PREVIOUS one, so the neighbour set
  drifts (03)
- **Guard before subscripting, never after** — `matrix[-1][0]` crashes,
  it does not return nil; `isValid` checks the row bound before touching
  `matrix[row].count` (03)
- **`inout` is not optional** — Swift arrays are value types, so a
  function taking `[[Int]]` mutates a copy and the caller sees nothing;
  the value-semantics proof in 01 is what makes this a constraint rather
  than a style choice (04, 232)
- **Transpose inner loop starts at `i + 1`** — starting at 0 swaps every
  pair TWICE and returns the matrix to its original state; the same
  triangular bound appears in every diagonal-symmetric operation (04, 232)
- **Two sweeps compose into a rotation** — transpose then reverse each
  ROW = clockwise; transpose then reverse the ROW ORDER = counter-clockwise;
  in-place does not mean single-pass (232)
- **Test on an even-sized grid** — a 3×3 has an untouched centre cell that
  masks off-by-one errors in the inner bound; a 4×4 does not (232)
- **Four boundaries, not four directions** — Spiral tracks `top`, `bottom`,
  `left`, `right`; each pass consumes one edge then shrinks its OWN
  boundary, which is why the walk terminates without a visited grid (233)
- **Guards are re-checked mid-loop, not just at the top** — after the top
  and right passes the boundaries have already moved; without
  `top <= bottom` before the bottom pass and `left <= right` before the
  left pass, a single remaining row or column is walked TWICE (233)
- **`<=` not `<` on the loop condition** — `top < bottom` drops the final
  row or column entirely; same one-character class of bug as Phase 17's
  merge-vs-schedule boundary (233)
- **A sentinel is only valid when it provably isn't data** — `Int.min`
  works for LC 73 because values are bounded to the 32-bit range; say
  that out loud rather than assuming it (234)
- **The grid already contains m + n spare cells** — row 0 and column 0 are
  exactly the size of the flag arrays you were about to allocate; that
  reframe is the whole O(1) follow-up (234)
- **One cell cannot hold two flags** — `matrix[0][0]` would mean both
  "row 0 has a zero" and "column 0 has a zero"; it keeps ONE meaning and
  a separate `firstColumnHasZero` Bool keeps the other (234)
- **Write order is load-bearing** — interior, then row 0, then column 0;
  clearing column 0 early wipes the row flags the interior pass still
  needs to read, and the whole grid zeroes out (234)

## Traps Logged This Phase

- Row-marking loop bounded by `0..<col` instead of `0..<columns` — marks
  only cells LEFT of the zero; `[[1,0,3],[4,5,6]]` leaves the 3 alive.
  Same wrong-bound family as the column loop that was written correctly
  two lines below it (234)
- Boundary walk missing its fourth pass entirely — the left-column segment
  was stubbed with a comment that also mislabelled it as the right column;
  the walk silently returned three sides of a rectangle (02)
- Left-column bounds `>= 0` instead of `>= 1` — re-prints `[0][0]`, which
  the top-row pass already consumed (02)
- `print()` separators between boundary segments — split one continuous
  walk into four visually disconnected lines, hiding whether the segments
  actually joined up (02)
- `matrix[0].count` with no empty guard, declared directly above an empty
  matrix in the same file (01)
- `import UIKit` in a solution file — will not compile on a Linux judge or
  in a command-line target; `Foundation` is the correct import (233)
- `var` on never-mutated `empty`, `new`, `zeroMatric`, `matrix` — house
  rule violation, fourth phase running (01, 233)
- Declared `rowCount` and `columnCount`, then hardcoded 4 and 3 one line
  below — dead constants that read as if they were used (01)
- Assigned `first`, `second`, `third` and never printed them — an access
  section that demonstrates nothing (01)
- Typos that compile: `righ`, `colums`, `fisrt`, `zeroMatric`, `squere`,
  `DiagNoan` — naming discipline, carried over from Phase 17 (01, 232)
- Solved 234 from hints rather than attempting the O(1) version cold —
  flagged for a redo pass; the brute force was attempted independently

## House Rules

- No force unwraps
- No `?? 0` nil-coalescing — explicit `if let / guard let` everywhere
- No stdlib convenience functions (`stride`, `swap`, `reversed`) — loops
  written out by hand
- `let` over `var` where mutation is absent
- Blank line between statements
- Every solution file opens with problem statement, example, constraints,
  and states time/space complexity
- Debug prints at key decision points, not every line
- Debug builds kept separate; prints stripped from the committed solution
- One-line commit messages

**Status:** ✅ Complete — closed Aug 5, 2026
