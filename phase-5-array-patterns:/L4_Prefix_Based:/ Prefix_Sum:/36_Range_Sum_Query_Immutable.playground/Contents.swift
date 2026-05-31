import Foundation


// ──────────────────────────────────────────
// LeetCode 303 — Range Sum Query Immutable
// Difficulty: Easy  |  Pattern: Prefix Sum
// ──────────────────────────────────────────


// MARK: - Problem

/*
 Given an integer array nums, handle multiple queries
 of the form sumRange(left, right).

 Return the sum of elements between indices
 left and right inclusive.

 Input:  nums = [-2, 0, 3, -5, 2, -1]

 sumRange(0, 2)  →   1   (-2 + 0 + 3)
 sumRange(2, 5)  →  -1   (3 + -5 + 2 + -1)
 sumRange(0, 5)  →  -3   (-2 + 0 + 3 - 5 + 2 - 1)

 Key insight:
 Build prefix array once in O(n)
 Answer every query in O(1) using subtraction
 prefix[right+1] - prefix[left]
*/


// MARK: - Interview Q&A

/*
 Q: Why is brute force slow?
 A: O(n) per query — 10k queries × 1M array = 10B operations

 Q: What is prefix[i]?
 A: Sum of all elements from index 0 to i-1
    prefix[0] = 0 (empty — nothing before index 0)

 Q: Why is prefix array size nums.count + 1?
 A: Extra slot at index 0 for the empty base case
    Avoids index out of bounds when left = 0

 Q: Why prefix[right+1] - prefix[left]?
 A: prefix[right+1] = sum of 0..right
    prefix[left]    = sum of 0..left-1
    Subtracting cancels the left part — leaves left..right

 Q: Why is array called immutable?
 A: nums never changes after init — safe to precompute once

 Q: Time and space?
 A: Init  O(n) — build prefix once
    Query O(1) — single subtraction
    Space O(n) — prefix array
*/


// MARK: - Brute Force  O(n) per query  O(1) space

/*
 Strategy:
 - Store original array
 - For each query loop from left to right
 - Accumulate and return sum

 INTERVIEW: Start here before jumping to optimised
 INTERVIEW: Closed range left...right includes both ends
 INTERVIEW: Weakness — recomputes from scratch every query
*/

struct NumArrayBrute {

    private let nums: [Int]

    init(_ nums: [Int]) {
        self.nums = nums
    }

    func sumRange(_ left: Int, _ right: Int) -> Int {

        var sum = 0

        for i in left...right {
            sum += nums[i]
        }

        return sum
    }
}


// MARK: - Optimised ⭐️  O(1) per query  O(n) space

/*
 Strategy:
 - Build prefix array of size nums.count + 1 in init
 - prefix[i+1] = prefix[i] + nums[i]
 - Each query → return prefix[right+1] - prefix[left]

 INTERVIEW: prefix size is nums.count + 1 not nums.count
 INTERVIEW: prefix[0] = 0 is the base case — set automatically
 INTERVIEW: Array(repeating: 0) zeroes everything — no manual init needed
 INTERVIEW: Query is one line — shows you understand the pattern
*/

struct NumArrayOptimised {

    private let prefix: [Int]

    init(_ nums: [Int]) {

        var p = Array(repeating: 0, count: nums.count + 1)

        for i in 0..<nums.count {
            p[i + 1] = p[i] + nums[i]
        }

        self.prefix = p
    }

    func sumRange(_ left: Int, _ right: Int) -> Int {
        return prefix[right + 1] - prefix[left]
    }
}


// MARK: - Dry Run

/*
 nums   = [-2,  0,  3, -5,  2, -1]
 index     0    1   2   3   4   5

 Building prefix:
 i=0 → p[1] = p[0] + nums[0] =  0 + (-2) = -2
 i=1 → p[2] = p[1] + nums[1] = -2 +   0  = -2
 i=2 → p[3] = p[2] + nums[2] = -2 +   3  =  1
 i=3 → p[4] = p[3] + nums[3] =  1 + (-5) = -4
 i=4 → p[5] = p[4] + nums[4] = -4 +   2  = -2
 i=5 → p[6] = p[5] + nums[5] = -2 + (-1) = -3

 prefix = [ 0, -2, -2,  1, -4, -2, -3]
 index     0    1   2   3   4   5   6

 Queries:
 sumRange(0, 2) = prefix[3] - prefix[0] =  1 -   0  =  1  ✅
 sumRange(2, 5) = prefix[6] - prefix[2] = -3 - (-2)  = -1  ✅
 sumRange(0, 5) = prefix[6] - prefix[0] = -3 -   0  = -3  ✅
*/


// MARK: - Complexity

/*
 ┌─────────────┬────────────┬────────────┐
 │             │ Brute      │ Optimised  │
 ├─────────────┼────────────┼────────────┤
 │ Init        │ O(1)       │ O(n)       │
 │ sumRange    │ O(n)       │ O(1)       │
 │ Space       │ O(1)       │ O(n)       │
 │ 10k queries │ 10k × n   │ 10k × 1    │
 └─────────────┴────────────┴────────────┘
*/


// MARK: - Traps

/*
 Trap 1 — wrong array size
 var p = Array(repeating: 0, count: nums.count)      ❌ crashes
 var p = Array(repeating: 0, count: nums.count + 1)  ✅ correct

 Trap 2 — wrong loop formula
 p[i + 1] = nums[i]          ❌ just copies — no running sum
 p[i + 1] = p[i] + nums[i]  ✅ running total

 Trap 3 — wrong range in brute force
 for i in left..<right { }   ❌ misses last element
 for i in left...right { }   ✅ closed range includes right
*/


// MARK: - Tests

typealias QueryTest = (left: Int, right: Int, expected: Int)

let nums = [-2, 0, 3, -5, 2, -1]

let tests: [QueryTest] = [

    (0, 2,  1),    // -2 + 0 + 3
    (2, 5, -1),    // 3 - 5 + 2 - 1
    (0, 5, -3),    // all elements
    (1, 1,  0),    // single element
    (0, 0, -2),    // first element
    (5, 5, -1),    // last element
    (1, 4,  0),    // middle slice

]

let brute     = NumArrayBrute(nums)
let optimised = NumArrayOptimised(nums)

print("--- Brute Force ---\n")

for (i, t) in tests.enumerated() {
    let r = brute.sumRange(t.left, t.right)
    print("Test \(i+1): \(r == t.expected ? "✅" : "❌")  |  sumRange(\(t.left), \(t.right))  Got: \(r)  Expected: \(t.expected)")
}

print("\n--- Optimised ⭐️ ---\n")

for (i, t) in tests.enumerated() {
    let r = optimised.sumRange(t.left, t.right)
    print("Test \(i+1): \(r == t.expected ? "✅" : "❌")  |  sumRange(\(t.left), \(t.right))  Got: \(r)  Expected: \(t.expected)")
}
