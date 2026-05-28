import Foundation

// ──────────────────────────────────────────
// LeetCode 567 — Permutation In String
// Difficulty: Medium  |  Pattern: Sliding Window
// ──────────────────────────────────────────


// MARK: - Problem

/*
 Given s1 and s2, return true if s2 contains a permutation of s1.

 Input:  s1 = "ab",  s2 = "eidbaooo"  →  true  ("ba" at index 3)
 Input:  s1 = "ab",  s2 = "eidboaoo"  →  false

 Key insight:
 Permutation = same char frequencies, any order
 Find window in s2 of size s1.count with same frequency map as s1
*/


// MARK: - Interview Q&A

/*
 Q: What is a permutation?
 A: Same characters in any order — same frequency map

 Q: Why fixed window size?
 A: Permutation must have exactly same length as s1

 Q: Why if not while when shrinking?
 A: Window grows by 1 each step — only ever 1 element to remove

 Q: Why remove key when count hits 0?
 A: Empty key inflates map size — must remove for correct comparison

 Q: Time and space?
 A: O(n) time — each char added and removed once | O(1) space — max 26 chars
*/


// MARK: - Brute Force  O(n×m) time  O(1) space

/*
 Strategy:
 - Build s1Map from s1
 - Slide window of size s1.count over s2
 - Compare s2Map with s1Map at each window
 - If equal → return true

 INTERVIEW: Start here, explain before coding
*/

func bruteForce(_ s1: String, _ s2: String) -> Bool {

    let words = Array(s2)
    var s1Map = [Character: Int]()

    for ch in s1 {

        if let count = s1Map[ch] {
            s1Map[ch] = count + 1
        } else {
            s1Map[ch] = 1
        }
    }

    for i in 0..<words.count {

        var s2Map = [Character: Int]()

        for j in i..<words.count {

            let ch = words[j]

            if let count = s2Map[ch] {
                s2Map[ch] = count + 1
            } else {
                s2Map[ch] = 1
            }

            if j - i + 1 == s1.count {

                if s1Map == s2Map {
                    return true
                }

                break
            }
        }
    }

    return false
}


// MARK: - Optimal ⭐️  O(n) time  O(1) space

/*
 Strategy:
 - Build s1Map from s1
 - Expand right → add to s2Map
 - if window > s1.count → shrink left
   → decrement count, if 0 remove key, left++
 - when window size == s1.count and s1Map == s2Map → true

 INTERVIEW: Fixed window size = s1.count
 INTERVIEW: if not while — window grows by 1 each step
 INTERVIEW: Remove key when count 0 — keeps map comparison accurate
*/

func optimised(_ s1: String, _ s2: String) -> Bool {

    let words = Array(s2)
    var s1Map = [Character: Int]()
    var s2Map = [Character: Int]()
    var left  = 0

    for ch in s1 {

        if let count = s1Map[ch] {
            s1Map[ch] = count + 1
        } else {
            s1Map[ch] = 1
        }
    }

    for right in 0..<words.count {

        let ch = words[right]

        if let count = s2Map[ch] {
            s2Map[ch] = count + 1
        } else {
            s2Map[ch] = 1
        }

        if right - left + 1 > s1.count {

            let leftChar = words[left]

            if let count = s2Map[leftChar] {

                s2Map[leftChar] = count - 1

                if s2Map[leftChar] == 0 {
                    s2Map.removeValue(forKey: leftChar)
                }
            }

            left += 1
        }

        if right - left + 1 == s1.count, s1Map == s2Map {
            return true
        }
    }

    return false
}


// MARK: - Tests

let tests: [(s1: String, s2: String, expected: Bool)] = [
    ("ab",    "eidbaooo",     true),
    ("ab",    "eidboaoo",     false),
    ("adc",   "dcda",         true),
    ("a",     "ab",           true),
    ("abc",   "bbbca",        true),
    ("hello", "ooolleoooleh", false)
]

print("--- Brute Force ---")
for (i, t) in tests.enumerated() {
    let r = bruteForce(t.s1, t.s2)
    print("Test \(i+1): \(r == t.expected ? "✅" : "❌") | Got: \(r) | Expected: \(t.expected)")
}

print("\n--- Optimal ⭐️ ---")
for (i, t) in tests.enumerated() {
    let r = optimised(t.s1, t.s2)
    print("Test \(i+1): \(r == t.expected ? "✅" : "❌") | Got: \(r) | Expected: \(t.expected)")
}

