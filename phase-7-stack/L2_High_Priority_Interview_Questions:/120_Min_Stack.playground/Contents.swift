import Foundation

/*
 =========================================================
        120 - MIN STACK  (LC 155)  ⭐ Blind75 / NeetCode
 =========================================================

 Problem
 -------
 Design a stack supporting push, pop, top, and getMin —
 EVERY operation in O(1).

 push(-2), push(0), push(-3)
 getMin() → -3
 pop()
 top()    → 0
 getMin() → -2   ← the whole problem: how did it KNOW -2
                   without searching?

 Interview rate: 🔴 Very High — top-3 stack question.
 Amazon staple (screens + onsites), Microsoft screens.

 ---------------------------------------------------------

 THE INSIGHT
 -----------
 A single currentMin variable dies when the min is popped —
 it can't recover the PREVIOUS min without an O(n) search.

 Augmented Stack: every element, when pushed, carries a
 sticky note — "the min AS OF my arrival." The note is
 written ONCE at push time, never updated. Popping an
 element takes its note along, automatically uncovering
 the previous answer.

 Compute at WRITE time, read at READ time — same trade as
 Phase 5 prefix sums (build once, query O(1)).

 =========================================================
 */

//==========================================================
// MARK: - Naive Attempt (kept as the lesson — DO NOT USE)
//==========================================================
/*
 My first attempt: getMin() looped with removeLast() to
 find the min.

 Two fatal flaws:
 1. DESTRUCTIVE — getMin emptied the stack; the very next
    pop() crashed. A read operation must not mutate.
 2. O(n) — any loop inside getMin means the design is wrong.
    The problem IS the O(1) constraint.

 The mental shift: not "how do I FIND the min" but "how do
 I never have to find it because every element REMEMBERED it."
 */

//==========================================================
// MARK: - Optimised: Augmented Stack (pairs) — O(1) everything
//==========================================================

class MinStack {

    // Each element carries the min AS OF its arrival
    private var items: [(value: Int, minSoFar: Int)] = []

    func push(_ value: Int) {

        if let currentTop = items.last {
            // ONE comparison: me vs the previous sticky note.
            // The previous element already summarized everything below.
            let newMin: Int
            if value < currentTop.minSoFar {
                newMin = value                    // new record holder
            } else {
                newMin = currentTop.minSoFar      // carry old record FORWARD
            }
            items.append((value, newMin))
        } else {
            // Empty stack — I'm my own min (cold-rewrite bug 1: this
            // branch missing = NOTHING ever gets stored)
            items.append((value, value))
        }
    }

    func pop() -> Int? {
        if items.isEmpty {
            return nil                            // guard — no crash path
        }
        return items.removeLast().value
        // The popped element takes its note along — the previous
        // answer is now on top, already correct. Zero recomputation.
    }

    func top() -> Int? {
        if items.isEmpty {
            return nil
        }
        return items[items.count - 1].value
    }

    func getMin() -> Int? {
        if items.isEmpty {
            return nil
        }
        return items[items.count - 1].minSoFar    // one read. no loop.
    }
}

//==========================================================
// MARK: - Dry Run (the sticky-note trace)
//==========================================================
/*
 push(-2): empty → [(-2, note: -2)]
 push(0):  min(0, note -2) = -2 → [(-2,-2), (0, note: -2)]
 push(-3): min(-3, note -2) = -3 → [..., (-3, note: -3)]
 getMin(): read top note → -3
 pop():    (-3,-3) leaves → top is (0, note: -2)
 getMin(): read top note → -2 ✅ — the answer was written
           3 pushes ago. The "recovery" was free.
 */

//==========================================================
// MARK: - Complexity
//==========================================================
/*
 push / pop / top / getMin : all O(1)
 Space : O(n) — one extra Int per element, the price of
         never searching.
 */

//==========================================================
// MARK: - Traps  (two cold-rewrite rounds documented)
//==========================================================
/*
 1. NAIVE TRAP: looping inside getMin — O(n) AND destructive
    if the loop pops. getMin is a read. (First attempt.)
 2. COLD-REWRITE BUG 1: push written as `if let last = ... {}`
    with NO else branch → first push onto empty stack silently
    stores nothing → every later call returns nil. The empty
    case isn't an edge case here — it's the base case.
 3. COLD-REWRITE BUG 2: both push branches appending
    (value, value) → the else must CARRY THE OLD RECORD:
    (value, last.minSoFar). Both branches ignoring the
    comparison result guts the entire design.
 4. COLD-REWRITE BUG 3: pop() without the isEmpty guard —
    the 111 crash, back. (top/getMin survived via optional
    chaining `items.last?.value`; pop can't use that trick.)
 5. The note is written ONCE at push — never update notes of
    elements already on the stack.

 Retention status: skeleton stuck cold (structure, pairs,
 reads); the push branching — the part that encodes the
 insight — did NOT. Rewrite #3 due before phase end.
 */

//==========================================================
// MARK: - Tests
//==========================================================

print("========== LC 155 exact sequence ==========")

let minStack = MinStack()
minStack.push(-2)
minStack.push(0)
minStack.push(-3)

if let min1 = minStack.getMin() { print("getMin :", min1) }      // -3
if let popped = minStack.pop() { print("pop    :", popped) }     // -3
if let t = minStack.top() { print("top    :", t) }               // 0
if let min2 = minStack.getMin() { print("getMin :", min2) }      // -2 ✅

print("\n========== Duplicates of the min ==========")

let dupStack = MinStack()
dupStack.push(1)
dupStack.push(1)
if let popped = dupStack.pop() { print("pop    :", popped) }     // 1
if let m = dupStack.getMin() { print("getMin :", m) }            // 1 — still there

print("\n========== Increasing then draining ==========")

let incStack = MinStack()
incStack.push(5)
incStack.push(7)
incStack.push(9)
if let m = incStack.getMin() { print("getMin :", m) }            // 5 — carried forward twice
if incStack.pop() != nil && incStack.pop() != nil {
    if let m = incStack.getMin() { print("getMin :", m) }        // 5
}

print("\n========== Empty guards ==========")

let empty = MinStack()
if empty.pop() == nil && empty.top() == nil && empty.getMin() == nil {
    print("pop/top/getMin on empty : nil, nil, nil — no crashes ✅")
}

//==========================================================
// MARK: - Interview Q&A
//==========================================================
/*
 Q1: Why not a single currentMin variable?
 A : It dies when the min is popped — recovering the previous
     min needs history, and a variable holds one value.

 Q2: How is getMin O(1) after the min was popped?
 A : The answer was computed at PUSH time — each element
     stores the min-as-of-its-arrival. Popping uncovers the
     previous element's already-correct note. Write-time
     compute, read-time read.

 Q3: Alternative design?
 A : Parallel min-stack: values in one array, running min in
     a second, pushed/popped in lockstep. Space-optimized
     variant: push to the min-stack only when value <=
     current min (pop from it only when the popped value
     equals its top). Most common follow-up — know it.

 Q4: O(1) getMax too?
 A : Same trick, second field per element: (value, minSoFar,
     maxSoFar).

 Q5: Harder cousin?
 A : LC 716 Max Stack — popMax() breaks the pattern (removing
     from the MIDDLE) and needs a doubly linked list + sorted
     structure. LC 895 Freq Stack uses the same augmentation
     idea per frequency.

 =========================================================
 */
