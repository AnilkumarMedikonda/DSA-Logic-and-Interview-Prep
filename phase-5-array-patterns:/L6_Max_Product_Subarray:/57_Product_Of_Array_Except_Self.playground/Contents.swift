import UIKit

// ============================================================
// MARK: - Problem
// ============================================================
// LC 238 — Product of Array Except Self
// Given an integer array nums, return an array answer such
// that answer[i] is equal to the product of all elements
// of nums except nums[i]. Must not use division!
//
// Example 1: [1, 2, 3, 4]      → [24, 12, 8, 6]
// Example 2: [-1, 1, 0, -3, 3] → [0, 0, 9, 0, 0]
//
// Constraints:
// - 2 <= nums.count <= 100000
// - No division allowed
// - Must solve in O(n)
// ============================================================


// ============================================================
// MARK: - Interview Q&A
// ============================================================
// Q1: Why can't we use division?
// A:  If array contains zero, division breaks.
//     e.g. total product = 0, dividing by nums[i] = 0/0 = crash.
//     Prefix approach handles zeros naturally.
//
// Q2: What is the core idea of the optimised approach?
// A:  answer[i] = product of everything LEFT of i
//                 * product of everything RIGHT of i
//     Left pass builds prefix products left to right.
//     Right pass multiplies postfix products right to left.
//
// Q3: Why answer[i] = answer[i-1] * nums[i-1] and not nums[i]?
// A:  We want product of everything BEFORE i, not AT i.
//     nums[i-1] is the last element before index i.
//     Using nums[i] would include self — wrong!
//
// Q4: Why init answer array with 1s?
// A:  Multiplication identity is 1.
//     answer[0] has nothing on its left → 1 is correct.
//     answer filled with 1s means right pass works cleanly.
//
// Q5: Why is space O(1) not O(n)?
// A:  The output array answer[] doesn't count as extra space
//     since it is the required return value.
//     The only extra variable is `right` — constant space.
//
// Q6: What pattern does this use?
// A:  Prefix product — same as L4 prefix sum but with
//     multiplication instead of addition, done from both sides.
// ============================================================


// ============================================================
// MARK: - Brute Force
// ============================================================
// Approach: For every index i, multiply all elements except i
// Time:  O(n²)
// Space: O(n) — result array
// ============================================================

func productExceptSelfBrute(_ nums: [Int]) -> [Int] {

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


// ============================================================
// MARK: - Optimised
// ============================================================
// Approach: Two pass prefix product
//   Pass 1 (left to right) → answer[i] = product of LEFT of i
//   Pass 2 (right to left) → multiply product of RIGHT of i
// Time:  O(n)
// Space: O(1) — answer array doesn't count as extra space
// ============================================================

func productExceptSelfOptimised(_ nums: [Int]) -> [Int] {

    let n = nums.count
    var answer = Array(repeating: 1, count: n)

    // Step 1 — left pass
    // answer[i] = product of everything left of i
    for i in 1..<n {
        answer[i] = answer[i - 1] * nums[i - 1]
    }

    // Step 2 — right pass
    // multiply answer[j] by product of everything right of j
    var right = 1
    var j = n - 1

    while j >= 0 {
        answer[j] *= right
        right *= nums[j]
        j -= 1
    }

    return answer
}


// ============================================================
// MARK: - Dry Run
// ============================================================
// nums = [1, 2, 3, 4]
//
// Step 1 — init:
// answer = [1, 1, 1, 1]
//
// Step 2 — left pass:
// i=1: answer[1] = answer[0] * nums[0] = 1 * 1 = 1
// i=2: answer[2] = answer[1] * nums[1] = 1 * 2 = 2
// i=3: answer[3] = answer[2] * nums[2] = 2 * 3 = 6
// answer = [1, 1, 2, 6]
//
// Step 3 — right pass:
// j=3: answer[3] *= 1  → 6*1=6    right = 1*4  = 4
// j=2: answer[2] *= 4  → 2*4=8    right = 4*3  = 12
// j=1: answer[1] *= 12 → 1*12=12  right = 12*2 = 24
// j=0: answer[0] *= 24 → 1*24=24  right = 24*1 = 24
// answer = [24, 12, 8, 6] ✅
//
// ─────────────────────────────────────────
// Visual:
// nums    = [ 1,   2,   3,   4]
// left    = [ 1,   1,   2,   6]  ← product of LEFT side
// right   = [24,  12,   4,   1]  ← product of RIGHT side
// answer  = [24,  12,   8,   6]  ← left * right ✅
// ============================================================


// ============================================================
// MARK: - Complexity
// ============================================================
// Brute Force:
//   Time  — O(n²) → two nested loops
//   Space — O(n)  → result array
//
// Optimised:
//   Time  — O(n)  → two single passes
//   Space — O(1)  → only `right` variable is extra
// ============================================================


// ============================================================
// MARK: - Traps
// ============================================================
// Trap 1: Using division → breaks when array has zero
//
// Trap 2: answer[i] = answer[i-1] * nums[i] instead of nums[i-1]
//         → includes self in product — wrong!
//
// Trap 3: Forgetting to init answer with 1s
//         → answer[0] left pass is skipped, stays 0 not 1
//
// Trap 4: Right pass order wrong — must multiply THEN update right
//         answer[j] *= right   ← first
//         right *= nums[j]     ← then update
// ============================================================


// ============================================================
// MARK: - Tests
// ============================================================

let test1 = [1, 2, 3, 4]           // Expected: [24, 12, 8, 6]
let test2 = [-1, 1, 0, -3, 3]      // Expected: [0, 0, 9, 0, 0]
let test3 = [2, 3]                  // Expected: [3, 2]
let test4 = [0, 0]                  // Expected: [0, 0]
let test5 = [1, 0, 3, 4]           // Expected: [0, 12, 0, 0]
let test6 = [-1, -2, -3, -4]       // Expected: [-24, -12, -8, -6]

print("=== Brute Force ===")
print(productExceptSelfBrute(test1))   // [24, 12, 8, 6]
print(productExceptSelfBrute(test2))   // [0, 0, 9, 0, 0]
print(productExceptSelfBrute(test3))   // [3, 2]
print(productExceptSelfBrute(test4))   // [0, 0]
print(productExceptSelfBrute(test5))   // [0, 12, 0, 0]
print(productExceptSelfBrute(test6))   // [-24, -12, -8, -6]

print("=== Optimised ===")
print(productExceptSelfOptimised(test1))   // [24, 12, 8, 6]
print(productExceptSelfOptimised(test2))   // [0, 0, 9, 0, 0]
print(productExceptSelfOptimised(test3))   // [3, 2]
print(productExceptSelfOptimised(test4))   // [0, 0]
print(productExceptSelfOptimised(test5))   // [0, 12, 0, 0]
print(productExceptSelfOptimised(test6))   // [-24, -12, -8, -6]
