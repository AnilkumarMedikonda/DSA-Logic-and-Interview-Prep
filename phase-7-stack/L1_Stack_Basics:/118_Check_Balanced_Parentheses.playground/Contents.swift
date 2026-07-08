import Foundation

/*
 =========================================================
        118 - CHECK BALANCED PARENTHESES
 =========================================================

 Rough-attempt twin of 119_Valid_Parentheses (LC 20 ⭐).
 One solve, two folders: this file records the attempt and
 its bug; 119 holds the polished Blind75 playground with
 full dry run, traps, tests, and Q&A.

 ---------------------------------------------------------

 THE BUG THIS ATTEMPT TAUGHT (worth the whole folder)
 ----------------------------------------------------
 Brute force removes adjacent pairs. My original order:

     chars.remove(at: i)        // ← indices SHIFT LEFT here
     chars.remove(at: i + 1)    // ← now deletes the wrong
                                //    element, or crashes

 Proof: "()" → remove(at:0) leaves [")"] → remove(at:1)
 = INDEX OUT OF RANGE. 💥

 Rule: when removing two indices, remove the HIGHER one
 first — the lower index is unaffected by the shift.
 (Array cousin of the Phase 6 range-crash traps.)

 =========================================================
 */

//==========================================================
// MARK: - Brute Force (fixed removal order) — O(n²)
//==========================================================

func isBalancedBruteForce(_ input: String) -> Bool {

    var chars = Array(input)

    if chars.isEmpty {
        return true
    }

    var removed = true

    while removed {
        removed = false
        var i = 0

        while i < chars.count - 1 {
            let first = chars[i]
            let second = chars[i + 1]

            if (first == "(" && second == ")") ||
               (first == "[" && second == "]") ||
               (first == "{" && second == "}") {

                chars.remove(at: i + 1)    // higher index FIRST
                chars.remove(at: i)
                removed = true
                break
            }

            i += 1
        }
    }

    return chars.isEmpty
}

//==========================================================
// MARK: - Optimised (stack) — see 119 for full treatment
//==========================================================

func isBalanced(_ input: String) -> Bool {

    var stack: [Character] = []
    let brackets: [Character: Character] = [")": "(", "]": "[", "}": "{"]

    for char in input {
        if char == "(" || char == "[" || char == "{" {
            stack.append(char)
        } else if let expected = brackets[char] {
            if stack.popLast() != expected {
                return false
            }
        }   
    }

    return stack.isEmpty
}

//==========================================================
// MARK: - Tests
//==========================================================

let testCases: [(input: String, expected: Bool)] = [
    ("()", true),              // the crash case for the original bug
    ("()[]{}", true),
    ("([)]", false),
    ("(", false),
    (")", false),
    ("", true)
]

var testIndex = 1
for testCase in testCases {
    let bruteResult = isBalancedBruteForce(testCase.input)
    let stackResult = isBalanced(testCase.input)

    let status: String
    if bruteResult == testCase.expected && stackResult == testCase.expected {
        status = "✅"
    } else {
        status = "❌ brute \(bruteResult) stack \(stackResult)"
    }

    print("Test \(testIndex) \"\(testCase.input)\": expected \(testCase.expected) \(status)")
    testIndex += 1
}

// Full dry run, traps, complexity, and interview Q&A → 119_Valid_Parentheses
