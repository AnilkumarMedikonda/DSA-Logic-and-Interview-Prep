import Foundation

//  240_Partition_Equal_Subset_Sum.swift
//  LeetCode 416
//
//  PROBLEM
//  Split nums into two groups with EQUAL sums. Every element must
//  go into exactly one group. Return true if possible.
//
//  EXAMPLE
//  nums = [1, 5, 11, 5]  ->  true     ([11] and [1, 5, 5])
//  nums = [1, 2, 3, 5]   ->  false    (total 11 is odd)
//
//  CONSTRAINTS
//  1 <= nums.count <= 200
//  1 <= nums[i] <= 100
//
//  THE REFRAME
//  Two equal halves = find ONE subset summing to total / 2.
//  Whatever is left over is automatically the other half.
//
//  THE SIX LINES
//  1. STATE       dp[s] = can some subset reach sum s?   ([Bool])
//  2. OPTIONS     for each num: take it, or skip it
//  3. COMBINER    ||   (feasibility)
//  4. TRANSITION  dp[s] = dp[s] || dp[s - num]
//  5. BASE        dp[0] = true   (pick nothing, sum 0)
//  6. ANSWER      dp[target]
//
//  0/1 KNAPSACK — each number used AT MOST ONCE.
//  Coin Change was UNBOUNDED — coins reusable, loop forwards.
//  This one loops BACKWARDS. That is the whole difference.

let nums = [1, 5, 11, 5]

//====================================================
// MARK: - Shared helper : manual total
//====================================================

func totalOf(_ nums: [Int]) -> Int {

    var total = 0

    for num in nums {
        total += num
    }
    return total
}

//====================================================
// MARK: - Solution 1 : Recursion
// Time  : O(2^n)   take or skip at every index
// Space : O(n)     recursion stack
//====================================================

func canPartitionRecursion(_ nums: [Int]) -> Bool {

    let total = totalOf(nums)

    if total % 2 != 0 {
        return false
    }
    return partitionHelper(nums, nums.count - 1, total / 2)
}

func partitionHelper(_ nums: [Int], _ index: Int, _ target: Int) -> Bool {

    // reached the target exactly
    if target == 0 {
        return true
    }

    // ran out of numbers, or overshot
    if index < 0 || target < 0 {
        return false
    }

    let take = partitionHelper(nums, index - 1, target - nums[index])
    let skip = partitionHelper(nums, index - 1, target)

    return take || skip
}

print("[1] Recursion         :", canPartitionRecursion(nums))

print("")

//====================================================
// MARK: - Solution 2 : 1D Backwards   <-- BEST FOR INTERVIEW
// Time  : O(n * target)
// Space : O(target)
//====================================================

func canPartition(_ nums: [Int]) -> Bool {

    let total = totalOf(nums)

    // odd total can never split evenly
    if total % 2 != 0 {
        return false
    }

    let target = total / 2

    var dp = Array(repeating: false, count: target + 1)
    dp[0] = true

    for num in nums {

        // manual reverse loop: target down to num
        var sum = target

        while sum >= num {

            if dp[sum - num] {
                dp[sum] = true
            }
            sum -= 1
        }
    }
    return dp[target]
}

print("[2] 1D Backwards      :", canPartition(nums))

print("")

//====================================================
// MARK: - Traced version of Solution 2
//====================================================

func canPartitionTrace(_ nums: [Int]) -> Bool {

    let total = totalOf(nums)

    print("total  = \(total)")

    if total % 2 != 0 {
        print("odd total -> false")

        return false
    }

    let target = total / 2

    print("target = \(target)")

    var dp = Array(repeating: false, count: target + 1)
    dp[0] = true

    print("start dp = \(dp)")

    for num in nums {
        print("\nnumber = \(num)")

        var sum = target

        while sum >= num {

            if dp[sum - num] && !dp[sum] {
                dp[sum] = true

                print("   sum \(sum): dp[\(sum - num)] true -> dp[\(sum)] = true")
            }
            sum -= 1
        }
        print("   dp = \(dp)")
    }

    print("\ndp[\(target)] = \(dp[target])")

    return dp[target]
}

print("=========================================")

print("  TRACE")

print("=========================================")

print("result :", canPartitionTrace(nums))

print("")

//====================================================
// MARK: - Verify
//====================================================

let cases: [([Int], Bool)] = [
    ([1, 5, 11, 5],   true),
    ([1, 2, 3, 5],    false),
    ([1, 1],          true),
    ([1],             false),
    ([2, 2, 3, 5],    false),
    ([3, 3, 3, 4, 5], true)
]

print("=========================================")

print("  VERIFY")

print("=========================================")

for (input, expected) in cases {

    let a = canPartitionRecursion(input)
    let b = canPartition(input)
    let ok = (a == expected && b == expected)

    print("\(input)  ->  rec \(a)  dp \(b)   expected \(expected)   \(ok ? "OK" : "FAIL")")
}

//====================================================
// MARK: - Why Solution 2 is the interview answer
//====================================================
//
//  Shortest to write, and the backwards loop is exactly what the
//  interviewer is testing. Say these four things in order:
//
//    1. "Two equal halves means one subset summing to total / 2."
//    2. "Odd total -> immediately false."
//    3. [write the code]
//    4. "The loop runs backwards because each number is usable
//        once. Forwards would read a cell this same number just
//        updated, counting it twice."
//
//  Step 4 is what separates you. Most candidates write the loop
//  from memory and go blank when asked why.

//====================================================
// MARK: - Traps logged
//====================================================
//
//  1. Inner loop MUST run backwards. Change it to forwards and run
//     [1, 1] with target 1 -> wrong true. Try it once.
//  2. Odd total -> return false before any dp work.
//  3. 2D version: rows are indexed by i, so the outer count is
//     n + 1, NOT target + 1. Sizing it target + 1 crashes on [1,1].
//  4. dp[0] = true is the base — picking nothing reaches sum 0.
