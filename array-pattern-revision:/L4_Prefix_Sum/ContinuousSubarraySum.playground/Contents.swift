import Foundation

// ============================================================
// LC 523 — Continuous Subarray Sum
// nums = [23, 2, 4, 6, 7], k = 6 → Output: true
// ============================================================

// MARK: - Brute Force
// T - O(n²), S - O(1)
func continuousSubarrayBruteForce(_ nums: [Int], _ k: Int) -> Bool {
    for i in 0..<nums.count {
        var sum = 0
        for j in i..<nums.count {
            sum += nums[j]
            if sum % k == 0 && j - i + 1 >= 2 {
                return true
            }
        }
    }
    return false
}

// MARK: - Optimised
// T - O(n), S - O(n)
func continuousSubarrayOptimised(_ nums: [Int], _ k: Int) -> Bool {
    var map: [Int: Int] = [0: -1]
    var sum = 0

    for i in 0..<nums.count {
        sum += nums[i]
        let remainder = sum % k

        if let firstIndex = map[remainder] {
            if i - firstIndex >= 2 {
                return true
            }
        } else {
            map[remainder] = i
        }
    }
    return false
}

// MARK: - Key Notes
// 1. Same remainder twice → subarray between is multiple of k
// 2. Gap >= 2 — subarray must have at least 2 elements
// 3. Init map [0: -1] — handles subarray starting from index 0

// MARK: - Tests
assert(continuousSubarrayBruteForce([23, 2, 4, 6, 7], 6)  == true)
assert(continuousSubarrayOptimised([23, 2, 4, 6, 7], 6)   == true)
assert(continuousSubarrayBruteForce([23, 2, 6, 4, 7], 6)  == true)
assert(continuousSubarrayOptimised([23, 2, 6, 4, 7], 6)   == true)
assert(continuousSubarrayBruteForce([23, 2, 6, 4, 7], 13) == false)
assert(continuousSubarrayOptimised([23, 2, 6, 4, 7], 13)  == false)
assert(continuousSubarrayBruteForce([5, 0, 0, 0], 3)      == true)
assert(continuousSubarrayOptimised([5, 0, 0, 0], 3)       == true)

print("✅ All tests passed")
