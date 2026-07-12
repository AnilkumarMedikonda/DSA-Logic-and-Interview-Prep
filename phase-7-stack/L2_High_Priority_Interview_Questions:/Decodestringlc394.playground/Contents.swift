import Foundation

// MARK: - 1. Problem
/*
 Decode String (LC 394, Medium) — Phase 7 follow-up, context-stack family

 Rule: k[substring] → substring repeats k times. Nesting allowed.
 Input guaranteed valid; k is always followed by [.

 "3[a]"          → "aaa"
 "3[a2[c]]"      → "accaccacc"      inner first: 2[c]=cc → acc → ×3
 "2[abc]3[cd]ef" → "abcabccdcdcdef"
 "10[a]"         → "aaaaaaaaaa"     k can be multi-digit!

 Pattern: CONTEXT STACK (pop philosophy #3, LC 224 lineage).
 At '[' freeze the paused pair (count, prefix string); at ']' unwind.
 Same skeleton as Basic Calculator — different cargo.
*/

// MARK: - 2. Brute Force
/*
 Skipped by design — the context-stack approach IS the natural first
 derivation here (single pass, no repeated scanning). A "brute" that
 repeatedly finds innermost brackets and rebuilds the string is
 O(n²)+ and teaches nothing this family hasn't already covered.
*/

// MARK: - 3. Optimised — context stack (count, prefix) pairs
/*
 Four character types, four branches:
 digit  → accumulate: currentNumber * 10 + digit  (multi-digit!)
 '['    → push BOTH contexts (count + prefix), reset both
 ']'    → pop both, combine: prefix + repeated(current)
 letter → append to currentString

 Combine order at ']' is the pop-order trap from 224/RPN:
 paused PREFIX first, then the repeated inner block.
*/
func decodeString(_ s: String) -> String {
    var countStack = [Int]()
    var stringStack = [String]()

    var currentString = ""
    var currentNumber = 0
    // State lives HERE only — never redeclare inside the loop

    for char in s {

        if let digit = char.wholeNumberValue, char.isNumber {
            currentNumber = currentNumber * 10 + digit

        } else if char == "[" {
            countStack.append(currentNumber)
            stringStack.append(currentString)
            currentNumber = 0
            currentString = ""

        } else if char == "]" {
            let repeatCount = countStack.removeLast()
            let lastString = stringStack.removeLast()
            currentString = lastString + String(repeating: currentString, count: repeatCount)

        } else {
            currentString.append(char)
        }
    }

    return currentString
}

// MARK: - 4. Dry Run  ("3[a2[c]]")
/*
 char '3' → currentNumber = 3
 char '[' → push (3, "");  reset          counts=[3]   strings=[""]
 char 'a' → currentString = "a"
 char '2' → currentNumber = 2
 char '[' → push (2, "a"); reset          counts=[3,2] strings=["","a"]
 char 'c' → currentString = "c"
 char ']' → pop (2, "a") → "a" + "cc" = "acc"
 char ']' → pop (3, "")  → ""  + "accaccacc" = "accaccacc"

 Return "accaccacc" ✅
 The nesting works because each '[' freezes the outer work and
 each ']' resumes exactly where it paused — LIFO by nature.
*/

// MARK: - 5. Complexity
/*
 Time:  O(n · maxK) worst case — String(repeating:) builds the
        expanded output, which can be exponentially larger than
        the input (e.g. "10[10[10[a]]]" → 1000 chars).
 Space: O(n) for the two stacks + O(output) for the result.
*/

// MARK: - 6. Traps
/*
 1. STATE DECLARED AT THE WRONG SCOPE — redeclaring currentString/
    currentNumber inside the loop shadows the outer state; every
    iteration resets, output is "". Correct logic, empty result.
    → New named bug class; joins pointer-increment-placement family.
 2. Multi-digit k — currentNumber * 10 + digit, never Int of a
    single char in isolation. "10[a]" is the probe.
 3. Combine order at ']' — paused prefix FIRST, then repeated inner.
    Swapping gives "cca" shapes. Pop-order trap, 224/RPN family.
 4. Push BOTH contexts at '[' — count alone loses the prefix;
    prefix alone loses the count. The pair is the context.
 5. char.wholeNumberValue over Int(String(char))! — no force
    unwrap, no String round-trip.
*/

// MARK: - 7. Tests
func check(_ label: String, _ got: String, _ expected: String) {
    print(got == expected ? "✅" : "❌", label, got)
}

check("single", decodeString("3[a]"), "aaa")
check("nested", decodeString("3[a2[c]]"), "accaccacc")
check("sequential", decodeString("2[abc]3[cd]ef"), "abcabccdcdcdef")
check("multi-digit", decodeString("10[a]"), "aaaaaaaaaa")
check("no brackets", decodeString("abc"), "abc")
check("deep nest", decodeString("2[b3[a]]"), "baaabaaa")
check("leading letters", decodeString("ab2[c]"), "abcc")

// MARK: - 8. Interview Q&A
/*
 Q: Why a stack — why not recursion?
 A: Both work; the stack is the iterative form of the same idea.
    Recursive version: on '[' recurse, on ']' return. The stack
    makes the paused-context idea explicit — stronger to narrate.

 Q: What exactly is pushed at '['?
 A: The paused context: (repeat count, everything decoded so far
    at THIS depth). Same shape as LC 224's (result, sign).

 Q: Why can't you convert the digit immediately?
 A: k may be multi-digit — accumulate with *10 until '[' arrives.

 Q: Worst-case output size?
 A: Exponential in nesting depth — k^depth. Worth flagging when
    asked about complexity; the input length alone doesn't bound it.

 Q: iOS bridge?
 A: Any nested-scope parsing — JSON/XML depth tracking, expression
    evaluation, undo groups (begin/endUndoGrouping pairs).

 [Rewrite debt: shadowing fix was provided, not derived — blank-file
  redo scheduled. Logic (contexts, combine order, multi-digit) was
  derived independently.]
*/
