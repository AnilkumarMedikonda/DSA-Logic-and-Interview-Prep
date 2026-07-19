import Foundation

// MARK: - 1. Problem
/*
 Basic Calculator II (LC 227, Medium) — Phase 7 follow-up, Meta staple

 Evaluate a string with + - * /, non-negative integers, and spaces.
 No parentheses. Integer division truncates toward zero.

 "3+2*2"    → 7     precedence: 2*2 resolves BEFORE the +
 " 3/2 "    → 1     truncation
 " 3+5 / 2" → 5     spaces must neither trigger nor reset

 Relation to LC 224 (Basic Calculator):
 224 = nesting, no precedence → stack of paused (result, sign) contexts
 227 = precedence, no nesting → stack of SIGNED NUMBERS
 LC 772 (Calculator III) = 227's precedence logic inside 224's freezing.
 Own both → III is assembly, not invention.
*/

// MARK: - 2. Brute Force
/*
 Skipped by design — two-pass alternatives (resolve * / into a
 rewritten token list, then sum) exist but teach nothing the
 single-pass form doesn't. The deferred-work stack IS the lesson.
*/

// MARK: - 3. Solution — stack of signed numbers  [READ-NOT-DERIVED]
/*
 ⚠️ Provenance: transcribed after explanation, / bug caught in
 review (was multiplying). Blank-file redo required (~Jul 15)
 before this counts as earned. The three things that must come
 from memory in the redo:
   1. '-' pushes a NEGATIVE — the stack absorbs signs
   2. lastSign starts as "+" — first number pushes itself
   3. end-of-string flush — the i == chars.count - 1 OR-condition

 Core idea: + and - can be DEFERRED (push signed number);
 * and / cannot (resolve immediately against the stack top).
 Final answer = sum of the stack. That IS the precedence trick.
*/
func calculate(_ s: String) -> Int {

    var stack = [Int]()
    var currentNumber = 0
    var lastSign: Character = "+"

    let chars = Array(s)

    for i in 0..<chars.count {
        let char = chars[i]

        if let digit = char.wholeNumberValue, char.isNumber {
            currentNumber = currentNumber * 10 + digit
        }

        // process pending number on operator OR end of string;
        // pure spaces trigger nothing
        if (!char.isNumber && char != " ") || i == chars.count - 1 {

            switch lastSign {
            case "+":
                stack.append(currentNumber)
            case "-":
                stack.append(-currentNumber)
            case "*":
                if let last = stack.popLast() {
                    stack.append(last * currentNumber)
                }
            case "/":
                if let last = stack.popLast() {
                    stack.append(last / currentNumber)
                }
            default:
                break
            }

            lastSign = char
            currentNumber = 0
        }
    }

    var result = 0
    for num in stack {
        result += num
    }

    return result
}

// MARK: - 4. Dry Run  ("14-3/2")
/*
 '1' → currentNumber = 1
 '4' → currentNumber = 14
 '-' → lastSign was "+" → push 14        stack=[14]
       lastSign = "-", reset
 '3' → currentNumber = 3
 '/' → lastSign was "-" → push -3        stack=[14, -3]
       lastSign = "/", reset
 '2' → currentNumber = 2, AND i == last index
     → lastSign "/" → pop -3, push -3/2 = -1   stack=[14, -1]
       (Swift truncates toward zero: -1, not -2 — matches LC spec)

 sum = 14 + (-1) = 13 ✅
 Note how the '-' became a sign ON the 3, and division then
 carried it through — subtraction never happens explicitly.
*/

// MARK: - 5. Complexity
/*
 Time:  O(n) — single pass; each number pushed once, popped ≤ once.
 Space: O(n) — worst case all additions: "1+2+3+…" fills the stack.
*/

// MARK: - 6. Traps
/*
 1. TWIN CASES DIVERGE IN ONE CHARACTER — the * and / branches are
    copy-paste twins; the / case shipped multiplying. Every branch
    needs a test only IT can satisfy. Family: run-before-paste.
 2. End-of-string flush — without the i == count-1 OR, the last
    number is never processed. Sentinel-flush family (LC 84's
    appended 0, here an index check).
 3. lastSign starts "+" — so the first number pushes itself.
 4. Spaces: must neither trigger processing nor reset state —
    " 3+5 / 2" is the probe.
 5. Truncation toward zero: 14-3/2 → -3/2 = -1 in Swift, which
    matches the LC spec. (Floor division would give -2 — wrong here.)
 6. Multi-digit: currentNumber * 10 + digit — never convert a
    lone char.
*/

// MARK: - 7. Tests — each branch has a test only it can satisfy
func check(_ label: String, _ got: Int, _ expected: Int) {
    print(got == expected ? "✅" : "❌", label, got)
}

check("* branch", calculate("3+2*2"), 7)
check("/ branch", calculate(" 3/2 "), 1)          // the bug-catcher
check("spaces + /", calculate(" 3+5 / 2"), 5)
check("negative through /", calculate("14-3/2"), 13)
check("single number", calculate("42"), 42)        // end-flush only
check("chained * /", calculate("2*3*4"), 24)
check("all subtraction", calculate("10-2-3"), 5)
check("div chain truncates", calculate("100/3/3"), 11)  // 33/3, not 11.11

// MARK: - 8. Interview Q&A
/*
 Q: Why does summing the stack at the end respect precedence?
 A: Because * / never reach the stack unresolved — they're folded
    into the top immediately. Only fully-resolved signed terms
    remain, and addition is order-independent.

 Q: Why push -currentNumber for '-' instead of subtracting?
 A: Subtraction isn't commutative — deferring it as a sign makes
    every remaining operation a plain sum. The stack absorbs signs.

 Q: Can you do O(1) space?
 A: Yes — track lastNumber instead of a stack: on * /, combine
    into lastNumber; on + -, fold lastNumber into result. The
    stack never holds more than the deferred terms, and only the
    top is ever touched. (Good follow-up to volunteer.)

 Q: Now add parentheses?
 A: LC 772 — freeze (result, sign, and this machinery) at each '('
    like LC 224, run 227's logic per depth level.

 Q: iOS bridge?
 A: NSExpression does exactly this internally; also spreadsheet-style
    formula fields and any user-entered math input validation.

 [Debt status: READ-NOT-DERIVED. Blank-file redo ~Jul 15 converts
  to earned. Related Tier 1 rotation candidate: LC 224.]
*/
