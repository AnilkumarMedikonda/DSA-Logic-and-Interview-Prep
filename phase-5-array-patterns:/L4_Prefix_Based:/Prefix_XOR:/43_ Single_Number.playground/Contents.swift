import Foundation


// ──────────────────────────────────────────
// LeetCode 136 — Single Number
// Difficulty: Easy  |  Pattern: Prefix XOR
// ──────────────────────────────────────────


// MARK: - Problem

/*
 Given array nums where every element appears twice
 except for one element which appears only once
 Find and return that single element

 Input:  nums = [2, 2, 3, 4, 4]  →  3
 Input:  nums = [1]               →  1
 Input:  nums = [4, 1, 2, 1, 2]  →  4

 Key insight:
 XOR same number = 0   (pairs cancel)
 XOR with 0     = same (unique remains)
 All pairs cancel → only unique remains
*/


// MARK: - Interview Q&A

/*
 Q: What is XOR?
 A: Same → 0   Different → 1
    5 ^ 5 = 0
    5 ^ 0 = 5

 Q: Why XOR works here?
 A: Every pair cancels to 0
    Only unique number remains
    2^2^3^4^4 = 0^3^0 = 3

 Q: Why start xor = 0?
 A: 0 is identity for XOR
    Any number ^ 0 = same number
    Safe starting point

 Q: Can we use HashMap?
 A: Yes but O(n) space
    XOR is O(1) space — better

 Q: Time and space?
 A: T - O(n)  S - O(1)
*/


// MARK: - Brute Force  O(n²) time  O(1) space

/*
 Strategy:
 - For each element check if it appears again
 - If no pair found return that element

 INTERVIEW: Start here before XOR solution
 INTERVIEW: Shows thinking process
*/

func singleNumberBrute(_ nums: [Int]) -> Int {

    for i in 0..<nums.count {

        var found = false

        for j in 0..<nums.count {

            if i != j && nums[i] == nums[j] {
                found = true
                break
            }
        }

        if found == false {
            return nums[i]
        }
    }

    return -1
}


// MARK: - Optimised ⭐️  O(n) time  O(1) space

/*
 Strategy:
 - Start xor = 0
 - XOR every element
 - Pairs cancel to 0
 - Unique number remains

 INTERVIEW: Explain XOR properties first
 INTERVIEW: xor ^= num  same as  xor = xor ^ num
 INTERVIEW: O(1) space — no extra storage
 INTERVIEW: works because pairs cancel
*/

func singleNumberOptimised(_ nums: [Int]) -> Int {

    var xor = 0

    for num in nums {
        xor ^= num
    }

    return xor
}


// MARK: - One Line ⭐️⭐️  O(n) time  O(1) space

/*
 INTERVIEW: Show this after explaining optimised
 INTERVIEW: reduce starts with 0
 INTERVIEW: ^ is XOR operator
 INTERVIEW: Shows Swift knowledge
*/

func singleNumberOneLine(_ nums: [Int]) -> Int {
    return nums.reduce(0, ^)
}


// MARK: - Dry Run

/*
 nums = [2, 2, 3, 4, 4]

 xor = 0
 num=2 → xor = 0^2 = 2
 num=2 → xor = 2^2 = 0   ← 2 cancelled
 num=3 → xor = 0^3 = 3
 num=4 → xor = 3^4 = 7
 num=4 → xor = 7^4 = 3   ← 4 cancelled

 return 3 ✅

 Why?
 (2^2) ^ (4^4) ^ 3
 =  0   ^   0  ^ 3
 = 3 ✅
*/


// MARK: - Complexity

/*
 ┌─────────────┬────────────┬────────────┐
 │             │ Brute      │ Optimised  │
 ├─────────────┼────────────┼────────────┤
 │ Time        │ O(n²)      │ O(n)       │
 │ Space       │ O(1)       │ O(1)       │
 │ Loops       │ 2 nested   │ 1 pass     │
 └─────────────┴────────────┴────────────┘
*/


// MARK: - Traps

/*
 Trap 1 — wrong identity value
 var xor = 1     ❌ wrong start
 var xor = 0     ✅ identity for XOR

 Trap 2 — wrong space complexity
 T - O(n)  S - O(n)   ❌ no extra space used
 T - O(n)  S - O(1)   ✅ only one variable

 Trap 3 — using HashMap
 HashMap works but O(n) space  ❌
 XOR is O(1) space             ✅ always prefer
*/


// MARK: - Tests

var nums = [2, 2, 3, 4, 4]

let tests: [(nums: [Int], expected: Int)] = [

    ([2, 2, 3, 4, 4],    3),    // classic case
    ([1],                1),    // single element
    ([4, 1, 2, 1, 2],    4),    // different order
    ([1, 3, 1, 2, 3],    2),    // unique in middle
    ([7, 3, 7],          3),    // three elements

]

print("====== LeetCode 136 — Single Number ======\n")

print("--- Brute Force ---\n")

for (i, t) in tests.enumerated() {
    let r = singleNumberBrute(t.nums)
    print("Test \(i+1): \(r == t.expected ? "✅" : "❌")  |  nums: \(t.nums)  Got: \(r)  Expected: \(t.expected)")
}

print("\n--- Optimised ⭐️ ---\n")

for (i, t) in tests.enumerated() {
    let r = singleNumberOptimised(t.nums)
    print("Test \(i+1): \(r == t.expected ? "✅" : "❌")  |  nums: \(t.nums)  Got: \(r)  Expected: \(t.expected)")
}

print("\n--- One Line ⭐️⭐️ ---\n")

for (i, t) in tests.enumerated() {
    let r = singleNumberOneLine(t.nums)
    print("Test \(i+1): \(r == t.expected ? "✅" : "❌")  |  nums: \(t.nums)  Got: \(r)  Expected: \(t.expected)")
}
