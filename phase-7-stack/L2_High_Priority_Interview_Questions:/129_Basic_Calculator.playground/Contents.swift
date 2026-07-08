import UIKit

// MARK: - Problem
// 129. Basic Calculator (LC 224) — Hard
// Evaluate a valid expression string: digits, +, -, (, ), spaces.
// Multi-digit numbers; '-' can be unary (-(2+3), -2). No eval-style built-ins.
// "1 + 1" → 2   "(1+(4+5+2)-3)+(6+8)" → 23   "2-(5-6)" → 3
//
// Key: evaluate left-to-right with running result + sign. A '(' PAUSES the
// current context — the stack holds paused (result, sign) pairs, not operands.
// Interview note: LC 227 (Calculator II, Meta staple) is a variant of this.

// MARK: - Optimised (Stack of Paused Contexts)
// State: result (running total), number (multi-digit accumulator),
// sign (+1/-1), stack (paused result & sign around each '(').
// T: O(n)  S: O(n) — stack depth = nesting depth
func calculate(_ s: String) -> Int {
    var result = 0
    var number = 0
    var sign = 1

    var stack: [Int] = []

    for char in s {
        // Build multi-digit number — flush only on non-digit
        if let digit = char.wholeNumberValue {
            number = number * 10 + digit
        }
        else if char == "+" {
            result += sign * number
            number = 0
            sign = 1
        }
        else if char == "-" {
            result += sign * number
            number = 0
            sign = -1
        }
        else if char == "(" {
            // Pause: save context, then reset for the sub-expression
            stack.append(result)
            stack.append(sign)
            result = 0
            sign = 1
        }
        else if char == ")" {
            // Complete pending number, then unwind (reverse of push order)
            result += sign * number
            number = 0

            let previousSign = stack.removeLast()
            let previousResult = stack.removeLast()
            result = previousResult + previousSign * result
        }
        else {
            continue    // spaces
        }
    }

    // Last number never meets an operator — final flush
    result += sign * number

    return result
}

// MARK: - Dry Run
// "2-(5-6)"
// '2' → number 2
// '-' → flush: result 2, sign → -1
// '(' → push 2, push -1; reset result 0, sign 1     stack [2, -1]
// '5' → number 5
// '-' → flush: result 5, sign → -1
// '6' → number 6
// ')' → flush: result 5 + (-1)(6) = -1
//       pop sign -1, pop result 2 → result = 2 + (-1)(-1) = 3
// end → number 0, no-op flush
// Result: 3 ✓

// MARK: - Complexity
// O(n) time — single pass. O(n) space — stack grows with paren nesting depth.

// MARK: - Traps
// 1. Multi-digit: number = number*10 + digit; flush result += sign*number
//    only on a NON-digit — flushing per digit breaks "100".
// 2. End-of-string: last number has no trailing operator — flush after loop.
// 3. Pop order = reverse of push order: pushed result then sign, so pop
//    sign FIRST. Swapping them breaks "2-(5-6)".
// 4. Sign before '(' must ride the stack: "2-(5-6)" — the minus applies to
//    the whole sub-result via previousSign, not lost on reset.
// 5. Unary minus works for free: "-(2+3)" — number is 0, so the flush on
//    '-' is a no-op and only sign flips.
// 6. `if let digit = char.wholeNumberValue` — one binding replaces
//    isNumber + force-unwrapped Int(String(char)).
// 7. removeLast() on ')' relies on LC's valid-expression guarantee —
//    say this in the interview; production code would guard.

// MARK: - Tests
let cases: [(String, Int)] = [
    ("1 + 1", 2),
    (" 2-1 + 2 ", 3),
    ("(1+(4+5+2)-3)+(6+8)", 23),
    ("10-(2+3)", 5),
    ("100", 100),                 // multi-digit + end-of-string flush
    ("(7)-(0)+(4)", 11),
    ("2-(5-6)", 3),               // sign-capture trap
    ("-(2+3)", -5)                // unary minus
]

for (expression, expected) in cases {
    let output = calculate(expression)
    print("\"\(expression)\" → \(output)  expected: \(expected)")
}

// MARK: - Interview Q&A
// Q: What does the stack hold, and why not operands?
// A: Paused contexts — the (result, sign) accumulated before each '('.
//    Operands are folded into `result` immediately; only the outer context
//    needs remembering until the matching ')'.
//
// Q: How is unary minus handled without special-casing?
// A: sign defaults to 1 and number to 0. A leading '-' flushes 0 (no-op)
//    and sets sign = -1 — the same code path as binary minus.
//
// Q: How would you extend to * and / (LC 227)?
// A: Track a lastNumber and the previous operator; on * or /, combine with
//    lastNumber immediately (precedence), deferring only + and - to result.
//
// Q: Recursive alternative?
// A: Recurse on '(' returning (value, consumed index) — same O(n), but the
//    explicit stack avoids deep call stacks on heavy nesting.
