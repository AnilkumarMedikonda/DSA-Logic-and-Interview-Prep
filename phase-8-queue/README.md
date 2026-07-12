# Phase 8 — Queue (Problems #133–143)

Part of my DSA interview-prep journey in Swift.
Repo: [DSA-Logic-and-Interview-Prep](https://github.com/AnilkumarMedikonda/DSA-Logic-and-Interview-Prep) · Branch: `feature/queue-patterns`

**Status: ✅ COMPLETE — 11/11 solved by hand** (no reference files this phase)

**Window: Jul 11–12 · Closed Jul 12, on schedule**

---

## Approach

Every problem follows the same workflow: **brute force first → optimise → review → playground file**. Each playground uses the eight-section MARK format:

`Problem → Brute Force → Optimised → Dry Run → Complexity → Traps → Tests → Interview Q&A`

House rules applied throughout:
- No predefined Swift convenience functions (`.max()`, `.reduce()`, `.sorted()`, `.contains()`)
- No force unwraps — explicit `if let / else` for all optionals
- `while` for condition-driven loops, `for-in` for bounded iteration
- `let` over `var` wherever mutation is absent

The Phase 7 house idiom **`while let top = stack.last, condition`** transplanted directly to the deque back-flush in 143 — same binding, same guard-plus-unwrap economy. The pattern travels.

---

## Clusters

### L1 — Queue Basics (133–138)
| # | Problem | LC | Status |
|---|---|---|---|
| 133 | Queue Basics & Operations | — | ✅ head-index + threshold compaction |
| 134 | Queue Using Array | — | ✅ fixed-capacity contract (front/rear/isEmpty/isFull) |
| 135 | Queue Using Stacks | 232 | ✅ lazy transfer, amortised O(1) |
| 136 | Circular Queue | 622 | ✅ ring buffer, `% capacity` wrap |
| 137 | Deque | 641 | ✅ backward wrap `(i - 1 + capacity) % capacity` — optimised on rewrite debt |
| 138 | FIFO Practice | 933 | ✅ warm-ups + LC 933 (on rewrite debt) |

Key lesson of the tier: **`Array.removeFirst()` is an O(n) trap, and there are exactly three escapes** — head-index with compaction, two-stack lazy transfer, ring buffer. All amortised O(1), each by a different mechanism (lazy deletion / deferred reversal / overwrite-in-place). Knowing *which mechanism* a problem wants is the tier's skill.

### L2 — High Priority Interview Questions (139–143)
| # | Problem | LC | Status |
|---|---|---|---|
| 139 | Number of Recent Calls | 933 | ✅ time-window eviction |
| 140 | Dota2 Senate | 649 | ✅ two-queue greedy, re-enter at `index + n` |
| 141 | Time Needed to Buy Tickets | 2073 | ✅ O(n) math over simulation |
| 142 | Moving Average from Data Stream | 346 | ✅ queue + running sum — derived optimised directly, skipped brute |
| 143 | Sliding Window Maximum ⭐ | 239 | ✅ Hard — **cold re-derivation pass** (first solved May '26) |

**Legend:** ✅ solved by hand (brute + optimised) · ⭐ Blind75 / NeetCode 150

---

## The Amortised O(1) Trilogy

Same complaint (`removeFirst()` shifts everything), three cures — the phase's central theme:

1. **Head-index + compaction** (133) — never delete, advance a pointer. Physically trim only when the dead zone dominates: `head > 50 && head * 2 >= items.count`. Lazy deletion.
2. **Two-stack lazy transfer** (135) — enqueue into `inStack`, dequeue from `outStack`; reverse only when `outStack` runs dry. Each element crosses exactly once → O(1) amortised. Deferred work.
3. **Ring buffer** (136, 137) — fixed array, `(index + 1) % capacity` forward, `(index - 1 + capacity) % capacity` backward. Nothing ever shifts because nothing is ever removed — slots are overwritten. Reuse-in-place.

Three mechanisms, one interview answer shape: *"the expensive operation is rare, so its cost spreads across the cheap ones."* Same argument later powers 143's O(n) proof.

---

## The Monotonic Deque (143) — the Boss Pattern

Phase 7's monotonic stack + one new ingredient: **expiry from the front**. Both ends active → deque.

```swift
// per step, in this exact order:
if let front = deque.first, front < right - k + 1 { deque.removeFirst() }      // 1. expire front
while let back = deque.last, nums[back] <= nums[right] { deque.removeLast() }  // 2. flush back
deque.append(right)                                                            // 3. enter
if right >= k - 1, let front = deque.first { result.append(nums[front]) }     // 4. front = answer
```

**Invariant:** indices in decreasing order of their values, all inside the window → the front is always the max.

- **Indices, not values** — expiry needs position; a value can't tell you it's too old
- **`if` for the front, `while` for the back** — a fixed window slides by 1, so at most one expiry per step; the back can hold many dominated values
- **`<=` on the flush** — evicting equals keeps the newer index, which survives in-window longer
- **O(n) amortised** — every index enters once, leaves at most once; the Phase 7 sentinel-flush argument, verbatim

Re-derived cold ~6 weeks after the first solve, same structure, zero reference. The spaced-revision ladder's first Hard-tier confirmation.

---

## Recurring Traps (hard-won this phase)

1. **Evict from the FRONT, never the back** — removing the newest keeps stale data and discards fresh input; that's LIFO behaviour smuggled into a stream (142). FIFO means oldest-out, always.
2. **The divisor is `count`, not `size`** — the window has a warm-up phase (÷1, ÷2, …) before it fills. Dividing by `size` from call one is the most common 346 bug (142).
3. **`Double` conversion BEFORE dividing** — `Int / Int` truncates silently. `Double(sum) / Double(count)`, never `Double(sum / count)` (142).
4. **Eviction order in the deque is load-bearing** — expire front → flush back → append. Appending first lets the new element evict the wrong neighbours (143).
5. **`front()` reads `items[head]`, never `items.first`** — with lazy deletion, `.first` returns a dead element (133). Same family as trap 1: the *logical* front and the *physical* front diverge.
6. **Bookkeeping line missing after structural mutation** — `head = 0` reset after compaction (133). The named bug class from LC 84 / 120 / 125 struck again; every structural mutation touches two things, check both.
7. **The stream and the window are different objects** — the stream grows forever and needn't be stored; the window is capped at `size` and is all you keep. Conflating them is why brute force wastes O(n) space (142).
8. **`% capacity` backward wrap needs the `+ capacity`** — `(i - 1) % capacity` goes negative in Swift; `(i - 1 + capacity) % capacity` doesn't (137).

Biggest meta-lesson: **the retention system passed its first real audit.** 143 — the phase boss, a Hard — was re-derived cold six weeks after the original solve with identical structure and one deliberate refinement (`if` where `while` was, with the reasoning to defend it). Earned code survives; the May derivation was attempt-first, and it showed.

---

## Key Reusable Primitives

- Head-index queue + compaction threshold — the general lazy-deletion skeleton (reused verbatim in 139: only the eviction condition changed)
- Ring buffer with dual-direction wrap — audio buffers, log rotation, any fixed-size cache
- Queue + running sum — one-in/one-out delta maintenance; generalises to any window aggregate that's invertible (sum, count — not max, which is why 143 needs the deque)
- Monotonic deque template — `if`-expire front, `while`-flush back, append, read front
- Two-queue greedy with re-entry at `index + n` (140) — the queue *is* the round system

---

## iOS Bridges

| Pattern | Production use |
|---|---|
| Time-window queue (933) | Rate limiting, debounce, API throttling |
| Moving average (346) | FPS counters, download-speed smoothing, CoreMotion sensor readings |
| Monotonic deque (239) | Peak memory over last N samples (MetricKit), jank detection via max frame time |
| Two-stack queue (232) | `OperationQueue` mental model — deferred, batched work |
| Ring buffer (622) | Audio buffers, log rotation, fixed-size caches |

---

## Queued Follow-ups

- **142 circular-buffer variant** — the "make `next()` true O(1)" interviewer follow-up; on rewrite debt, derive cold
- **Rewrite debt carried forward:** 120, 125, 137 (circular deque optimised), LC 933 — blank-file rewrites before Trees
- **LC 1438 / LC 1696** — monotonic deque extensions (two deques / deque + DP), queued for the revision ladder
- **143 re-touch at a later phase-open** — it's now Tier 1; next cold rotation confirms it stays

---

*Next: Phase 9 Linked List (Jul 13–19) → Trees (Jul 20–Aug 2) → … → DP → Bit Manipulation, ending Aug 28 — full plan in `ROADMAP.md` (problems 111–264, Blind75-complete). Mock interviews parallel from mid-August. Target: September 2026 loops.*
