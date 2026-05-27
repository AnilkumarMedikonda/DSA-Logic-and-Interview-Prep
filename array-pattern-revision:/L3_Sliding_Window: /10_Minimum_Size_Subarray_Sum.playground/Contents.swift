import Foundation

// ──────────────────────────────────────────
// LeetCode 209 — Minimum Size Subarray Sum
// Difficulty: Medium  |  Pattern: Sliding Window
// ──────────────────────────────────────────

// MARK: - Problem

/*
 Given array of positive integers and target, return minimum
 length of subarray whose sum >= target. Return 0 if none exists.

 Input:  target = 7, nums = [2, 3, 1, 2, 4, 3]
 Output: 2  →  [4, 3]

 Input:  target = 4, nums = [1, 4, 4]
 Output: 1  →  [4]

 Input:  target = 11, nums = [1, 2, 3, 4, 5]
 Output: 3  →  [3, 4, 5]
*/

// MARK: - Interview Q&A

/*
 Q: Why >= target not == target?
 A: Window can overshoot target — still a valid answer

 Q: Why while not if when shrinking?
 A: After one shrink window may still be valid — keep shrinking to find minimum

 Q: Why Int.max as initial length?
 A: We need minimum — start high so any valid window beats it

 Q: Why return 0 if length == Int.max?
 A: No valid subarray found — Int.max means never updated

 Q: Time and space?
 A: Brute O(n²) O(1) | Optimal O(n) O(1) — each element added and removed once
*/

// MARK: - Brute Force  O(n²) time  O(1) space

/*
 Strategy:
 - Fix i as start
 - Expand j forward, add to sum
 - When sum >= target → record length, break
 - Track minimum across all i

 INTERVIEW: Start here, explain before coding
*/

func bruteForce(_ nums: [Int], _ target: Int) -> Int {

    var length = Int.max

    for i in 0..<nums.count {

        var sum = 0

        for j in i..<nums.count {
            sum += nums[j]

            if sum >= target {
                length = min(length, j - i + 1)
                break
            }
        }
    }

    return length == Int.max ? 0 : length
}

// MARK: - Optimal ⭐️  O(n) time  O(1) space

/*
 Strategy:
 - right expands → adds nums[right] to sum
 - while sum >= target → record length → shrink left
 - sum -= nums[left] → left++
 - each element added and removed at most once → O(n)

 INTERVIEW: while not if — window may still be valid after one shrink
 INTERVIEW: min(length, right - left + 1) — always track minimum
*/

func optimised(_ nums: [Int], _ target: Int) -> Int {

    var left   = 0
    var sum    = 0
    var length = Int.max

    for right in 0..<nums.count {

        sum += nums[right]

        while sum >= target {
            length = min(length, right - left + 1)
            sum -= nums[left]
            left += 1
        }
    }

    return length == Int.max ? 0 : length
}

// MARK: - Tests

let tests: [(nums: [Int], target: Int, expected: Int)] = [
    ([2, 3, 1, 2, 4, 3], 7,  2),
    ([1, 4, 4],          4,  1),
    ([1, 2, 3, 4, 5],    11, 3),
    ([1, 1, 1, 1, 1],    11, 0),
    ([1, 2, 3, 4, 5],    15, 5),
    ([2, 3, 1, 2, 4, 3], 4,  1)
]

print("--- Brute Force ---")
for (i, t) in tests.enumerated() {
    let r = bruteForce(t.nums, t.target)
    print("Test \(i+1): \(r == t.expected ? "✅" : "❌") | Got: \(r) | Expected: \(t.expected)")
}

print("\n--- Optimal ⭐️ ---")
for (i, t) in tests.enumerated() {
    let r = optimised(t.nums, t.target)
    print("Test \(i+1): \(r == t.expected ? "✅" : "❌") | Got: \(r) | Expected: \(t.expected)")
}
