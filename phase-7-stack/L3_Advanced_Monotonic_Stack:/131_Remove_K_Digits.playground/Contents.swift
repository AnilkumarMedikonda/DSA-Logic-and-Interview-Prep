import Foundation

// MARK: - Problem
// 131. Remove K Digits (LC 402) — Medium
// Remove k digits from num (non-negative integer string) so the result is
// the SMALLEST possible number. Return as string.
// "1432219", k=3 → "1219"   "10200", k=1 → "200"   "10", k=2 → "0"
//
// Key: greedy + monotonic INCREASING stack. A digit bigger than its next
// digit should die — removing a big digit from a more significant position
// always wins. Pop while top > incoming, budgeted by k.
//
// Brute force skipped: try all C(n,k) removals — exponential, not viable.

// MARK: - Optimised (Greedy + Monotonic Increasing Stack)
// T: O(n)  S: O(n)

func removeKdigits(_ num: String, _ k: Int) -> String {
    var k = k
    var stack: [Character] = []

    for digit in num {
        // Greedy pop: top > incoming and budget remains
        while k > 0, let top = stack.last, top > digit {
            stack.removeLast()
            k -= 1
        }
        stack.append(digit)
    }

    // Leftover k: input was non-decreasing — drop the LAST k digits
    while k > 0 && !stack.isEmpty {
        stack.removeLast()
        k -= 1
    }

    // Strip leading zeros in one scan (removeFirst() in a loop is O(n²))
    var start = 0
    while start < stack.count && stack[start] == "0" {
        start += 1
    }

    // All zeros or everything removed → "0"
    if start >= stack.count {
        return "0"
    }

    return String(stack[start...])
}

// MARK: - Dry Run
// "1432219", k=3
// '1' → push                        [1]
// '4' → 1>4? no → push              [1,4]
// '3' → 4>3 pop (k=2) → push        [1,3]
// '2' → 3>2 pop (k=1) → push        [1,2]
// '2' → 2>2? no (strict) → push     [1,2,2]
// '1' → 2>1 pop (k=0) → push        [1,2,1]
// '9' → k=0, no pop → push          [1,2,1,9]
// k=0, no leading zero → "1219" ✓

// MARK: - Complexity
// O(n) time — each digit pushed/popped ≤ once; zero-strip is one scan.
// O(n) space for the stack.

// MARK: - Traps
// 1. Strict > on pop: "112", k=1 → "11". With >= you'd pop the 1 → "12".
// 2. Leftover k: "12345", k=1 never pops — drain the LAST k digits after
//    the loop (biggest values in least significant spots).
// 3. Leading zeros: "10200", k=1 → stack "0200" → strip → "200".
// 4. Empty / all-zero → return "0", never "". "10", k=2 hits this.
// 5. removeFirst() in a loop is O(n) per call → O(n²) on "1000...0".
//    Scan to first non-zero, slice once: String(stack[start...]).
// 6. Character comparison works directly for digits ("9" > "1") — no Int
//    conversion needed.
// 7. `while k > 0, let top = stack.last, top > digit` — the binding
//    replaces both isEmpty and the force unwrap.

// MARK: - Tests
let cases: [(String, Int, String)] = [
    ("1432219", 3, "1219"),
    ("10200", 1, "200"),
    ("10", 2, "0"),
    ("123456", 3, "123"),      // leftover-k drain
    ("987654", 2, "7654"),
    ("100200", 1, "200"),
    ("112", 1, "11")           // strict-> diagnostic
]

for (num, k, expected) in cases {
    let output = removeKdigits(num, k)
    print("num \"\(num)\", k \(k) → \"\(output)\"  expected: \"\(expected)\"")
}

// MARK: - Interview Q&A
// Q: Why is popping when top > incoming always safe?
// A: The removed digit sits in a MORE significant position than the incoming
//    smaller digit. Replacing a bigger digit with a smaller one at higher
//    significance reduces the number regardless of what follows.
//
// Q: Why remove from the END when digits are non-decreasing?
// A: No pop ever fired, so every digit ≤ the next. The largest digits are
//    at the tail, in the least significant positions — cheapest to cut.
//
// Q: How does this differ from 126–129's stacks?
// A: The pop condition serves a GREEDY objective (minimise the number), not
//    a structural one (collision, boundary, context). Same mechanics,
//    different proof obligation — you must argue the greedy choice is safe.
//
// Q: Related problems?
// A: LC 316 Remove Duplicate Letters, LC 321 Create Maximum Number — same
//    greedy-stack family with added constraints.
