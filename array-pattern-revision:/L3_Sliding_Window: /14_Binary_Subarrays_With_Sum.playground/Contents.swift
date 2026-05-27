import Foundation

// ──────────────────────────────────────────
// LeetCode 930 — Binary Subarrays With Sum
// Difficulty: Medium  |  Pattern: Sliding Window
// ──────────────────────────────────────────

// MARK: - Problem

/*
 Given a binary array and goal, return number of subarrays
 with sum exactly equal to goal.

 Input:  nums = [1,0,1,0,1],  goal = 2
 Output: 4

 Input:  nums = [0,0,0],  goal = 0
 Output: 6

 Key insight:
 exactly(goal) = atMost(goal) - atMost(goal - 1)
*/

// MARK: - Interview Q&A

/*
 Q: Why not just use one sliding window for exactly goal?
 A: Zeros make window ambiguous — sum stays same when zero added,
    so you don't know when to stop expanding or shrinking

 Q: Why atMost(goal) - atMost(goal - 1)?
 A: atMost(goal)   → sum 0,1,...,goal
    atMost(goal-1) → sum 0,1,...,goal-1
    subtract       → exactly goal

 Q: Why if goal < 0 return 0?
 A: atMost(goal-1) when goal=0 → atMost(-1) → impossible, return 0 safely

 Q: Why count += right - left + 1?
 A: All subarrays ending at right within window are valid — right-left+1 of them

 Q: What if goal > total sum of array?
 A: Answer is 0 — no subarray can reach that sum

 Q: Time and space?
 A: O(n) time — two passes of atMost | O(1) space
*/

// MARK: - Brute Force  O(n²) time  O(1) space

/*
 Strategy:
 - Fix i as start
 - Expand j, accumulate sum
 - if sum == goal → count++
 - No break needed — binary array, zeros never reduce sum below goal

 INTERVIEW: Start here, explain before coding
*/

func bruteForce(_ nums: [Int], _ goal: Int) -> Int {

    var count = 0

    for i in 0..<nums.count {

        var sum = 0

        for j in i..<nums.count {
            sum += nums[j]

            if sum == goal {
                count += 1
            }
        }
    }

    return count
}

// MARK: - Helper — atMost

/*
 Count subarrays with sum <= goal.

 if goal < 0  → return 0  (impossible, handles goal=0 edge case)
 expand right → add nums[right] to sum
 while sum > goal → shrink left
 count += right - left + 1  (all subarrays ending at right)
*/

func atMost(_ nums: [Int], _ goal: Int) -> Int {

    if goal < 0 { return 0 }

    var left  = 0
    var sum   = 0
    var count = 0

    for right in 0..<nums.count {

        sum += nums[right]

        while sum > goal {
            sum -= nums[left]
            left += 1
        }

        count += right - left + 1
    }

    return count
}

// MARK: - Optimal ⭐️  O(n) time  O(1) space

/*
 Strategy:
 - atMost(goal)   → subarrays with sum <= goal
 - atMost(goal-1) → subarrays with sum <= goal-1
 - subtract       → subarrays with sum exactly goal

 INTERVIEW: exactly = atMost(k) - atMost(k-1) is a reusable pattern
*/

func optimised(_ nums: [Int], _ goal: Int) -> Int {
    return atMost(nums, goal) - atMost(nums, goal - 1)
}

// MARK: - Tests

let tests: [(nums: [Int], goal: Int, expected: Int)] = [
    ([1,0,1,0,1], 2, 4),
    ([0,0,0,0],   0, 10),
    ([1,1,1,1],   2, 3),
    ([0,0,0],     0, 6),
    ([1,0,1,0,1], 4, 0),
    ([1,0,1,0,1], 0, 2)
]

print("--- Brute Force ---")
for (i, t) in tests.enumerated() {
    let r = bruteForce(t.nums, t.goal)
    print("Test \(i+1): \(r == t.expected ? "✅" : "❌") | Got: \(r) | Expected: \(t.expected)")
}

print("\n--- Optimal ⭐️ ---")
for (i, t) in tests.enumerated() {
    let r = optimised(t.nums, t.goal)
    print("Test \(i+1): \(r == t.expected ? "✅" : "❌") | Got: \(r) | Expected: \(t.expected)")
}
