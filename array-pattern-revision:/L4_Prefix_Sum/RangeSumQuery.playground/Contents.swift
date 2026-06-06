import UIKit

// MARK: - LC 303 Range Sum Query - Immutable

// MARK: - Key Interview Points
// 1. Build prefix once in init → O(n)
// 2. Every query → O(1)
// 3. prefix[0] = 0 → dummy base → handles left = 0 safely

// MARK: - Formula
// Build   → prefix[i+1] = prefix[i] + nums[i]
// Query   → prefix[right+1] - prefix[left]
// Why +1  → prefix shifted by 1, so nums[right] lives at prefix[right+1]
// Why -left → removes unwanted left part

// MARK: - Brute Force  T: O(n) per query  S: O(1)
func sumRangeBrute(_ nums: [Int], _ left: Int, _ right: Int) -> Int {
    var sum = 0
    for i in left...right {
        sum += nums[i]
    }
    return sum
}

// MARK: - Optimised  T: O(n) build, O(1) query  S: O(n)
class NumArray {
    private var prefix: [Int]

    init(_ nums: [Int]) {
        prefix = Array(repeating: 0, count: nums.count + 1)
        for i in 0..<nums.count {
            prefix[i + 1] = prefix[i] + nums[i]
        }
    }

    func sumRange(_ left: Int, _ right: Int) -> Int {
        return prefix[right + 1] - prefix[left]
    }
}

// MARK: - Traps
// ❌ prefix[right] instead of prefix[right+1] → misses nums[right]
// ❌ prefix size n instead of n+1             → index out of bounds
// ❌ rebuilding prefix on every query         → loses O(1) benefit

// MARK: - Tests
let obj = NumArray([-2, 0, 3, -5, 2, -1])
print(obj.sumRange(0, 2))   // 1
print(obj.sumRange(2, 5))   // -1
print(obj.sumRange(0, 5))   // -3
