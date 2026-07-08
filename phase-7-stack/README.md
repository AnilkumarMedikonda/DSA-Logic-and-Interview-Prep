# Phase 7 — Stack (Problems #111–132)

Part of my DSA interview-prep journey in Swift.
Repo: [DSA-Logic-and-Interview-Prep](https://github.com/AnilkumarMedikonda/DSA-Logic-and-Interview-Prep) · Branch: `feature/stack-patterns`

**Status: ✅ COMPLETE — 22/22 accounted for** (solved by hand or reference-filed by deliberate decision)

**Window: Jul 7–10 · Closed Jul 8, two days early**

---

## Approach

Every solved problem follows the same workflow: **brute force first → optimise → review → playground file**. Each playground uses an eight-section MARK format:

`Problem → Brute Force → Optimised → Dry Run → Complexity → Traps → Tests → Interview Q&A`

House rules applied throughout:
- No predefined Swift convenience functions (`.max()`, `.reduce()`, `.sorted()`, `.contains()`)
- No force unwraps — explicit `if let / else` for all optionals
- `while` for condition-driven loops, `for-in` for bounded iteration
- `let` over `var` wherever mutation is absent

House idiom born this phase: **`while let top = stack.last, condition`** — one binding replaces the `isEmpty` guard *and* the force unwrap. Adopted as the standard monotonic-stack form for all phases going forward.

---

## Clusters

### L1 — Stack Basics (111–117)
| # | Problem | Status |
|---|---|---|
| 111 | Stack Basics & Operations | ✅ guarded pops, Stack struct |
| 112 | Stack Using Array | ✅ class implementation, if-let pops |
| 113 | Reverse String Using Stack | ✅ LIFO-as-reversal |
| 114 | Reverse Array Using Stack | ✅ pattern rep |
| 115 | Copy Stack | ✅ double-reversal via temp |
| 116 | Print Without Modifying | ✅ 3 approaches (value copy / temp+restore / index loop) |
| 117 | Remove All Elements | ✅ value-copy vs `inout` mutation lesson |

Key lesson of the tier: **value-vs-reference semantics both directions** — a struct stack copies on assignment; mutating the original requires `inout` or a class.

### L2 — Interview Stack (118–125)
| # | Problem | LC | Status |
|---|---|---|---|
| 118 | Balanced Parentheses (brute study) | 20 | ✅ removal-order bug documented |
| 119 | Valid Parentheses ⭐ | 20 | ✅ cold-verified |
| 120 | Min Stack ⭐ | 155 | ✅ augmented-stack rewrite debt cleared |
| 121 | Next Greater Element I | 496 | ✅ transcription-after-explanation |
| 122 | Daily Temperatures ⭐ | 739 | ✅ (force-unwrap regression caught) |
| 123 | Online Stock Span | 901 | ✅ cold-derived — closed 121–123 rewrite debt |
| 124 | Evaluate Reverse Polish Notation ⭐ | 150 | ✅ pop-order trap (subtraction/division) |
| 125 | Sort a Stack | — | ✅ recursion + insert-in-order |

The monotonic stack was documented as the **waiting-room model**: elements wait on the stack for their answer; the incoming element resolves everyone it beats. Three knobs turn one template into seven problems — comparison direction, values vs indices, record-on-pop type.

### L3 — Advanced Monotonic Stack (126–132)
| # | Problem | LC | Pattern | Status |
|---|---|---|---|---|
| 126 | Asteroid Collision | 735 | Fight-and-pop, multi-round collision | ✅ |
| 127 | Largest Rectangle in Histogram | 84 | Monotonic increasing + sentinel flush | ✅ Hard |
| 128 | Car Fleet | 853 | Inverted stack — grow-only, skip-push | ✅ |
| 129 | Basic Calculator | 224 | Stack of paused (result, sign) contexts | ✅ Hard, zero-logic-bug derivation |
| 130 | Next Greater Element II | 503 | Circular NGE — 2n loop, `i % n`, pass-one push | 📖 reference (triage) |
| 131 | Remove K Digits | 402 | Greedy + monotonic increasing | ✅ |
| 132 | Largest Rectangle — revision | 84 | Cold rewrite, no reference | ✅ passed |

**Legend:** ✅ solved by hand (brute + optimised) · 📖 read-not-derived reference file · ⭐ Blind75

---

## The Four Pop Philosophies

Same data structure, four different reasons to pop — knowing *which one a problem needs* is the interview skill; the mechanics are ~15 lines every time.

1. **Structural pop** (121–123, 126, 127, 130) — pop when a relationship between top and incoming is violated (warmer day, taller bar, collision course). The stack holds *unresolved* elements waiting for their answer.
2. **Inverted / grow-only** (128) — a "violation" skips the push instead of popping. The stack only grows; the answer is `stack.count`. Reducible to a single variable since only the top is ever compared.
3. **Context stack** (129) — holds neither operands nor indices but **paused states**: (result, sign) pairs frozen at each `(`, unwound at `)`.
4. **Greedy pop** (131) — the pop condition serves an *optimisation goal* (smallest number), not a structural rule. The extra interview obligation: proving the greedy choice is safe.

---

## The Skip Decision (and why it's on purpose)

Only one problem this phase: **130 (NGE II)**. Linear NGE was derived three ways in L2; the circular variant adds exactly one trick (2n loop with `i % n`, push only in pass one). Lower standalone frequency at target companies → 10-minute reference file with the trick, the traps, and the diagnostic test (`[5,4,3,2,1]` → max stays -1). Banner'd READ-NOT-DERIVED so revision triage treats it as unlearned.

Prep hours go where questions exist.

---

## Recurring Traps (hard-won this phase)

1. **The invariant has two halves** — pop violators, then **PUSH**. The 132 cold rewrite retained the clever half (width branches, sentinel) and dropped the obvious half (`stack.append(i)`) — returning 0 for every input. Drill both halves, not just the hard one.
2. **Empty-stack branch is where solutions break** — width `= i` in 127 (`[2,1,2]` → 3 is the proof), fresh push in 128/131. `while let top = stack.last, condition` handles guard + unwrap in one binding.
3. **Strict vs non-strict comparison is always a deliberate choice** — `>` in 130 (`[3,3,3]` → all -1) and 131 (`"112", k=1` → `"11"`); `<=` merges in 128 (catching exactly at target = same fleet); equal sizes in 126 destroy **both**.
4. **Push indices, not values, when position math follows** (127, 130) — width and span need positions.
5. **Sentinel flush** (127: append `0`) replaces the end-of-loop cleanup — one shorter bar than everything forces all remaining pops.
6. **Pop order = reverse of push order** (129) — pushed result then sign, so pop sign first. Swapping breaks `2-(5-6)`.
7. **Integer division truncates arrival times** (128) — `Double(...)` before dividing; `t=10, [6,8], [3,2]` is the diagnostic (int math merges what shouldn't merge).
8. **`removeFirst()` in a loop is O(n²)** (131 zero-strip) — scan to the first keeper, slice once.
9. **Run-before-paste is the gate, not re-reading the diff** — the 132 missing push printed `0` on `[2,1,2]` in thirty seconds; two rounds of diff-reading missed it.

Biggest meta-lesson (again): **the retention system works both directions.** 129 — a Hard — derived with zero logic bugs because 126–128 were earned attempt-first. And the 132 cold rewrite honestly measured what stuck: sentinel and width branches survived, the push slipped, and now it's a named trap with a Trees-phase re-touch scheduled. A pasted-perfect "rewrite" would have recorded a lie.

---

## Key Reusable Primitives

- `while let top = stack.last, condition` — the house monotonic-stack idiom (guard + unwrap in one binding)
- Monotonic stack template + three knobs — seven problems from one skeleton (121–123, 126–127, 130–131)
- Paused-context push/pop pairs (129) — reusable for any nested-scope evaluation (LC 227, LC 394 Decode String)
- Descending insertion sort over tuples (128) — pairs stay synced through the sort
- Sentinel-flush technique (127) — applies to any "drain remaining stack at end" situation

---

## Queued Follow-ups

- **LC 227 Basic Calculator II** — Meta staple, 20-minute variant of 129 (track `lastNumber`, apply `*` `/` immediately)
- **LC 85 Maximal Rectangle** — 127 run row-by-row over a binary matrix
- **LC 316 / 321** — greedy-stack family extending 131
- **127 re-touch at Trees-phase start** — drill "pop violators, then PUSH"

---

*Next: Phase 8 Queue & Deque (Jul 11–12) → Linked List (Jul 13–19) → Trees (Jul 20–Aug 2) → … → DP → Bit Manipulation, ending Aug 28 — full plan in `ROADMAP.md` (problems 111–264, Blind75-complete). Mock interviews parallel from August. Target: August 2026.*
