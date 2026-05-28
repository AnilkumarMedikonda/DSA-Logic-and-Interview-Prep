import Foundation

// ──────────────────────────────────────────
// LeetCode 1004 — Max Consecutive Ones III
// Difficulty: Medium  |  Pattern: Sliding Window
// ──────────────────────────────────────────

// MARK: - Problem

/*
 Given binary array and k, return max consecutive 1s
 if you can flip at most k zeros.

 Input:  nums = [1,1,1,0,0,0,1,1,1,1,0],  k = 2
 Output: 6

 Input:  nums = [0,0,1,1,0,0,1,1,1,0,1,1,0,0,0,1,1,1,1],  k = 3
 Output: 10

 Key insight:
 Flipping k zeros = allowing at most k zeros in window
 Same as: longest subarray with at most k zeros
*/

// MARK: - Interview Q&A

/*
 Q: What is the key insight of this problem?
 A: Flipping k zeros = allowing k zeros in window — reframe the problem

 Q: When is window invalid?
 A: When zeroCount > k

 Q: Why while not if when shrinking?
 A: Multiple zeros may need to be removed before window is valid again

 Q: Why decrement zeroCount before left++?
 A: Check if left element is zero first — then move pointer

 Q: Time and space?
 A: O(n) time — each element visited once | O(1) space — no extra data structure
*/

// MARK: - Brute Force  O(n²) time  O(1) space

/*
 Strategy:
 - Fix i as start
 - Expand j, count zeros
 - if zeros <= k → record length
 - else → break

 INTERVIEW: Start here, explain before coding
*/

func bruteForce(_ nums: [Int], _ k: Int) -> Int {

    var answer = 0

    for i in 0..<nums.count {

        var zeroCount = 0

        for j in i..<nums.count {

            if nums[j] == 0 {
                zeroCount += 1
            }

            if zeroCount <= k {
                answer = max(answer, j - i + 1)
            } else {
                break
            }
        }
    }

    return answer
}

// MARK: - Optimal ⭐️  O(n) time  O(1) space

/*
 Strategy:
 - expand right → if 0 → zeroCount++
 - while zeroCount > k → if nums[left]==0 → zeroCount-- → left++
 - record max window

 INTERVIEW: "Flipping k zeros = allowing k zeros in window"
 INTERVIEW: while not if — multiple shrinks may be needed
 INTERVIEW: check nums[left] before left++ — order matters
*/

func optimised(_ nums: [Int], _ k: Int) -> Int {

    var left      = 0
    var zeroCount = 0
    var answer    = 0

    for right in 0..<nums.count {

        if nums[right] == 0 {
            zeroCount += 1
        }

        while zeroCount > k {
            if nums[left] == 0 {
                zeroCount -= 1
            }
            left += 1
        }

        answer = max(answer, right - left + 1)
    }

    return answer
}

// MARK: - Tests

let tests: [(nums: [Int], k: Int, expected: Int)] = [
    ([1,1,1,0,0,0,1,1,1,1,0],          2, 6),
    ([0,0,1,1,0,0,1,1,1,0,1,1,0,0,0,1,1,1,1], 3, 10),
    ([1,1,1],                           0, 3),
    ([0,0,0],                           0, 0),
    ([0,0,0],                           3, 3),
    ([1],                               0, 1)
]

print("--- Brute Force ---")
for (i, t) in tests.enumerated() {
    let r = bruteForce(t.nums, t.k)
    print("Test \(i+1): \(r == t.expected ? "✅" : "❌") | Got: \(r) | Expected: \(t.expected)")
}

print("\n--- Optimal ⭐️ ---")
for (i, t) in tests.enumerated() {
    let r = optimised(t.nums, t.k)
    print("Test \(i+1): \(r == t.expected ? "✅" : "❌") | Got: \(r) | Expected: \(t.expected)")
}
