import Foundation

/*
 =========================================================
        113 - REVERSE STRING USING STACK
 =========================================================

 Problem
 -------
 Reverse a given string using a Stack.

 Example
 Input  : "Hello"
 Output : "olleH"

 ---------------------------------------------------------

 What is the Idea?

 A Stack follows the LIFO principle.
 LIFO = Last In, First Out — LIFO *is* reversal.

 Push Order          Stack (Top ↓)       Pop Order
 H                   o                   o
 e                   l                   l
 l                   l                   l
 l                   e                   e
 o                   H                   H

 Result : "olleH"

 ---------------------------------------------------------

 Algorithm

 Step 1: Create an empty stack.
 Step 2: Push every character into the stack.
 Step 3: Create an empty result CHARACTER ARRAY.
 Step 4: Pop until empty, appending each popped character.
 Step 5: Convert to String ONCE at the end and return.

 ---------------------------------------------------------

 Dry Run

 Input : "Hello"
 Push  : stack = [H, e, l, l, o]
 Pop   : o → l → l → e → H
 Result: "olleH"

 ---------------------------------------------------------

 Time Complexity
 Push Characters    O(n)
 Pop Characters     O(n)
 Total              O(n)

 Space Complexity
 Stack + result     O(n)

 Note: two-pointer reversal does this in O(1) extra space —
 the stack version exists to teach the LIFO-reversal pattern,
 which powers Decode String and RPN later. Say this if asked.

 ---------------------------------------------------------

 Traps

 1. result += String(char) in the pop loop — the Phase 6
    string-building trap (#100/#101/#104). Collect into
    [Character], convert with String(resultChars) ONCE.
    (String.append(Character) is acceptable; += String(char)
    is the trap — know the distinction.)
 2. Unguarded removeLast() — safe here only because the
    while condition IS the guard.
 3. Debug prints inside the function make it unusable as a
    reusable primitive — keep the function pure, print in tests.

 =========================================================
 */

//==========================================================
// MARK: - Reverse String Using Stack
//==========================================================

func reverseString(_ string: String) -> String {

    // Step 1 + 2: push every character
    var stack = [Character]()

    for character in string {
        stack.append(character)
    }

    // Step 3: result as [Character] — no string building in the loop
    var resultChars = [Character]()

    // Step 4: pop until empty (while condition is the crash guard)
    while stack.isEmpty == false {
        let removedCharacter = stack.removeLast()
        resultChars.append(removedCharacter)
    }

    // Step 5: ONE conversion at the end
    return String(resultChars)
}

//==========================================================
// MARK: - Testing
//==========================================================

let testCases: [(input: String, expected: String)] = [
    ("Hello", "olleH"),
    ("Swift", "tfiwS"),
    ("a", "a"),                 // single char
    ("", ""),                   // empty
    ("aba", "aba"),             // palindrome — reversal equals input
    ("ab cd", "dc ba")          // spaces reverse too
]

var testIndex = 1
for testCase in testCases {
    let result = reverseString(testCase.input)

    let status: String
    if result == testCase.expected {
        status = "✅"
    } else {
        status = "❌ got \"\(result)\""
    }

    print("Test \(testIndex) \"\(testCase.input)\" -> expected \"\(testCase.expected)\" \(status)")
    testIndex += 1
}

/*
 =========================================================
                    INTERVIEW Q&A
 =========================================================

 Q1: Why does a stack reverse things?
 A : LIFO — the last character pushed is the first popped,
     so output order is the exact reverse of input order.

 Q2: Is this the best way to reverse a string?
 A : No — two-pointer in-place reversal is O(n) time with
     O(1) extra space; this is O(n) space. The stack version
     matters because LIFO-reversal is the mechanism behind
     Decode String, RPN evaluation, and undo systems.

 Q3: Why collect into [Character] instead of appending to
     a String with += String(char)?
 A : += String(char) allocates a new String per iteration.
     Appending Characters to an array and converting once
     avoids the churn — the recurring Phase 6 trap.

 =========================================================
 */
