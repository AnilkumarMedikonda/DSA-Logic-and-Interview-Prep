import UIKit

// ============================================================
// MARK: - Problem
// ============================================================
// LC 560 — Subarray Sum Equals K
// Given an array of integers nums and an integer k, return
// the total number of subarrays whose sum equals k.
//
// Example 1: nums = [1, 2, 3], k = 3       → 2
// Example 2: nums = [1, 1, 1], k = 2       → 2
// Example 3: nums = [1, -1, 1], k = 1      → 3
//
// Constraints:
// - 1 <= nums.count <= 20000
// - -1000 <= nums[i] <= 1000
// - Array can have negative numbers
// ============================================================


// ============================================================
// MARK: - Interview Q&A
// ============================================================
// Q1: Why can't we use sliding window here?
// A:  Sliding window only works on positive numbers.
//     Negatives break the monotonic property — adding more
//     elements doesn't guarantee sum increases.
//     HashMap prefix sum works for negatives too.
//
// Q2: Why init map with [0: 1]?
// A:  Handles case where subarray starts from index 0.
//     If prefixSum == k, then sum - k = 0.
//     Without [0:1], we'd miss these subarrays.
//
// Q3: What does map[sum - k] mean?
// A:  If prefixSum at j = sum, and prefixSum at i = sum - k,
//     then subarray from i+1 to j has sum = k.
//     map[sum - k] tells how many such starting points exist.
//
// Q4: Why update map AFTER checking sum - k?
// A:  We check first, then store. If we store first,
//     we might count the current index as a valid start
//     for itself — wrong!
//
// Q5: What is the time and space complexity?
// A:  Time  → O(n) single pass
//     Space → O(n) HashMap stores at most n prefix sums
//
// Q6: How is this different from Two Sum?
// A:  Two Sum → find indices where nums[i] + nums[j] = target
//     LC 560  → find count of subarrays where sum = k
//     Both use HashMap but for different lookups.
// ============================================================


// ============================================================
// MARK: - Brute Force
// ============================================================
// Approach: Two nested loops, try every subarray
// Time:  O(n²)
// Space: O(1)
// ============================================================

func subarraySumBrute(_ nums: [Int], _ k: Int) -> Int {

    var count = 0

    for i in 0..<nums.count {

        var sum = 0

        for j in i..<nums.count {
            sum += nums[j]
            if sum == k {
                count += 1
            }
        }
    }

    return count
}


// ============================================================
// MARK: - Optimised
// ============================================================
// Approach: Prefix sum + HashMap
//   map stores → [prefixSum: frequency]
//   At each index check if (sum - k) exists in map
//   That means a subarray ending here sums to k
// Time:  O(n)
// Space: O(n)
// ============================================================

func subarraySumOptimised(_ nums: [Int], _ k: Int) -> Int {

    var map: [Int: Int] = [0: 1]   // init with 0 → handles subarrays from index 0
    var count = 0
    var sum = 0

    for i in 0..<nums.count {

        sum += nums[i]

        // check if sum - k exists → subarray with sum k found
        if let value = map[sum - k] {
            count += value
        }

        // update map with current prefix sum
        if let existing = map[sum] {
            map[sum] = existing + 1
        } else {
            map[sum] = 1
        }
    }

    return count
}


// ============================================================
// MARK: - Dry Run
// ============================================================
// nums = [1, 2, 3], k = 3
//
// map = [0: 1]   sum = 0   count = 0
//
// i=0, nums[i]=1:
//   sum = 1
//   sum-k = 1-3 = -2 → not in map
//   map = [0:1, 1:1]
//
// i=1, nums[i]=2:
//   sum = 3
//   sum-k = 3-3 = 0 → map[0]=1 → count = 1  ✅ [1,2]
//   map = [0:1, 1:1, 3:1]
//
// i=2, nums[i]=3:
//   sum = 6
//   sum-k = 6-3 = 3 → map[3]=1 → count = 2  ✅ [3]
//   map = [0:1, 1:1, 3:1, 6:1]
//
// Answer: 2 ✅
//
// ─────────────────────────────────────────
// nums = [1, -1, 1], k = 1
//
// map = [0: 1]   sum = 0   count = 0
//
// i=0, nums[i]=1:
//   sum = 1
//   sum-k = 0 → map[0]=1 → count = 1  ✅ [1]
//   map = [0:1, 1:1]
//
// i=1, nums[i]=-1:
//   sum = 0
//   sum-k = -1 → not in map
//   map = [0:2, 1:1]
//
// i=2, nums[i]=1:
//   sum = 1
//   sum-k = 0 → map[0]=2 → count = 3  ✅ [1,-1,1] and [1]
//   map = [0:2, 1:2]
//
// Answer: 3 ✅
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
// Trap 1: Not initialising map with [0: 1]
//         → misses subarrays starting from index 0
//
// Trap 2: Updating map BEFORE checking sum - k
//         → counts current index as its own start point
//
// Trap 3: Using sliding window
//         → breaks on negative numbers
//
// Trap 4: Storing sum itself instead of sum - k
//         → wrong lookup, wrong count
// ============================================================


// ============================================================
// MARK: - Tests
// ============================================================

let test1 = [1, 2, 3];      let k1 = 3    // Expected: 2
let test2 = [1, 1, 1];      let k2 = 2    // Expected: 2
let test3 = [1, -1, 1];     let k3 = 1    // Expected: 3
let test4 = [1];             let k4 = 1    // Expected: 1
let test5 = [1, 2, 3];      let k5 = 6    // Expected: 1
let test6 = [-1, -1, 1];    let k6 = -1   // Expected: 2

print("=== Brute Force ===")
print(subarraySumBrute(test1, k1))   // 2
print(subarraySumBrute(test2, k2))   // 2
print(subarraySumBrute(test3, k3))   // 3
print(subarraySumBrute(test4, k4))   // 1
print(subarraySumBrute(test5, k5))   // 1
print(subarraySumBrute(test6, k6))   // 2

print("=== Optimised ===")
print(subarraySumOptimised(test1, k1))   // 2
print(subarraySumOptimised(test2, k2))   // 2
print(subarraySumOptimised(test3, k3))   // 3
print(subarraySumOptimised(test4, k4))   // 1
print(subarraySumOptimised(test5, k5))   // 1
print(subarraySumOptimised(test6, k6))   // 2
