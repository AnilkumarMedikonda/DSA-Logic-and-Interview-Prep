import Foundation

// ──────────────────────────────────────────
// LeetCode 76 — Minimum Window Substring
// Difficulty: Hard  |  Pattern: Sliding Window
// ──────────────────────────────────────────

// MARK: - Problem

/*
 Given two strings s and t, return the minimum window substring
 of s that contains all characters of t. Return "" if none exists.

 Input:  s = "ADOBECODEBANC",  t = "ABC"
 Output: "BANC"

 Input:  s = "a",  t = "a"
 Output: "a"

 Input:  s = "a",  t = "b"
 Output: ""
*/

// MARK: - Interview Q&A

/*
 Q: What does formed track?
 A: How many unique chars from t are currently satisfied in window

 Q: What does required track?
 A: Total unique chars in t that need to be satisfied — tMap.count

 Q: Why formed++ only when sMap[ch] == tMap[ch]?
 A: Only when count exactly meets requirement — not before, not after

 Q: Why formed-- only when sMap[leftChar] < tMap[leftChar]?
 A: Only when removing left char drops it below required count

 Q: Why while not if when shrinking?
 A: Keep shrinking until window is no longer valid — find true minimum

 Q: Time and space?
 A: O(n) time — each char added and removed once | O(n) space — two hashmaps
*/

// MARK: - Helper

func isContainsTarget(hashMap: [Character: Int], _ t: String) -> Bool {
    for ch in t {
        if let count = hashMap[ch], count >= 1 {
            continue
        } else {
            return false
        }
    }
    return true
}

// MARK: - Brute Force  O(n³) time  O(n) space

/*
 Strategy:
 - Fix i as start
 - Expand j, build substring, track chars in hashMap
 - isContainsTarget checks if all chars of t are in window
 - Track minimum window

 INTERVIEW: Start here, explain before coding
 NOTE: isContainsTarget is O(n) inside O(n²) loop → O(n³) total
*/

func bruteForce(_ s: String, _ t: String) -> String {

    let words         = Array(s)
    var minSubString  = ""

    for i in 0..<words.count {

        var str     = ""
        var hashMap = [Character: Int]()

        for j in i..<words.count {

            let ch = words[j]
            str += String(ch)

            if let count = hashMap[ch] {
                hashMap[ch] = count + 1
            } else {
                hashMap[ch] = 1
            }

            if str.count >= t.count,
               isContainsTarget(hashMap: hashMap, t),
               minSubString.isEmpty || str.count < minSubString.count {
                minSubString = str
                break
            }
        }
    }

    return minSubString
}

// MARK: - Optimal ⭐️  O(n) time  O(n) space

/*
 Strategy:
 - Build tMap — frequency of each char in t
 - required = tMap.count — unique chars needed
 - expand right → add to sMap
   → if sMap[ch] == tMap[ch] → formed++
 - while formed == required → valid window
   → record minimum
   → shrink left
   → if sMap[leftChar] < tMap[leftChar] → formed--
   → left++

 INTERVIEW: formed tracks satisfaction — not just presence
 INTERVIEW: formed++ only when count exactly meets tMap count
 INTERVIEW: formed-- only when count drops below tMap count
*/

func optimised(_ s: String, _ t: String) -> String {

    let words    = Array(s)
    var tMap     = [Character: Int]()
    var sMap     = [Character: Int]()
    var answer   = ""
    var left     = 0
    var formed   = 0
    var required = 0

    for ch in t {
        if let count = tMap[ch] {
            tMap[ch] = count + 1
        } else {
            tMap[ch] = 1
        }
    }

    required = tMap.count

    for right in 0..<words.count {

        let ch = words[right]

        if let count = sMap[ch] {
            sMap[ch] = count + 1
        } else {
            sMap[ch] = 1
        }

        if let tCount = tMap[ch], sMap[ch] == tCount {
            formed += 1
        }

        while formed == required {

            let windowSize = right - left + 1

            if answer.isEmpty || windowSize < answer.count {
                answer = String(words[left...right])
            }

            let leftChar = words[left]

            if let count = sMap[leftChar] {
                sMap[leftChar] = count - 1
            }

            if let tCount = tMap[leftChar], sMap[leftChar]! < tCount {
                formed -= 1
            }

            left += 1
        }
    }

    return answer
}

// MARK: - Tests

let tests: [(s: String, t: String, expected: String)] = [
    ("ADOBECODEBANC", "ABC",  "BANC"),
    ("a",             "a",    "a"),
    ("a",             "b",    ""),
    ("aa",            "aa",   "aa"),
    ("bdab",          "ab",   "ab")
]

print("--- Brute Force ---")
for (i, t) in tests.enumerated() {
    let r = bruteForce(t.s, t.t)
    print("Test \(i+1): \(r == t.expected ? "✅" : "❌") | Got: \(r) | Expected: \(t.expected)")
}

print("\n--- Optimal ⭐️ ---")
for (i, t) in tests.enumerated() {
    let r = optimised(t.s, t.t)
    print("Test \(i+1): \(r == t.expected ? "✅" : "❌") | Got: \(r) | Expected: \(t.expected)")
}
