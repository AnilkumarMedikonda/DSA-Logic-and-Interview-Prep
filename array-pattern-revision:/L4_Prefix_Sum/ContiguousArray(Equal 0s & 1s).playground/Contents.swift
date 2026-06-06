import Foundation
// ============================================================
// LC 525 — Contiguous Array (Equal 0s & 1s)
// nums = [0, 1, 1, 0, 1, 1, 1, 0] → Output: 4
// ============================================================

// MARK: - Brute Force
// T - O(n²), S - O(1)
func bruteForceContiguousArray(_ nums: [Int]) -> Int {
    var maxCount = 0
    for i in 0..<nums.count {
        var zeros = 0
        var ones = 0
        for j in i..<nums.count {
            if nums[j] == 0 {
                zeros += 1
            } else {
                ones += 1
            }
            if zeros == ones {
                let length = j - i + 1
                if length > maxCount {
                    maxCount = length
                }
            }
        }
    }
    return maxCount
}

// MARK: - Optimised
// T - O(n), S - O(n)
func optimisedContiguousArray(_ nums: [Int]) -> Int {
    var map: [Int: Int] = [0: -1]
    var maxLength = 0
    var sum = 0

    for i in 0..<nums.count {
        if nums[i] == 0 {
            sum += -1
        } else {
            sum += 1
        }

        if let firstOccurrence = map[sum] {
            let length = i - firstOccurrence
            if length > maxLength {
                maxLength = length
            }
        } else {
            map[sum] = i
        }
    }
    return maxLength
}

// MARK: - Key Notes
// 1. Replace 0 → -1, problem becomes longest subarray with sum = 0
// 2. map stores FIRST SEEN index — never update if already exists
// 3. Init map [0: -1] — handles subarray starting from index 0

// MARK: - Tests
assert(bruteForceContiguousArray([0, 1])                    == 2)
assert(optimisedContiguousArray([0, 1])                     == 2)
assert(bruteForceContiguousArray([0, 1, 0])                 == 2)
assert(optimisedContiguousArray([0, 1, 0])                  == 2)
assert(bruteForceContiguousArray([0, 1, 1, 0, 1, 1, 1, 0]) == 4)
assert(optimisedContiguousArray([0, 1, 1, 0, 1, 1, 1, 0])  == 4)
assert(bruteForceContiguousArray([0, 0, 0, 1, 1, 1])        == 6)
assert(optimisedContiguousArray([0, 0, 0, 1, 1, 1])         == 6)

print("✅ All tests passed")
