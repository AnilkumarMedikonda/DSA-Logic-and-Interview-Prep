import UIKit

// ============================================================
// MARK: - Problem
// ============================================================
// 60 — Longest Subarray With Zero Sum
// Given an array of integers, find the length of the longest
// subarray whose sum equals zero.
//
// Example 1: [15, -2, 2, -8, 1, 7, 10, 23] → 5  ([-2,2,-8,1,7])
// Example 2: [1, 2, 3]                      → 0  (no zero sum)
// Example 3: [0]                            → 1
// Example 4: [3, -3, 1]                     → 2  ([3,-3])
//
// Constraints:
// - 1 <= nums.count <= 100000
// - -1000 <= nums[i] <= 1000
// - Array can have negatives and zeros
// ============================================================


// ============================================================
// MARK: - Interview Q&A
// ============================================================
// Q1: What is the core idea of the optimised approach?
// A:  If prefixSum at index i == prefixSum at index j,
//     then subarray from i+1 to j has sum = 0.
//     Same prefix sum appearing twice = zero sum subarray!
//
// Q2: Why init map with [0: -1]?
// A:  Handles case where subarray starts from index 0.
//     If sum becomes 0 at index i, length = i - (-1) = i+1
//     which is the correct full length from start.
//
// Q3: Why store only FIRST occurrence in map?
// A:  We want the LONGEST subarray.
//     First occurrence gives maximum possible length.
//     Overwriting would give shorter subarrays.
//
// Q4: Why not check if sum == 0 explicitly in optimised?
// A:  Not needed — map[0: -1] handles it automatically.
//     If sum == 0, map[0] exists with index -1.
//     length = i - (-1) = i + 1 ✅
//     Same prefix sum twice already covers all zero sum cases.
//
// Q5: How is this different from LC 560?
// A:  LC 560 → count subarrays with sum = k
//             map stores [prefixSum: frequency]
//     LC 60  → find longest subarray with sum = 0
//             map stores [prefixSum: firstIndex]
//
// Q6: Time and space complexity?
// A:  Time  → O(n) single pass
//     Space → O(n) HashMap stores prefix sums
// ============================================================


// ============================================================
// MARK: - Brute Force
// ============================================================
// Approach: Two nested loops, find longest zero sum subarray
// Time:  O(n²)
// Space: O(1)
// ============================================================

func longestSubarrayBrute(_ nums: [Int]) -> Int {

    var maxLength = 0

    for i in 0..<nums.count {

        var sum = 0

        for j in i..<nums.count {
            sum += nums[j]
            if sum == 0 {
                let length = j - i + 1
                if length > maxLength {
                    maxLength = length
                }
            }
        }
    }

    return maxLength
}


// ============================================================
// MARK: - Optimised
// ============================================================
// Approach: Prefix sum + HashMap
//   map stores → [prefixSum: firstIndex]
//   Same prefix sum seen again → zero sum subarray found
//   length = currentIndex - firstIndex
// Time:  O(n)
// Space: O(n)
// ============================================================

func longestSubarrayOptimised(_ nums: [Int]) -> Int {

    var maxLength = 0
    var map: [Int: Int] = [0: -1]   // init → handles subarrays from index 0
    var sum = 0

    for i in 0..<nums.count {

        sum += nums[i]

        if let index = map[sum] {
            // same prefix sum seen → zero sum subarray found
            let length = i - index
            if length > maxLength {
                maxLength = length
            }
        } else {
            // store first occurrence only → gives longest length
            map[sum] = i
        }
    }

    return maxLength
}


// ============================================================
// MARK: - Dry Run
// ============================================================
// nums = [15, -2, 2, -8, 1, 7, 10, 23]
//
// map = [0:-1]  sum = 0  maxLength = 0
//
// i=0, nums[i]=15:  sum=15  → map[15]=0
// i=1, nums[i]=-2:  sum=13  → map[13]=1
// i=2, nums[i]=2:   sum=15  → map[15]=0 exists! length=2-0=2  maxLength=2
// i=3, nums[i]=-8:  sum=7   → map[7]=3
// i=4, nums[i]=1:   sum=8   → map[8]=4
// i=5, nums[i]=7:   sum=15  → map[15]=0 exists! length=5-0=5  maxLength=5 ✅
// i=6, nums[i]=10:  sum=25  → map[25]=6
// i=7, nums[i]=23:  sum=48  → map[48]=7
//
// Answer: 5 ✅  → subarray [-2, 2, -8, 1, 7]
//
// ─────────────────────────────────────────
// nums = [3, -3, 1]
//
// map = [0:-1]  sum = 0  maxLength = 0
//
// i=0, nums[i]=3:   sum=3   → map[3]=0
// i=1, nums[i]=-3:  sum=0   → map[0]=-1 exists! length=1-(-1)=2  maxLength=2 ✅
// i=2, nums[i]=1:   sum=1   → map[1]=2
//
// Answer: 2 ✅  → subarray [3, -3]
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
//   Space — O(n)  → HashMap stores prefix sums
// ============================================================


// ============================================================
// MARK: - Traps
// ============================================================
// Trap 1: Not initialising map with [0: -1]
//         → misses zero sum subarrays starting from index 0
//
// Trap 2: Overwriting map[sum] on revisit
//         → gives shorter subarray, not longest
//
// Trap 3: length = i - index + 1
//         → off by one error, correct is i - index
//
// Trap 4: Checking sum == 0 instead of map lookup
//         → misses subarrays where same prefix sum appears twice
// ============================================================


// ============================================================
// MARK: - Tests
// ============================================================

let test1 = [15, -2, 2, -8, 1, 7, 10, 23]   // Expected: 5
let test2 = [1, 2, 3]                         // Expected: 0
let test3 = [0]                               // Expected: 1
let test4 = [3, -3, 1]                        // Expected: 2
let test5 = [1, -1, 1, -1]                    // Expected: 4
let test6 = [0, 0, 0]                         // Expected: 3

print("=== Brute Force ===")
print(longestSubarrayBrute(test1))   // 5
print(longestSubarrayBrute(test2))   // 0
print(longestSubarrayBrute(test3))   // 1
print(longestSubarrayBrute(test4))   // 2
print(longestSubarrayBrute(test5))   // 4
print(longestSubarrayBrute(test6))   // 3

print("=== Optimised ===")
print(longestSubarrayOptimised(test1))   // 5
print(longestSubarrayOptimised(test2))   // 0
print(longestSubarrayOptimised(test3))   // 1
print(longestSubarrayOptimised(test4))   // 2
print(longestSubarrayOptimised(test5))   // 4
print(longestSubarrayOptimised(test6))   // 3
