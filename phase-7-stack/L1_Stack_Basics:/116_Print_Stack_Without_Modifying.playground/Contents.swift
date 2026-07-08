import Foundation

/*
 =========================================================
        116 - PRINT STACK WITHOUT MODIFYING
 =========================================================

 Problem
 -------
 Print all elements of a stack (top to bottom) without
 modifying the original stack.

 Example
 Original Stack (Top ↓)     Output      After Printing (Top ↓)
 50                         50          50
 40                         40          40
 30                         30          30
 20                         20          20
 10                         10          10

 ---------------------------------------------------------

 THE KEY INSIGHT (Swift-specific)
 --------------------------------
 Swift arrays are VALUE TYPES. A function parameter or a
 `var copy = stack` assignment is already an independent
 copy (copy-on-write). The caller's stack was never at risk.

 So there are THREE approaches, and knowing WHICH applies
 WHEN is the actual learning:

 1. Value-copy destructive print — Swift-honest version.
    Copy is free; destroy the copy; caller untouched.

 2. Temp + restore dance — the CLASSICAL exercise answer.
    REQUIRED when the stack is a REFERENCE type (a class
    Stack like problem 112, or Java/Python arrays), because
    there popping really does destroy the caller's data.

 3. Index loop backwards — the production answer.
    O(1) extra space, zero mutation, no stack ops at all.

 ---------------------------------------------------------

 Dry Run (Approach 2, the classical one)

 Original [10, 20, 30, 40, 50]
    ↓ pop + print:  50 40 30 20 10
 Temp     [50, 40, 30, 20, 10]
    ↓ pop + push back
 Original [10, 20, 30, 40, 50]   — restored ✅

 ---------------------------------------------------------

 Complexity

 Approach 1: O(n) time, O(n) space (the copy)
 Approach 2: O(n) time, O(n) space (temp stack)
 Approach 3: O(n) time, O(1) space  ⭐ production choice

 ---------------------------------------------------------

 Traps

 1. Doing the temp+restore dance on a Swift array parameter —
    correct output, but the restore protects a local copy
    nobody sees. Know your value semantics.
 2. On a REFERENCE stack, forgetting the restore loop —
    prints fine, silently empties the caller's stack.
 3. Debug prints inside reusable functions (phase trap #3).

 =========================================================
 */

//==========================================================
// MARK: - Approach 1: Value-Copy Destructive Print (Swift-honest)
//==========================================================

func printStackValueCopy(_ stack: [Int]) {

    var working = stack                       // independent copy — free

    while working.isEmpty == false {
        let value = working.removeLast()
        print(value)                          // destroying the COPY only
    }
}

//==========================================================
// MARK: - Approach 2: Temp + Restore (for REFERENCE stacks)
//==========================================================
// Demonstrated on the class Stack from 112 — where it's genuinely needed.

class RefStack {
    private var items: [Int] = []

    func push(_ item: Int) { items.append(item) }

    func pop() -> Int? {
        if items.isEmpty { return nil }
        return items.removeLast()
    }

    func isEmpty() -> Bool { return items.isEmpty }
    func display() -> [Int] { return items }
}

func printRefStackWithoutModifying(_ stack: RefStack) {

    let temp = RefStack()

    // Pop + print + stash
    while stack.isEmpty() == false {
        if let value = stack.pop() {
            print(value)
            temp.push(value)
        }
    }

    // Restore — WITHOUT this, the caller's stack is silently emptied
    while temp.isEmpty() == false {
        if let value = temp.pop() {
            stack.push(value)
        }
    }
}

//==========================================================
// MARK: - Approach 3: Index Loop (production answer, O(1) space)
//==========================================================

func printStackByIndex(_ stack: [Int]) {

    var index = stack.count - 1

    while index >= 0 {
        print(stack[index])
        index -= 1
    }
}

//==========================================================
// MARK: - Testing
//==========================================================

let stack = [10, 20, 30, 40, 50]

print("Original Stack : \(stack)")

print("\n========== Approach 1: Value Copy ==========")
printStackValueCopy(stack)
print("Original after : \(stack)  ✅ untouched")

print("\n========== Approach 2: Temp + Restore (reference stack) ==========")
let refStack = RefStack()
refStack.push(10)
refStack.push(20)
refStack.push(30)
refStack.push(40)
refStack.push(50)
print("RefStack before : \(refStack.display())")
printRefStackWithoutModifying(refStack)
print("RefStack after  : \(refStack.display())  ✅ restored")

print("\n========== Approach 3: Index Loop ==========")
printStackByIndex(stack)
print("Original after : \(stack)  ✅ untouched, O(1) space")

print("\n========== Edge Cases ==========")
printStackValueCopy([])          // prints nothing, no crash
printStackByIndex([])            // prints nothing, no crash
printStackValueCopy([99])        // single element
print("Edge cases pass ✅")

/*
 =========================================================
                    INTERVIEW Q&A
 =========================================================

 Q1: Which approach would you use in production?
 A : The index loop — O(1) space, zero mutation, no ceremony.
     The temp+restore dance is the exercise answer for
     reference-type stacks where you only have push/pop.

 Q2: Why is the temp+restore unnecessary on a Swift array?
 A : Arrays are value types with copy-on-write — the function
     parameter is already an independent copy. Popping it
     cannot affect the caller. In Java/Python the same code
     WOULD destroy the caller's stack, so the restore matters.

 Q3: What breaks if you forget the restore loop on a
     reference stack?
 A : Nothing visibly — output is correct — but the caller's
     stack is now empty. The silent-mutation class of bug.

 Q4: Print order?
 A : Top to bottom (LIFO order) — 50 first for this stack.
     The index loop achieves it by walking the array backwards.

 =========================================================
 */
