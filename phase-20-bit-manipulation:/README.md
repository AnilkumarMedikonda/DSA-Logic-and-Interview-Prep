# Phase 20 — Bit Manipulation (245–247)

The final phase of the roadmap. Bit manipulation problems reduce to a
handful of mechanical operations on binary — reading, setting, and
counting bits — combined with knowing how Swift stores integers. The
whole phase turns on one distinction: **signed `Int` (arithmetic
shift, sign-extends) vs unsigned `UInt32` (logical shift, fills with
zero)**. Every LC problem here specifies a 32-bit *unsigned* input, so
they must be solved on `UInt32` — on `Int` the loops either hang on a
negative or overflow when the top bit lands on the sign bit.

Structure: `Basics/` (01–04) build the vocabulary before any LC
problem, same as Phases 15–19.

## Problems

| #   | Problem          | LeetCode | Approach                                   | Complexity              |
|-----|------------------|----------|--------------------------------------------|-------------------------|
| 245 | Number of 1 Bits | LC 191   | Brian Kernighan `n & (n-1)`; manual divide | O(set bits) / O(log n)  |
| 246 | Counting Bits    | LC 338   | DP `dp[i] = dp[i >> 1] + (i & 1)`          | O(n), O(1) per number   |
| 247 | Reverse Bits     | LC 190   | Pull last bit, push onto result, ×32       | O(1) (fixed 32 passes)  |

Basics files: 01 Bit Basics (representation, decimal↔binary by hand),
02 Bit Operators (`& | ^ ~`, truth tables, XOR properties), 03 Shifts
(`<< >>`, arithmetic vs logical, Swift smart/masking shift), 04 Bit
Tricks (check/set/clear/toggle, `n & (n-1)`, `n & -n`, power of 2,
count set bits).

## Core Patterns

- **`n & (n - 1)` clears the lowest set bit** — loop runs once per 1
  bit, so counting set bits is O(set bits), not O(32). This is the
  245 follow-up and the engine of `countSetBits` in 04.
- **`n & -n` isolates the lowest set bit** — `-n` is `~n + 1`, which
  flips everything left of the lowest 1; AND keeps exactly that bit.
- **`dp[i] = dp[i >> 1] + (i & 1)`** — `i` is `i/2` with one bit
  pushed on; `i >> 1 < i` so the subproblem is already solved. Turns
  246 from O(n·32) into O(n) (04 tricks → 246).
- **Build the reverse by shifting the result up and the input down** —
  `result = (result << 1) | (n & 1)`, `n >>= 1`, ×32. First bit read
  ends up most significant (247).
- **`1 << i` is a single-bit mask** — powers every check/set/clear/
  toggle in 04.

## Traps Logged This Phase

- **`number & (n - 1)` froze the right operand** in 245 — must be
  `number - 1`. With `n` frozen the loop never shrinks → infinite.
- **Signed right shift never terminates on a negative `Int`** — sign
  bit refills, `-8 >> k` sticks at `-1`. `while n != 0` hangs. Solve
  on `UInt32`.
- **`import UIKit` in a DSA file** — won't compile command-line; use
  `Foundation`. (Recurring: also hit in Spiral Matrix.)
- **`countSetBits` / `n & -n` trap on `Int.min`** — `n - 1` and `-n`
  overflow. Non-negative / `UInt32` input only.
- **`1...n` traps when `n == 0`** — guard before the loop in 246.

## House Rules

- No built-in `String(n, radix: 2)` / `Int(_, radix:)` in Basics —
  manual `%2 / /2` and `*2 + bit` loops; radix used once only to
  verify.
- No force unwraps, no `?? 0`.
- Blank line after every print/debug statement.
- Every solution file opens with problem statement, example,
  constraints, and states time/space complexity.

## Status

**COMPLETE** — 245, 246, 247 solved; Basics 01–04 done.
Roadmap **247/247 (100%)**.
