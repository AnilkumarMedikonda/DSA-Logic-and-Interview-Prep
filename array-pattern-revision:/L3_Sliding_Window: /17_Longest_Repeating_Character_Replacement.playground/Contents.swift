import Foundation

// ──────────────────────────────────────────
// LeetCode 424 — Longest Repeating Character Replacement
// Difficulty: Medium  |  Pattern: Sliding Window
// ──────────────────────────────────────────

// MARK: - Problem

/*
 Given string s and integer k, you can replace at most k characters.
 Return length of longest substring containing same letter after replacements.

 Input:  s = "ABAB",    k = 2  →  4  (replace both B's → "AAAA")
 Input:  s = "AABABBA", k = 1  →  4  (replace one char)

 Key insight:
 windowSize - maxFreq <= k  → valid window
 windowSize - maxFreq > k   → invalid, shrink
*/

// MARK: - Interview Q&A

/*
 Q: What does maxFreq represent?
 A: Count of most frequent character in current window

 Q: Why windowSize - maxFreq?
 A: That's how many characters need to be replaced — non-dominant chars

 Q: Why if not while when shrinking?
 A: We want maximum window — just slide forward, never shrink more than 1

 Q: Why hashMap.values.max() is O(n²) not O(n)?
 A: max() scans all values inside O(n) loop → O(n²) total

 Q: How to make it truly O(n)?
 A: Track maxFreq inline → maxFreq = max(maxFreq, hashMap[char]!)

 Q: Time and space?
 A: O(n²) with max() | O(n) with inline maxFreq | O(26) space — only letters
*/

// MARK: - Brute Force  O(n³) time  O(n) space

/*
 Strategy:
 - Fix i as start
 - Expand j, track char frequencies in hashMap
 - maxFreq = hashMap.values.max()
 - if windowSize - maxFreq <= k → valid, record length
 - else → break

 INTERVIEW: Start here, explain before coding
 NOTE: values.max() is O(n) inside O(n²) → O(n³) total
*/

func bruteForce(_ s: String, _ k: Int) -> Int {

    let words = Array(s)
    var count = 0

    for i in 0..<words.count {

        var hashMap = [Character: Int]()

        for j in i..<words.count {

            let ch = words[j]

            if let c = hashMap[ch] {
                hashMap[ch] = c + 1
            } else {
                hashMap[ch] = 1
            }

            
            
        }
    }

    return count
}

// MARK: - Optimal ⭐️  O(n) time  O(1) space

/*
 Strategy:
 - expand right → add to hashMap
 - maxFreq = max(maxFreq, hashMap[char])  ← inline, O(1)
 - if windowSize - maxFreq > k → shrink left by 1
 - count = max(count, right - left + 1)

 INTERVIEW: if not while — just slide forward for maximum window
 INTERVIEW: inline maxFreq → truly O(n) not O(n²)
 INTERVIEW: window never shrinks more than 1 at a time
*/

func optimised(_ s: String, _ k: Int) -> Int {

    let words   = Array(s)
    var hashMap = [Character: Int]()
    var maxFreq = 0
    var left    = 0
    var count   = 0

    for right in 0..<words.count {

        let char = words[right]

        if let c = hashMap[char] {
            hashMap[char] = c + 1
        } else {
            hashMap[char] = 1
        }

        maxFreq = max(maxFreq, hashMap[char]!)

        let windowSize = right - left + 1

        if windowSize - maxFreq > k {
            let leftChar = words[left]
            if let c = hashMap[leftChar] {
                hashMap[leftChar] = c - 1
            }
            left += 1
        }

        count = max(count, right - left + 1)
    }

    return count
}

// MARK: - Tests

let tests: [(s: String, k: Int, expected: Int)] = [
    ("ABAB",    2, 4),
    ("AABABBA", 1, 4),
    ("AAAA",    2, 4),
    ("ABCD",    2, 3),
    ("A",       0, 1),
    ("AABB",    0, 2)
]

print("--- Brute Force ---")
for (i, t) in tests.enumerated() {
    let r = bruteForce(t.s, t.k)
    print("Test \(i+1): \(r == t.expected ? "✅" : "❌") | Got: \(r) | Expected: \(t.expected)")
}

print("\n--- Optimal ⭐️ ---")
for (i, t) in tests.enumerated() {
    let r = optimised(t.s, t.k)
    print("Test \(i+1): \(r == t.expected ? "✅" : "❌") | Got: \(r) | Expected: \(t.expected)")
}

