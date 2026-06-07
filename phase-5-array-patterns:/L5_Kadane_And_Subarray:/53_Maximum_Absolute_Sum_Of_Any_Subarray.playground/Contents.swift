import UIKit

// ============================================================
// MARK: - Problem: Maximum Absolute Sum of Any Subarray (LC 1749)
// ============================================================
// You are given an integer array nums.
// Return the maximum absolute sum of any subarray of nums.
//
// Example 1: [1, -3, 2, 3, -4]      → 5
// Example 2: [-3, -5, -3]           → 11
// Example 3: [2, -5, 1, -4, 3, -2]  → 8
//
// Constraints:
// - 1 <= nums.length <= 10⁵
// - -10⁴ <= nums[i] <= 10⁴
// ============================================================

// ============================================================
// MARK: - Brute Force — O(n²) Time | O(1) Space
// ============================================================
// Steps:
// 1. Run two nested loops
// 2. Accumulate sum for each subarray
// 3. Track maximum of abs(sum)
// 4. Return maximum
// ============================================================

func maxAbsoluteSumBrute(_ nums: [Int]) -> Int {
    var maximum = 0

    for i in 0..<nums.count {
        var sum = 0
        for j in i..<nums.count {
            sum += nums[j]
            maximum = max(maximum, abs(sum))
        }
    }

    return maximum
}

// ============================================================
// MARK: - Optimised — Kadane's Algorithm — O(n) Time | O(1) Space
// ============================================================
// Key Insight:
// Absolute sum is maximum when EITHER:
// Case 1 → subarray sum is MOST POSITIVE → Kadane's max
// Case 2 → subarray sum is MOST NEGATIVE → Kadane's min → abs()
//
// Answer = max(maxSum, abs(minSum))
//
// Steps:
// 1. Init maxSum, minSum, currentMax, currentMin with nums[0]
// 2. Loop from index 1
// 3. Kadane's max → maxSum
// 4. Kadane's min → minSum
// 5. Return max(maxSum, abs(minSum))
// ============================================================

func maxAbsoluteSumOptimised(_ nums: [Int]) -> Int {
    var maximumSum = nums[0]
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
        maximumSum = max(maximumSum, currentMax)

        // Kadane's min — extend or fresh start
        if currentMin + nums[i] > nums[i] {
            currentMin = nums[i]
        } else {
            currentMin += nums[i]
        }
        minSum = min(minSum, currentMin)
    }

    return max(maximumSum, abs(minSum))
}

// ============================================================
// MARK: - Test Cases — Basic
// ============================================================

print("---- Brute Force ----")
print(maxAbsoluteSumBrute([1, -3, 2, 3, -4]))      // 5
print(maxAbsoluteSumBrute([-3, -5, -3]))            // 11
print(maxAbsoluteSumBrute([2, -5, 1, -4, 3, -2]))  // 8

print("---- Optimised ----")
print(maxAbsoluteSumOptimised([1, -3, 2, 3, -4]))      // 5
print(maxAbsoluteSumOptimised([-3, -5, -3]))            // 11
print(maxAbsoluteSumOptimised([2, -5, 1, -4, 3, -2]))  // 8

// ============================================================
// MARK: - Test Cases — Edge Cases
// ============================================================

print("---- Edge Case 1: Single Element ----")
print(maxAbsoluteSumOptimised([5]))                 // 5
print(maxAbsoluteSumOptimised([-5]))                // 5
print(maxAbsoluteSumOptimised([0]))                 // 0

print("---- Edge Case 2: All Positive ----")
print(maxAbsoluteSumOptimised([1, 2, 3, 4, 5]))    // 15
print(maxAbsoluteSumOptimised([10, 20, 30]))        // 60

print("---- Edge Case 3: All Negative ----")
print(maxAbsoluteSumOptimised([-1, -2, -3]))        // 6
print(maxAbsoluteSumOptimised([-5, -4, -3]))        // 12
print(maxAbsoluteSumOptimised([-100, -50, -200]))   // 350

print("---- Edge Case 4: Mix Positive Negative ----")
print(maxAbsoluteSumOptimised([1, -3, 2, 3, -4]))  // 5
print(maxAbsoluteSumOptimised([-4, 3, 2, -3, 1]))  // 5

print("---- Edge Case 5: Zeros ----")
print(maxAbsoluteSumOptimised([0, 0, 0]))           // 0
print(maxAbsoluteSumOptimised([-1, 0, -2]))         // 3
print(maxAbsoluteSumOptimised([1, 0, -1]))          // 1

print("---- Edge Case 6: Large Negative Wins ----")
print(maxAbsoluteSumOptimised([-5, -10, -3]))       // 18
print(maxAbsoluteSumOptimised([1, -10, 1]))         // 10

print("---- Edge Case 7: Large Positive Wins ----")
print(maxAbsoluteSumOptimised([5, 10, 3]))          // 18
print(maxAbsoluteSumOptimised([-1, 10, -1]))        // 10

// ============================================================
// MARK: - Complexity Summary
// ============================================================
// Approach       Time      Space
// Brute Force    O(n²)     O(1)
// Optimised      O(n)      O(1)
//
// Key Formula:
// Case 1 — Most positive → maxSum
// Case 2 — Most negative → abs(minSum)
// Answer  → max(maxSum, abs(minSum))
// ============================================================
