import UIKit

// MARK: - Problem
// 84. Valid Anagram (LeetCode 242)
//
// Given two strings s and t, return true if t is an anagram of s,
// otherwise false.
//
// Anagram = same characters with the same frequencies (order differs).
//
// Example 1: s = "anagram", t = "nagaram" -> true
// Example 2: s = "rat",     t = "car"     -> false
//
// Constraints: 1 <= s.count, t.count <= 5 * 10^4, lowercase letters.
//
// Cluster note: this is the foundation check used inside #81 (LC 567),
// #82 (LC 438), and #83 (LC 49). Solved last here, but in interviews
// it usually appears FIRST as a 5-minute warm-up — expected flawless.

// MARK: - Approach 1 (Two Maps)
// Build a frequency map for each string, compare for full equality.
// T: O(n)   S: O(26) ~ O(1)
func isAnagramTwoMaps(_ s: String, _ t: String) -> Bool {

    // Different lengths can never be anagrams
    if s.count != t.count {
        return false
    }

    var sMap = [Character: Int]()
    var tMap = [Character: Int]()

    for ch in s {
        if let count = sMap[ch] {
            sMap[ch] = count + 1
        } else {
            sMap[ch] = 1
        }
    }

    for ch in t {
        if let count = tMap[ch] {
            tMap[ch] = count + 1
        } else {
            tMap[ch] = 1
        }
    }

    return sMap == tMap
}

// MARK: - Approach 2 (Single Map — increment/decrement)
// One map: +1 for each char of s, -1 for each char of t. If they are
// anagrams, every count cancels to zero and the map ends empty.
// Bonus: early exit the moment t contains a char s cannot cover.
// T: O(n)   S: O(26) ~ O(1)
func isAnagram(_ s: String, _ t: String) -> Bool {

    if s.count != t.count {
        return false
    }

    var map = [Character: Int]()

    // +1 for every char in s
    for ch in s {
        if let count = map[ch] {
            map[ch] = count + 1
        } else {
            map[ch] = 1
        }
    }

    // -1 for every char in t
    for ch in t {
        if let count = map[ch] {
            if count == 1 {
                map[ch] = nil        // cancelled — remove, never leave 0
            } else {
                map[ch] = count - 1
            }
        } else {
            return false             // t has a char s doesn't — impossible
        }
    }

    // Everything cancelled <=> anagram
    return map.isEmpty
}

// MARK: - Dry Run (Single Map)
// s = "anagram", t = "nagaram"
//
// After +1 pass over s: [a:3, n:1, g:1, r:1, m:1]
//
// -1 pass over t:
// ch | action                  | map after
// ---|-------------------------|---------------------------
// n  | 1 -> remove key         | [a:3, g:1, r:1, m:1]
// a  | 3 -> 2                  | [a:2, g:1, r:1, m:1]
// g  | 1 -> remove key         | [a:2, r:1, m:1]
// a  | 2 -> 1                  | [a:1, r:1, m:1]
// r  | 1 -> remove key         | [a:1, m:1]
// a  | 1 -> remove key         | [m:1]
// m  | 1 -> remove key         | [:]
//
// map.isEmpty -> true
//
// Counter case: s = "rat", t = "car"
// After s: [r:1, a:1, t:1]
// t: 'c' -> not in map -> return false immediately (early exit)

// MARK: - Complexity
// Both approaches: T O(n) — two linear passes. S O(26) ~ O(1) — at
// most 26 lowercase keys. Single-map halves the space constant and
// adds early exit; two-maps is more symmetric and easier to explain.

// MARK: - Traps
// 1. Length check first — without it, s = "a", t = "aa" needs the map
//    logic to catch it; with it, O(1) rejection.
// 2. Single map: delete the key at count 0 (the #81 zero-key habit) —
//    map.isEmpty is the final check, and a stale [a:0] breaks it.
// 3. Single map: the else -> return false branch handles a char in t
//    that s never had. Skipping it crashes into decrementing nil.
// 4. Do NOT sort both strings and compare — .sorted() is predefined
//    (rule), and O(n log n) loses to O(n) counting anyway.

// MARK: - Tests
let tests: [(s: String, t: String, expected: Bool)] = [
    ("anagram", "nagaram", true),
    ("rat", "car", false),           // same length, different chars
    ("a", "a", true),
    ("a", "b", false),
    ("ab", "a", false),              // length mismatch guard
    ("aab", "abb", false),           // same letters, different counts
    ("aacc", "ccac", false),         // t has extra c, missing a
    ("listen", "silent", true)
]

for test in tests {
    let twoMapsResult = isAnagramTwoMaps(test.s, test.t)
    let singleMapResult = isAnagram(test.s, test.t)
    let twoMapsStatus = twoMapsResult == test.expected ? "PASS" : "FAIL"
    let singleMapStatus = singleMapResult == test.expected ? "PASS" : "FAIL"
    print("s: \(test.s), t: \(test.t) | twoMaps: \(twoMapsResult) [\(twoMapsStatus)] | singleMap: \(singleMapResult) [\(singleMapStatus)]")
}

// MARK: - Interview Q&A
//
// Q1. Why check lengths first?
// A1. Anagrams must use every character exactly once, so unequal
//     lengths are an instant false — O(1) rejection before any work.
//
// Q2. Two maps vs one map — which do you present?
// A2. Either passes. Single map is the sharper answer: half the
//     space constant, and the -1 pass can early-exit the moment t
//     shows a character s cannot cover. Mention both, code one.
//
// Q3. Why must map.isEmpty be the final check and not "all zeros"?
// A3. Keys are deleted when their count cancels to 0. Leaving zero
//     counts in the map would force a scan for all-zeros at the end;
//     deleting keys makes the check a single O(1) isEmpty.
//
// Q4. Why not sort both strings and compare?
// A4. Works (equal sorted forms <=> anagram) but costs O(n log n) vs
//     O(n) for counting, and needs a hand-written sort under the
//     no-predefined-functions rule. Counting is strictly better here.
//
// Q5. Follow-up: what if inputs contain Unicode characters?
// A5. The dictionary approach already handles it — [Character: Int]
//     keys on any Character. Only fixed-size 26-array optimisations
//     would break. (This is the actual LC 242 follow-up question.)
//
// Q6. How does this problem relate to LC 567/438/49?
// A6. It IS the core primitive: 567 asks "does any window pass this
//     check", 438 asks "which windows pass it", 49 asks "group strings
//     by this equivalence". Master 242 and the other three are
//     structure around the same frequency comparison.
