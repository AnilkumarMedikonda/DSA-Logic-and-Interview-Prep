import Foundation

/*
 =========================================================
   119 - VALID PARENTHESES (LC 20) ⭐ Blind75 
 =========================================================
 Brackets must close by type AND in order.
 "()[]{}" true · "([)]" false (order!) · "(" false · ")" false · "" true

 Why stack: most recently opened must close FIRST = LIFO.
 Counting fails on "([)]" — counts match, order doesn't.
 =========================================================
 */

//==========================================================
// MARK: - Brute Force — remove adjacent pairs, O(n²)
//==========================================================

func isValidBruteForce(_ s: String) -> Bool {

    var chars = Array(s)

    if chars.isEmpty {
        return true
    }

    var isRemoved = true

    while isRemoved {
        isRemoved = false
        var i = 0

        while i < chars.count - 1 {
            let first = chars[i]
            let second = chars[i + 1]

            if (first == "(" && second == ")") ||
               (first == "[" && second == "]") ||
               (first == "{" && second == "}") {

                chars.remove(at: i + 1)    // higher index FIRST (day-1 bug)
                chars.remove(at: i)
                isRemoved = true
                break
            }

            i += 1        // INSIDE the inner loop (cold-rewrite bug —
                          // outside = infinite loop on "(]" )
        }
    }

    return chars.isEmpty
}

//==========================================================
// MARK: - Optimised — stack, O(n) ⭐ the interview answer
//==========================================================

func isValid(_ s: String) -> Bool {

    let brackets: [Character: Character] = [")": "(", "]": "[", "}": "{"]
    var stack = [Character]()

    for char in s {
        if char == "(" || char == "[" || char == "{" {
            stack.append(char)
        } else if let expected = brackets[char] {
            if stack.popLast() != expected {    // nil pop = ")" alone = false
                return false
            }
        }
    }

    return stack.isEmpty    // "(" survives the loop — leftovers = false
}

//==========================================================
// MARK: - Traps
//==========================================================
/*
 1. Brute: remove LOWER index first → shift → wrong delete/crash.
    Fix: higher index first. (Day-1 attempt bug — retained ✅)
 2. Brute: i += 1 outside the inner loop → infinite loop on any
    non-pair like "(]". (Cold-rewrite bug — the recurring
    pointer-increment trap from Phase 6, new jacket.)
 3. Forgetting final stack.isEmpty — "(" would return true.
 4. Closer on empty stack: popLast()'s nil IS the false, not a crash.
 5. Counting instead of stacking — "([)]" kills it. Order needs LIFO.
 6. ALWAYS test the adversarial case — "([)]" would have exposed
    bug 2 immediately; testing only happy paths hides hangs.
 */

//==========================================================
// MARK: - Tests
//==========================================================

let testCases: [(String, Bool)] = [
    ("()", true),
    ("()[]{}", true),
    ("{[()]}", true),
    ("(]", false),          // the infinite-loop case for bug 2
    ("([)]", false),        // the counting-killer
    ("(", false),
    (")", false),
    ("", true)
]

var passed = 0
for (input, expected) in testCases {
    let brute = isValidBruteForce(input)
    let stack = isValid(input)

    let ok = brute == expected && stack == expected
    if ok { passed += 1 }
    print("\"\(input)\": expected \(expected) | brute \(brute) | stack \(stack) \(ok ? "✅" : "❌")")
}
print("\n\(passed)/\(testCases.count) passed")

//==========================================================
// MARK: - Interview Q&A (compressed)
//==========================================================
/*
 Why stack, not counters? → order, not quantity; "([)]" proves it.
 Empty-stack closer?      → popLast() nil ≠ opener → false. No crash path.
 Why final isEmpty?       → unclosed openers survive the loop peacefully.
 Complexity               → O(n) time, O(n) space worst case.
 Follow-ups               → LC 22 Generate, LC 32 Longest Valid,
                            LC 1249 Min Remove — same LIFO core.
 =========================================================
 */
