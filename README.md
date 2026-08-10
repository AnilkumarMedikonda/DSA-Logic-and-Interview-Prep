# 🚀 Swift DSA Journey

**247 problems · Phases 0–20 done.** A from-scratch walk through Data Structures & Algorithms in Swift — every solution attempted before it was optimized, tested on the empty / single / failing case, and analysed for time and space.

---

## 🧠 About

The focus throughout: strong logical thinking, clean scalable Swift, complexity awareness, and **pattern recognition over memorization** — asking "which pattern is this?" before writing a line.

---

## 📂 Learning Phases

### 🔹 Phase 0 – Logic Building ✅
Loop thinking, iteration, dry-run ability, patterns. Loops, nested loops, break/continue, series, star patterns.
📁 `phase-0-logic-building/`

### 🔹 Phase 1 – Complexity ✅
Big-O, best/worst case, auxiliary space, in-place vs extra, recursion stack, brute-force vs optimized.
📁 `phase-1-complexity/`

### 🔹 Phase 2 – Arrays ✅
Traversal, search, insert/delete, rotation, merge/split, pair-sum, frequency counting, dictionary problems.
📁 `phase-2-arrays/`

### 🔹 Phase 3 – Strings ✅
Traversal, reversal, palindromes, character frequency, ASCII, word-level, two-pointer string problems.
📁 `phase-3-strings/`

### 🔹 Phase 4 – HashMap Thinking ✅
Frequency counting, duplicate detection, pair-sum, anagrams, prefix-sum + hashmap, subarray-sum.
📁 `phase-4-hashmap/`

### 🔹 Phase 5 – Array Patterns ✅ — 72 problems
Two Pointer (opposite ends + same direction), Partition (Dutch National Flag), Sliding Window (fixed / variable / monotonic), Prefix-Based (sum, XOR, 2D), Kadane's, Max Product Subarray, Subarray XOR/Sum, Binary Search (on index + **on answer**).
📁 `phase-5-array-patterns/`

### 🔹 Phase 6 – String Patterns ✅ — 38 problems (73–110)
Sliding-window substrings, min-window, anagram/permutation, palindrome two-pointer, compression/encoding, and pattern matching (KMP, Rabin-Karp, Z) — high-frequency problems solved by hand, the rest documented as interview talking points.
📁 `phase-6-string-patterns/`

### 🔹 Phase 7 – Stack ✅ — 22 problems (111–132)
Stack fundamentals, the monotonic-stack template (one skeleton → seven problems), and advanced patterns: collision (Asteroid), inverted (Car Fleet), context (Basic Calculator 🔥), greedy (Remove K Digits). Highlights: Valid Parentheses ⭐, Min Stack ⭐, Daily Temperatures ⭐, Largest Rectangle 🔥.
📁 `phase-7-stack/` · closed Jul 8

### 🔹 Phase 8 – Queue & Deque ✅ — 11 problems (133–143)
The `removeFirst()` O(n) trap and three amortised-O(1) escapes (head-index compaction, two-stack transfer, ring buffer). Monotonic deque → Sliding Window Maximum ⭐ 🔥 (cold re-derivation pass).
📁 `phase-8-queue/`

### 🔹 Phase 9 – Linked List ✅ — 23 problems (144–166)
First reference-semantics phase. Three reusable machines: slow/fast pointers, dummy head, pointer reversal. Highlights: Reverse ⭐, Floyd's cycle + entrance, Reorder ⭐, Merge K ⭐, Reverse k-Group 🔥, LRU Cache ⭐.
📁 `phase-9-linked-list/`

### 🔹 Phase 10 – Trees ✅ — 19 problems (167–185) · 3× Hard
Recursion as *the* tool. Post-order bubbled returns, global consumption pointers, BFS level snapshot. Highlights: Diameter ⭐, LCA ⭐, Max Path Sum 🔥, Construct from traversals 🔥, Serialize/Deserialize 🔥.
📁 `phase-10-trees/` · closed a week early

### 🔹 Phase 11 – Binary Search Tree ✅ — 8 problems (186–193)
Three-way walk, delete with successor replace, inorder-is-sorted driving four problems, whole-subtree range bounds, BST Iterator.
📁 `phase-11-binary-search-tree/`

### 🔹 Phase 12 – Heap / Priority Queue ✅ — 9 problems (194–202) · 1× Hard
Array-backed heaps from scratch, size-k heaps for top-k, two heaps for stream median, heap simulation. Highlights: Top K Frequent ⭐, Median From Stream ⭐ 🔥.
📁 `phase-12-heap/`

### 🔹 Phase 13 – Graph ✅ — 17 problems (203–219) · 2× Hard
Five core algorithms: DFS/BFS, Topological Sort (Kahn's), Union-Find, Dijkstra's, Kruskal's. Highlights: Islands ⭐, Clone Graph ⭐, Course Schedule ⭐, Alien Dictionary 🔥, Word Ladder 🔥.
📁 `phase-13-graph/`

### 🔹 Phase 14 – Trie ✅ — 3 problems (220–222) · 1× Hard
Trie template, wildcard DFS branching, Trie-as-pruner over a grid. Implement Trie ⭐, Add & Search Words ⭐, Word Search II ⭐ 🔥.
📁 `phase-14-trie/`

### 🔹 Phase 15 – Backtracking ✅ — 4 problems (223–226)
The Choose → Explore → Undo loop; the Explore call defines the problem (`i+1` vs `i` vs used-set). Subsets ⭐, Permutations ⭐, Combination Sum ⭐, Word Search ⭐.
📁 `phase-15-backtracking/`

### 🔹 Phase 16 – Greedy ✅ — 2 problems (227–228)
Commit once, never undo; prove it safe with the exchange argument. Jump Game ⭐, Jump Game II.
📁 `phase-16-greedy/`

### 🔹 Phase 17 – Intervals ✅ — 5 problems (229–233)
Sort as step 0, merge pattern (extend-or-push), the `<=` vs `<` boundary, three-zone insert. Merge ⭐, Insert ⭐, Non-Overlapping ⭐, Meeting Rooms I & II.
📁 `phase-17-intervals/`

### 🔹 Phase 18 – Matrix ✅ — 3 problems (232–234)
Non-square grids as default, transpose + reverse rotation, four shrinking boundaries, grid-as-scratch for O(1) space. Rotate Image ⭐, Spiral Matrix ⭐, Set Matrix Zeroes ⭐.
📁 `phase-18-matrix/`

### 🔹 Phase 19 – Dynamic Programming ✅ — 10 problems (235–244)
The six-line checklist before any code; "ending at i" vs "up to i"; bounded vs unbounded knapsack (loop direction flips); space optimization (rolling variables, rolling row, diagonal carry). **1D:** Climbing Stairs ⭐, House Robber I/II ⭐, Coin Change ⭐, LIS ⭐, Partition ⭐, Word Break ⭐, Decode Ways ⭐. **2D:** Unique Paths ⭐, LCS ⭐.
📁 `phase-19-dynamic-programming/`

### 🔹 Phase 20 – Bit Manipulation ✅ — 3 problems (245–247)

Focused on:
* Binary representation and conversion by hand before any operator
* Signed vs unsigned integers — the whole phase turns on this one split
* Arithmetic shift (Int, sign-extends) vs logical shift (UInt32, fills zero)
* Two workhorse identities: `n & (n-1)` clears the lowest set bit, `n & -n` isolates it
* Counting bits as DP — reuse an earlier answer instead of recounting

**Basics:** Bit Basics (place values, decimal↔binary by hand, positions, odd/even) · Bit Operators (`& | ^ ~`, truth tables, XOR cancels pairs, `n & 1`) · Shifts (`<< >>`, arithmetic vs logical, `1 << i` masks) · Bit Tricks (check/set/clear/toggle, `n & (n-1)`, `n & -n`, power of 2, count set bits).

**L1:** Number of 1 Bits — LC 191 ⭐ (Brian Kernighan, O(set bits)) · Counting Bits — LC 338 ⭐ (DP `dp[i] = dp[i>>1] + (i&1)`) · Reverse Bits — LC 190 ⭐ (shift-and-build ×32, UInt32 mandatory).
📁 `phase-20-bit-manipulation/` · closed Aug 10

---

## 🗺️ Master Roadmap — Phases 7–20 (Problems 111–247)

Ordered by concept dependency:

| Phase | Topic | Problems | Highlights |
|-------|-------|----------|------------|
| 7 ✅ | Stack | 111–132 | Valid Parentheses, Min Stack, Monotonic Stack |
| 8 ✅ | Queue & Deque | 133–143 | Circular Queue, Sliding Window Maximum |
| 9 ✅ | Linked List | 144–166 | Cycle Detection, Reorder, LRU Cache, Merge K |
| 10 ✅ | Trees | 167–185 | Diameter, LCA, Max Path Sum, Serialize |
| 11 ✅ | Binary Search Tree | 186–193 | Validate BST, Kth Smallest, BST Iterator |
| 12 ✅ | Heap | 194–202 | Top K Frequent, Median From Stream |
| 13 ✅ | Graph | 203–219 | Islands, Course Schedule, Dijkstra's, Kruskal's |
| 14 ✅ | Trie | 220–222 | Implement Trie, Word Search II |
| 15 ✅ | Backtracking | 223–226 | Subsets, Permutations, Combination Sum |
| 16 ✅ | Greedy | 227–228 | Jump Game I & II |
| 17 ✅ | Intervals | 229–233 | Merge, Insert, Meeting Rooms I & II |
| 18 ✅ | Matrix | 232–234 | Rotate Image, Spiral Matrix, Set Zeroes |
| 19 ✅ | Dynamic Programming | 235–244 | House Robber, Coin Change, LIS, LCS |
| 20 ✅ | Bit Manipulation | 245–247 | Number of 1 Bits, Counting Bits, Reverse Bits |

> Phase 17's Meeting Rooms I & II and Phase 18's problems both restart at 232 — the numbering is per-folder, not globally continuous.

---

## 🎯 Goals

Strong problem-solving, optimization thinking, clean interview-ready solutions, deep pattern recognition — and cracking a product-based company interview by end of 2026.

## 💡 Learning Approach

Understand → dry run → brute force → optimize step by step → analyze complexity → handle edge cases → compare approaches. Every solution ships with brute force, optimized ⭐, complexity, and interview Q&A notes.

---

## 🔥 Status

**Roadmap complete — 247/247.** All phases closed. **Now in revision — getting interview-ready.**

**What's next:**
* **Foundation phase (75 questions)** — drilling the core patterns to fluency: name the pattern fast, code the optimal cold, state both complexities without looking.
* **Advanced phase (25 questions)** — raising the ceiling to the senior bar once foundation is automatic.
* Mock interviews in parallel from mid-August · target: September 2026 loops.

### ✅ Completed
Phases 0–20. Full breakdown above; per-phase problem counts, dates, and Hard tallies are in each section.

---

## 💡 Key Learnings Per Pattern

**Two Pointer** — sort first to skip duplicates; check whether pointers can meet (`<` vs `<=`); `swapAt` takes indices; the smaller side is the bottleneck.

**Partition (Dutch Flag)** — three pointers low/mid/high; mid doesn't advance after a high-swap (unseen element), does after a low-swap.

**Sliding Window** — expand right, shrink left when invalid; `while` for min-window, `if` for max-window; `exactly(k) = atMost(k) − atMost(k−1)`; deque stores indices.

**Prefix Sum** — build once, query O(1); init `[0:1]` for frequency, `[0:−1]` for index; replace `0 → −1` for equal-0s-1s; same remainder twice ⇒ multiple of k.

**Kadane's** — seed both sums with `nums[0]`, never 0; extend-or-restart; circular = total − minSubarray; all-negative ⇒ return maxSum only.

**Max Product Subarray** — track max AND min (a negative flips them); save temps before updating either.

**Binary Search** — on-index: `mid = left + (right−left)/2`; on-answer: define a **monotonic** feasibility check, save candidate and keep shrinking, never return early; lower bound is 1 or `max(array)` depending on structural feasibility.

**Substring Search / Repeated Unit** — forward scan by index, never build strings in loops; `s + s` trick with first/last dropped; guard `n < 2` before `1...(n/2)`.

**KMP / Rabin-Karp / Z (read-not-derived)** — `lps[i]` = longest proper prefix = suffix ending at i; rolling hash: `+ modulus before %`; hash equality ≠ string equality (verify on match); Rabin-Karp's edge is multi-pattern.

**Stack Fundamentals** — `pop() -> Int?` IS the empty-guard; end of array = top; final `isEmpty` check catches unclosed openers.

**Monotonic Stack** — the invariant has **two halves**: pop violators, *then push* (dropping the push returns 0 for everything); push indices for width/span math; sentinel flush replaces end-of-loop cleanup; `>` vs `>=` is a deliberate choice.

**Advanced Stack** — fight-and-pop uses `while` not `if` (one element kills many); context stack holds paused `(result, sign)` states, popped in reverse; greedy pop needs a safety proof; `removeFirst()` in a loop is O(n²).

**Queue / Ring Buffer** — `removeFirst()` is O(n); three escapes (compaction, two-stack, ring); forward wrap `(i+1)%cap`, backward `(i-1+cap)%cap`; resolve empty-vs-full ambiguity *before* coding.

**Queue + Running Sum** — one-in/one-out, never re-sum; divisor is count not size (warm-up phase); evict from the front only; works for invertible aggregates, not max/min.

**Monotonic Deque** — monotonic stack + front expiry; store indices; order is expire-front → flush-back → append; `if` for front, `while` for back; back flush uses `<=`.

**Linked List** — the optional IS the data structure; head stays / current walks (losing the walker was the top bug); `while let node = current`; identity `===` never `==`; guard before subscript.

**Pointer Reversal** — four lines, save-next FIRST (else the rest is orphaned silently); recursive form re-points via `head.next?.next = head`.

**Slow / Fast** — one skeleton, four problems; loop condition is about fast; `f.next` → second middle, `f.next.next` → first middle; Floyd's entrance `L = nC − k`; never print-loop a cyclic list.

**Dummy Head** — kills every first-node / delete-head special case; `tail.next = left ?? right` is the one legitimate `??` (choosing references, not defaulting data).

**List Composition** — reorder/palindrome/sort all = middle + reverse/recurse + weave/merge; the CUT (`mid.next = nil`) is the forgotten step; cut before slow so halves shrink.

**LRU (Hashmap + DLL)** — dict for lookup, DLL for order; doubly so mid-unlink is O(1); dummy head AND tail; node stores its own key; the trap is forgetting `cache.removeValue` on eviction.

**Tree Traversals** — position of "root" names the order; iterative inorder pushes the left spine; BFS with a head index, not `removeFirst()`.

**Post-Order Bubbled Return** — what a node *reports* to the answer vs *returns* to its parent can differ (Diameter reports `l+r`, returns `1+max`); Max Path Sum conflating them is THE bug; `max(0, child)` clamps negatives.

**LCA** — return is overloaded (LCA / whichever target / nil); both children non-nil ⇒ this node; `===` identity; BST upgrade → O(h)/O(1) by direction.

**Build From Traversals** — `preorder[0]` is the root, inorder position splits; value→index dict + index-range recursion kills O(n²); left before right is load-bearing; look up before consuming the pointer.

**Serialize / Deserialize** — preorder + explicit `#` markers is self-describing; deserialize IS the build pattern with a sentinel; bounds-guard and parse with `if let`.

**Path Sum** — leaf check AT the leaf, never at nil; killer test `[1,2]` target 1 → false; subtract and pass the remainder down.

**BST** — three-way walk is the backbone of search/insert/delete/LCA; recurse-and-reattach (`root.left = f(...)`); delete's successor logic lives INSIDE the match branch; validity is a whole-subtree range property (left tightens upper, right tightens lower); optional bounds over Int.min/max.

**Inorder Is Sorted** — validate (strictly increasing), kth smallest (`count < k`), iterator (paused stack, amortized O(1)), construction (middle-as-root); right-first gives kth *largest*.

**Heap** — three formulas (parent `(i-1)/2`, children `2i+1`/`2i+2`); insert sifts up, remove sifts down; min/max is one comparator flip; strict `<`/`>` only; write child formulas carefully (`2*i*2+1` passes at the root and fails deeper).

**Size-k / Two Heaps** — keep k, evict worst (kth largest → **min**-heap); "I never need full ordering"; two heaps split a stream, median at the roots, rebalance so max-heap holds ≤1 extra.

**Heap Simulation** — act on the extremum and re-insert; Task Scheduler ladder sort → formula → heap+cooldown; only the heap reconstructs the actual schedule.

**Graph Fundamentals** — undirected edges append BOTH directions; array-backed marks isolated nodes, dict-backed misses them; component count increments in the outer loop before `dfs`, not inside.

**DFS/BFS** — BFS must be FIFO (`removeLast()` silently makes it DFS and breaks shortest-path); multi-source BFS seeds all sources at level 0; reverse DFS from boundaries + intersect visited sets; Clone Graph's visited map doubles as clone registry.

**Topological Sort (Kahn's)** — in-degrees, seed zero-degree, peel; `count < n` ⇒ cycle; directed only; Alien Dictionary compares adjacent words, first diff = one edge; guard duplicate edges.

**Union-Find** — `find` with path compression, `union` by rank; `find(u)==find(v)` before union ⇒ cycle; one structure for components / tree-validation / redundancy / MST; α(N) ≈ O(1).

**Parent Tracking** — undirected edges are bidirectional; skip the parent edge before the visited check or every edge reports a cycle; tree = n−1 edges + no cycle + connected.

**Dijkstra's / Kruskal's** — Dijkstra greedily relaxes the closest node, positive weights only, `Int.max` ⇒ unreachable; Kruskal sorts edges, adds cheapest non-cycle, stops at n−1.

**Trie** — children dict + isWord; walk-create-**move**-mark (all phase bugs were "didn't move forward"); search vs startsWith differ only in return; wildcard `.` explores all children (recursion, not a loop); grid version stores `word: String?` in the end node, `#` mark + restore, `word = nil` to dedup.

**Backtracking** — Choose → Explore → Undo; the Explore call defines it (`i+1` no reuse, `i` reuse, used-set any-order); save point differs per problem; path and used mutate together; pass `remaining` down; the Explore recursion is the easiest step to lose.

**Grid Backtracking** — `dfs(r,c,index)` = "can I match from here?"; check order bounds-before-access; `#` mark → 4 dirs → restore; chain with `||`; `exit` shadows Swift, use `exist`.

**Greedy** — commit once; the exchange argument is the interview skill; fails when an early best blocks a better future (coins `[4,3,1]`); the sort key IS the strategy.

**Jump Game** — never ask "which jump", track farthest reachable; min-jumps = BFS levels via `currentEnd`; update farthest before the boundary check; loop to `count−1`.

**Intervals** — sort first (compare i with i−1); START key to merge, END key for greedy keep/remove; the WIP interval enters the result exactly once; extend with `max()`; `<=` combines when merging, `<` coexists when scheduling; min rooms = max concurrent (heap of end times).

**Matrix** — test on non-square grids (a square hides index swaps); loop order flips but subscript order doesn't; offsets are `(rowΔ, colΔ)`; guard before subscripting; `inout` is mandatory; transpose inner loop starts at `i+1`; rotation = transpose + reverse rows; spiral tracks four *boundaries*, guards re-checked mid-loop, `<=` not `<`; row 0 / col 0 are your flag arrays.

**Dynamic Programming** — the six-line checklist before code (state as a *sentence*); the combiner names the base case; "ending at i" (`max(dp)`) vs "up to i" (`dp[n-1]`); four solutions, only state + transition change; sentinel must be provably outside the answer range (`amount+1`); bounded vs unbounded flips the inner loop direction; rolling needs the OLD value captured first; 2D sizing outer=rows inner=cols; rolling-row is about overwrite *timing*; LCS carries the diagonal in one variable; the `(m+1)×(n+1)` offset is where index bugs live; half-open ranges self-guard, closed ranges trap on size ≤1; guard before you allocate.

**Bit Manipulation** — `n & (n-1)` clears the lowest set bit (count in O(set bits), not O(32)); `n & -n` isolates it (`-n == ~n + 1`); a signed `Int` right shift sign-extends and the loop never reaches 0 → use `UInt32` for LC 191/190; `dp[i] = dp[i>>1] + (i&1)` counts bits in O(n); `1 << i` is the single-bit mask behind check/set/clear/toggle; reversing bits is O(1) — a fixed 32 passes.

---

## ⚙️ Pattern Recognition Table

| Pattern | Trigger Words |
|---------|--------------|
| Two Pointer | sorted array, pairs, palindrome, duplicates |
| Partition | rearrange, group, sort colors, 0s 1s 2s |
| Sliding Window | subarray, substring, window, contiguous |
| Prefix Sum | range sum, subarray sum equals k, 2D matrix |
| Kadane's | maximum subarray, circular, absolute, product |
| Max Product Subarray | product subarray, track max AND min |
| Binary Search (Index) | sorted, find target, rotated, peak |
| Binary Search (Answer) | minimize the max, maximize the min, min speed/capacity/days |
| String Sliding Window | longest/shortest substring, at most K distinct, char replacement |
| Anagram / Permutation | rearrangement of characters, group by signature |
| Forward Scan Search | first occurrence, strStr, needle in haystack |
| Repeated Unit | repeated substring, built by copies, s + s trick |
| Fixed Window + HashMap | fixed-length substrings occurring more than once |
| Stack (matching) | valid parentheses, balanced, nested, undo, most recent |
| Monotonic Stack | next greater/smaller, daily temperatures, span, largest rectangle |
| Context Stack | nested expressions, calculator, decode string, state |
| Greedy Stack | remove k digits, keep lexicographic order |
| Circular Array + Stack | circular next greater — 2n loop with i % n |
| Queue (FIFO) | first come first served, stream, recent requests |
| Ring Buffer | fixed capacity, circular, design queue/deque with k slots |
| Queue + Running Sum | moving average, rolling aggregate over last k |
| Monotonic Deque | sliding window max/min, window + max/min together |
| Two-Queue Greedy | rounds, turn-based elimination, re-enter the line |
| Slow / Fast Pointers | middle, cycle, "without extra space", palindrome list |
| Dummy Head | new head uncertain, might delete head, build a result list |
| Pointer Reversal | reverse list, reverse in groups, reorder |
| Two-Pointer List Swap | intersection of two lists, different lengths, O(1) space |
| Divide & Conquer on Lists | sort a list, merge K lists, O(n log n) no extra space |
| HashMap + Doubly Linked List | LRU/LFU cache, O(1) get AND put |
| Tree DFS (bubbled return) | height, depth, balanced, diameter, path sum through nodes |
| Tree BFS (level snapshot) | level order, zigzag, right side view |
| LCA | lowest common ancestor, deepest shared parent |
| Global Consumption Pointer | build tree from traversals, deserialize, token streams |
| Self-Describing Encoding | serialize/deserialize, flatten and rebuild |
| Leaf-Anchored Recursion | root-to-leaf paths, path sum, must END at a leaf |
| BST Three-Way Walk | search/insert/delete/LCA in BST, O(h) |
| BST Range Bounds | validate BST, whole-subtree constraints carried down |
| Controlled Inorder | kth smallest, BST iterator, sorted stream from tree |
| Sorted Array → BST | height-balanced construction, middle-as-root |
| Heap (Extremum) | repeatedly take largest/smallest, priority, smash top two |
| Size-k Heap | kth largest, top k frequent, k closest — k ≪ n |
| Two Heaps | running median, split a stream into halves |
| Heap Simulation + Cooldown | task scheduling, cooling period, reconstruct schedule |
| DFS/BFS Flood Fill | number of islands, connected components, "how many groups" |
| Multi-Source BFS | rotting oranges, nearest 0 — all sources at level 0 |
| Reverse DFS from Boundaries | pacific atlantic, reachable from edges, flow uphill |
| Clone Graph (DFS + Map) | deep copy a graph, visited map = clone registry |
| Topological Sort (Kahn's) | course schedule, task ordering, "what order", alien dictionary |
| Union-Find (DSU) | redundant connection, components, cycle detection, "is it a tree" |
| Parent Tracking (Undirected) | graph valid tree, undirected cycle detection |
| Dijkstra's (Weighted Path) | network delay, cheapest flights, positive edges only |
| Kruskal's (MST) | min cost to connect, connect all points, cheapest network |
| BFS Shortest Transform | word ladder, minimum transformations, unweighted shortest |
| Trie | prefix, autocomplete, dictionary, spell check, startsWith |
| Trie + Wildcard DFS | '.' matches any character, pattern search in dictionary |
| Trie + Grid Backtracking | word list + 2D board, find all words in grid |
| Backtracking (Subsets) | all subsets, power set, all combinations |
| Backtracking (Permutations) | all orderings, arrangements, order matters |
| Backtracking + Pruning | combination sum, target sum, reuse, cut invalid branches |
| Grid Backtracking | word in 2D board, path in grid, cannot reuse cell |
| Greedy (Exchange Argument) | max activities, min resources, provably safe local choice |
| Farthest Reach | jump game, can I reach the end, reachability in one pass |
| Level Boundaries | minimum jumps, fewest steps, BFS levels without a queue |
| Merge Pattern | merge intervals, combine overlapping, consolidate ranges |
| Three-Zone Insert | insert into sorted intervals, before/overlap/after |
| Sort-by-End Greedy | non-overlapping, min removals, max meetings |
| Heap of End Times | meeting rooms, min resources, max concurrent events |
| Matrix Transpose + Reverse | rotate image, rotate 90°, in-place rotation |
| Shrinking Boundaries | spiral order, layer by layer, perimeter inward |
| In-Grid Flag Storage | set matrix zeroes, O(1) space, mark rows and columns |
| 1D DP (Take/Skip) | max/min/count over a sequence, adjacent constraint, "in how many ways" |
| Knapsack (Subset Sum) | reach a target, use items once (0/1) or unlimited, "can it be made" |
| 2D Grid DP | paths in a grid, two strings compared, dp[i][j] from neighbours |
| Count Set Bits | number of 1 bits, hamming weight — `n & (n-1)` |
| XOR Cancellation | single number, find the loner — duplicates cancel |
| Power of Two | is it a power of 2 — `n > 0 && n & (n-1) == 0` |
| Reverse Bits | reverse a 32-bit integer — shift-and-build ×32, UInt32 |

---

## 💡 Learning Philosophy

* Ask which pattern first — the framework beats memorization ("What order?" → topo sort, "A cycle?" → Union-Find, "Shortest path?" → BFS/Dijkstra).
* Read-only code doesn't stick; derived code does — attempt first, always.
* The invariant has both halves — drill the obvious part, not just the clever one.
* Earned code survives the cold rewrite (proven by the six-week Sliding Window Maximum re-derivation).
* The algorithm is rarely where points are lost — the boilerplate around it is.

---

## 🏠 House Rules (Swift)

* No force unwraps (`!`).
* No `?? 0` — explicit `if let / else`. `??` only when choosing between two references (`tail.next = left ?? right`).
* No predefined convenience functions (`.max()`, `.sorted()`, `.contains()`, `.dropFirst()`) — manual loops.
* `let` over `var` where mutation is absent.
* `while` for condition-driven loops, `for-in` for bounded iteration.
* `final class` for reference types.
* Every problem tested on the empty case, the single-element case, and the failing case.

---

## 👨‍💻 Author

**Medikonda Anil Kumar** — iOS Developer · Swift · DSA · Problem Solving
📁 [github.com/AnilkumarMedikonda/DSA-Logic-and-Interview-Prep](https://github.com/AnilkumarMedikonda/DSA-Logic-and-Interview-Prep)

---

*Roadmap complete — 247/247, Phase 20 closed Aug 10. Now in revision for interview readiness → Foundation phase (75) → Advanced phase (25). Mock interviews from mid-August. Target: September 2026 loops.*
