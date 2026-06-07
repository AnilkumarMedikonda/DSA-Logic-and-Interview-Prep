import UIKit

// ============================================================
// MARK: - Problem: Maximum Sum Circular Subarray (LC 918)
// ============================================================
// Given a circular integer array nums, return the maximum
// possible sum of a non-empty subarray.
//
// Example 1: [1, -2, 3, -2]   → 3   ([3])
// Example 2: [5, -3, 5]       → 10  ([5, 5] circular)
// Example 3: [-3, -2, -3]     → -2  ([-2])
// Example 4: [3, -1, 2, -1]   → 4   ([3,-1,2])
//
// Constraints:
// - 1 <= nums.length <= 3 * 10⁴
// - -3 * 10⁴ <= nums[i] <= 3 * 10⁴
// ============================================================

// ============================================================
// MARK: - Brute Force — O(n²) Time | O(1) Space
// ============================================================
// Steps:
// 1. Outer loop — picks start index i
// 2. Inner loop — extends up to n elements from i
// 3. Use (i + j) % n for circular wrap
// 4. Accumulate sum, track maximum
// 5. Return maximum
// ============================================================

func maxSubArrayCircularBrute(_ nums: [Int]) -> Int {
    var maximumSum = Int.min

    for i in 0..<nums.count {
        var sum = 0
        for j in 0..<nums.count {
            let index = (i + j) % nums.count
            sum += nums[index]
            maximumSum = max(maximumSum, sum)
        }
    }

    return maximumSum
}

// ============================================================
// MARK: - Optimised — O(n) Time | O(1) Space
// ============================================================
// Key Insight — Two Cases:
//
// Case 1: Max subarray does NOT wrap around
//         → Normal Kadane's → maxSum
//
// Case 2: Max subarray DOES wrap around
//         → totalSum - minSubarray
//         → Middle (minimum) part is excluded
//
// Answer = max(maxSum, totalSum - minSum)
//
// Edge Case: All elements negative
//         → totalSum == minSum → empty array invalid
//         → Return maxSum only
//
// Steps:
// 1. Init totalSum, maxSum, minSum, currentMax, currentMin
// 2. Loop from index 1
// 3. Kadane's max → maxSum
// 4. Kadane's min → minSum
// 5. Accumulate totalSum
// 6. Edge case check after loop
// 7. Return max(maxSum, totalSum - minSum)
// ============================================================

func maxSubArrayCircularOptimised(_ nums: [Int]) -> Int {
    var totalSum   = nums[0]
    var maxSum     = nums[0]
    var minSum     = nums[0]
    var currentMax = nums[0]
    var currentMin = nums[0]

    for i in 1..<nums.count {

        // Kadane's max — extend or fresh start
        if currentMax + nums[i] < nums[i] {
            currentMax = nums[i]
        } else {
            currentMax += nums[i]
        }
        maxSum = max(maxSum, currentMax)

        // Kadane's min — extend or fresh start
        if currentMin + nums[i] > nums[i] {
            currentMin = nums[i]
        } else {
            currentMin += nums[i]
        }
        minSum = min(minSum, currentMin)

        // total sum
        totalSum += nums[i]
    }

    // Edge case — all negative
    if totalSum == minSum {
        return maxSum
    }

    return max(maxSum, totalSum - minSum)
}

// ============================================================
// MARK: - Test Cases — Basic
// ============================================================

print("---- Brute Force ----")
print(maxSubArrayCircularBrute([1, -2, 3, -2])) // 3
print(maxSubArrayCircularBrute([5, -3, 5]))      // 10
print(maxSubArrayCircularBrute([-3, -2, -3]))    // -2
print(maxSubArrayCircularBrute([3, -1, 2, -1]))  // 4

print("---- Optimised ----")
print(maxSubArrayCircularOptimised([1, -2, 3, -2])) // 3
print(maxSubArrayCircularOptimised([5, -3, 5]))      // 10
print(maxSubArrayCircularOptimised([-3, -2, -3]))    // -2
print(maxSubArrayCircularOptimised([3, -1, 2, -1]))  // 4

// ============================================================
// MARK: - Test Cases — Edge Cases
// ============================================================

print("---- Edge Case 1: Single Element ----")
print(maxSubArrayCircularOptimised([5]))              // 5
print(maxSubArrayCircularOptimised([-5]))             // -5

print("---- Edge Case 2: All Negative ----")
print(maxSubArrayCircularOptimised([-3, -2, -3]))     // -2
print(maxSubArrayCircularOptimised([-1, -2, -3]))     // -1
print(maxSubArrayCircularOptimised([-5, -4, -3]))     // -3

print("---- Edge Case 3: All Positive ----")
print(maxSubArrayCircularOptimised([1, 2, 3]))        // 6
print(maxSubArrayCircularOptimised([5, 5, 5]))        // 15

print("---- Edge Case 4: Wrap Around ----")
print(maxSubArrayCircularOptimised([5, -3, 5]))       // 10
print(maxSubArrayCircularOptimised([3, -2, 3, -2, 3])) // 9

print("---- Edge Case 5: No Wrap Around ----")
print(maxSubArrayCircularOptimised([-2, 3, 3, -2]))   // 6
print(maxSubArrayCircularOptimised([1, 2, -5, 3]))    // 3

print("---- Edge Case 6: Zeros ----")
print(maxSubArrayCircularOptimised([0, 0, 0]))        // 0
print(maxSubArrayCircularOptimised([-1, 0, -2]))      // 0

// ============================================================
// MARK: - Complexity Summary
// ============================================================
// Approach       Time      Space
// Brute Force    O(n²)     O(1)
// Optimised      O(n)      O(1)
//
// Key Formula:
// Case 1 — No wrap  → maxSum
// Case 2 — Wrap     → totalSum - minSum
// Answer            → max(Case1, Case2)
// ============================================================
