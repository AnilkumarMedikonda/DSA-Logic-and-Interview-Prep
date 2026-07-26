# Phase 11 — Binary Search Tree (Problems 186–193)

Swift solutions for the BST phase of my DSA roadmap. Every problem includes
brute force + optimized approaches, step comments, traps, and tests.

## Structure
## Problems

| # | Problem | LeetCode | Approach | Complexity |
|---|---------|----------|----------|------------|
| 186 | Search in BST | LC 700 | Three-way walk (recursive + iterative) | O(h) / O(1) iterative |
| 187 | Insert into BST | LC 701 | Recurse + reattach; iterative parent-tracking | O(h) |
| 188 | Delete Node in BST | LC 450 | Three cases: leaf, one child, inorder-successor replace | O(h) |
| 189 | Validate BST | LC 98 | Range (min, max) with optional bounds; inorder alternate | O(n) / O(h) stack |
| 190 | Kth Smallest ⭐ | LC 230 | Inorder counter with early exit | O(h + k) |
| 191 | LCA of BST | LC 235 | Iterative value-guided walk | O(h) / **O(1)** |
| 192 | BST Iterator | LC 173 | Controlled inorder — explicit stack holds paused state | O(h) mem, amortized O(1) |
| 193 | Sorted Array to BST | LC 108 | Middle-as-root, inclusive index-range recursion | O(n) / O(log n) stack |

## Core Patterns

- **Three-way walk** — `key < node → left, key > node → right, else found`;
  the backbone of 186, 187, 188, 191
- **Inorder of a BST is sorted** — validates a tree (189), finds kth smallest (190),
  drives the iterator (192), and reverses into construction (193)
- **Recurse-and-reattach** — `root.left = f(...)` / `root.right = f(...)`;
  dropping the reattachment orphans nodes (187, 188)
- **Subtree bounds, not parent-child checks** — validity is a range carried down
  the whole subtree (189)

## Traps Logged This Phase

- Successor logic in delete belongs **inside** the match branch — outside, it runs
  on every ancestor and corrupts the tree (188)
- Right recursion in validate tightens the **lower** bound — copying `max` into
  both calls silently passes deep violations (189)
- Right-first inorder gives kth **largest**, not smallest (190)
- Missing `count < k` short-circuit loses O(h + k) (190)
- Iterator `init` must push the left spine — otherwise it starts empty (192)
- Inclusive range `[lo, hi]` is empty when `lo > hi` — the base case must match
  the range convention (193)

## House Rules

- No force unwraps; `if let / guard let` everywhere (`popLast()` over `removeLast()`)
- No `?? 0` nil-coalescing
- No convenience functions (`.max()`, `.sorted()`, `.contains()`)
- `while let` for condition-driven walks; `let` over `var` where possible
- Optional returns over sentinel values (`Int?`, not `-1` / `0`)

**Status:** ✅ Complete — closed Jul 26, 2026
