# Phase 10 — Trees

Swift implementations of the full binary-tree interview set, built attempt-first:
brute force → review → optimise. 19 problems across two levels, starting from
zero tree background.

**Status:** Complete (167–185) · 7× Blind75 · 3× Hard (LC 124, 105, 297)

---

## L1 — Tree Basics (167–172)

Foundation work. These build the primitives everything in L2 calls.

| # | Problem | Concept |
|---|---|---|
| 167 | Create Binary Tree | Level-order builder from `[Int?]`, nil = missing child |
| 168 | Preorder Traversal | Recursive + iterative (stack) |
| 169 | Inorder Traversal | Recursive + iterative (stack, push-left-spine) |
| 170 | Postorder Traversal | Recursive + iterative |
| 171 | Level Order Traversal | BFS queue with head index |
| 172 | Maximum Depth | Recursive + iterative |

---

## L2 — High Priority Interview Questions (173–185)

| # | Problem | LC | Approach | |
|---|---|---|---|---|
| 173 | Invert Binary Tree | 226 | Swap children, recurse | ⭐ Blind75 |
| 174 | Same Tree | 100 | Parallel DFS, structure + value | ⭐ Blind75 |
| 175 | Balanced Binary Tree | 110 | Brute force → height with `-1` sentinel, one pass | ⭐ Blind75 |
| 176 | Diameter of Binary Tree | 543 | Brute force → report `left + right`, return `1 + max` | ⭐ Blind75 |
| 177 | Subtree of Another Tree | 572 | Serialization + `isSameTree` at every node | ⭐ Blind75 |
| 178 | Level Order (list of lists) | 102 | BFS level-size snapshot + DFS level-index | |
| 179 | Zigzag Level Order | 103 | BFS with direction flag | |
| 180 | Right Side View | 199 | BFS last-in-level + DFS right-first, `depth == result.count` | |
| 181 | Lowest Common Ancestor | 235/236 | DFS bubbled return; BST walk as O(h)/O(1) upgrade | ⭐ Blind75 |
| 182 | Maximum Path Sum 🔴 | 124 | Split-path answer vs straight-path return | ⭐ Blind75 |
| 183 | Construct from Pre+Inorder 🔴 | 105 | Value→index dict + global preorder pointer | |
| 184 | Serialize / Deserialize 🔴 | 297 | Preorder with `#` nil sentinels | ⭐ Blind75 |
| 185 | Path Sum | 112 | Subtract-and-check **at leaf** | |

---

## Core patterns

**Post-order bubbled return** — 175, 176, 181, 182

The spine of the phase. What a node **reports** to the answer and what it
**returns** to its parent can differ:

```swift
let splitPath = leftPath + rightPath + root.val   // report: bends through node
maxiPathSum = max(maxiPathSum, splitPath)

return root.val + max(leftPath, rightPath)        // return: straight, ONE child
```

A parent extending through this node cannot enter both branches — that's why
the return picks one child. Diameter, LCA, and Max Path Sum are the same
skeleton with different report/return pairs.

**Sentinel early exit** — 175

Encode failure in the return value (`-1` = unbalanced) so one pass answers both
"what's the height?" and "is it balanced?". Same trick family as the `#`
markers in 184.

**Global consumption pointer** — 183, 184

Preorder hands out roots in exactly the order the recursion needs. A single
mutable index drains the sequence:

```swift
let rootValue = preOrder[preOrderIndex]
preOrderIndex += 1

root.left = dfs(...)     // LEFT BEFORE RIGHT — load-bearing
root.right = dfs(...)
```

Swap the last two lines and it breaks silently. Invariant: every call consumes
exactly its own subtree's tokens and leaves the pointer at the next sibling.

**BFS level-size snapshot** — 171, 178, 179, 180

Freeze `queue.count` before draining a level — that count is the level
boundary. Direction flag on top gives zigzag; last-in-level gives right side
view.

**Self-describing serialization** — 184

Preorder + explicit nil markers carries the tree's *shape* in the token stream,
so deserialize needs nothing else. Inorder alone is ambiguous — root and
subtree are indistinguishable; preorder and postorder are not.

---

## Two distinctions worth memorising

**LCA: report vs return meaning (LC 236).** The recursive return value is
overloaded: "the LCA if found in this subtree, else whichever of p/q was found,
else nil." Both children non-nil ⇒ the targets split here ⇒ this node is the
LCA. Uses `===` identity, so duplicate values are safe.

**Path Sum: leaf check, not nil check (LC 112).** The path must end at a leaf,
so the comparison `target == value` lives at the leaf. The sloppy version
(`if root == nil { return target == 0 }`) wrongly accepts paths stopping at
internal nodes. Killer test: `[1,2]`, target `1` → `false`.

---

## House rules

- No force unwraps (`!`)
- No `?? 0` — explicit `if let` / `guard let` / `else`
- No convenience functions (`.max()` on collections, `.sorted()`,
  `.firstIndex(of:)`) — logic written by hand; two-arg `max(_:_:)` allowed
- `let` over `var` where nothing is reassigned
- `final class` for `TreeNode`
- Node comparison is `===` — identity, never `==`
- Every problem tested including empty tree, single node, skewed tree, and the
  failing case

---

## Traps logged this phase

| Trap | What it looks like |
|---|---|
| **Report/return conflated** | `currentPath = leftPath + root.val` in Max Path Sum — missing `rightPath`, misses every answer that bends |
| **Negative early exit** | Pruning on `targetSum < 0` — wrong, node values can be negative |
| **Nil-check path sum** | Leaf condition checked at nil instead of at the leaf |
| **Consume before validate** | Advancing the preorder pointer before the dictionary lookup — failed lookup corrupts the index |
| **Build order swapped** | `root.right` before `root.left` with a global pointer — silently wrong tree |
| **Force unwrap in parse** | `Int(values[index])!` in deserialize — bind it, bail on nil |
| **Consistent typo compiles** | `righ` everywhere still builds — the compiler won't save naming |

---

## Revision grouping

For R1 passes, group by pattern rather than number:

- **Bubbled-return block:** 175 → 176 → 181 → 182 (the phase's spine, in order of difficulty)
- **BFS block:** 178 → 179 → 180 (one skeleton, three questions)
- **Pointer-consumption block:** 183 → 184 (same invariant, two problems)
- **Parallel-DFS block:** 174 → 177 (177 is 174 called at every node)
- **Warm-ups:** 173, 185

**Follow-ups queued:** LC 113 (Path Sum II — backtracking), LC 437 (Path Sum
III — prefix sum on a tree), LC 106 (Construct from In+Postorder).

---

*Phase 10 Trees complete (Jul 20–25, ahead of the Aug 2 target) → Next phase
per `ROADMAP.md` (problems 111–264, Blind75-complete). Mock interviews parallel
from mid-August. Target: September 2026 loops.*
