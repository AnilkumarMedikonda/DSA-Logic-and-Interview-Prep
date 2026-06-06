import Foundation

// MARK: - LC 724 Pivot Index

// MARK: - Key Interview Points
// 1. Pivot = index where leftSum == rightSum
// 2. rightSum = total - leftSum - nums[i]  → nums[i] is pivot, not left or right
// 3. Check condition BEFORE updating leftSum
// 4. T: O(n)  S: O(1)  → no extra space needed

// MARK: - Formula
// total    = sum of all elements
// rightSum = total - leftSum - nums[i]
// if leftSum == rightSum → return i
// leftSum += nums[i]  ← always at end

// MARK: - Brute Force  T: O(n²)  S: O(1)
func pivotIndexBrute(_ nums: [Int]) -> Int {
    for i in 0..<nums.count {
        var leftSum = 0
        var rightSum = 0
        for left in 0..<i {
            leftSum += nums[left]
        }
        for right in i+1..<nums.count {
            rightSum += nums[right]
        }
        if leftSum == rightSum {
            return i
        }
    }
    return -1
}

// MARK: - Optimised  T: O(n)  S: O(1)
func pivotIndexOptimised(_ nums: [Int]) -> Int {
    var total = 0
    for num in nums {
        total += num
    }
    var leftSum = 0
    for i in 0..<nums.count {
        let rightSum = total - leftSum - nums[i]
        if leftSum == rightSum {
            return i
        }
        leftSum += nums[i]
    }
    return -1
}

// MARK: - Traps
// ❌ leftSum += nums[i] before check  → wrong leftSum at pivot
// ❌ rightSum = total - leftSum       → forgot to remove nums[i]
// ❌ variable shadowing in brute      → inner i over outer i

// MARK: - Tests
let nums = [1, 7, 3, 6, 5, 6]
print(pivotIndexBrute(nums))      // 3
print(pivotIndexOptimised(nums))  // 3

let nums2 = [1, 2, 3]
print(pivotIndexBrute(nums2))     // -1
print(pivotIndexOptimised(nums2)) // -1

let nums3 = [-1, -1, -1, 0, 1, 1]
print(pivotIndexBrute(nums3))     // 0
print(pivotIndexOptimised(nums3)) // 0
