import Foundation

// ──────────────────────────────────────────
// LeetCode 3 — Longest Substring Without Repeating Characters
// Difficulty: Medium  |  Pattern: Sliding Window
// ──────────────────────────────────────────

// MARK: - Problem

/*
 Given a string, return length of longest substring
 without repeating characters.

 Input:  "abcabcbb"
 Output: 3  →  "abc"

 Input:  "bbbbb"
 Output: 1  →  "b"

 Input:  "pwwkew"
 Output: 3  →  "wke"
*/

// MARK: - Interview Q&A

/*
 Q: Why HashMap over Set?
 A: HashMap stores last seen index — jump left directly, no while loop needed

 Q: Why always update hashMap[char] = right?
 A: Index must refresh every time — stale index causes wrong left jump

 Q: Why max(left, index + 1) not just index + 1?
 A: Prevents left moving backwards when duplicate is behind current window

 Q: Time and space?
 A: O(n) time — each char visited once | O(n) space — hashmap stores chars
*/

// MARK: - Helper

func isDuplicateString(_ str: String) -> Bool {
    var hashMap = [Character: Int]()
    for ch in str {
        if let count = hashMap[ch] {
            hashMap[ch] = count + 1
            return true
        } else {
            hashMap[ch] = 1
        }
    }
    return false
}

// MARK: - Brute Force  O(n³) time  O(n) space

/*
 Strategy:
 - Fix i as start
 - Expand j forward, build substring
 - isDuplicateString check on each substring
 - Break when duplicate found
 - Track max length

 INTERVIEW: Start here, explain before coding
 NOTE: isDuplicateString is O(n) inside O(n²) loop → O(n³) total
*/

func bruteForce(_ str: String) -> Int {

    let words  = Array(str)
    var length = 0

    for i in 0..<words.count {
        var sub = ""

        for j in i..<words.count {
            sub += String(words[j])

            if !isDuplicateString(sub) {
                length = max(length, j - i + 1)
            } else {
                break
            }
        }
    }

    return length
}

// MARK: - Optimal v1 — Count HashMap  O(n) time  O(n) space

/*
 Strategy:
 - charMap stores count of each char in window
 - expand right → increment count
 - while count > 1 → shrink left, decrement count
 - track max window

 INTERVIEW: Good first optimal — shows sliding window thinking
 NOTE: while loop shrinks one step at a time
*/

func optimalCountBased(_ str: String) -> Int {

    let words   = Array(str)
    var charMap = [Character: Int]()
    var left    = 0
    var answer  = 0

    for right in 0..<words.count {

        let char = words[right]
        charMap[char, default: 0] += 1

        while charMap[char]! > 1 {
            charMap[words[left], default: 0] -= 1
            left += 1
        }

        answer = max(answer, right - left + 1)
    }

    return answer
}

// MARK: - Optimal v2 ⭐️ BEST — Index HashMap  O(n) time  O(n) space

/*
 Strategy:
 - hashMap stores last seen INDEX of each char
 - if char seen → jump left = max(left, index + 1)
 - always update hashMap[char] = right
 - track max window

 INTERVIEW: Best solution — no while loop, direct jump
 INTERVIEW: max(left, index+1) prevents left moving backwards
 INTERVIEW: always update index after the check
*/

func optimalIndexBased(_ str: String) -> Int {

    let words   = Array(str)
    var hashMap = [Character: Int]()
    var left    = 0
    var answer  = 0

    for right in 0..<words.count {

        let char = words[right]

        if let index = hashMap[char] {
            left = max(left, index + 1)
        }

        hashMap[char] = right
        answer = max(answer, right - left + 1)
    }

    return answer
}

// MARK: - Interview Progression

/*
 Step 1 → Brute Force    O(n³)  "check every substring with duplicate helper"
 Step 2 → Optimal v1     O(n)   "sliding window with count — shrink with while"
 Step 3 → Optimal v2 ⭐️  O(n)   "index HashMap — jump left directly, no while"

 This progression shows:
 - you understand the problem
 - you know sliding window
 - you can optimise further when asked
*/

// MARK: - Tests

let tests: [(input: String, expected: Int)] = [
    ("abcabcbb", 3),
    ("bbbbb",    1),
    ("pwwkew",   3),
    ("",         0),
    ("abcdef",   6),
    ("dvdf",     3)
]

print("--- Brute Force ---")
for (i, t) in tests.enumerated() {
    let r = bruteForce(t.input)
    print("Test \(i+1): \(r == t.expected ? "✅" : "❌") | Got: \(r) | Expected: \(t.expected)")
}

print("\n--- Optimal v1 Count Based ---")
for (i, t) in tests.enumerated() {
    let r = optimalCountBased(t.input)
    print("Test \(i+1): \(r == t.expected ? "✅" : "❌") | Got: \(r) | Expected: \(t.expected)")
}

print("\n--- Optimal v2 ⭐️ Index Based ---")
for (i, t) in tests.enumerated() {
    let r = optimalIndexBased(t.input)
    print("Test \(i+1): \(r == t.expected ? "✅" : "❌") | Got: \(r) | Expected: \(t.expected)")
}

