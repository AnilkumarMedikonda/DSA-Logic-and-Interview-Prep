import Foundation

// ============================================================
// LC 238 — Product of Array Except Self
// nums = [1, 2, 3, 4] → Output: [24, 12, 8, 6]
// ============================================================

// MARK: - Brute Force
// T - O(n²), S - O(n)
func productExceptSelfBruteForce(_ nums: [Int]) -> [Int] {
    var result: [Int] = []
    for i in 0..<nums.count {
        var product = 1
        for j in 0..<nums.count {
            if i != j {
                product *= nums[j]
            }
        }
        result.append(product)
    }
    return result
}

// MARK: - Optimised
// T - O(n), S - O(1) extra space
// Left pass  → array[i] = product of all elements left of i
// Right pass → multiply array[i] with running right product
func productExceptSelfOptimised(_ nums: [Int]) -> [Int] {
    var array = Array(repeating: 1, count: nums.count)

    var product = 1
    for i in 0..<nums.count {
        array[i] = product
        product *= nums[i]
    }

    var rightProduct = 1
    var i = nums.count - 1
    while i >= 0 {
        array[i] *= rightProduct
        rightProduct *= nums[i]
        i -= 1
    }

    return array
}

// MARK: - Key Notes
// 1. No division allowed — left pass × right pass instead
// 2. result array not counted as extra space per problem statement
// 3. Left pass: array[i] = product of everything BEFORE i, not including i

// MARK: - Tests
assert(productExceptSelfBruteForce([1, 2, 3, 4])     == [24, 12, 8, 6])
assert(productExceptSelfOptimised([1, 2, 3, 4])      == [24, 12, 8, 6])
assert(productExceptSelfBruteForce([-1, 1, 0, -3, 3]) == [0, 0, 9, 0, 0])
assert(productExceptSelfOptimised([-1, 1, 0, -3, 3])  == [0, 0, 9, 0, 0])
assert(productExceptSelfBruteForce([2, 3])            == [3, 2])
assert(productExceptSelfOptimised([2, 3])             == [3, 2])

print("✅ All tests passed")
