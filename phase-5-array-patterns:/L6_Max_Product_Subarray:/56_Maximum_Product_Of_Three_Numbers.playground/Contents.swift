import UIKit

// ============================================================
// MARK: - Problem
// ============================================================
// LC 628 — Maximum Product of Three Numbers
// Given an integer array nums, find three numbers whose
// product is maximum and return the maximum product.
//
// Example 1: [1, 2, 3]       → 6
// Example 2: [1, 2, 3, 4]    → 24
// Example 3: [-1, -2, -3]    → -6
// Example 4: [-1, -2, -3, 4] → 24
//
// Constraints:
// - 3 <= nums.count <= 10⁴
// - -1000 <= nums[i] <= 1000
// ============================================================


// ============================================================
// MARK: - Interview Q&A
// ============================================================
// Q1: Why two candidates for the answer?
// A:  Candidate 1 = max1 * max2 * max3 → all positives case
//     Candidate 2 = max1 * min1 * min2 → two negatives case
//     negative * negative = positive, so two smallest numbers
//     multiplied by the largest can beat three largest numbers.
//
// Q2: Why use else if in max/min cascade?
// A:  Without else if, same number can update multiple
//     variables in one iteration — corrupting the tracking.
//     else if ensures each num updates exactly one variable.
//
// Q3: Why init max1/max2/max3 with Int.min?
// A:  Array can have all negatives. Int.min ensures any
//     number in the array will beat the initial value.
//
// Q4: Why init min1/min2 with Int.max?
// A:  Array can have all positives. Int.max ensures any
//     number in the array will beat the initial value.
//
// Q5: How is this different from LC 152?
// A:  LC 152 — find max product subarray (contiguous)
//     LC 628 — find max product of any 3 numbers (non-contiguous)
//     LC 628 is simpler — no currentMin tracking needed.
//
// Q6: Can we solve this with sorting?
// A:  Yes — sort, then compare last3 vs first2*last1.
//     But sorting is O(n log n). One pass is O(n). Better!
// ============================================================


// ============================================================
// MARK: - Brute Force
// ============================================================
// Approach: Try every combination of 3 numbers, track max
// Time:  O(n³)
// Space: O(1)
// ============================================================

func maximumProductBrute(_ nums: [Int]) -> Int {

    var maxProduct = Int.min

    for i in 0..<nums.count {
        for j in i+1..<nums.count {
            for k in j+1..<nums.count {
                let product = nums[i] * nums[j] * nums[k]
                if product > maxProduct {
                    maxProduct = product
                }
            }
        }
    }

    return maxProduct
}


// ============================================================
// MARK: - Optimised
// ============================================================
// Approach: One pass — track top 3 max and bottom 2 min.
//           Answer is max of two candidates.
// Time:  O(n)
// Space: O(1)
// ============================================================

func maximumProductOptimised(_ nums: [Int]) -> Int {

    var max1 = Int.min   // largest
    var max2 = Int.min   // 2nd largest
    var max3 = Int.min   // 3rd largest

    var min1 = Int.max   // smallest
    var min2 = Int.max   // 2nd smallest

    for num in nums {

        // update top 3 max — cascade down
        if num > max1 {
            max3 = max2
            max2 = max1
            max1 = num
        } else if num > max2 {
            max3 = max2
            max2 = num
        } else if num > max3 {
            max3 = num
        }

        // update bottom 2 min — cascade down
        if num < min1 {
            min2 = min1
            min1 = num
        } else if num < min2 {
            min2 = num
        }
    }

    // two candidates
    let candidate1 = max1 * max2 * max3   // top 3 largest
    let candidate2 = max1 * min1 * min2   // 2 smallest * largest

    if candidate1 > candidate2 {
        return candidate1
    } else {
        return candidate2
    }
}


// ============================================================
// MARK: - Dry Run
// ============================================================
// nums = [-1, -2, -3, 4]
//
// num=-1: max1=-1  max2=MIN  max3=MIN  min1=-1  min2=MAX
// num=-2: max1=-1  max2=-2   max3=MIN  min1=-2  min2=-1
// num=-3: max1=-1  max2=-2   max3=-3   min1=-3  min2=-2
// num= 4: max1=4   max2=-1   max3=-2   min1=-3  min2=-2
//
// candidate1 = 4 * -1 * -2  = 8
// candidate2 = 4 * -3 * -2  = 24  ← wins!
//
// Answer: 24 ✅
//
// ─────────────────────────────────────────
// nums = [1, 2, 3, 4]
//
// num=1: max1=1   max2=MIN  max3=MIN  min1=1  min2=MAX
// num=2: max1=2   max2=1    max3=MIN  min1=1  min2=2
// num=3: max1=3   max2=2    max3=1    min1=1  min2=2
// num=4: max1=4   max2=3    max3=2    min1=1  min2=2
//
// candidate1 = 4 * 3 * 2 = 24  ← wins!
// candidate2 = 4 * 1 * 2 = 8
//
// Answer: 24 ✅
// ============================================================


// ============================================================
// MARK: - Complexity
// ============================================================
// Brute Force:
//   Time  — O(n³) → three nested loops
//   Space — O(1)  → no extra space
//
// Optimised:
//   Time  — O(n)  → single pass
//   Space — O(1)  → only 5 variables
// ============================================================


// ============================================================
// MARK: - Traps
// ============================================================
// Trap 1: Using if instead of else if in cascade
//         → same number updates multiple variables
//
// Trap 2: Only checking candidate1 (top 3 max)
//         → misses negative*negative case
//
// Trap 3: Init max with 0 instead of Int.min
//         → fails for all-negative arrays
//
// Trap 4: Forgetting min2 in candidate2
//         → wrong answer for two-negative cases
// ============================================================


// ============================================================
// MARK: - Tests
// ============================================================

let test1 = [1, 2, 3]           // Expected: 6
let test2 = [1, 2, 3, 4]        // Expected: 24
let test3 = [-1, -2, -3]        // Expected: -6
let test4 = [-1, -2, -3, 4]     // Expected: 24
let test5 = [-10, -10, 1, 3, 2] // Expected: 300
let test6 = [0, 0, 0]           // Expected: 0

print("=== Brute Force ===")
print(maximumProductBrute(test1))   // 6
print(maximumProductBrute(test2))   // 24
print(maximumProductBrute(test3))   // -6
print(maximumProductBrute(test4))   // 24
print(maximumProductBrute(test5))   // 300
print(maximumProductBrute(test6))   // 0

print("=== Optimised ===")
print(maximumProductOptimised(test1))   // 6
print(maximumProductOptimised(test2))   // 24
print(maximumProductOptimised(test3))   // -6
print(maximumProductOptimised(test4))   // 24
print(maximumProductOptimised(test5))   // 300
print(maximumProductOptimised(test6))   // 0
