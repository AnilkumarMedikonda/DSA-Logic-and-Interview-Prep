# Phase 19 — Dynamic Programming (Problems 235–244)

Swift solutions for the Dynamic Programming phase of my DSA roadmap. Every
problem includes step-by-step comments, debug logs, traps, and tests. Covers
the five basics files (overlapping subproblems, memoization, tabulation, space
optimization, state transition), the full 1D ladder from Climbing Stairs to
Decode Ways, and the first 2D grid problems — Unique Paths and Longest Common
Subsequence — including their rolling-row and diagonal-carry space optimizations.

The organizing idea across the phase is the **six-line checklist** — state,
options, combiner, transition, base, answer — written as a comment block before
any Swift is typed. Get the state sentence and the transition right and the
code writes itself; get the state wrong and nothing downstream can be fixed.


## Problems

### L1 — 1D DP

| # | Problem | LeetCode | Approach | Complexity |
|---|---------|----------|----------|------------|
| 235 | Climbing Stairs ⭐ | LC 70 | Fibonacci recurrence; four solutions naive → memo → tabulation → two rolling variables | O(n) time, O(1) space |
| 236 | House Robber ⭐ | LC 198 | `dp[i] = max(dp[i-1], nums[i] + dp[i-2])`; "up to i" state, answer `dp[n-1]` | O(n) time, O(1) space |
| 237 | House Robber II ⭐ | LC 213 | Case split into two straight-line runs (`dropLast` / `dropFirst`); guard `n == 1` | O(n) time, O(1) space |
| 238 | Coin Change ⭐ | LC 322 | Unbounded knapsack; forward loop; sentinel `amount + 1`, answer `-1` if unreached | O(amount·coins) time, O(amount) space |
| 239 | Longest Increasing Subsequence ⭐ | LC 300 | "Ending at i" state, answer `max(dp)`; plus the O(n log n) tails/binary-search follow-up | O(n²) time, O(n) space |
| 240 | Partition Equal Subset Sum ⭐ | LC 416 | Subset-sum to `total/2`; 0/1 knapsack, **backwards** inner loop | O(n·target) time, O(target) space |
| 241 | Word Break ⭐ | LC 139 | Coin Change on positions; words reusable so forward loop; distinct-length trick | O(n·L·k) time, O(n) space |
| 242 | Decode Ways ⭐ | LC 91 | Climbing Stairs with legality rules; one-digit ≠ '0', two-digit in 10…26 | O(n) time, O(1) space |

### L2 — 2D DP

| # | Problem | LeetCode | Approach | Complexity |
|---|---------|----------|----------|------------|
| 243 | Unique Paths ⭐ | LC 62 | `dp[i][j] = above + left`; first row and column seeded to 1; rolling-row collapse | O(m·n) time, O(n) space |
| 244 | Longest Common Subsequence ⭐ | LC 1143 | `(m+1)×(n+1)` grid; match → diagonal + 1, differ → max(above, left); 1D diagonal carry | O(m·n) time, O(n) space |

## Basics

| File | Covers |
|------|--------|
| 01_DP_Basics | Overlapping subproblems + optimal substructure; naive Fibonacci; why the call tree is O(2ⁿ); call-count proof via an `inout` accumulator |
| 02_Memoization | Top-down: same recursion + a cache; sentinel choice (`-1` vs `nil`); array vs dictionary cache; the three-line recipe |
| 03_Tabulation | Bottom-up: seed base cases, fill in increasing order; the four things to write down (state, base, transition, answer); loop-direction dependency |
| 04_Space_Optimization | Rolling variables when the transition reaches back a fixed distance; assignment-order bug; when it is *not* possible (LIS, reconstruction) |
| 05_State_Transition | The six-line checklist; "ending at i" vs "up to i"; combiner → base-case mapping; the dimension question (1D vs 2D) |

## Core Patterns

- **The six-line checklist comes before any code** — state, options,
  combiner, transition, base, answer; five of the six happen before a line
  of Swift, and that ratio is what an interviewer grades (05, all)
- **The combiner names the base case** — `max`/`min` → trivial best, `+` →
  identity 1, `||` → true; `dp[0] = 1` in Decode Ways and `dp[0] = true` in
  Word Break both fall straight out of this (05, 238, 241, 242)
- **"Ending at i" and "up to i" are different states** — House Robber is
  "up to i" so the answer is `dp[n-1]`; LIS is "ending at i" so the answer
  is `max(dp)`; picking the wrong one returns an almost-right number
  (05, 236, 239)
- **Four solutions, only two lines change** — naive → memo → tabulation →
  rolling is mechanical; state (line 1) and transition (line 4) are the only
  parts that vary between problems (235, all)
- **The sentinel must be provably outside the answer range** — `amount + 1`
  for Coin Change beats `Int.max` because it can't overflow on `+1` and no
  valid answer can reach it; the final check is then `> amount`, not
  `== sentinel` (238)
- **Bounded vs unbounded flips the loop direction** — Coin Change reuses
  coins (unbounded) → forward inner loop; Partition uses each number once
  (0/1) → backward inner loop; Word Break reuses words → forward (238, 240, 241)
- **Rolling variables need the OLD value captured first** — `let current =
  prev1 + prev2` before reassigning, or a tuple swap; overwriting `prev1`
  before reading it corrupts `prev2` (04, 235)
- **Space optimization is impossible when the transition reaches back a
  variable distance** — Coin Change reaches back by `coin`, LIS reaches back
  to every earlier `j`; there is no fixed window to slide, so the array
  stays (04, 238, 239)
- **2D array sizing: outer = rows, inner = columns** — `Array(repeating:
  Array(repeating: 0, count: cols), count: rows)`; getting this backwards
  crashed Partition's 2D version on `[1,1]` before it was fixed in Unique
  Paths (240, 243)
- **The rolling-row trick is about overwrite timing** — `dp[j]` not yet
  touched this row is the cell ABOVE, `dp[j-1]` already touched is the cell
  LEFT; one array holds two rows because of *when* each slot is written
  (243)
- **LCS needs a third neighbour — the diagonal** — carried in one variable:
  `let top = dp[j]` before overwrite, then `diagonal = top` at the end of
  the iteration; three cells tracked with one array plus one scalar (244)
- **The `(m+1)×(n+1)` offset is where index bugs live** — `dp[i][j]` means
  "first i characters", so the i-th character sits at index `i-1`, and the
  answer is `dp[m][n]`, not `dp[m-1][n-1]` like Unique Paths (244)
- **Half-open ranges are self-guarding, closed ranges are not** — `1..<m`
  is an empty (safe) range when `m == 1`; `1...m` traps; every crash in this
  phase was a closed range over a size-1 or size-0 input (238, 242, 243, 244)

## Traps Logged This Phase

- Base-case seeding BEFORE the size guard — `dp[1] = ...` written before
  `if n < 2 { return }`; crashes on a single-element input because the array
  has only one slot. Guard first, then allocate (05, 235)
- `for value in 1...amount` traps when `amount == 0`, which the constraints
  allow; same closed-range family as Decode Ways' `2...n` (238, 242)
- Naive Coin Change never converts the internal sentinel to `-1` — the
  sentinel has to survive inside the recursion for `min` to work, so the
  conversion belongs in a WRAPPER, not the recursive body (238)
- `Int(String(chars[...]))!` in Decode Ways — a force unwrap AND a built-in
  conversion, both house-rule violations; replaced with direct character
  comparison (`chars[i-2] == "1" || (chars[i-2] == "2" && chars[i-1] <= "6")`),
  which also excludes leading zeros for free (242)
- Word Break inner loop `0..<n` instead of `0..<i` — `chars[j..<i]` would
  trap when `j > i`; survives only because `dp[j]` is false for `j > i`, i.e.
  relying on an accident (241)
- `canPartitionMemo` calling the plain `helper` instead of `memoHelper` —
  the memo array was never even allocated; the "memoized" solution silently
  ran as the naive one (240)
- 2D dp rows sized `target + 1` instead of `n + 1` in Partition — passes on
  the sample input where `target > n`, crashes on `[1,1]` where `target < n`
  (240)
- `dp.max()!` / `dp.last!` force unwraps — safe behind a guard but invite
  "what if it's empty?" in an interview; use an explicit index or `?? base`
  (237, 239)
- Complexity mislabeled O(n²) instead of O(2ⁿ) on naive recursion — undercuts
  the whole optimization story, since the point is the exponential→linear
  jump (235)
- Base cases returning `n` by coincidence — `if n == 1 { return n }` is right
  only because the answer equals the input at that point; write the value you
  mean, not the accident (235)
- `let old = tails[left]` kept only to print a value the array already shows
  — dead temp variable (239)
- Typos that compile: `cliamStatirs`, `Tablations`, `interveiw`, `Longets`,
  `Incresing`, `canPartion`, `numsDecodeing`, `uniQuePaths`, `Optmised` —
  naming discipline, carried from Phases 17–18 (235, 239, 240, 242, 243)
- `import UIKit` in solution files — will not compile on a Linux judge;
  `Foundation` (or nothing) is correct (multiple)

## House Rules

- No force unwraps
- No `?? 0` nil-coalescing — explicit `if let / guard let` everywhere
- No stdlib convenience functions (`reduce`, `stride`, `map`, `swap`) —
  loops written out by hand
- `let` over `var` where mutation is absent
- Compact spacing — at most one blank line, between logical blocks only
- Blank line after every print / debug statement
- Every solution file opens with problem statement, example, constraints,
  and states time/space complexity
- Debug prints at key decision points, not every line
- Debug builds kept separate; prints stripped from the committed solution
- One-line commit messages

## Open Items

- Extract `robLinear` into a standalone `236_House_Robber.swift` — currently
  the straight-line House Robber lives only as a helper inside the 237 file,
  so the Blind75 problem is otherwise missing from the repo
- Coin Change (238) flagged for a revision pass — the reuse idea and the
  `amount + 1` sentinel took several sittings to land; worth re-coding cold

**Status:** ✅ Complete — closed Aug 8, 2026
