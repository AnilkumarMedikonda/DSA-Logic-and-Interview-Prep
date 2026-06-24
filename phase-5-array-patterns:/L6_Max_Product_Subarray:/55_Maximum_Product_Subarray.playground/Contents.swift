import UIKit

// ============================================================
// MARK: - Problem
// ============================================================
// LC 152 — Max Product Subarray
// Given an integer array nums, find the contiguous subarray
// that has the largest product and return that product.
//
// Example 1: [2, 3, -2, 4]  → 6   (subarray [2, 3])
// Example 2: [-2, 3, -4]    → 24  (subarray [-2, 3, -4])
// Example 3: [0, 2]         → 2   (subarray [2])
// Example 4: [-2]           → -2  (subarray [-2])
//
// Constraints:
// - 1 <= nums.count <= 200
// - -10 <= nums[i] <= 10
// - Array can have negatives, zeros, single element
// ============================================================


// ============================================================
// MARK: - Interview Q&A
// ============================================================
// Q1: Why do we track currentMin?
// A:  A big negative * another negative = big positive.
//     currentMin holds the most negative value so far,
//     which can flip to the largest positive on next negative.
//
// Q2: Why save tempMax and tempMin before updating?
// A:  If we update currentMax first, the old value is lost.
//     currentMin calculation needs the original currentMax.
//     Saving temps freezes both values before touching either.
//
// Q3: Why 3 candidates — a, b, c?
// A:  a = currentMax * nums[i] → extend running max
//     b = currentMin * nums[i] → negative flip to positive
//     c = nums[i]              → fresh start (handles zeros)
//
// Q4: What happens when array has zero?
// A:  All candidates become 0 or nums[i].
//     c = nums[i] ensures we reset and continue fresh.
//
// Q5: Why init maxProduct with nums[0] not Int.min?
// A:  Array can have all negatives. nums[0] is always
//     a valid answer for single element case.
//
// Q6: How is this different from Max Sum Subarray (LC 53)?
// A:  LC 53 — track only currentMax (addition is simple)
//     LC 152 — track currentMax AND currentMin (multiplication
//     can flip signs, negatives matter)
// ============================================================


// ============================================================
// MARK: - Brute Force
// ============================================================
// Approach: Try every subarray, multiply elements, track max
// Time:  O(n²)
// Space: O(1)
// ============================================================

func maxProductBrute(_ nums: [Int]) -> Int {

    var maxProduct = Int.min

    for i in 0..<nums.count {

        var product = 1

        for j in i..<nums.count {
            product *= nums[j]
            if product > maxProduct {
                maxProduct = product
            }
        }
    }

    return maxProduct
}


// ============================================================
// MARK: - Optimised
// ============================================================
// Approach: Track currentMax and currentMin at every step.
//           At each index pick best of 3 candidates.
// Time:  O(n)
// Space: O(1)
// ============================================================

func maxProductOptimised(_ nums: [Int]) -> Int {

    var currentMax = nums[0]
    var currentMin = nums[0]
    var maxProduct = nums[0]

    for i in 1..<nums.count {

        // Step 1 — freeze both before updating
        let tempMax = currentMax
        let tempMin = currentMin

        // Step 2 — 3 candidates
        let a = tempMax * nums[i]   // extend running max
        let b = tempMin * nums[i]   // negative flip
        let c = nums[i]             // fresh start

        // Step 3 — currentMax = biggest of a, b, c
        if a > b && a > c {
            currentMax = a
        } else if b > c {
            currentMax = b
        } else {
            currentMax = c
        }

        // Step 4 — currentMin = smallest of a, b, c
        if a < b && a < c {
            currentMin = a
        } else if b < c {
            currentMin = b
        } else {
            currentMin = c
        }

        // Step 5 — update global max
        if currentMax > maxProduct {
            maxProduct = currentMax
        }
    }

    return maxProduct
}


// ============================================================
// MARK: - Dry Run
// ============================================================
// nums = [2, 3, -2, 4]
//
// Start: curMax=2  curMin=2  maxProduct=2
//
// i=1, nums[i]=3:
//   a=2*3=6  b=2*3=6  c=3
//   currentMax = 6
//   currentMin = 3
//   maxProduct = 6
//
// i=2, nums[i]=-2:
//   a=6*-2=-12  b=3*-2=-6  c=-2
//   currentMax = -2
//   currentMin = -12
//   maxProduct = 6  ← unchanged
//
// i=3, nums[i]=4:
//   a=-2*4=-8  b=-12*4=-48  c=4
//   currentMax = 4
//   currentMin = -48
//   maxProduct = 6  ← unchanged
//
// Answer: 6 ✅
//
// ─────────────────────────────────────────
// nums = [-2, 3, -4]
//
// Start: curMax=-2  curMin=-2  maxProduct=-2
//
// i=1, nums[i]=3:
//   a=-2*3=-6  b=-2*3=-6  c=3
//   currentMax = 3
//   currentMin = -6
//   maxProduct = 3
//
// i=2, nums[i]=-4:
//   a=3*-4=-12  b=-6*-4=24  c=-4
//   currentMax = 24   ← currentMin saved us!
//   currentMin = -12
//   maxProduct = 24
//
// Answer: 24 ✅
// ============================================================


// ============================================================
// MARK: - Complexity
// ============================================================
// Brute Force:
//   Time  — O(n²) → two nested loops
//   Space — O(1)  → no extra space
//
// Optimised:
//   Time  — O(n)  → single pass
//   Space — O(1)  → only 3 variables
// ============================================================


// ============================================================
// MARK: - Traps
// ============================================================
// Trap 1: Not tracking currentMin
//         → miss negative*negative = positive case
//
// Trap 2: Not saving tempMax and tempMin
//         → stale values corrupt currentMin calculation
//
// Trap 3: Init maxProduct with Int.min
//         → fails for single negative element [-2]
//
// Trap 4: j starting from 0 in brute force
//         → multiplies wrong subarrays
//
// Trap 5: Updating maxProduct with currentMin
//         → answer is always in currentMax
// ============================================================


// ============================================================
// MARK: - Tests
// ============================================================

let test1 = [2, 3, -2, 4]      // Expected: 6
let test2 = [-2, 3, -4]        // Expected: 24
let test3 = [0, 2]             // Expected: 2
let test4 = [-2]               // Expected: -2
let test5 = [-2, 0, -1]        // Expected: 0
let test6 = [2, -5, -2, -4, 3] // Expected: 24

print("=== Brute Force ===")
print(maxProductBrute(test1))   // 6
print(maxProductBrute(test2))   // 24
print(maxProductBrute(test3))   // 2
print(maxProductBrute(test4))   // -2
print(maxProductBrute(test5))   // 0
print(maxProductBrute(test6))   // 24

print("=== Optimised ===")
print(maxProductOptimised(test1))   // 6
print(maxProductOptimised(test2))   // 24
print(maxProductOptimised(test3))   // 2
print(maxProductOptimised(test4))   // -2
print(maxProductOptimised(test5))   // 0
print(maxProductOptimised(test6))   // 24
