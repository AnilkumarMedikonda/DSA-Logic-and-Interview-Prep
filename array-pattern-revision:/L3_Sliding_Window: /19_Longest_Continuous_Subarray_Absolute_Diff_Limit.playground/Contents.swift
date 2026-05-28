import Foundation

// ──────────────────────────────────────────
// LeetCode 1438 — Longest Continuous Subarray With Absolute Diff <= Limit
// Difficulty: Hard  |  Pattern: Sliding Window + Two Deques
// ──────────────────────────────────────────

// MARK: - Problem

/*
 Return length of longest subarray where absolute difference
 between any two elements <= limit.

 Input:  nums = [8,2,4,7],      limit = 4  →  2
 Input:  nums = [10,1,2,4,7,2], limit = 5  →  4
 Input:  nums = [4,2,2,2,4,4,2,2], limit = 0  →  3

 Key insight:
 max(window) - min(window) <= limit
 Use two deques — one tracks max, one tracks min
*/

// MARK: - Interview Q&A

/*
 Q: Why max - min represents absolute diff of any two elements?
 A: Largest possible diff in window = max - min. If that <= limit, all pairs are valid.

 Q: Why two deques not one?
 A: Need both max and min of window at every step — one deque can only track one

 Q: How is maxDeque different from minDeque?
 A: maxDeque removes back when nums[back] <= nums[right]
    minDeque removes back when nums[back] >= nums[right]

 Q: Why while for shrinking not if?
 A: After removing left, max-min may still exceed limit — keep shrinking

 Q: Why remove front when == left not < left?
 A: Front can only be left or ahead — check exact match

 Q: Time and space?
 A: O(n) time — each index added and removed once | O(n) space — two deques
*/

// MARK: - Brute Force  O(n²) time  O(1) space

/*
 Strategy:
 - Fix i as start
 - Expand j, track max and min
 - if max - min <= limit → record length

 INTERVIEW: Start here, explain before coding
*/

func bruteForce(_ nums: [Int], _ limit: Int) -> Int {

    var longest = 0

    for i in 0..<nums.count {

        var maxElement = Int.min
        var minElement = Int.max

        for j in i..<nums.count {

            maxElement = max(maxElement, nums[j])
            minElement = min(minElement, nums[j])

            if maxElement - minElement <= limit {
                longest = max(longest, j - i + 1)
            }
        }
    }

    return longest
}

// MARK: - Optimal ⭐️  O(n) time  O(n) space

/*
 Strategy:
 - maxDeque → front = max index (remove back when <= nums[right])
 - minDeque → front = min index (remove back when >= nums[right])
 - append both after cleanup
 - while max - min > limit → remove front if == left, left++
 - record max window

 INTERVIEW: Two deques — same as problem 18 but track both max and min
 INTERVIEW: maxDeque back → <= | minDeque back → >=
 INTERVIEW: while recalculates diff every iteration — critical
*/

func optimised(_ nums: [Int], _ limit: Int) -> Int {

    var maxDeque   = [Int]()
    var minDeque   = [Int]()
    var left       = 0
    var answer     = 0

    for right in 0..<nums.count {

        // max deque — remove back while smaller
        while let last = maxDeque.last, nums[last] <= nums[right] {
            maxDeque.removeLast()
        }

        // min deque — remove back while larger
        while let last = minDeque.last, nums[last] >= nums[right] {
            minDeque.removeLast()
        }

        maxDeque.append(right)
        minDeque.append(right)

        // shrink while invalid
        while let maxF = maxDeque.first,
              let minF = minDeque.first,
              nums[maxF] - nums[minF] > limit {

            if maxDeque.first == left { maxDeque.removeFirst() }
            if minDeque.first == left { minDeque.removeFirst() }
            left += 1
        }

        answer = max(answer, right - left + 1)
    }

    return answer
}

// MARK: - Tests

let tests: [(nums: [Int], limit: Int, expected: Int)] = [
    ([8,2,4,7],           4, 2),
    ([10,1,2,4,7,2],      5, 4),
    ([4,2,2,2,4,4,2,2],   0, 3),
    ([1,5,6,7,8,10,6,5,6],4, 5),
    ([1],                  0, 1)
]

print("--- Brute Force ---")
for (i, t) in tests.enumerated() {
    let r = bruteForce(t.nums, t.limit)
    print("Test \(i+1): \(r == t.expected ? "✅" : "❌") | Got: \(r) | Expected: \(t.expected)")
}

print("\n--- Optimal ⭐️ ---")
for (i, t) in tests.enumerated() {
    let r = optimised(t.nums, t.limit)
    print("Test \(i+1): \(r == t.expected ? "✅" : "❌") | Got: \(r) | Expected: \(t.expected)")
}
