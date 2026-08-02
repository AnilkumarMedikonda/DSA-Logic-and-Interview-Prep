# Phase 17 — Intervals (Problems 229–233)

Swift solutions for the Intervals phase of my DSA roadmap. Every problem
includes step-by-step comments, debug logs, traps, and tests. Covers sorting
as step 0, the merge and overlap patterns, the `<=` vs `<` boundary, and the
heap-driven Meeting Rooms II finale.


## Problems

| # | Problem | LeetCode | Approach | Complexity |
|---|---------|----------|----------|------------|
| 229 | Merge Intervals ⭐ | LC 56 | Sort by START; extend-or-push with max(); final append after loop | O(n log n) |
| 230 | Insert Interval ⭐ | LC 57 | Three zones (before/absorb/after), three while loops, one shared index | O(n) |
| 231 | Non-Overlapping Intervals ⭐ | LC 435 | Sort by END; greedy keep-earliest-end; count removals | O(n log n) |
| 232 | Meeting Rooms | LC 252 / LintCode 920 | Sort by start; neighbor clash check with strict < | O(n log n) |
| 233 | Meeting Rooms II | LC 253 / LintCode 919 | Min-heap of end times; reuse = pop+push, new room = push; answer = heap size | O(n log n) |

## Core Patterns

- **Sorting is step 0** — after sorting, overlappers become NEIGHBORS;
  all-pairs O(n²) checking collapses to an O(n) scan comparing i with i−1
  (basics)
- **The sort key IS the strategy** (Phase 16 carried over) — START for
  merging problems (56, 57), END for greedy scheduling/removal (435);
  picking the wrong key gives a wrong or unprovable greedy (basics)
- **Extend-or-push with a work-in-progress interval** — `current` only
  enters the result when FINISHED: a gap appears, or the input ends; the
  final append after the loop is load-bearing (229)
- **max() on extend, always** — the contained interval [[1,10],[2,3]] is
  why: the next interval's end can be SMALLER than what's already merged;
  plain assignment shrinks the boundary and corrupts later comparisons (229)
- **Three zones, one shared index** — Insert Interval: copy everything
  ending before, absorb everything overlapping via min-start/max-end, push
  the grown interval ONCE, copy the rest; each while loop consumes its zone
  and hands the index forward (230)
- **The new interval is the bridge** — [3,5] and [6,7] don't overlap each
  other, but [4,8] overlaps both; existing intervals merge THROUGH the
  newcomer, never with each other (input guarantees they're disjoint) (230)
- **`<=` vs `<` is the phase's off-by-one** — Merge (56): `<=`, touchers
  COMBINE ([1,4],[4,5] → [1,5]); Scheduling (435/252): `<`, touchers
  COEXIST (back-to-back meetings are attendable); same shape, one
  character, different answers (229 vs 231/232)
- **lastEnd freezes on removal** — Non-Overlapping: removing the current
  (later-ending) interval keeps the earlier boundary; advancing lastEnd on
  a removal silently keeps the WRONG interval (231)
- **Min rooms = max concurrent meetings** — the reframe that unlocks 253;
  the heap holds end times of occupied rooms, the root is the room freeing
  EARLIEST; if even that one is busy, no room is free (233)
- **Reuse = pop+push (size flat), new room = push (size grows)** — heap
  size never shrinks below the running max, so final size IS the answer;
  no separate max tracking needed (233)
- **Seed the heap with the first meeting, loop from 1** — avoids the
  empty-peek special case entirely (233)
- **Phase 12 heap returns** — the MinHeap rewrite included the `<=`
  early-break in sift-up (no equal-swap churn) and
  `heap[0] = heap.removeLast()` as a one-line root replacement (233)

## Traps Logged This Phase

- `result.append(current)` INSIDE the merge loop — appends every
  iteration: duplicates plus unfinished merges leak into the result (229)
- Fixing that by deleting the append entirely — the last work-in-progress
  interval never meets a gap, the input just ends; without the after-loop
  append it's silently lost, and inputs that merge into one interval
  return [] (229)
- `start()` builds the input but never calls `merge()` — third occurrence
  of the wired-up-but-never-called bug (Recursion Tree, Greedy start,
  now this); new habit: write the call first, then fill the function
  (basics 03)
- Confusing which intervals merge — [3,5],[6,7] have a gap; they only
  combine because [4,8] bridges them; zone 2 always compares against the
  GROWN newInterval, never between two existing intervals (230)
- `var` on a never-mutated `lastIndex` — house rule: `let` (229)
- Typos that compile: `currnet`, `earlisetEnd` — naming discipline (229, 233)

## House Rules

- No force unwraps
- No `?? 0` nil-coalescing — explicit `if let / guard let` everywhere
- `final class` for reference types
- Guard statements for early exits and pruning
- `let` over `var` where mutation is absent
- Debug prints at key decision points, not every line
- Step-by-step structure with clear section headers
- `.sort()` / `.sorted()` permitted in interval phases — sorting is step 0
  of the strategy, not the skill under test

**Status:** ✅ Complete — closed Aug 2, 2026 (third phase closed same day)
