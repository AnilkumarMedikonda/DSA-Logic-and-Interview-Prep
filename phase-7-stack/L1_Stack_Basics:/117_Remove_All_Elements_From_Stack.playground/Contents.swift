import Foundation

/*
 =========================================================
        117 - REMOVE ALL ELEMENTS FROM STACK
 =========================================================

 Problem
 -------
 Remove all elements from a stack, printing each removed
 element (top to bottom order).

 Example
 Input Stack (Top ↓)     Output              Final Stack
 50                      Removed : 50        []
 40                      Removed : 40
 30                      Removed : 30
 20                      Removed : 20
 10                      Removed : 10

 ---------------------------------------------------------

 THE LESSON (mutation side of 116's value-semantics lesson)
 ----------------------------------------------------------
 "Remove all elements" — from WHAT, exactly?

 Version A (value copy): drains a COPY. The caller's stack
 survives untouched. Function name says "remove", effect
 says "print in removal order". Space: O(n) — the copy.

 Version B (inout): drains the CALLER'S stack for real.
 The honest "remove all". Space: O(1) — true in-place.

 "When does a Swift function actually mutate its argument?"
 is a real interview question — the answer is: only when
 the parameter is inout (or the type is a reference type).

 ---------------------------------------------------------

 Dry Run

 [10, 20, 30, 40, 50]
   → Remove 50 → [10, 20, 30, 40]
   → Remove 40 → [10, 20, 30]
   → Remove 30 → [10, 20]
   → Remove 20 → [10]
   → Remove 10 → []

 ---------------------------------------------------------

 Complexity

 Version A: Time O(n), Space O(n) — the value copy
 Version B: Time O(n), Space O(1) — true in-place drain

 ---------------------------------------------------------

 Traps

 1. Believing Version A empties the caller's stack — value
    semantics means it drained a copy. Name/effect mismatch.
 2. Claiming O(1) space while holding a full value copy.
 3. Unguarded removeLast — safe here only because the while
    condition IS the guard.

 =========================================================
 */

//==========================================================
// MARK: - Version A: Value-Copy Drain (caller untouched)
//==========================================================

func printInRemovalOrder(_ stack: [Int]) {

    var working = stack                    // independent copy

    while working.isEmpty == false {
        let removedElement = working.removeLast()
        print("Removed : \(removedElement)")
    }
}

//==========================================================
// MARK: - Version B: True Remove All (inout — caller's stack drained)
//==========================================================

func removeAllElements(from stack: inout [Int]) {

    while stack.isEmpty == false {
        let removedElement = stack.removeLast()
        print("Removed : \(removedElement)")
    }
}

//==========================================================
// MARK: - Testing
//==========================================================

print("========== Version A: Value Copy ==========")

let stackA = [10, 20, 30, 40, 50]
print("Before : \(stackA)")
printInRemovalOrder(stackA)
print("After  : \(stackA)  ✅ caller untouched (value semantics)")

print("\n========== Version B: inout (true removal) ==========")

var stackB = [10, 20, 30, 40, 50]
print("Before : \(stackB)")
removeAllElements(from: &stackB)
print("After  : \(stackB)  ✅ genuinely emptied")

print("\n========== Edge Cases ==========")

var emptyStack = [Int]()
removeAllElements(from: &emptyStack)       // no output, no crash
print("Empty stack drain : no crash ✅")

var single = [99]
removeAllElements(from: &single)
print("Single element drain : \(single) ✅")

/*
 =========================================================
                    INTERVIEW Q&A
 =========================================================

 Q1: Does Version A remove elements from the caller's stack?
 A : No — Swift arrays are value types; the parameter is an
     independent copy. Only Version B (inout) mutates the
     caller's data. In Java/Python, Version A's code WOULD
     drain the caller's stack (reference semantics).

 Q2: Why is only Version B O(1) space?
 A : Version A materializes a full copy of the stack before
     draining it. Version B works directly on the caller's
     storage — no copy exists.

 Q3: Why does removeLast() not crash here?
 A : The while stack.isEmpty == false condition guarantees
     at least one element exists before every removal — the
     loop condition IS the guard.

 Q4: Removal order?
 A : Top to bottom — LIFO. Last pushed (50) is first removed.

 =========================================================
 */
