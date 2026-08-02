# Phase 15 — Backtracking (Problems 223–226)

Swift solutions for the Backtracking phase of my DSA roadmap. Every problem
includes step-by-step comments, debug logs, traps, and tests. Covers the core
Choose → Explore → Undo pattern, permutation state tracking, element reuse
with pruning, and 2D grid backtracking.


## Problems

| # | Problem | LeetCode | Approach | Complexity |
|---|---------|----------|----------|------------|
| 223 | Subsets ⭐ | LC 78 | Save path on ENTRY; recurse `i + 1`, no base case needed | O(n · 2ⁿ) |
| 224 | Permutations ⭐ | LC 46 | Loop ALL elements + `used` set; save when path is full | O(n · n!) |
| 225 | Combination Sum ⭐ | LC 39 | Recurse with `i` for reuse; prune on `remaining < 0` | O(2^target) |
| 226 | Word Search ⭐ | LC 79 | Grid DFS from every cell; "#" mark → explore 4 dirs → restore | O(m·n·4^L) |

## Core Patterns

- **Choose → Explore → Undo** — the universal backtracking loop: append to
  `path`, recurse, `removeLast()`; the same array is reused across all
  branches, and Undo guarantees siblings start clean (basics)
- **The Explore call defines the problem** — `i + 1` = Subsets (no reuse,
  forward only); `i` = Combination Sum (reuse allowed, no duplicate
  orderings); no start index at all = Permutations (any order) (223–225)
- **Save point differs per problem** — Subsets saves on EVERY entry (all
  partial paths are valid); Permutations saves only when
  `path.count == nums.count`; Combination Sum only when `remaining == 0`;
  Word Search returns `true` the moment `index == word.count` (223–226)
- **path + used stay in sync** — when order matters, Choose does
  `append + insert` together and Undo does `removeLast + remove` together;
  breaking the pairing corrupts every later branch (224)
- **Pass remaining, not the sum** — recurse with `remaining - candidates[i]`
  instead of re-summing the path; `remaining < 0` becomes the pruning cut
  that stops infinite reuse chains (225)
- **Duplicate skip at the same level** — sort first, then
  `if i > index && nums[i] == nums[i-1] { continue }`; blocks duplicate
  SIBLING branches while still allowing the same value to go DEEPER (basics)
- **"#" visited trick on the grid** — save `temp = board[r][c]`, overwrite
  with "#", explore 4 directions, restore; O(1) visited tracking with no
  extra array, and "#" can never match a word character (226)
- **Short-circuit `||` across directions** — chain the four recursive calls
  with `||`; exploration stops the instant one direction succeeds (226)
- **Check order matters in grid DFS** — index-complete → bounds → char
  mismatch; bounds must come before array access or the code crashes (226)
- **Recursion tree = interview tool** — `depth` counter + indented prints
  make the tree shape visible; drawing this tree is how you explain the
  solution and derive branching^depth complexity (basics)

## Traps Logged This Phase

- Choosing `nums[index]` instead of `nums[i]` inside the loop — the loop
  variable exists but is ignored, so every branch re-picks the first
  remaining element (basics)
- Writing the recursion but never calling it from `start()` — the setup
  runs, prints a title, and silently does nothing (basics)
- Choose immediately followed by Undo with no Explore call between — the
  path never grows past one element and recursion never fires; the
  three-step pattern is only two steps (basics)
- `print("Choose")` without `\(num)` interpolation — Swift prints the
  literal text; debug output shows actions but never values (224)
- Duplicate `print` from copy-pasting the Choose block — output shows
  every choice twice and the trace looks like a bug that isn't there (224)
- Naming `func exit` shadows Swift's built-in `exit()` — and LC 79
  requires the signature `exist` anyway (226)
- Unused `let removed = path.removeLast()` after deleting debug prints —
  compiler warning; drop the binding when the value is no longer used (225)
- Common thread: **the Explore step is the easiest to lose** — forgetting
  the recursive call, calling with wrong state, or never wiring it up from
  the entry point

## House Rules

- No force unwraps
- No `?? 0` nil-coalescing — explicit `if let / guard let` everywhere
- `final class` for reference types
- Guard statements for early exits and pruning
- `let` over `var` where mutation is absent
- Debug prints at key decision points, not every line
- Step-by-step structure with clear section headers

**Status:** ✅ Complete — closed Aug 2, 2026
