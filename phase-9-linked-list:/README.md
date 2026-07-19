# Phase 9 — Linked Lists

Swift implementations of the full linked-list interview set, built attempt-first:
brute force → review → optimise. 23 problems across three levels.

**Status:** Complete (144–166) · 5× Blind75 · 2× NeetCode

---

## L1 — Basics (144–151)

Foundation work. No LeetCode numbers — these build the primitives everything else calls.

| # | Problem | Concept |
|---|---|---|
| 144 | Create Node | `final class`, optional `next` as null terminator |
| 145 | Create Linked List | Peel-first head + attach/advance walker |
| 146 | Traversal | `while let` idiom |
| 147 | Insert Node | Walk to `position - 1`, grab-then-attach rewire |
| 148 | Delete Node | Same walk; `if let` on the victim is the bounds check |
| 149 | Search Node | Early return; `indexOf` returns `Int?`, not `-1` |
| 150 | Find Length | Walk with a counter |
| 151 | Find Middle Node | Two-pass brute force → slow/fast one-pass |

---

## L2 — Patterns (152–157)

| # | Problem | LC | Pattern | |
|---|---|---|---|---|
| 152 | Reverse Linked List | 206 | Iterative 3-pointer + recursive | ⭐ Blind75 |
| 153 | Merge Two Sorted Lists | 21 | Dummy head | ⭐ Blind75 |
| 154 | Linked List Cycle | 141 | Floyd's tortoise & hare | ⭐ Blind75 |
| 155 | Linked List Cycle II | 142 | Collision + reset walk | |
| 156 | Middle Of Linked List | 876 | Slow/fast | |
| 157 | Remove Nth From End | 19 | Two-pointer gap + dummy head | |

---

## L3 — Advanced (158–166)

| # | Problem | LC | Approach | |
|---|---|---|---|---|
| 158 | Reorder List | 143 | Middle + reverse + weave | ⭐ Blind75 |
| 159 | Palindrome Linked List | 234 | Middle + reverse + compare | |
| 160 | Intersection of Two Lists | 160 | Two-pointer list-swap, O(1) | |
| 161 | Add Two Numbers | 2 | Dummy head + carry | ⭐ NeetCode |
| 162 | Sort List | 148 | Merge sort on list, O(n log n) | ⭐ NeetCode |
| 163 | Copy List with Random Pointer | 138 | HashMap O(n) + interleave weave O(1) | ⭐ Blind75 |
| 164 | Merge K Sorted Lists | 23 | Divide & conquer, O(N log K) | ⭐ Blind75 |
| 165 | Reverse Nodes in k-Group | 25 | Iterative, O(1) space | |
| 166 | LRU Cache | 146 | HashMap + doubly linked list | ⭐ Blind75 |

---

## Core patterns

**Slow / fast pointers** — 151, 154, 155, 156, 158, 159

One skeleton, many questions. Fast moves 2, slow moves 1; what you do at the
stopping point decides the answer.

```swift
while let f = fast, let fNext = f.next {
    slow = slow?.next
    fast = fNext.next
}
```

Convention knob: requiring `f.next` returns the **second** middle on even
lengths (LC 876). Requiring `f.next.next` returns the **first** — which is what
reorder and merge sort need, so each half stays strictly smaller.

**Dummy head** — 153, 157, 161, 164, 166

A throwaway sentinel node removes every "is this the first node?" and "am I
deleting the head?" special case. Build off `dummy.next`, return `dummy.next`.

**Pointer reversal** — 152, 158, 159, 165

Three pointers, four lines, strict order:

```swift
let next = node.next   // save  — rescue the forward link
node.next = prev       // flip
prev = node            // advance
current = next         // advance
```

**Save before you overwrite.** Reverse the first two lines and the rest of the
list is orphaned — no crash, just silently gone.

---

## Two proofs worth memorising

**Cycle entrance (LC 142).** After slow and fast collide, move one pointer back
to head and advance both by 1 — they meet at the entrance.

Let `L` = head→entrance, `C` = cycle length, collision `k` steps into the cycle.
Slow travelled `L + k`, fast travelled `2(L + k)` and also `L + k + nC`.
So `L + k = nC`, giving **`L = nC − k`** — meaning `L` steps from head and `L`
steps from the collision both land on the entrance.

**Intersection (LC 160).** Two pointers that swap lists at the end each travel
`a + b` nodes, so they synchronise without ever measuring the length difference.

---

## House rules

- No force unwraps (`!`)
- No `?? 0` — explicit `if let` / `else`. `??` is allowed only when choosing
  between two node references (`tail.next = left ?? right`)
- No convenience functions (`.dropFirst()`, `.sorted()`, `.max()`)
- `let` over `var` where nothing is reassigned
- `final class` for `ListNode`
- Node comparison is always `===` / `!==` — identity, never `==`
- Every problem tested including empty list, single node, and the failing case

---

## Traps logged this phase

| Trap | What it looks like |
|---|---|
| **Lost walker** | Building a list without `current`, or without advancing it. Head stays, current walks — always two pointers |
| **Optional interpolation** | `print(head?.value)` → `Optional(1)`. Use `if let` at the call site |
| **Guard after the crash line** | Reading `values[0]` before checking `isEmpty` |
| **Node vs value check** | `while fast?.value != nil` — "can I step" is about `next` existence, never the value |
| **`!= nil` + `?.` chains** | Works, but re-checks what `while let` already proved. Use the binding |
| **Force unwrap in helpers** | `current = current.next!` — bind the node instead of reading back what you just wrote |
| **Rebuilt helpers** | `createList` broke five times when retyped from memory. Reviewed code is an asset — paste it, don't re-derive it |

---

## Revision grouping

For R1 passes, group by pattern rather than number:

- **Slow/fast block:** 154 → 155 → 156
- **Dummy head block:** 153 → 157 → 161
- **Reversal block:** 152 → 165 → 158
- **Composition block:** 159 → 162 (both call middle + reverse)
- **Design:** 166 (own category — hashmap + doubly linked list)

---

*Phase 9 Linked List complete (Jul 13–19) → Next: Trees (Jul 20–Aug 2) → … → DP → Bit Manipulation, ending Aug 28 — full plan in `ROADMAP.md` (problems 111–264, Blind75-complete). Mock interviews parallel from mid-August. Target: September 2026 loops.*
