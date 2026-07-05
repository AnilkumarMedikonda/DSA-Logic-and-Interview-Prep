import Foundation

// MARK: - Problem
/*
 LC 38 — Count and Say (Medium)
 Frequency: Very High (Meta, Amazon) — string simulation / run-length encoding pattern

 The count-and-say sequence is defined recursively:
   countAndSay(1) = "1"
   countAndSay(n) = the "spoken" run-length encoding of countAndSay(n - 1)

 To "say" a string, scan groups of identical consecutive digits and
 append count followed by the digit:
   n = 1 → "1"
   n = 2 → read "1"    → one 1              → "11"
   n = 3 → read "11"   → two 1s             → "21"
   n = 4 → read "21"   → one 2, one 1       → "1211"
   n = 5 → read "1211" → one 1, one 2, two 1s → "111221"

 Constraints: 1 <= n <= 30
 Return the nth term of the sequence.
*/

// MARK: - Shared Helper (Say / Run-Length Speak)
/*
 Given a digit string, produce its spoken form.
 Forward scan with a run counter:
   - Fix the current character.
   - Inner while loop advances i across the entire run, counting.
   - Append count, then the character.
 The inner loop moving i is what guarantees the outer loop terminates.
*/
func say(_ s: String) -> String {
    let chars = Array(s)
    var result = ""
    var i = 0

    while i < chars.count {
        let currentChar = chars[i]
        var count = 0

        // Count the full run of currentChar; i lands on the next different char
        while i < chars.count && chars[i] == currentChar {
            count += 1
            i += 1
        }

        result += String(count)
        result.append(currentChar)
    }

    return result
}

// MARK: - Brute Force (Recursive, Top-Down)
/*
 Direct translation of the definition:
   countAndSay(n) = say(countAndSay(n - 1))
 Recursion depth = n (max 30, safe).
 Same total work as the iterative version, but carries call-stack overhead.
*/
func countAndSayBrute(_ n: Int) -> String {
    if n == 1 {
        return "1"
    }

    let previous = countAndSayBrute(n - 1)
    return say(previous)
}

// MARK: - Optimised (Iterative, Bottom-Up)
/*
 Same simulation without recursion: start at "1" and apply say()
 exactly (n - 1) times. 1..<n is empty when n = 1, so the base case
 needs no separate guard. No asymptotic improvement exists — the
 output itself grows exponentially, so any correct solution must do
 this much work.
*/
func countAndSay(_ n: Int) -> String {
    var result = "1"

    for _ in 1..<n {
        result = say(result)
    }

    return result
}

// MARK: - Dry Run
/*
 Big picture for countAndSay(5):
   n=1: "1"
   n=2: say("1")    → one 1               → "11"
   n=3: say("11")   → two 1s              → "21"
   n=4: say("21")   → one 2, one 1        → "1211"
   n=5: say("1211") → one 1, one 2, two 1s → "111221"

 Detailed trace of say("1211") → expected "111221":

 Setup: chars = ["1","2","1","1"], result = "", i = 0, chars.count = 4

 RUN 1 (i = 0):
   currentChar = "1", count = 0
   chars[0] = "1" == "1" ✅ → count = 1, i = 1
   chars[1] = "2" != "1" ❌ → inner loop stops
   append "1" (count) + "1" (char) → result = "11"        (one 1)

 RUN 2 (i = 1):
   currentChar = "2", count = 0
   chars[1] = "2" == "2" ✅ → count = 1, i = 2
   chars[2] = "1" != "2" ❌ → inner loop stops
   append "1" + "2" → result = "1112"                     (one 2)

 RUN 3 (i = 2):
   currentChar = "1", count = 0
   chars[2] = "1" == "1" ✅ → count = 1, i = 3
   chars[3] = "1" == "1" ✅ → count = 2, i = 4
   i = 4, i < 4 fails ❌ → inner loop stops
   append "2" + "1" → result = "111221"                   (two 1s)

 Outer check: i = 4, 4 < 4 is false → outer loop ends
 return "111221" ✅

 Note RUN 3: the inner loop ran twice — the only run with count > 1.
 The inner loop is your finger sliding across identical digits.
*/

// MARK: - Complexity
/*
 Let L(k) = length of the kth term. Each term is roughly 1.3x the
 previous (Conway's constant ≈ 1.303), so lengths grow exponentially.

 Time:  O(L(1) + L(2) + ... + L(n)) — dominated by the last term,
        i.e. exponential in n. Commonly stated as O(2^n) upper bound.
        This is unavoidable: the answer itself is that long.
 Space: O(L(n)) for the result string (plus O(n) stack in the
        recursive version — the iterative version avoids that).
*/

// MARK: - Traps
/*
 1. Infinite loop: forgetting i += 1 inside the run-counting while
    loop. The inner loop MUST advance i past the whole run.
 2. Last run not flushed: solutions that compare chars[i] with
    chars[i + 1] often drop the final group. The fix-the-char +
    inner-while structure used here flushes every run inside the loop.
 3. LC 443 confusion: in String Compression you skip the count when
    a run has length 1. Here you ALWAYS write the count — "1" becomes
    "11", not "1".
 4. Reading digits as numbers: "say" works on characters, not numeric
    values. Compare Characters directly; only the count is converted
    via String(count).
 5. Off-by-one in the iterative loop: n = 1 must return "1" without
    entering the loop. 1..<n handles this for free (empty range when
    n = 1); a 2...n range would crash for n < 2 and need a guard.
*/

// MARK: - Tests
func runTests() {
    let expected: [Int: String] = [
        1: "1",
        2: "11",
        3: "21",
        4: "1211",
        5: "111221",
        6: "312211"
    ]

    var testNumbers: [Int] = []
    for key in expected.keys {
        testNumbers.append(key)
    }

    for n in testNumbers {
        if let want = expected[n] {
            let gotBrute = countAndSayBrute(n)
            let gotOptimised = countAndSay(n)

            if gotBrute == want && gotOptimised == want {
                print("✅ n = \(n) → \(gotOptimised)")
            } else {
                print("❌ n = \(n) → brute: \(gotBrute), optimised: \(gotOptimised), expected: \(want)")
            }
        }
    }

    // Growth sanity check
    let term10 = countAndSay(10)
    print("n = 10 → length \(term10.count): \(term10)")
}

runTests()

// MARK: - Validation 2: Decode Round-Trip + Property Checks
/*
 Stronger than the fixed table: if say(previous) = current, then decoding
 current must rebuild previous exactly.
 IMPORTANT: Count and Say strings are ALL digits, so RLE-style decoding
 ("consume digits until a letter") fails — the digit loop swallows the
 whole string. Decode must read strict PAIRS: chars[i] = count,
 chars[i+1] = character. Safe because counts never exceed 3 (single
 digit, see Q4) — this decode is itself a use of that property.
 Also checks two known properties of the sequence:
   - only digits 1, 2, 3 ever appear
   - no run is longer than 3 (a longer run means the previous say()
     failed to merge — exactly what the extra i += 1 bug produces)
 Validates every term up to n without hardcoding any answers.
*/
func decodeSaid(_ s: String) -> String {
    let chars = Array(s)
    var result = ""
    var i = 0

    // Strict pairs: chars[i] = count (single digit), chars[i+1] = char
    while i + 1 < chars.count {
        let ch = chars[i + 1]

        if let count = chars[i].wholeNumberValue {
            var k = 0
            while k < count {
                result.append(ch)
                k += 1
            }
        }

        i += 2
    }

    return result
}

func validateCountAndSay(upTo n: Int) {
    var previous = "1"
    var term = 2

    while term <= n {
        let current = say(previous)

        // Check 1: round-trip — decoding current must give back previous
        let decoded = decodeSaid(current)
        if decoded != previous {
            print("❌ n=\(term): decode(\"\(current)\") = \"\(decoded)\", expected \"\(previous)\"")
            return
        }

        // Check 2: only digits 1, 2, 3 ever appear
        for ch in current {
            if ch != "1" && ch != "2" && ch != "3" {
                print("❌ n=\(term): illegal digit \(ch) in \"\(current)\"")
                return
            }
        }

        // Check 3: no run longer than 3
        let runChars = Array(current)
        var j = 0
        while j < runChars.count {
            let runChar = runChars[j]
            var runLen = 0
            while j < runChars.count && runChars[j] == runChar {
                runLen += 1
                j += 1
            }
            if runLen > 3 {
                print("❌ n=\(term): run of \(runLen) x \(runChar) in \"\(current)\"")
                return
            }
        }

        previous = current
        term += 1
    }

    print("✅ all terms up to n=\(n) passed round-trip + property checks")
    print("   final term length: \(previous.count)")
}

validateCountAndSay(upTo: 20)

// MARK: - Interview Q&A
/*
 Q1. Can this be done faster than simulation?
 A1. No. The nth term has exponential length, so just writing the
     output is exponential. Simulation is optimal.

 Q2. Recursive vs iterative — which do you prefer and why?
 A2. Iterative. Same work, no call stack, and the say() helper keeps
     it just as readable. Recursion is fine here (depth ≤ 30) but
     adds nothing.

 Q3. How does this relate to run-length encoding?
 A3. say() IS run-length encoding with counts always written. LC 443
     (String Compression) is the in-place variant that omits count 1.
     Same run-counting skeleton: fix char, inner loop counts and
     advances, flush count + char.

 Q4. Why does every term contain only digits 1, 2, 3?
 A4. A run of 4+ identical digits can never form: it would imply the
     previous term described something like "two 2s, two 2s" written
     "2222", but that description would have been merged into "four
     2s" (i.e., the previous say() already collapsed the run). This
     is a classic follow-up — the digits never exceed 3 after n = 1.

 Q5. Follow-up: decode a said string back to the original?
 A5. Read pairs (count, digit) and expand. Ambiguity note: multi-digit
     counts can't occur in this sequence (max digit is 3), so pairwise
     reading is safe here, but general RLE decoding needs delimiters
     or a defined count width.
*/
