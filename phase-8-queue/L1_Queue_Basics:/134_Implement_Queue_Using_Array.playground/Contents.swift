import UIKit

// ═══════════════════════════════════════════════════════════
// 134_Implement_Queue_Using_Array
// Phase 8 — L1_Queue_Basics
// ═══════════════════════════════════════════════════════════

// MARK: - 1. Problem
/*
 Implement a FIFO queue backed by a Swift array.
 Operations: enqueue(x), dequeue() -> Int?, peek() -> Int?, count, isEmpty

 Queue = First In, First Out. Insert at rear, remove from front.
 The catch: Swift arrays are fast at the END (append/removeLast),
 slow at the FRONT (removeFirst shifts everything). A queue needs
 the front — that mismatch is the whole problem.
*/

// MARK: - 2. Brute Force — append + removeFirst
/*
 Intuition: map queue operations directly onto array methods.
 enqueue = append (rear), dequeue = removeFirst (front). Correct,
 obvious — and hides an O(n) inside a one-line call: removeFirst
 shifts every remaining element one slot left.
*/
struct QueueBrute {

    private var elements: [Int] = []

    mutating func enqueue(_ element: Int) {
        elements.append(element)
    }

    mutating func dequeue() -> Int? {
        guard !elements.isEmpty else { return nil }
        return elements.removeFirst()       // O(n) — every element shifts left
    }

    func peek() -> Int? {
        elements.first
    }

    var count: Int { elements.count }
    var isEmpty: Bool { elements.isEmpty }
}

// MARK: - 3. Optimised — head index + compaction
/*
 Intuition: don't move elements — move a POINTER. `head` marks the
 logical front; dequeue is just head += 1. Dead slots pile up on the
 left, so occasionally compact: delete the dead prefix in one pass,
 reset head to 0. The rare O(n) compaction is pre-paid by the many
 O(1) dequeues before it → amortized O(1).

 Same idea family as two-pointer / sliding window:
 track a logical position instead of physically mutating.
*/
struct Queue {

    private var elements: [Int] = []
    private var head = 0                    // logical front — everything before it is dead

    mutating func enqueue(_ element: Int) {
        elements.append(element)
    }

    mutating func dequeue() -> Int? {
        guard head < elements.count else { return nil }
        let value = elements[head]
        head += 1                           // front moves; no element moves

        // Compact when dead space dominates (>50% of array)
        if head > 50 && head * 2 > elements.count {
            elements.removeFirst(head)      // one O(n) pass, pre-paid
            head = 0                        // array shifted → pointer must follow
        }
        return value
    }

    func peek() -> Int? {
        guard head < elements.count else { return nil }
        return elements[head]
    }

    var count: Int { elements.count - head }
    var isEmpty: Bool { head == elements.count }
}

// MARK: - 4. Dry Run
/*
 enqueue 1, 2, 3        elements = [1,2,3]  head = 0
 dequeue → 1            elements = [1,2,3]  head = 1   ← 1 is dead, not deleted
 dequeue → 2            elements = [1,2,3]  head = 2
 peek    → 3            reads elements[2]
 count   → 1            3 (physical) − 2 (head) = 1
 dequeue → 3            head = 3 == count → now empty
 dequeue → nil          guard fires

 Compaction case: 60 enqueues, 55 dequeues
   head = 55, elements.count = 60 → 55 > 50 ✓ and 110 > 60 ✓
   removeFirst(55) → elements = [56...60], head = 0
   peek → 56 ✓  (without head = 0: reads index 55 → CRASH)
*/

// MARK: - 5. Complexity
/*
              Brute            Optimised
 enqueue      O(1)*            O(1)*
 dequeue      O(n)             O(1) amortized
 peek         O(1)             O(1)
 n dequeues   O(n²) total      O(n) total
 Space        O(n)             O(n), up to ~2× before compaction

 * append is amortized O(1) — Swift array growth reallocations
*/

// MARK: - 6. Traps
/*
 1. removeFirst() LOOKS O(1) — it's a one-line call hiding a full
    left-shift. The interview probe is whether you say this out loud.
 2. head = 0 missing after compaction → pointer points past the
    shrunk array → out-of-bounds. Bug class: "bookkeeping line
    missing after structural mutation" (same as 133, LC 84).
 3. count must be elements.count - head, NOT elements.count —
    dead slots aren't queue elements.
 4. All three read paths (dequeue/peek/isEmpty) must use head,
    not index 0 / isEmpty on the raw array.
*/

// MARK: - 7. Tests
print("── Brute ──")
var brute = QueueBrute()
brute.enqueue(1)
brute.enqueue(2)
brute.enqueue(3)
if let v = brute.dequeue() { print(v) }         // 1
print(brute.count)                              // 2
if let p = brute.peek() { print(p) }            // 2
if let v = brute.dequeue() { print(v) }         // 2
if let v = brute.dequeue() { print(v) }         // 3
if brute.dequeue() == nil { print("empty") }    // empty

print("── Optimised ──")
var queue = Queue()
queue.enqueue(1)
queue.enqueue(2)
queue.enqueue(3)
if let v = queue.dequeue() { print(v) }         // 1
print(queue.count)                              // 2
if let p = queue.peek() { print(p) }            // 2
if let v = queue.dequeue() { print(v) }         // 2
if let v = queue.dequeue() { print(v) }         // 3
if queue.dequeue() == nil { print("empty") }    // empty

print("── Compaction ──")
var big = Queue()
for i in 1...60 { big.enqueue(i) }
for _ in 1...55 { _ = big.dequeue() }           // triggers compaction
print(big.count)                                // 5
if let p = big.peek() { print(p) }              // 56 — proves head = 0 held

// MARK: - 8. Interview Q&A
/*
 Q: Why is removeFirst O(n)?
 A: Arrays are contiguous memory — removing index 0 forces every
    remaining element to shift one slot left to fill the gap.

 Q: Why "amortized" O(1) and not just O(1)?
 A: Individual dequeues are O(1) except the rare compaction, which
    is O(n). But compaction only fires after ~n/2 cheap dequeues
    accumulated — spread its cost over them and each dequeue
    averages O(1). Same accounting as monotonic stack's push/pop.

 Q: Why not compact on every dequeue?
 A: That's removeFirst with extra steps — O(n) every time.
    The ratio condition (head * 2 > count) is what defers the cost.

 Q: Alternative approaches?
 A: Two stacks (problem 135), ring buffer with fixed capacity
    (problem 136), or a linked list — O(1) dequeue with no
    compaction, at the cost of node allocations (Phase 9).
*/
