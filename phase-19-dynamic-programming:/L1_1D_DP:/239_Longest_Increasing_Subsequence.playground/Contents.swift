//  239_Longest_Increasing_Subsequence.swift
//  LeetCode 300 — Longest Increasing Subsequence
//
//  PROBLEM
//  Given an integer array, return the LENGTH of the longest
//  STRICTLY increasing subsequence. You may delete elements but
//  cannot reorder them.
//
//  EXAMPLE
//  nums = [10, 9, 2, 5, 3, 7, 101, 18]  ->  4    ([2, 3, 7, 101])
//  nums = [7, 7, 7, 7]                  ->  1    (strictly increasing)
//
//  CONSTRAINTS
//  1 <= nums.count <= 2500
//  -10^4 <= nums[i] <= 10^4
//
//  THE SIX LINES
//  1. STATE       dp[i] = length of the LIS that ENDS at index i
//  2. OPTIONS     for every j < i, if nums[j] < nums[i] then attach
//  3. COMBINER    max()
//  4. TRANSITION  dp[i] = max(dp[i], dp[j] + 1)
//  5. BASE        every dp[i] = 1
//  6. ANSWER      max(dp)  —  NOT dp[n-1]
//
//  WHY NOT dp[n-1]: the state ENDS at i, so the best chain may end
//  anywhere. In [2, 5, 3, 7, 1] the last cell is 1, answer is 3.
//
//  NO SPACE OPTIMIZATION: dp[i] reads EVERY earlier cell, so there
//  is no fixed window to slide. Same reason as Coin Change.

import Foundation

let nums = [10, 9, 2, 5, 3, 7, 101, 18]

print("=========================================")

print("  LIS   nums = \(nums)")

print("=========================================\n")

//====================================================
// MARK: - Solution 1 : DP  (INTERVIEW ANSWER)
// Time  : O(n^2)   two nested loops
// Space : O(n)     the dp array
//====================================================

func lengthOfLIS(_ nums: [Int]) -> Int {
    guard !nums.isEmpty else { return 0 }

    var dp = Array(repeating: 1, count: nums.count)

    for i in 1..<nums.count {
        for j in 0..<i {
            if nums[j] < nums[i] {
                dp[i] = max(dp[i], dp[j] + 1)
            }
        }
    }
    return dp.max() ?? 1
}

print("[1] DP O(n^2)")

print("    length =", lengthOfLIS(nums), "\n")

//====================================================
// MARK: - Traced DP — every comparison
//====================================================

func lengthOfLISTrace(_ nums: [Int]) -> Int {
    
    guard !nums.isEmpty else { return 0 }

    var dp = Array(repeating: 1, count: nums.count)

    print("start   dp = \(dp)   (every element alone = chain of 1)")

    for i in 1..<nums.count {
        
        print("\ni = \(i)   nums[i] = \(nums[i])")

        for j in 0..<i {
            if nums[j] < nums[i] {
                let candidate = dp[j] + 1

                if candidate > dp[i] {
                    dp[i] = candidate

                    print("   j=\(j)  \(nums[j]) < \(nums[i])  dp[\(j)] + 1 = \(candidate)   dp[\(i)] -> \(dp[i])   BETTER")

                } else {
                    print("   j=\(j)  \(nums[j]) < \(nums[i])  dp[\(j)] + 1 = \(candidate)   keep \(dp[i])")
                }

            } else {
                print("   j=\(j)  \(nums[j]) not < \(nums[i])  skip")
            }
        }
        print("   dp = \(dp)")
    }

    let answer = dp.max() ?? 1

    print("\nfinal dp = \(dp)")

    print("dp[last] = \(dp[dp.count - 1])   <- NOT the answer")

    print("max(dp)  = \(answer)             <- the answer")

    return answer
}

print("=========================================")

print("  TRACE   nums = [2, 5, 3, 7, 1]")

print("  (shows why the answer is max, not last)")

print("=========================================")

print("\nresult =", lengthOfLISTrace([2, 5, 3, 7, 1]))

//====================================================
// MARK: - Solution 2 : Binary Search  (follow-up)
// Time  : O(n log n)
// Space : O(n)
//====================================================
//
// tails[k] = the SMALLEST tail value of any increasing chain of
// length k+1 seen so far. Small tails leave room for future numbers.
//
// For each number, binary search the first tail >= it.
//   nothing found -> extends the longest chain, append
//   slot found    -> overwrite with the smaller number
//
// IMPORTANT: tails is NOT the actual subsequence — only its COUNT
// is correct. For the real sequence use O(n^2) DP + parent array.

func lengthOfLISBinarySearch(_ nums: [Int]) -> Int {
    var tails = [Int]()

    for num in nums {
        var left = 0
        var right = tails.count

        while left < right {
            let mid = (left + right) / 2

            if tails[mid] < num {
                left = mid + 1
            } else {
                right = mid
            }
        }

        if left == tails.count {
            tails.append(num)
        } else {
            tails[left] = num
        }
    }
    return tails.count
}

print("\n[2] BINARY SEARCH O(n log n)")

print("    length =", lengthOfLISBinarySearch(nums), "\n")

//====================================================
// MARK: - Traced binary search
//====================================================

func lengthOfLISBinaryTrace(_ nums: [Int]) -> Int {
    var tails = [Int]()

    for num in nums {
        var left = 0
        var right = tails.count

        while left < right {
            let mid = (left + right) / 2

            if tails[mid] < num {
                left = mid + 1
            } else {
                right = mid
            }
        }

        if left == tails.count {
            tails.append(num)

            print("num \(num)   bigger than all tails   APPEND     tails = \(tails)")

        } else {
            tails[left] = num

            print("num \(num)   overwrites index \(left)              tails = \(tails)")
        }
    }

    print("\ntails = \(tails)   length = \(tails.count)")

    print("NOTE: tails is not the real subsequence, only its length is correct")

    return tails.count
}

print("=========================================")

print("  TRACE   binary search")

print("=========================================")

print("\nresult =", lengthOfLISBinaryTrace(nums))

//====================================================
// MARK: - Verify
//====================================================

print("\n=========================================")

print("  VERIFY")

print("=========================================")

let cases: [([Int], Int)] = [
    ([10, 9, 2, 5, 3, 7, 101, 18], 4),
    ([0, 1, 0, 3, 2, 3],           4),
    ([7, 7, 7, 7],                 1),
    ([2, 5, 3, 7, 1],              3),
    ([5],                          1),
    ([5, 4, 3, 2, 1],              1)
]

for (input, expected) in cases {
    let a = lengthOfLIS(input)
    let b = lengthOfLISBinarySearch(input)

    print("\(input)  ->  dp \(a)  bs \(b)   expected \(expected)   \(a == expected && b == expected ? "OK" : "FAIL")")
}

//====================================================
// MARK: - Traps logged
//====================================================
//
//  1. Answer is max(dp), NOT dp[n-1]. [2,5,3,7,1] catches this.
//  2. `nums[j] < nums[i]` must be STRICT. Using <= would count
//     [7,7,7,7] as 4 instead of 1.
//  3. Inner loop is `0..<i` — only earlier elements can attach.
//  4. Outer loop starts at 1 — dp[0] is already 1.
//  5. `tails` is NOT the subsequence, only its count is meaningful.
