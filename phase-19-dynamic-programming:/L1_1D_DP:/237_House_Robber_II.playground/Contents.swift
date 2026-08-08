//  237_House_Robber_II.swift
//  LeetCode 213 — House Robber II
//
//  PROBLEM
//  Houses arranged in a CIRCLE. Adjacent houses cannot both be
//  robbed, and the last house is adjacent to the first. Return the
//  maximum money robbable without alerting the police.
//
//  EXAMPLE
//  Input:  nums = [2, 3, 2]
//  Output: 3
//  Explanation: house 0 and house 2 are adjacent in the circle,
//               so rob house 1 alone.
//
//  CONSTRAINTS
//  1 <= nums.count <= 100
//  0 <= nums[i] <= 1000
//
//  ---------------------------------------------------------------
//  THE SIX LINES  (straight-line House Robber, the inner problem)
//  ---------------------------------------------------------------
//
//  1. STATE       dp[i] = max money robbable from houses 0...i
//  2. OPTIONS     rob i  -> nums[i] + dp[i-2]
//                 skip i -> dp[i-1]
//  3. COMBINER    max()
//  4. TRANSITION  dp[i] = max(dp[i-1], nums[i] + dp[i-2])
//  5. BASE        dp[0] = nums[0], dp[1] = max(nums[0], nums[1])
//  6. ANSWER      dp[n-1]      ("up to i", NOT "ending at i")
//
//  ---------------------------------------------------------------
//  THE CIRCLE FIX
//  ---------------------------------------------------------------
//
//  Do not invent a new recurrence. Only the boundary changed.
//  In any valid answer, either house 0 is robbed or it is not:
//
//    world A — rob house 0 allowed, last house banned  -> nums[0..<n-1]
//    world B — house 0 banned, last house allowed      -> nums[1..<n]
//
//  Each world is a plain straight-line House Robber.
//  Answer = max(world A, world B).
//
//  Guard n == 1 first: both slices would be empty.

import Foundation

let nums = [2, 3, 2]

print("=========================================")

print("  HOUSE ROBBER II   nums = \(nums)")

print("=========================================\n")

//====================================================
// MARK: - Solution 1 : Recursion
// Time  : O(2^n)
// Space : O(n)
//====================================================

func robRecursion(_ nums: [Int]) -> Int {

    if nums.count == 1 {
        return nums[0]
    }

    let first = Array(nums.dropLast())
    let second = Array(nums.dropFirst())

    //  index derived from the array it indexes into
    return max(
        robRecursionHelper(first, first.count - 1),
        robRecursionHelper(second, second.count - 1)
    )
}

func robRecursionHelper(_ nums: [Int], _ index: Int) -> Int {

    if index < 0 {
        return 0
    }

    if index == 0 {
        return nums[0]
    }

    let rob = nums[index] + robRecursionHelper(nums, index - 2)
    let skip = robRecursionHelper(nums, index - 1)

    return max(rob, skip)
}

print("[1] RECURSION")
print("    max   =", robRecursion(nums), "\n")


//====================================================
// MARK: - Solution 2 : Memoization  (top-down)
// Time  : O(n)
// Space : O(n)
//====================================================

func robMemo(_ nums: [Int]) -> Int {

    if nums.count == 1 {
        return nums[0]
    }

    let first = Array(nums.dropLast())
    let second = Array(nums.dropFirst())

    var dp1 = Array(repeating: -1, count: first.count)
    var dp2 = Array(repeating: -1, count: second.count)

    return max(robMemoHelper(first, first.count - 1, &dp1), robMemoHelper(second, second.count - 1, &dp2))
}

func robMemoHelper(_ nums: [Int], _ index: Int, _ dp: inout [Int]) -> Int {

    if index < 0 {
        return 0
    }

    if index == 0 {
        return nums[0]
    }

    if dp[index] != -1 {
        return dp[index]
    }

    let rob = nums[index] + robMemoHelper(nums, index - 2, &dp)
    let skip = robMemoHelper(nums, index - 1, &dp)
    dp[index] = max(rob, skip)

    return dp[index]
}

print("[2] MEMOIZATION")
print("    max   =", robMemo(nums), "\n")


//====================================================
// MARK: - Solution 3 : Tabulation  (bottom-up)
// Time  : O(n)
// Space : O(n)
//====================================================

func robTabulation(_ nums: [Int]) -> Int {

    if nums.count == 1 {
        return nums[0]
    }

    return max( robTab(Array(nums.dropLast()), "world A  (0 ..< n-1)"),
        robTab(Array(nums.dropFirst()), "world B  (1 ..< n)"))
}

func robTab(_ nums: [Int], _ tag: String) -> Int {

    if nums.count == 1 {
        return nums[0]
    }

    var dp = Array(repeating: 0, count: nums.count)

    dp[0] = nums[0]
    dp[1] = max(nums[0], nums[1])

    for i in 2..<nums.count {
        dp[i] = max(dp[i - 1], nums[i] + dp[i - 2])
    }

    print("    \(tag)  \(nums)  ->  dp = \(dp)")

    //  no force unwrap — the guard above proves the array is non-empty
    return dp[nums.count - 1]
}

print("[3] TABULATION")

print("    max   =", robTabulation(nums), "\n")


//====================================================
// MARK: - Solution 4 : Space Optimization  (INTERVIEW ANSWER)
// Time  : O(n)     two passes over ~n elements
// Space : O(1)     transition reaches back only 2 cells
//====================================================

func robSpace(_ nums: [Int]) -> Int {

    if nums.count == 1 {
        return nums[0]
    }

    return max(
        robLinear(Array(nums.dropLast()), "world A"),
        robLinear(Array(nums.dropFirst()), "world B")
    )
}

func robLinear(_ nums: [Int], _ tag: String) -> Int {

    //  both start at 0 — this is why an empty array returns 0
    //  instead of crashing, and why no size guard is needed here
    var prev2 = 0
    var prev1 = 0

    print("    --- \(tag): \(nums) ---")

    for money in nums {
        let current = max(prev1, prev2 + money)
        print("    money \(money)   max(\(prev1), \(prev2) + \(money)) = \(current)")
        prev2 = prev1
        prev1 = current
    }

    return prev1
}

print("[4] SPACE OPTIMIZATION")

print("    max   =", robSpace(nums), "\n")


//====================================================
// MARK: - Verify
//====================================================

print("=========================================")

print("  VERIFY")

print("=========================================")

let cases: [([Int], Int)] = [
    ([2, 3, 2],       3),
    ([1, 2, 3, 1],    4),
    ([1, 2, 3],       3),
    ([1, 2, 1, 1],    3),
    ([5],             5),
    ([2, 7, 9, 3, 1], 11)
]

for (input, expected) in cases {

    let got = robSpace(input)

    print("\(input)  ->  \(got)   expected \(expected)   \(got == expected ? "OK" : "FAIL")")
}


//====================================================
// MARK: - Traps logged
//====================================================
//
//  1. Deriving a sub-array index from the ORIGINAL array's count.
//     `nums.count - 2` happens to be right for an (n-1)-length
//     slice, but nothing says so. Bind the slice, then index it.
//
//  2. `dp.last!` — correct behind a guard, but force unwraps invite
//     "what if it's empty?" in an interview. Use dp[count - 1].
//
//  3. Two sub-array runs printing untagged traces interleave into
//     unreadable output. Tag every helper trace.
//
//  4. [2, 3, 2] passes even with a WRONG sub-array split. Always
//     test [1, 2, 1, 1] — the two worlds differ there.
//
//  5. n == 1 must be guarded before the split: both slices go empty.
