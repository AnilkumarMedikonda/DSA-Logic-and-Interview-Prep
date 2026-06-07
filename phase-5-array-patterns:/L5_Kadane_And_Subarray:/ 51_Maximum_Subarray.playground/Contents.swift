import UIKit

// ============================================================
// MARK: - Problem: Maximum Subarray (LC 53)
// ============================================================
// Given an integer array nums, find the contiguous subarray
// which has the largest sum and return its sum.
//
// Example 1: [-2,1,-3,4,-1,2,1,-5,4] → 6  ([4,-1,2,1])
// Example 2: [1]                      → 1
// Example 3: [5,4,-1,7,8]            → 23
//
// Constraints:
// - 1 <= nums.length <= 10⁵
// - -10⁴ <= nums[i] <= 10⁴
// ============================================================

// ============================================================
// MARK: - Brute Force — O(n²) Time | O(1) Space
// ============================================================
// Steps:
// 1. Run two nested loops — outer picks start, inner picks end
// 2. Accumulate sum for each (i, j) subarray
// 3. Track maximum sum seen so far
// 4. Return maximum
// ============================================================

func maxSubArrayBrute(_ nums: [Int]) -> Int {
    var maximum = Int.min

    for i in 0..<nums.count {
        var sum = 0
        for j in i..<nums.count {
            sum += nums[j]
            maximum = max(maximum, sum)
        }
    }

    return maximum
}

// ============================================================
// MARK: - Optimised — Kadane's Algorithm — O(n) Time | O(1) Space
// ============================================================
// Steps:
// 1. Initialize currentSum and maximumSum with nums[0]
// 2. Loop from index 1
// 3. At each i, decide: extend current subarray OR start fresh
//    - If currentSum + nums[i] < nums[i] → start fresh
//    - Else → extend by adding nums[i]
// 4. Update maximumSum at each step
// 5. Return maximumSum
// ============================================================

func maxSubArrayKadane(_ nums: [Int]) -> Int {
    var currentSum = nums[0]
    var maximumSum = nums[0]

    for i in 1..<nums.count {
        if currentSum + nums[i] < nums[i] {
            currentSum = nums[i]
        } else {
            currentSum += nums[i]
        }
        maximumSum = max(maximumSum, currentSum)
    }

    return maximumSum
}

// ============================================================
// MARK: - Test Cases — Basic
// ============================================================

print("---- Basic Cases ----")
print(maxSubArrayBrute([-2, 1, -3, 4, -1, 2, 1, -5, 4])) // 6
print(maxSubArrayBrute([5, 4, -1, 7, 8]))                 // 23
print(maxSubArrayBrute([1, 2, 3, 4, 5]))                  // 15

print(maxSubArrayKadane([-2, 1, -3, 4, -1, 2, 1, -5, 4])) // 6
print(maxSubArrayKadane([5, 4, -1, 7, 8]))                 // 23
print(maxSubArrayKadane([1, 2, 3, 4, 5]))                  // 15

// ============================================================
// MARK: - Test Cases — Edge Cases
// ============================================================

print("---- Edge Case 1: Single Element ----")
print(maxSubArrayKadane([1]))                              // 1
print(maxSubArrayKadane([-1]))                             // -1
print(maxSubArrayKadane([0]))                              // 0

print("---- Edge Case 2: All Negative ----")
print(maxSubArrayKadane([-1, -2, -3]))                     // -1
print(maxSubArrayKadane([-3, -2, -1]))                     // -1
print(maxSubArrayKadane([-5, -4, -3, -2, -1]))             // -1
print(maxSubArrayKadane([-100, -50, -200]))                // -50

print("---- Edge Case 3: All Positive ----")
print(maxSubArrayKadane([1, 2, 3, 4, 5]))                  // 15
print(maxSubArrayKadane([10, 20, 30]))                     // 60

print("---- Edge Case 4: Mix of Zeros ----")
print(maxSubArrayKadane([0, 0, 0]))                        // 0
print(maxSubArrayKadane([-1, 0, -2]))                      // 0
print(maxSubArrayKadane([0, -1, 0, -2, 0]))                // 0

print("---- Edge Case 5: Negative at Start ----")
print(maxSubArrayKadane([-5, 1, 2, 3]))                    // 6
print(maxSubArrayKadane([-100, 1, 2, 3]))                  // 6

print("---- Edge Case 6: Negative at End ----")
print(maxSubArrayKadane([1, 2, 3, -5]))                    // 6
print(maxSubArrayKadane([1, 2, 3, -100]))                  // 6

print("---- Edge Case 7: Negative in Middle ----")
print(maxSubArrayKadane([3, -1, 3]))                       // 5
print(maxSubArrayKadane([3, -10, 3]))                      // 3

print("---- Edge Case 8: Large Values ----")
print(maxSubArrayKadane([10000, -1, 10000]))               // 19999
print(maxSubArrayKadane([-10000, 10000, -10000]))          // 10000

print("---- Edge Case 9: Alternating ----")
print(maxSubArrayKadane([1, -1, 1, -1, 1]))                // 1
print(maxSubArrayKadane([2, -1, 2, -1, 2]))                // 4

// ============================================================
// MARK: - Complexity Summary
// ============================================================
// Approach       Time      Space
// Brute Force    O(n²)     O(1)
// Kadane's       O(n)      O(1)
// ============================================================
