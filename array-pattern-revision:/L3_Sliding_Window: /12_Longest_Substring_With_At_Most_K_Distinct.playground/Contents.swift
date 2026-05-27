import Foundation

// ──────────────────────────────────────────
// LeetCode 340 — Longest Substring With At Most K Distinct
// Difficulty: Medium  |  Pattern: Sliding Window
// ──────────────────────────────────────────

// MARK: - Problem

/*
 Given string s and integer k, return length of longest substring
 with at most k distinct characters.

 Input:  s = "eceba",  k = 2
 Output: 3  →  "ece"

 Input:  s = "aa",  k = 1
 Output: 2  →  "aa"

 Input:  s = "aabbcc",  k = 2
 Output: 4  →  "aabb" or "bbcc"
*/

// MARK: - Interview Q&A

/*
 Q: How do you track distinct characters in window?
 A: HashMap — key is char, value is count. distinct = hashMap.count

 Q: When do you shrink the window?
 A: while hashMap.count > k → remove left char, left++

 Q: Why remove key when count hits 0?
 A: Key staying in map inflates distinct count — must remove to track correctly

 Q: Why while not if when shrinking?
 A: One shrink may not be enough — keep shrinking until distinct <= k

 Q: Time and space?
 A: O(n) time — each char added and removed once | O(k) space — map holds at most k+1 chars
*/

// MARK: - Brute Force  O(n²) time  O(k) space

/*
 Strategy:
 - Fix i as start
 - Expand j forward, track unique count via hashMap
 - When unique > k → break
 - Track max length

 INTERVIEW: Start here, explain before coding
*/

func bruteForce(_ s: String, _ k: Int) -> Int {

    let words  = Array(s)
    var length = 0

    for i in 0..<words.count {

        var hashMap     = [Character: Int]()
        var uniqueCount = 0

        for j in i..<words.count {

            let ch = words[j]

            if let count = hashMap[ch] {
                hashMap[ch] = count + 1
            } else {
                hashMap[ch] = 1
                uniqueCount += 1
            }

            if uniqueCount <= k {
                length = max(length, j - i + 1)
            } else {
                break
            }
        }
    }

    return length
}

// MARK: - Optimal ⭐️  O(n) time  O(k) space

/*
 Strategy:
 - expand right → add char, increment count
 - while distinct > k → shrink left
   → decrement count, if count == 0 remove key, uniqueCount--
   → left++
 - track max window

 INTERVIEW: Remove key when count hits 0 — keeps distinct count accurate
 INTERVIEW: while not if — one shrink may not be enough
*/

func optimised(_ s: String, _ k: Int) -> Int {

    let words       = Array(s)
    var hashMap     = [Character: Int]()
    var uniqueCount = 0
    var left        = 0
    var length      = 0

    for right in 0..<words.count {

        let rightChar = words[right]

        if let count = hashMap[rightChar] {
            hashMap[rightChar] = count + 1
        } else {
            hashMap[rightChar] = 1
            uniqueCount += 1
        }

        while uniqueCount > k {
            let leftChar = words[left]

            if let count = hashMap[leftChar] {
                hashMap[leftChar] = count - 1
                if hashMap[leftChar] == 0 {
                    hashMap.removeValue(forKey: leftChar)
                    uniqueCount -= 1
                }
            }
            left += 1
        }

        length = max(length, right - left + 1)
    }

    return length
}

// MARK: - Tests

let tests: [(s: String, k: Int, expected: Int)] = [
    ("eceba",   2, 3),
    ("aa",      1, 2),
    ("aabbcc",  2, 4),
    ("a",       1, 1),
    ("abcdef",  3, 3),
    ("aaabbb",  1, 3)
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

