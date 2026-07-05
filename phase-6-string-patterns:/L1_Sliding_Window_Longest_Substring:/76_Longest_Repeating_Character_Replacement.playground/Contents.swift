import Foundation

// ──────────────────────────────────────────
// 76_Longest_Repeating_Character_Replacement
// LeetCode 424  |  Difficulty: Medium  |  Pattern: Sliding Window
// ──────────────────────────────────────────

// MARK: - Problem

/*
 Given string s and integer k, you can replace at most k characters.
 Return length of longest substring containing same letter after replacements.

 Input:  s = "ABAB",    k = 2  →  4
 Input:  s = "AABABBA", k = 1  →  4
 Input:  s = "AAAA",    k = 0  →  4
 Input:  s = "ABCDE",   k = 1  →  2

 Key insight:
 windowSize - maxFreq <= k  → valid
 windowSize - maxFreq > k   → invalid, shrink
*/

// MARK: - Interview Q&A

/*
 Q: What does maxFreq represent?
 A: Count of most frequent character in current window

 Q: Why windowSize - maxFreq?
 A: That's how many chars need replacing — the non-dominant ones

 Q: Why if not while when shrinking?
 A: maxFreq never decreases, so window length never truly shrinks below
    best found — one shrink per step is enough

 Q: Why not hashMap.values.max()?
 A: Scans whole map every call → O(n²)/O(n³). Track maxFreq inline instead.

 Q: Time and space?
 A: O(n) time | O(26) space — uppercase letters only
*/

// MARK: - Brute Force
// T - O(n²)   S - O(k)

func bruteForce(_ s: String, _ k: Int) -> Int {

    let words = Array(s)
    var count = 0

    for i in 0..<words.count {

        var hashMap = [Character: Int]()
        var maxFreq = 0

        for j in i..<words.count {

            let ch = words[j]
            var newCount = 1

            if let c = hashMap[ch] {
                newCount = c + 1
                hashMap[ch] = newCount
            } else {
                hashMap[ch] = newCount
            }

            maxFreq = maxFreq > newCount ? maxFreq : newCount
            let windowSize = j - i + 1

            if windowSize - maxFreq <= k {
                count = count > windowSize ? count : windowSize
            } else {
                break
            }
        }
    }

    return count
}

// MARK: - Optimal ⭐️
// T - O(n)   S - O(26) ~ O(1)

func optimised(_ s: String, _ k: Int) -> Int {

    let words   = Array(s)
    var hashMap = [Character: Int]()
    var maxFreq = 0
    var left    = 0
    var count   = 0

    for right in 0..<words.count {

        let char = words[right]
        var newCount = 1

        if let c = hashMap[char] {
            newCount = c + 1
            hashMap[char] = newCount
        } else {
            hashMap[char] = newCount
        }

        maxFreq = maxFreq > newCount ? maxFreq : newCount
        let windowSize = right - left + 1

        if windowSize - maxFreq > k {
            let leftChar = words[left]
            if let c = hashMap[leftChar] {
                hashMap[leftChar] = c - 1
            }
            left += 1
        }

        count = count > (right - left + 1) ? count : (right - left + 1)
    }

    return count
}

// MARK: - Traps

/*
 1. maxFreq is NEVER decreased on shrink — looks wrong, is correct.
 2. if, not while, when shrinking left.
 3. k = 0 → only already-uniform windows are valid.
 4. No .max(), no force unwraps — track maxFreq with a manual var.
*/

// MARK: - Tests

let tests: [(s: String, k: Int, expected: Int)] = [
    ("ABAB",    2, 4),
    ("AABABBA", 1, 4),
    ("AAAA",    0, 4),
    ("ABCDE",   1, 2),
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
