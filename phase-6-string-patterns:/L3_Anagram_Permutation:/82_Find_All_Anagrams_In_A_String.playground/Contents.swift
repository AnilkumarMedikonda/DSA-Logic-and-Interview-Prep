import UIKit

// MARK: - Problem
// 82. Find All Anagrams in a String (LeetCode 438)
//
// Given two strings s and p, return an array of ALL start indices of
// p's anagrams in s. Return the answer in any order (ascending falls
// out naturally from left-to-right sliding).
//
// An anagram = any rearrangement of p's characters (same as a
// permutation in #81). So we are NOT searching for specific strings —
// we check: does a window of length p.count in s have the exact same
// character frequency map as p? If yes, record the window's START index.
//
// Example 1: s = "cbaebabacd", p = "abc" -> [0, 6]
//            index 0: "cba", index 6: "bac"
// Example 2: s = "abab", p = "ab" -> [0, 1, 2]
//            "ab", "ba", "ab" — overlapping matches all count
//
// Constraints: 1 <= s.count, p.count <= 3 * 10^4, lowercase letters.
//
// Relationship to #81 (LC 567): identical fixed-size sliding window.
// #81 returns true on the FIRST match; #82 appends the start index on
// EVERY match and returns the full list. Classic interview chain:
// solve 567, then "now return all indices" = 438.

// MARK: - Brute Force
// For every start index in s, build a window map capped at p.count
// characters and compare with p's map. Append i on match.
// T: O(n * m * 26)   S: O(26) ~ O(1)
// n = s.count, m = p.count
func findAnagramsBruteForce(s: String, p: String) -> [Int] {

    var pMap = [Character: Int]()
    var result = [Int]()

    if p.count > s.count { return result }

    // Map the PATTERN once
    for char in p {
        if let count = pMap[char] {
            pMap[char] = count + 1
        } else {
            pMap[char] = 1
        }
    }

    // Slide over the SEARCH string
    let words = Array(s)

    for i in 0..<words.count {

        var windowMap = [Character: Int]()

        for j in i..<words.count {

            // Stop growing BEFORE adding — window longer than the
            // pattern can never match
            if j - i + 1 > p.count { break }

            let char = words[j]
            if let count = windowMap[char] {
                windowMap[char] = count + 1
            } else {
                windowMap[char] = 1
            }

            if windowMap == pMap {
                result.append(i)   // start index, keep scanning other starts
            }
        }
    }

    return result
}

// MARK: - Optimised (Fixed-Size Sliding Window)
// Consecutive windows differ by only 2 characters — one enters on the
// right, one leaves on the left. Maintain ONE window map and update it
// per slide. On a match, append the window's START (= left) and KEEP
// sliding — never return early, matches can overlap.
// T: O(26 * n)   S: O(26) ~ O(1)
func findAnagramsOptimised(s: String, p: String) -> [Int] {

    if p.count > s.count { return [] }

    // Map the PATTERN once
    var pMap = [Character: Int]()
    var result = [Int]()

    for char in p {
        if let count = pMap[char] {
            pMap[char] = count + 1
        } else {
            pMap[char] = 1
        }
    }

    // Slide over the SEARCH string
    let words = Array(s)

    var windowMap = [Character: Int]()
    var left = 0

    for right in 0..<words.count {

        // 1. Add the entering char
        let char = words[right]
        if let count = windowMap[char] {
            windowMap[char] = count + 1
        } else {
            windowMap[char] = 1
        }

        // 2. Shrink when window exceeds PATTERN LENGTH
        while right - left + 1 > p.count {
            let leftChar = words[left]
            if let count = windowMap[leftChar] {
                if count == 1 {
                    windowMap[leftChar] = nil   // remove key, never leave 0
                } else {
                    windowMap[leftChar] = count - 1
                }
            }
            left += 1
        }

        // 3. Compare full maps — on match, append the START index
        if windowMap == pMap {
            result.append(left)   // NOT right — left is the window start
        }
    }

    return result
}

// MARK: - Dry Run
// s = "cbaebabacd", p = "abc" -> pMap = [a:1, b:1, c:1], window size 3
//
// right | char | window (left...right) | windowMap        | match? | append
// ------|------|-----------------------|------------------|--------|-------
//   0   |  c   | "c"                   | [c:1]            |  no    |
//   1   |  b   | "cb"                  | [c:1, b:1]       |  no    |
//   2   |  a   | "cba"                 | [c:1, b:1, a:1]  |  YES   | left = 0
//   3   |  e   | "bae" (drop c)        | [b:1, a:1, e:1]  |  no    |
//   4   |  b   | "aeb" (drop b)        | [a:1, e:1, b:1]  |  no    |
//   5   |  a   | "eba" (drop a)        | [e:1, b:1, a:1]  |  no    |
//   6   |  b   | "bab" (drop e)        | [b:2, a:1]       |  no    |
//   7   |  a   | "aba" (drop b)        | [a:2, b:1]       |  no    |
//   8   |  c   | "bac" (drop a)        | [b:1, a:1, c:1]  |  YES   | left = 6
//   9   |  d   | "acd" (drop b)        | [a:1, c:1, d:1]  |  no    |
//
// result = [0, 6]
//
// Overlap case: s = "abab", p = "ab" -> matches at left = 0, 1, 2 —
// windows share characters; the slide moves ONE step after every
// match, never jumps ahead. result = [0, 1, 2].

// MARK: - Complexity
// Brute force: O(n * m * 26) time — n start indices, up to m chars per
//   window, map comparison bounded by 26 letters. Space O(26).
// Optimised:   O(26 * n) time — one add + at most one remove per
//   slide, comparison bounded by 26 letters. Space O(26) ~ O(1).

// MARK: - Traps
// 1. append(right) instead of append(left): records the window's END,
//    not its START. Gives [2, 8] instead of [0, 6]. At compare time
//    the window spans left...right — the start is left
//    (equivalently right - p.count + 1).
// 2. Returning on first match: #81 habit. #82 needs ALL matches —
//    append and KEEP sliding.
// 3. Overlapping matches: never skip ahead after a match ("abab"/"ab"
//    -> [0, 1, 2]). The one-step slide handles this automatically.
// 4. Stale zero keys: remove the key when a leaving char's count hits
//    0, or map equality silently fails forever after.
// 5. Guard returns [] (empty array), not false — the return type
//    changed from #81.
// 6. Brute force break must come BEFORE adding the char, else one
//    wasted add per start index.
// 7. Roles: p is the PATTERN (mapped once), s is the SEARCH string
//    (slide over it). Guard is p.count > s.count.

// MARK: - Tests
var s = "cbaebabacd"
var p = "abc"

let tests: [(s: String, p: String, expected: [Int])] = [
    ("cbaebabacd", "abc", [0, 6]),     // two separated matches
    ("abab", "ab", [0, 1, 2]),         // overlapping matches
    ("a", "a", [0]),                   // single char match
    ("a", "b", []),                    // single char no match
    ("ab", "abc", []),                 // pattern longer than search string
    ("aaaa", "aa", [0, 1, 2]),         // duplicate chars, all overlapping
    ("baa", "aa", [1]),                // match at the very end
    ("abcdefg", "hij", [])             // no common characters
]

for test in tests {
    let bruteResult = findAnagramsBruteForce(s: test.s, p: test.p)
    let optimisedResult = findAnagramsOptimised(s: test.s, p: test.p)
    let bruteStatus = bruteResult == test.expected ? "PASS" : "FAIL"
    let optimisedStatus = optimisedResult == test.expected ? "PASS" : "FAIL"
    print("s: \(test.s), p: \(test.p) | brute: \(bruteResult) [\(bruteStatus)] | optimised: \(optimisedResult) [\(optimisedStatus)]")
}

// MARK: - Interview Q&A
//
// Q1. How does this differ from Permutation in String (LC 567)?
// A1. Same fixed-size sliding window and frequency comparison. 567
//     returns a Bool on the first match; 438 collects the start index
//     of every match and returns [Int]. Interviewers commonly chain
//     them: solve 567, then extend to 438.
//
// Q2. Why append left and not right on a match?
// A2. The problem asks for START indices. At compare time the window
//     spans left...right, so the start is left. Appending right gives
//     end indices — [2, 8] instead of [0, 6] on the main example.
//
// Q3. How are overlapping anagrams handled?
// A3. Automatically. The window advances one position per iteration
//     and every position is compared, so overlapping windows like
//     "ab", "ba", "ab" in "abab" are each checked independently.
//
// Q4. Why must a key be deleted when its count reaches 0?
// A4. Swift dictionary equality compares key sets and values. A stale
//     [e:0] entry makes windowMap != pMap even when real frequencies
//     match, so every later match is silently missed.
//
// Q5. How would you reduce the O(26) comparison per slide to O(1)?
// A5. Maintain a matches counter over the distinct letters (the
//     formed/required idea from Minimum Window Substring). Only the
//     entering and leaving characters can change match status, so
//     update the counter for at most 2 letters per slide and check
//     matches == required instead of comparing whole maps. Overall
//     time drops from O(26 * n) to O(n).
//
// Q6. What is the complexity of the optimised solution?
// A6. Time O(26 * n): O(1) map updates per slide plus a comparison
//     bounded by 26 lowercase letters. Space O(26) ~ O(1) for the two
//     maps plus O(k) for the output array (k = number of matches).
