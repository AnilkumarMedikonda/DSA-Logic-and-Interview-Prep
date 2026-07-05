import Foundation

// MARK: - Problem
/*
 LC 214 — Shortest Palindrome (Hard)
 Level: L7_Pattern_Matching_KMP — Problem #102

 ⚠️ STATUS: Covered previously in the palindrome cluster (Phase 6).
 This file exists for repo completeness. Solution is READ-NOT-DERIVED —
 cold rewrite is NOT an interview target. Deliverable = concept explanation.

 Given a string `s`, convert it to a palindrome by adding characters
 IN FRONT of it. Return the shortest palindrome you can make.

 Example 1:
   Input:  s = "aacecaaa"
   Output: "aaacecaaa"     (prepend "a")

 Example 2:
   Input:  s = "abcd"
   Output: "dcbabcd"       (prepend "dcb")

 Core insight: the answer is determined by the LONGEST PALINDROMIC PREFIX
 of s. Whatever isn't part of that prefix must be reversed and prepended.
*/

// MARK: - Brute Force (concept only)
/*
 For k from n down to 1: check if s[0..<k] is a palindrome (converging
 two-pointer check). First k that works -> prepend reversed(s[k...]).
 Time O(n²) worst case. Acceptable to describe; KMP version below is the
 canonical solution.
*/

// MARK: - Optimised (KMP / LPS on s + "#" + reversed(s)) — READ-NOT-DERIVED
/*
 Trick: build combined = s + "#" + reversed(s).
 The LPS value at the LAST index of combined = length of the longest
 palindromic PREFIX of s.

 Why it works:
   - A prefix of s that is also a suffix of reversed(s) is a prefix that
     reads the same forwards and backwards -> a palindromic prefix.
   - LPS at the last position finds exactly the longest such overlap.
   - The "#" separator (a char not in s) caps the border so it can never
     exceed s's true length (e.g. s = "aaaa" would otherwise over-match).

 Answer = reversed(leftover suffix) + s.
*/

func shortestPalindrome(_ s: String) -> String {

    let n = s.count

    if n < 2 {
        return s
    }

    let sChars = Array(s)

    // Build reversed(s) manually — no .reversed()
    var reversedChars = [Character]()
    var readIndex = n - 1
    while readIndex >= 0 {
        reversedChars.append(sChars[readIndex])
        readIndex -= 1
    }

    // combined = s + "#" + reversed(s)
    var combined = [Character]()
    for char in sChars {
        combined.append(char)
    }
    combined.append("#")
    for char in reversedChars {
        combined.append(char)
    }

    // Standard LPS build on combined (same as #100's KMP Step 1)
    var lps = [Int](repeating: 0, count: combined.count)
    var length = 0
    var index = 1

    while index < combined.count {
        if combined[index] == combined[length] {
            length += 1
            lps[index] = length     // store border LENGTH (trap from #100)
            index += 1
        } else {
            if length > 0 {
                length = lps[length - 1]    // fall back — do NOT advance index
            } else {
                lps[index] = 0
                index += 1
            }
        }
    }

    // Longest palindromic prefix length of s
    let palindromePrefixLength = lps[combined.count - 1]

    // Prepend reversed(leftover suffix)
    var result = [Character]()
    var suffixIndex = n - 1
    while suffixIndex >= palindromePrefixLength {
        result.append(sChars[suffixIndex])
        suffixIndex -= 1
    }
    for char in sChars {
        result.append(char)
    }

    return String(result)
}

// MARK: - Dry Run
/*
 s = "abcd"
   reversed = "dcba"
   combined = "abcd#dcba"
   LPS of combined ends at value 1 ("a" prefix == "a" suffix)
   palindromePrefixLength = 1 -> leftover = "bcd" -> prepend "dcb"
   result = "dcbabcd" ✅

 s = "aacecaaa"
   combined = "aacecaaa#aaacecaa"
   LPS last value = 7 ("aacecaa" is the longest palindromic prefix)
   leftover = "a" -> prepend "a" -> "aaacecaaa" ✅
*/

// MARK: - Complexity
/*
 Time : O(n) — one LPS pass over a string of length 2n + 1
 Space: O(n) — combined array + LPS array
*/

// MARK: - Traps
/*
 1. Forgetting the "#" separator — border can overflow past s's length on
    inputs like "aaaa", producing a palindromic-prefix length > n.
 2. lps[index] = length, not = index (same trap as #100 cold rewrite).
 3. LPS fallback branch must not advance index (same trap as #100).
 4. Prepending the suffix un-reversed — must reverse the leftover.
 5. Characters can only be added IN FRONT — appending is a different
    (easier) problem.
*/

// MARK: - Tests
let testCases: [(input: String, expected: String)] = [
    ("aacecaaa", "aaacecaaa"),
    ("abcd", "dcbabcd"),
    ("", ""),
    ("a", "a"),
    ("aa", "aa"),
    ("ba", "aba"),
    ("racecar", "racecar")      // already a palindrome
]

var testIndex = 1
for testCase in testCases {
    let result = shortestPalindrome(testCase.input)

    let status: String
    if result == testCase.expected {
        status = "✅"
    } else {
        status = "❌ got \(result)"
    }

    print("Test \(testIndex) \"\(testCase.input)\": expected \"\(testCase.expected)\" \(status)")
    testIndex += 1
}

// MARK: - Interview Q&A
/*
 Q1: What determines the shortest palindrome?
 A : The longest palindromic prefix of s. Everything after it must be
     reversed and prepended.

 Q2: How does KMP find the longest palindromic prefix?
 A : Build s + "#" + reversed(s). The LPS value at the last index is the
     longest prefix of s that is also a suffix of reversed(s) — which is
     exactly a prefix that reads the same both ways.

 Q3: Why the "#" separator?
 A : It's a character that can't appear in s, so the computed border can
     never spill across the boundary and exceed s's real length.

 Q4: Non-KMP alternative?
 A : Shrink k from n: converging two-pointer palindrome check on s[0..<k],
     O(n²) worst case. Fine to offer; KMP is the O(n) answer.

 Q5: Would you code this in an interview?
 A : This is a Hard whose difficulty is entirely KMP internals. I'd explain
     the combined-string insight and the LPS mechanism; coding it cold is
     not the expectation at product companies, and I'd say so candidly if
     pushed on time.
*/
