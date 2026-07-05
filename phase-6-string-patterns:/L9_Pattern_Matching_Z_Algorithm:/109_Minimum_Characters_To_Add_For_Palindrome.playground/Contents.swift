import Foundation

// MARK: - Problem
/*
 Minimum Characters To Add (in front) For Palindrome — #109
 ⚠️ SKIPPED — this is #102 (LC 214 Shortest Palindrome) asking for the
 COUNT instead of the STRING. Same insight, same LPS construction.
 Repo completeness file; solution lifted from #102.

 "abcd" -> 3 (prepend "dcb")  |  "aacecaaa" -> 1  |  "aba" -> 0
*/

// MARK: - Optimised — reference (see #102 for the annotated version)
/*
 answer = s.count - (longest palindromic prefix of s)
 Longest palindromic prefix = LPS last value of s + "#" + reversed(s).
*/

func minCharsForPalindrome(_ s: String) -> Int {

    let n = s.count

    if n < 2 {
        return 0
    }

    let sChars = Array(s)

    var combined = [Character]()
    for char in sChars {
        combined.append(char)
    }
    combined.append("#")

    var readIndex = n - 1
    while readIndex >= 0 {
        combined.append(sChars[readIndex])
        readIndex -= 1
    }

    var lps = [Int](repeating: 0, count: combined.count)
    var length = 0
    var index = 1

    while index < combined.count {
        if combined[index] == combined[length] {
            length += 1
            lps[index] = length
            index += 1
        } else {
            if length > 0 {
                length = lps[length - 1]
            } else {
                lps[index] = 0
                index += 1
            }
        }
    }

    let palindromePrefixLength = lps[combined.count - 1]

    return n - palindromePrefixLength
}

// MARK: - Traps
/*
 1. Identical to #102's: missing "#" separator lets the border overflow
    (e.g. "aaaa" reports a prefix longer than n).
 2. Characters go IN FRONT only — appending is a different problem.
 3. Answer relation: count = n - palindromicPrefixLength; returning the
    prefix length itself is the off-by-concept mistake.
*/

// MARK: - Tests
let testCases: [(String, Int)] = [
    ("abcd", 3),
    ("aacecaaa", 1),
    ("aba", 0),
    ("", 0),
    ("a", 0),
    ("ba", 1),
    ("aaaa", 0)
]

for (input, expected) in testCases {
    let result = minCharsForPalindrome(input)
    let status: String
    if result == expected {
        status = "✅"
    } else {
        status = "❌ got \(result)"
    }
    print("\"\(input)\": expected \(expected) \(status)")
}

// MARK: - Interview Q&A (the deliverable)
/*
 Same as #102, one sentence:
 "Find the longest palindromic prefix via the LPS of s + '#' + reversed(s);
  everything after that prefix must be mirrored in front, so the answer is
  n minus that prefix length."
*/
