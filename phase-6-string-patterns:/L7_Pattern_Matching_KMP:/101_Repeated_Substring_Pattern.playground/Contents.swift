import Foundation

// MARK: - Problem
/*
 LC 459 — Repeated Substring Pattern (Easy)
 Level: L7_Pattern_Matching_KMP — Problem #101

 Given a string `s`, return true if it can be constructed by taking a
 substring of it and appending MULTIPLE copies of that substring together.

 Example 1:
   Input:  s = "abab"
   Output: true          ("ab" repeated 2x)

 Example 2:
   Input:  s = "aba"
   Output: false

 Example 3:
   Input:  s = "abcabcabc"
   Output: true          ("abc" repeated 3x)

 Edge cases:
   - "a"    -> false (multiple copies required — one copy doesn't count)
   - "aa"   -> true  ("a" x 2)
   - "abac" -> false (no single repeating unit)
   - Unit length must divide s.count evenly
*/

// MARK: - Brute Force (divisor lengths + in-place modulo verification)
/*
 For every candidate unit length len in 1...(n/2) that divides n evenly,
 verify in place: chars[i] must equal chars[i % len] for every i.
 No string building — pure index comparison.
*/

func repeatedSubstringPatternBrute(_ s: String) -> Bool {

    let chars = Array(s)
    let n = chars.count

    // A single character can never be "multiple copies"
    if n < 2 {
        return false
    }

    for len in 1...(n / 2) {

        if n % len != 0 {
            continue
        }

        // Every char must equal its position within the unit
        var isRepeated = true
        var i = len                 // first unit trivially matches itself

        while i < n {
            if chars[i] != chars[i % len] {
                isRepeated = false
                break
            }
            i += 1
        }

        if isRepeated {
            return true
        }
    }

    return false
}

// MARK: - Optimised (the s + s rotation trick)
/*
 Claim: s is built from a repeated unit
        <=> s appears inside (s + s) with the first and last chars removed.

 Why: if s = unit repeated k times (k >= 2), then rotating s by one unit
 gives back s itself. Inside s + s, that rotated copy starts at index `len`
 (0 < len < n), which survives dropping the first and last characters.
 Conversely, if s is found at index p with 0 < p < n inside s + s, then
 s is periodic with period p, and p divides... enough of the structure
 to force a repeated unit.

 The search is a direct client of #100's forward scan.
 Same family as LC 796 Rotate String (also an s + s problem).
*/

func repeatedSubstringPatternOptimised(_ s: String) -> Bool {

    let n = s.count

    if n < 2 {
        return false
    }

    let doubled = Array(s + s)
    let needleChars = Array(s)

    // Search s inside (s+s) with first and last chars dropped:
    // valid starting positions are 1...(n - 1)
    let firstStart = 1
    let lastStart = doubled.count - n - 1   // = n - 1

    var start = firstStart

    while start <= lastStart {

        var j = 0

        while j < n && doubled[start + j] == needleChars[j] {
            j += 1
        }

        if j == n {
            return true     // s found at an interior position -> repeated
        }

        start += 1
    }

    return false
}

// MARK: - Dry Run
/*
 Brute force: s = "abab", n = 4
   len = 1: 4 % 1 == 0. i=1: 'b' != chars[1%1='a'... i.e. chars[0]='a'] -> break
   len = 2: 4 % 2 == 0. i=2: chars[2]='a' == chars[0]='a' ✓
                        i=3: chars[3]='b' == chars[1]='b' ✓ -> true ✅

 Brute force: s = "aba", n = 3
   len = 1: i=1: 'b' != 'a' -> break
   (len = 2 skipped: 3 % 2 != 0; loop ends at n/2 = 1 anyway)
   -> false ✅

 Optimised: s = "abab"
   s + s = "abababab", interior starts 1...3
   start = 1: "baba" vs "abab" -> mismatch at j=0
   start = 2: doubled[2...5] = "abab" == s -> true ✅

 Optimised: s = "aba"
   s + s = "abaaba", interior starts 1...2
   start = 1: "baa" mismatch; start = 2: "aab" mismatch -> false ✅
*/

// MARK: - Complexity
/*
 Brute force:
   Time : O(n x d) where d = number of divisors of n up to n/2
          (~O(n·√n) worst case, much faster in practice)
   Space: O(n) for the char array

 Optimised (s + s with forward-scan search):
   Time : O(n²) worst case with the brute-force search
          (O(n) if the search were KMP — not needed here)
   Space: O(n) for the doubled array

 Note: "optimised" here means conceptually elegant / reusable, not strictly
 faster than brute force. Interviewers love the s + s insight; mention both.
*/

// MARK: - Traps
/*
 1. n < 2 guard missing -> 1...(n/2) becomes 1...0 -> RUNTIME CRASH on "a".
    (My original bug.)
 2. Building the repeated string with `repeated += pattern` — O(n) allocation
    churn per candidate. The modulo check chars[i] == chars[i % len] does the
    same verification in place. (My original approach — string-building trap
    again, same as #100 attempt 1.)
 3. Candidate lengths only up to n/2 — a unit longer than half can't repeat
    MULTIPLE times.
 4. Skipping the divisibility check (n % len == 0) -> false positives on
    partial units.
 5. In the s+s trick, forgetting to drop first AND last chars -> s always
    matches itself at index 0 and index n -> always returns true.
 6. Verification scan starts at i = len, not i = 0 (first unit is the unit).
*/

// MARK: - Tests
let testCases: [(input: String, expected: Bool)] = [
    ("abab", true),
    ("aba", false),
    ("abcabcabc", true),
    ("aaaa", true),
    ("a", false),           // the crash case
    ("aa", true),
    ("abac", false),
    ("abaababaab", true),   // "abaab" x 2
    ("ababab", true),
    ("abcab", false)
]

var testIndex = 1
for testCase in testCases {
    let bruteResult = repeatedSubstringPatternBrute(testCase.input)
    let optimisedResult = repeatedSubstringPatternOptimised(testCase.input)

    let bruteStatus: String
    if bruteResult == testCase.expected {
        bruteStatus = "✅"
    } else {
        bruteStatus = "❌ got \(bruteResult)"
    }

    let optimisedStatus: String
    if optimisedResult == testCase.expected {
        optimisedStatus = "✅"
    } else {
        optimisedStatus = "❌ got \(optimisedResult)"
    }

    print("Test \(testIndex) \"\(testCase.input)\": expected \(testCase.expected) | brute \(bruteStatus) | s+s \(optimisedStatus)")
    testIndex += 1
}

// MARK: - Interview Q&A
/*
 Q1: What's the core constraint on the repeating unit's length?
 A : It must divide n evenly, and it can be at most n/2 — otherwise the unit
     can't appear multiple times.

 Q2: How do you verify a candidate length without building strings?
 A : chars[i] == chars[i % len] for every i. Position i must match the
     corresponding position inside the unit. One pass, zero allocations.

 Q3: Explain the s + s trick.
 A : If s is a repeated unit, rotating s by one unit gives s back. So s
     appears inside s + s at an interior index (not 0, not n). Drop the
     first and last characters of s + s and search for s — found means true.

 Q4: Why drop the first and last characters?
 A : To exclude the two trivial matches — s at index 0 and s at index n —
     which exist for EVERY string, repeated or not.

 Q5: What's the complexity trade-off between the two approaches?
 A : Divisor + modulo scan is ~O(n·√n) and allocation-free. The s + s trick
     is O(n²) with a naive search or O(n) with KMP, and is three lines if a
     substring-search function already exists. In an interview I'd code the
     divisor scan and mention the s + s trick for elegance.

 Q6: Related problems?
 A : LC 796 Rotate String — same s + s idea (a rotation of s is always a
     substring of s + s). LC 28 provides the search primitive.

 Q7: KMP connection (concept only)?
 A : The LPS array gives an O(n) answer directly: s is a repeated pattern
     iff lps[n-1] > 0 and n % (n - lps[n-1]) == 0 — the "leftover" after
     removing the longest border is the unit length. Read-not-derived;
     mention it, don't code it.
*/
