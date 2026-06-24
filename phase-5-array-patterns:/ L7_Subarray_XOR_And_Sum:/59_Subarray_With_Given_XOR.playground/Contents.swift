import UIKit

// ============================================================
// MARK: - Problem
// ============================================================
// 59 — Subarray With Given XOR
// Given an array of integers nums and an integer k, return
// the total number of subarrays whose XOR equals k.
//
// Example 1: nums = [4, 2, 2, 6, 4], k = 6  → 4
// Example 2: nums = [5, 6, 7, 8, 9], k = 5  → 2
//
// Constraints:
// - 1 <= nums.count <= 100000
// - 0 <= nums[i] <= 10^9
// - Array can have duplicates
// ============================================================


// ============================================================
// MARK: - Interview Q&A
// ============================================================
// Q1: What is the core XOR property used here?
// A:  If prefixXOR up to j = xor, and prefixXOR up to i = xor^k
//     then XOR of subarray from i+1 to j = k.
//     So we look up map[xor ^ k] at each step.
//
// Q2: Why init map with [0: 1]?
// A:  Handles subarrays starting from index 0.
//     If xor == k, then xor ^ k = 0.
//     Without [0:1] we'd miss these subarrays.
//
// Q3: Why XOR and not subtraction like LC 560?
// A:  LC 560 uses prefix sum → sum - k = previous sum
//     XOR version uses prefix XOR → xor ^ k = previous xor
//     XOR is its own inverse: a ^ a = 0, a ^ 0 = a
//
// Q4: Why update map AFTER checking xor ^ k?
// A:  Check first, then store. If we store first,
//     we might count current index as its own start — wrong!
//
// Q5: Time and space complexity?
// A:  Time  → O(n) single pass
//     Space → O(n) HashMap stores prefix XORs
//
// Q6: How is this similar to LC 560?
// A:  Same HashMap prefix pattern — just ^ instead of -
//     LC 560: map[sum - k]   → subarray sum = k
//     XOR:    map[xor ^ k]   → subarray XOR = k
// ============================================================


// ============================================================
// MARK: - Brute Force
// ============================================================
// Approach: Two nested loops, XOR every subarray
// Time:  O(n²)
// Space: O(1)
// ============================================================

func subarrayXORBrute(_ nums: [Int], _ k: Int) -> Int {

    var count = 0

    for i in 0..<nums.count {

        var xor = 0

        for j in i..<nums.count {
            xor ^= nums[j]
            if xor == k {
                count += 1
            }
        }
    }

    return count
}


// ============================================================
// MARK: - Optimised
// ============================================================
// Approach: Prefix XOR + HashMap
//   map stores → [prefixXOR: frequency]
//   At each index check if (xor ^ k) exists in map
//   That means a subarray ending here has XOR = k
// Time:  O(n)
// Space: O(n)
// ============================================================

func subarrayXOROptimised(_ nums: [Int], _ k: Int) -> Int {

    var count = 0
    var map: [Int: Int] = [0: 1]   // init → handles subarrays from index 0
    var xor = 0

    for i in 0..<nums.count {

        xor ^= nums[i]   // running prefix XOR

        // check if xor ^ k exists → subarray with XOR k found
        if let value = map[xor ^ k] {
            count += value
        }

        // update map with current prefix XOR
        if let existing = map[xor] {
            map[xor] = existing + 1
        } else {
            map[xor] = 1
        }
    }

    return count
}


// ============================================================
// MARK: - Dry Run
// ============================================================
// nums = [4, 2, 2, 6, 4], k = 6
//
// map = [0:1]  xor = 0  count = 0
//
// i=0, nums[i]=4:
//   xor = 0^4 = 4
//   xor^k = 4^6 = 2 → not in map
//   map = [0:1, 4:1]
//
// i=1, nums[i]=2:
//   xor = 4^2 = 6
//   xor^k = 6^6 = 0 → map[0]=1 → count=1  ✅ [4,2]
//   map = [0:1, 4:1, 6:1]
//
// i=2, nums[i]=2:
//   xor = 6^2 = 4
//   xor^k = 4^6 = 2 → not in map
//   map = [0:1, 4:2, 6:1]
//
// i=3, nums[i]=6:
//   xor = 4^6 = 2
//   xor^k = 2^6 = 4 → map[4]=2 → count=3  ✅ [2,2,6] and [4,2,2,6]
//   map = [0:1, 4:2, 6:1, 2:1]
//
// i=4, nums[i]=4:
//   xor = 2^4 = 6
//   xor^k = 6^6 = 0 → map[0]=1 → count=4  ✅ [4,2,2,6,4]
//   map = [0:1, 4:2, 6:2, 2:1]
//
// Answer: 4 ✅
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
//   Space — O(n)  → HashMap stores prefix XORs
// ============================================================


// ============================================================
// MARK: - Traps
// ============================================================
// Trap 1: Not initialising map with [0: 1]
//         → misses subarrays starting from index 0
//
// Trap 2: Using sum - k instead of xor ^ k
//         → wrong lookup for XOR problems
//
// Trap 3: Updating map BEFORE checking xor ^ k
//         → counts current index as its own start
//
// Trap 4: Resetting xor inside outer loop
//         → breaks prefix XOR continuity
// ============================================================


// ============================================================
// MARK: - Tests
// ============================================================

let test1 = [4, 2, 2, 6, 4];   let k1 = 6   // Expected: 4
let test2 = [5, 6, 7, 8, 9];   let k2 = 5   // Expected: 2
let test3 = [1, 1, 1];         let k3 = 1   // Expected: 3
let test4 = [4];               let k4 = 4   // Expected: 1
let test5 = [0, 0, 0];         let k5 = 0   // Expected: 6

print("=== Brute Force ===")
print(subarrayXORBrute(test1, k1))   // 4
print(subarrayXORBrute(test2, k2))   // 2
print(subarrayXORBrute(test3, k3))   // 3
print(subarrayXORBrute(test4, k4))   // 1
print(subarrayXORBrute(test5, k5))   // 6

print("=== Optimised ===")
print(subarrayXOROptimised(test1, k1))   // 4
print(subarrayXOROptimised(test2, k2))   // 2
print(subarrayXOROptimised(test3, k3))   // 3
print(subarrayXOROptimised(test4, k4))   // 1
print(subarrayXOROptimised(test5, k5))   // 6
