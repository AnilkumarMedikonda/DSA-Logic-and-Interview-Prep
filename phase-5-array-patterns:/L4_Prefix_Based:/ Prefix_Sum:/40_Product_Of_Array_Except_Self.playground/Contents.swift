import Foundation


// ──────────────────────────────────────────
// LeetCode 238 — Product of Array Except Self
// Difficulty: Medium  |  Pattern: Prefix Sum
// ──────────────────────────────────────────


// MARK: - Problem

/*
 Given array nums return an array answer where
 answer[i] = product of all elements except nums[i]

 Must solve without division operator

 Input:  nums = [1, 2, 3, 4]  →  [24, 12, 8, 6]
 Input:  nums = [0, 1, 2, 3]  →  [6, 0, 0, 0]
 Input:  nums = [-1, 2, 3]    →  [6, -3, -2]

 Key insight:
 answer[i] = LEFT[i] × RIGHT[i]
 Build left forward — build right backward
*/


// MARK: - Interview Q&A

/*
 Q: Why can't we use division?
 A: Problem constraint — also crashes when nums[i] = 0

 Q: What is the key insight?
 A: answer[i] = product of LEFT side × product of RIGHT side

 Q: What is LEFT[0] and RIGHT[n-1]?
 A: Both = 1 — nothing left of index 0
              — nothing right of last index

 Q: What is O(1) space trick?
 A: Reuse answer array itself for left pass
    Use single variable for running right product
    Output array not counted as extra space

 Q: Why multiply before growing right variable?
 A: At last index right must still be 1
    Nothing right of last index
    Multiply first — grow after

 Q: Time and space?
 A: Brute      O(n²) time  O(n) space
    Optimised   O(n)  time  O(n) space
    O(1) space  O(n)  time  O(1) space ⭐️
*/


// MARK: - Brute Force  O(n²) time  O(n) space

/*
 Strategy:
 - For each index i loop all elements
 - Skip when i == j
 - Multiply everything else
 - Append to result

 INTERVIEW: product starts at 1 — identity for multiplication
 INTERVIEW: if i != j skips self — no division needed
 INTERVIEW: result.append outside inner loop
*/

func productExceptSelf(_ nums: [Int]) -> [Int] {

    var result = [Int]()

    for i in 0..<nums.count {

        var product: Int = 1

        for j in 0..<nums.count {

            if i != j {
                product *= nums[j]
            }
        }

        result.append(product)
    }

    return result
}


// MARK: - Optimised ⭐️  O(n) time  O(n) space

/*
 Strategy:
 - Build left  array forward  — left[i]  = left[i-1]  × nums[i-1]
 - Build right array backward — right[j] = right[j+1] × nums[j+1]
 - answer[i] = left[i] × right[i]

 INTERVIEW: left[0]    = 1 — nothing left  of index 0
 INTERVIEW: right[n-1] = 1 — nothing right of last index
 INTERVIEW: use while loop for backward — no predefined functions
 INTERVIEW: three separate loops — clean and readable
*/

func productExceptSelfOptimised(_ nums: [Int]) -> [Int] {

    let n      = nums.count
    var left   = Array(repeating: 1, count: n)
    var right  = Array(repeating: 1, count: n)
    var answer = Array(repeating: 1, count: n)

    // Loop 1 — build left products
    for i in 1..<n {
        left[i] = left[i-1] * nums[i-1]
    }

    // Loop 2 — build right products
    var j = n - 2

    while j >= 0 {
        right[j] = right[j+1] * nums[j+1]
        j -= 1
    }

    // Loop 3 — multiply left × right
    for i in 0..<n {
        answer[i] = left[i] * right[i]
    }

    return answer
}


// MARK: - O(1) Space ⭐️⭐️  O(n) time  O(1) space

/*
 Strategy:
 - Reuse answer array itself to store left products
 - Single variable tracks running right product
 - Walk backward — multiply answer × right — grow right

 INTERVIEW: answer array not counted as extra space
 INTERVIEW: multiply BEFORE growing right — order matters
 INTERVIEW: at last index right must be 1 — nothing right of it
 INTERVIEW: this is the optimal solution — best possible space
*/

func productExceptSelfO1(_ nums: [Int]) -> [Int] {

    let n      = nums.count
    var answer = Array(repeating: 1, count: n)

    // Loop 1 — store left products in answer
    for i in 1..<n {
        answer[i] = answer[i-1] * nums[i-1]
    }

    // Loop 2 — multiply right on the fly
    var right = 1
    var j     = n - 1

    while j >= 0 {
        answer[j] *= right       // multiply left × right first
        right     *= nums[j]     // then grow right
        j -= 1
    }

    return answer
}


// MARK: - Dry Run

/*
 nums  = [1,   2,   3,   4]
 index    0    1    2    3


 --- Brute Force ---

 i=0: skip 0 → 2×3×4 = 24
 i=1: skip 1 → 1×3×4 = 12
 i=2: skip 2 → 1×2×4 =  8
 i=3: skip 3 → 1×2×3 =  6

 result = [24, 12, 8, 6] ✅


 --- Optimised ---

 Left pass:
 left[0] = 1
 left[1] = left[0] × nums[0] = 1 × 1 = 1
 left[2] = left[1] × nums[1] = 1 × 2 = 2
 left[3] = left[2] × nums[2] = 2 × 3 = 6
 left  = [1,  1,  2,  6]

 Right pass:
 right[3] = 1
 right[2] = right[3] × nums[3] = 1  × 4 = 4
 right[1] = right[2] × nums[2] = 4  × 3 = 12
 right[0] = right[1] × nums[1] = 12 × 2 = 24
 right = [24, 12,  4,  1]

 answer = [1×24, 1×12, 2×4, 6×1]
        = [24,   12,   8,   6]  ✅


 --- O(1) Space ---

 Left pass stores in answer:
 answer = [1,  1,  2,  6]

 Backward pass — right variable:
 j=3 → answer[3] = 6  × 1  = 6    right = 1  × 4 = 4
 j=2 → answer[2] = 2  × 4  = 8    right = 4  × 3 = 12
 j=1 → answer[1] = 1  × 12 = 12   right = 12 × 2 = 24
 j=0 → answer[0] = 1  × 24 = 24   right = 24 × 1 = 24

 answer = [24, 12, 8, 6] ✅
*/


// MARK: - Complexity

/*
 ┌──────────────┬────────────┬────────────┬────────────┐
 │              │ Brute      │ Optimised  │ O(1) Space │
 ├──────────────┼────────────┼────────────┼────────────┤
 │ Time         │ O(n²)      │ O(n)       │ O(n)       │
 │ Space        │ O(n)       │ O(n)       │ O(1)  ⭐️  │
 │ Arrays used  │ result     │ left+right │ answer     │
 │ Loops        │ 2 nested   │ 3 passes   │ 2 passes   │
 │ Division     │ No         │ No         │ No         │
 │ Zero safe    │ ✅         │ ✅         │ ✅         │
 └──────────────┴────────────┴────────────┴────────────┘
*/


// MARK: - Traps

/*
 Trap 1 — using division
 answer[i] = total / nums[i]         ❌ not allowed + crashes on 0

 Trap 2 — wrong identity value
 var product: Int = 0                 ❌ kills everything
 var product: Int = 1                 ✅ identity for multiplication

 Trap 3 — wrong left loop start
 for i in 0..<n { }                  ❌ overwrites left[0] = 1
 for i in 1..<n { }                  ✅ keeps left[0] = 1

 Trap 4 — wrong right loop start
 var j = n - 1                        ❌ overwrites right[n-1] = 1
 var j = n - 2                        ✅ keeps right[n-1] = 1

 Trap 5 — wrong order in O(1) space
 right     *= nums[j]                 ❌ grow first — wrong value
 answer[j] *= right                   ❌ already grown
 answer[j] *= right first             ✅ multiply before growing
 right     *= nums[j] after           ✅ correct order
*/


// MARK: - Tests

let tests: [(nums: [Int], expected: [Int])] = [

    ([1, 2, 3, 4],    [24, 12, 8, 6]),    // classic case
    ([0, 1, 2, 3],    [6, 0, 0, 0]),      // zero in array
    ([-1, 2, 3],      [6, -3, -2]),       // negatives
    ([0, 0, 2, 3],    [0, 0, 0, 0]),      // two zeros
    ([1, 1, 1, 1],    [1, 1, 1, 1]),      // all ones
    ([2, 3],          [3, 2]),            // two elements
    ([-1, -1, -1],    [1, 1, 1]),         // all negatives

]

print("====== LeetCode 238 — Product of Array Except Self ======\n")

print("--- Brute Force ---\n")

for (i, t) in tests.enumerated() {
    let r = productExceptSelf(t.nums)
    print("Test \(i+1): \(r == t.expected ? "✅" : "❌")  |  nums: \(t.nums)  Got: \(r)  Expected: \(t.expected)")
}

print("\n--- Optimised ⭐️ ---\n")

for (i, t) in tests.enumerated() {
    let r = productExceptSelfOptimised(t.nums)
    print("Test \(i+1): \(r == t.expected ? "✅" : "❌")  |  nums: \(t.nums)  Got: \(r)  Expected: \(t.expected)")
}

print("\n--- O(1) Space ⭐️⭐️ ---\n")

for (i, t) in tests.enumerated() {
    let r = productExceptSelfO1(t.nums)
    print("Test \(i+1): \(r == t.expected ? "✅" : "❌")  |  nums: \(t.nums)  Got: \(r)  Expected: \(t.expected)")
}
