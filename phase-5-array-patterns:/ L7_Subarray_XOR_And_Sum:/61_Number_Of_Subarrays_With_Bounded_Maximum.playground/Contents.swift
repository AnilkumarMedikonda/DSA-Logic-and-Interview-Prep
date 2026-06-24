import UIKit

// ============================================================
// MARK: - Problem
// ============================================================
// LC 795 — Subarrays With Bounded Maximum
// Given an integer array nums and two integers left and right,
// return the number of contiguous subarrays where the maximum
// element is between left and right (inclusive).
//
// Example 1: nums=[2,1,4,3], left=2, right=3  → 3
// Example 2: nums=[2,9,2,5,6], left=2, right=8 → 7
//
// Constraints:
// - 1 <= nums.count <= 50000
// - 0 <= nums[i] <= 10^9
// - 0 <= left <= right <= 10^9
// ============================================================


// ============================================================
// MARK: - Interview Q&A
// ============================================================
// Q1: What is the core idea of brute force?
// A:  Try every subarray, track max element.
//     If left <= max <= right → count it.
//
// Q2: What is the optimised trick?
// A:  f(x) = count of subarrays where all elements <= x
//     Answer = f(right) - f(left - 1)
//     f(right) includes subarrays with max in range AND below
//     f(left-1) removes subarrays with max below range
//     Difference = subarrays with max exactly in [left, right]
//
// Q3: How do we compute f(x) in O(n)?
// A:  Track count of valid subarrays ending at each index.
//     If nums[i] <= x → cur += 1 (extend previous subarrays)
//     If nums[i] > x  → cur = 0  (reset, element too large)
//     Add cur to result at each step.
//
// Q4: Why cur resets to 0 when nums[i] > x?
// A:  Element exceeds x → no subarray ending here is valid.
//     All previous subarrays are broken by this element.
//
// Q5: Time and space complexity?
// A:  Brute  → Time O(n²), Space O(1)
//     Optimised → Time O(n), Space O(1)
// ============================================================


// ============================================================
// MARK: - Brute Force
// ============================================================
// Approach: Try every subarray, track max, check if in range
// Time:  O(n²)
// Space: O(1)
// ============================================================

func subarraysBoundedMaxBrute(_ nums: [Int], _ left: Int, _ right: Int) -> Int {

    var count = 0

    for i in 0..<nums.count {

        var maxVal = Int.min

        for j in i..<nums.count {

            if nums[j] > maxVal {
                maxVal = nums[j]
            }

            if maxVal >= left && maxVal <= right {
                count += 1
            }
        }
    }

    return count
}


// ============================================================
// MARK: - Optimised
// ============================================================
// Approach: Count by subtraction
//   f(x) = count subarrays where max <= x
//   Answer = f(right) - f(left - 1)
// Time:  O(n)
// Space: O(1)
// ============================================================

func countSubarraysWithMaxAtMost(_ nums: [Int], _ x: Int) -> Int {

    var result = 0
    var cur = 0

    for i in 0..<nums.count {
        if nums[i] <= x {
            cur += 1        // extend valid subarrays ending here
        } else {
            cur = 0         // reset — element too large
        }
        result += cur
    }

    return result
}

func subarraysBoundedMaxOptimised(_ nums: [Int], _ left: Int, _ right: Int) -> Int {
    return countSubarraysWithMaxAtMost(nums, right) -
           countSubarraysWithMaxAtMost(nums, left - 1)
}


// ============================================================
// MARK: - Dry Run
// ============================================================
// nums = [2, 1, 4, 3], left = 2, right = 3
//
// All subarrays:
// [2]       → max=2 ✅
// [2,1]     → max=2 ✅
// [2,1,4]   → max=4 ❌
// [2,1,4,3] → max=4 ❌
// [1]       → max=1 ❌
// [1,4]     → max=4 ❌
// [1,4,3]   → max=4 ❌
// [4]       → max=4 ❌
// [4,3]     → max=4 ❌
// [3]       → max=3 ✅
// Answer: 3 ✅
//
// ─────────────────────────────────────────
// Optimised dry run:
//
// f(right=3):
// i=0, nums[0]=2 <= 3 → cur=1  result=1
// i=1, nums[1]=1 <= 3 → cur=2  result=3
// i=2, nums[2]=4 >  3 → cur=0  result=3
// i=3, nums[3]=3 <= 3 → cur=1  result=4
// f(3) = 4
//
// f(left-1=1):
// i=0, nums[0]=2 >  1 → cur=0  result=0
// i=1, nums[1]=1 <= 1 → cur=1  result=1
// i=2, nums[2]=4 >  1 → cur=0  result=1
// i=3, nums[3]=3 >  1 → cur=0  result=1
// f(1) = 1
//
// Answer = f(3) - f(1) = 4 - 1 = 3 ✅
// ============================================================


// ============================================================
// MARK: - Complexity
// ============================================================
// Brute Force:
//   Time  — O(n²) → two nested loops
//   Space — O(1)  → no extra space
//
// Optimised:
//   Time  — O(n)  → two single passes
//   Space — O(1)  → only cur variable
// ============================================================


// ============================================================
// MARK: - Traps
// ============================================================
// Trap 1: Using left instead of left-1 in subtraction
//         → off by one, excludes valid subarrays
//
// Trap 2: Not resetting cur when nums[i] > x
//         → counts invalid subarrays
//
// Trap 3: Checking max == right instead of max <= right in f(x)
//         → wrong helper function logic
//
// Trap 4: Forgetting that f(x) counts ALL subarrays with max <= x
//         → not just max == x
// ============================================================


// ============================================================
// MARK: - Tests
// ============================================================

let test1nums = [2, 1, 4, 3];      let l1 = 2; let r1 = 3   // Expected: 3
let test2nums = [2, 9, 2, 5, 6];   let l2 = 2; let r2 = 8   // Expected: 7
let test3nums = [1, 3, 2];         let l3 = 2; let r3 = 3   // Expected: 4
let test4nums = [2, 3];            let l4 = 2; let r4 = 3   // Expected: 3
let test5nums = [5];               let l5 = 1; let r5 = 3   // Expected: 0

print("=== Brute Force ===")
print(subarraysBoundedMaxBrute(test1nums, l1, r1))   // 3
print(subarraysBoundedMaxBrute(test2nums, l2, r2))   // 7
print(subarraysBoundedMaxBrute(test3nums, l3, r3))   // 4
print(subarraysBoundedMaxBrute(test4nums, l4, r4))   // 3
print(subarraysBoundedMaxBrute(test5nums, l5, r5))   // 0

print("=== Optimised ===")
print(subarraysBoundedMaxOptimised(test1nums, l1, r1))   // 3
print(subarraysBoundedMaxOptimised(test2nums, l2, r2))   // 7
print(subarraysBoundedMaxOptimised(test3nums, l3, r3))   // 4
print(subarraysBoundedMaxOptimised(test4nums, l4, r4))   // 3
print(subarraysBoundedMaxOptimised(test5nums, l5, r5))   // 0
