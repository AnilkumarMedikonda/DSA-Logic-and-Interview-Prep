# Phase 12 — Heap / Priority Queue (Problems 194–202)

Swift solutions for the Heap phase of my DSA roadmap. Every problem includes
brute force + optimized approaches, step comments, traps, and tests. All
heaps are array-backed and built from scratch.


## Problems

| # | Problem | LeetCode | Approach | Complexity |
|---|---------|----------|----------|------------|
| 194 | Implement Min Heap | — | Array-backed, sift up on insert / sift down on remove | O(log n) ops |
| 195 | Implement Max Heap | — | Same structure, comparators flipped | O(log n) ops |
| 196 | Priority Queue | — | MaxHeap wrapper with enqueue / dequeue API | O(log n) ops |
| 197 | Kth Largest ⭐ | LC 215 | Size-k **min**-heap — root is the answer | O(n log k) |
| 198 | Top K Frequent ⭐ | LC 347 | Count + size-k heap on `HeapNode(number, frequency)`; bucket-sort alternate | O(n log k) / **O(n)** |
| 199 | Median from Stream ⭐ | LC 295 | Two heaps — max-heap lower half, min-heap upper half | O(log n) add, O(1) find |
| 200 | Task Scheduler | LC 621 | Frame formula `(maxFreq-1)(n+1) + ties`; heap + cooldown queue alternate | **O(n)** / O(n log 26) |
| 201 | K Closest Points | LC 973 | Size-k **max**-heap, squared distance (no sqrt) | O(n log k) |
| 202 | Last Stone Weight | LC 1046 | Max-heap smash simulation | O(n log n) |

## Core Patterns

- **Array as tree** — parent `(i-1)/2`, children `2i+1` / `2i+2`;
  the entire phase runs on these three formulas
- **Min and max heap are one comparator apart** — flip `<` and `>`,
  nothing else changes (194 → 195)
- **Size-k heap for top-k** — keep only k candidates, evict the worst;
  pay log k per element instead of sorting everything (197, 198, 201)
- **Invert the heap for top-k** — kth *largest* needs a *min*-heap,
  k *closest* needs a *max*-heap; the root is always the eviction candidate
- **Two heaps split a stream** — max-heap owns the lower half, min-heap the
  upper; the median lives at the roots (199)
- **Heap-driven simulation** — repeatedly act on the extremum and
  re-insert the result (200, 202)
- **Interview ladders** — sort → size-k heap → bucket / QuickSelect (top-k);
  sort greedy → formula → heap simulation (scheduler, only the simulation
  can reconstruct the actual schedule)

## Traps Logged This Phase

- Write child index formulas visually parallel — `2 * i * 2 + 1` is 4i+1
  and passes shallow tests because it's accidentally correct at the root (195)
- `insert` sifts **up**, `remove` sifts **down** — the wrong call fails
  only on deeper heaps (198)
- `<=` comparisons cause equal-swap churn — strict `<` / `>` only (198)
- LeetCode matches method names exactly — a signature typo fails before
  logic ever runs (199)
- Sort is a smell when you only need the max — one pass gives max + tie count (200)
- Safe-by-guard ≠ safe-by-construction — `count > 1` justifying `!` is
  exactly the pattern `if let` exists to replace (202)

## House Rules

- No force unwraps; `if let / guard let` everywhere (`popLast()` over `removeLast()`)
- No `?? 0` nil-coalescing
- No convenience functions (`.max()`, `.sorted()`, `.contains()`)
- `while let` for condition-driven walks; `let` over `var` where possible
- Optional returns over sentinel values (`Int?`, not `-1` / `0`)
- `@discardableResult` on `remove()` — eviction discards intentionally

**Status:** ✅ Complete — closed Jul 27, 2026
