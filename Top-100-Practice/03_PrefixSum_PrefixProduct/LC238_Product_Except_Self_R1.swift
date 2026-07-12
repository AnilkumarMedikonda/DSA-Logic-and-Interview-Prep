// LC238_Product_Except_Self_R1
// PROBLEM: Return array where answer[i] = product of ALL elements except nums[i].
// Rules: NO division allowed · O(n) required · zeros can appear
// [1,2,3,4] → [24,12,8,6] · [-1,1,0,-3,3] → [0,0,9,0,0]
// Trap probes: one zero (everything else 0), two zeros (ALL 0)

var nums = [1, 2, 3, 4]

// Brute Force
// T - O(n²) S - O(1)
// Steps: nested loop, except i → multiply elements

func productExceptSelf(_ nums: [Int]) -> [Int] {

    var result: [Int] = []

    for i in 0..<nums.count {
        var answer = 1
        for j in 0..<nums.count where i != j {
            answer *= nums[j]
        }
        result.append(answer)
    }

    return result
}

print("--- Brute Force ---")
print(productExceptSelf(nums))


// Optimized Approach
// answer[i] = (product of everything LEFT of i) * (product of everything RIGHT of i)
// Pass 1: left products stored in answer array
// Pass 2: right-to-left sweep with running product (no second array)
// T - O(n) S - O(1) (output array excluded)

func productExceptSelfOptimized(_ nums: [Int]) -> [Int] {

    var answer = Array(repeating: 1, count: nums.count)

    // left pass: answer[i] = product of everything before i
    for i in 1..<nums.count {
        answer[i] = answer[i - 1] * nums[i - 1]
    }

    // right pass: multiply in product of everything after i
    var right = 1
    var i = nums.count - 1

    while i >= 0 {
        answer[i] *= right
        right *= nums[i]
        i -= 1
    }

    return answer
}

print("--- Optimized ---")
print(productExceptSelfOptimized(nums))                  // [24, 12, 8, 6]
print(productExceptSelfOptimized([-1, 1, 0, -3, 3]))     // [0, 0, 9, 0, 0]  one zero
print(productExceptSelfOptimized([0, 4, 0, 2]))          // [0, 0, 0, 0]     two zeros
