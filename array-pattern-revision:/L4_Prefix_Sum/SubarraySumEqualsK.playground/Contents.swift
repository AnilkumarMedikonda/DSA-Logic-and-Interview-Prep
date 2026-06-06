import Foundation

// ============================================================
// LC 560 — Subarray Sum Equals K
// nums = [1, -1, 1, 1, 1], k = 3 → Output: 2
// ============================================================

// MARK: - Brute Force
// T - O(n²), S - O(1)
func subarraySumKBruteForce(_ nums: [Int], _ k: Int) -> Int {
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

// MARK: - Optimised
// T - O(n), S - O(n)
func subarraySumKOptimised(_ nums: [Int], _ k: Int) -> Int {
    var map: [Int: Int] = [0: 1]
    var count = 0
    var sum = 0

    for i in 0..<nums.count {
        sum += nums[i]
        if let existing = map[sum - k] {
            count += existing
        }
        if let existing = map[sum] {
            map[sum] = existing + 1
        } else {
            map[sum] = 1
        }
    }
    return count
}

// MARK: - Key Notes
// 1. Init map [0:1] — else subarrays from index 0 are missed
// 2. Check map BEFORE updating — else current index counts itself
// 3. Sliding window fails — negative numbers break it

// MARK: - Tests
assert(subarraySumKBruteForce([1, -1, 1, 1, 1], 3) == 2)
assert(subarraySumKOptimised([1, -1, 1, 1, 1],  3) == 2)
assert(subarraySumKBruteForce([1, 1, 1], 2)        == 2)
assert(subarraySumKOptimised([1, 1, 1],  2)        == 2)
assert(subarraySumKBruteForce([-1, -1, 1], 0)      == 1)
assert(subarraySumKOptimised([-1, -1, 1],  0)      == 1)
assert(subarraySumKBruteForce([0, 0, 0], 0)        == 6)
assert(subarraySumKOptimised([0, 0, 0],  0)        == 6)

print("✅ All tests passed")
