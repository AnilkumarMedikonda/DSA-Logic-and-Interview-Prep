# Phase 16 — Greedy (Problems 227–228)

Swift solutions for the Greedy phase of my DSA roadmap. Every problem includes
step-by-step comments, debug logs, traps, and tests. Covers the greedy mindset
(commit once, never undo), proving when greedy is safe vs when it fails, the
sort-then-scan combo, and both Jump Game variants.


## Problems

| # | Problem | LeetCode | Approach | Complexity |
|---|---------|----------|----------|------------|
| 227 | Jump Game ⭐ | LC 55 | Track farthest reachable index; `i > farthest` → false, early exit on last index | O(n) / O(1) |
| 228 | Jump Game II | LC 45 | BFS levels without a queue; `i == currentEnd` → forced jump, extend to farthest | O(n) / O(1) |

## Core Patterns

- **Commit once, never undo** — greedy is the anti-backtracking: Phase 15's
  three steps (Choose → Explore → Undo) collapse to one (Choose. Done.);
  this only works when looking back can never help (basics)
- **The exchange argument** — the interview obligation is proving the greedy
  choice safe: "swapping my choice for any other never improves the answer";
  the code is short, the justification is the skill (basics)
- **Greedy fails when an early best blocks a better future** — coins [4,3,1],
  amount 6: greedy takes 4+1+1 = 3 coins, optimal is 3+3 = 2; this
  counterexample is why LC 322 Coin Change is DP, not greedy (basics)
- **The greedy test question** — "can a locally worse choice EVER win later?"
  NO → greedy; YES → DP or backtracking (basics)
- **The sort key IS the strategy** — sort by END for activity selection,
  by START for merging; picking the wrong key gives a wrong or unprovable
  greedy; after sorting, the pass is usually two pointers (basics)
- **Smallest-that-fits assignment** — Assign Cookies: sort both arrays, give
  the smallest satisfying cookie to the least greedy child; anything bigger
  wastes size a greedier child might need (basics)
- **Safe-to-discard logic** — if the smallest remaining cookie can't satisfy
  the least greedy remaining child, it can't satisfy anyone — throw it away
  without checking the rest (basics)
- **One-variable reachability** — Jump Game never asks "which jump?";
  `farthest = max(farthest, i + nums[i])` and the single check
  `i > farthest` replace the exponential path search (227)
- **BFS levels without a queue** — Jump Game II: `currentEnd` is the edge of
  the current jump's range; touching it forces `jumps += 1` and the next
  level extends to `farthest` collected while walking this one (228)
- **Update farthest BEFORE the boundary check** — the order inside the loop
  is load-bearing; checking the boundary first jumps with stale reach (228)

## Traps Logged This Phase

- `print("Pick Once coim")` without `\(coin)` interpolation — same Phase 15
  lesson resurfacing: debug output shows actions but never values (basics)
- Loop bound `0..<nums.count` instead of `0..<nums.count - 1` in Jump Game
  II — including the last index counts one extra jump when landing exactly
  on it (228)
- Variable `jump` shadowing the function `jump(_:)` — compiles, but blocks
  recursion and reads ambiguously; counts are plural: `jumps` (228)
- `var lastIndex` where mutation is absent — house rule: `let` (227)
- Asymmetric debug traces — keeping only the ⊘ no-improvement print while
  successful extends stay silent reads confusingly during revision; match
  the pair or drop both (227)
- Missing single-element guard — `[0]` needs 0 jumps; `nums.count <= 1`
  early return before any loop (228)

## House Rules

- No force unwraps
- No `?? 0` nil-coalescing — explicit `if let / guard let` everywhere
- `final class` for reference types
- Guard statements for early exits and pruning
- `let` over `var` where mutation is absent
- Debug prints at key decision points, not every line
- Step-by-step structure with clear section headers
- `.sort()` permitted in greedy phases — sorting is step 0 of the strategy,
  not the skill under test

**Status:** ✅ Complete — closed Aug 2, 2026
