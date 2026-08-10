//
//  246_Counting_Bits.swift
//  Phase 20 — Bit Manipulation / L1 High Priority
//
//  LeetCode 338 — Counting Bits
//
//  Statement:
//  Given an integer n, return an array ans of length n + 1 where
//  ans[i] is the number of 1 bits in the binary representation of i,
//  for every i from 0 to n.
//
//  Example:
//    Input : n = 5
//    Output: [0, 1, 1, 2, 1, 2]
//      0 -> 0      3 -> 11  -> 2
//      1 -> 1      4 -> 100 -> 1
//      2 -> 10 ->1 5 -> 101 -> 2
//
//  Constraints:
//    - 0 <= n <= 10^5
//
//  countBitsManual — Time: O(n log n), Space: O(1) extra
//  countBits (DP)  — Time: O(n),       Space: O(1) extra
//

import Foundation

// ============================================================
// MARK: - Approach 1: Manual count per number
// ============================================================
//
// For each i, count its 1 bits by halving (from 245's manual method).
// n + 1 numbers, each up to log(n) bits -> O(n log n).

func countBitsManual(_ n: Int) -> [Int] {
    var result = [Int]()
    for number in 0...n {
        var value = number
        var count = 0
        while value > 0 {
            let bit = value % 2
            if bit == 1 {
                count += 1
            }
            value = value / 2
        }
        result.append(count)
    }
    return result
}

// ============================================================
// MARK: - Approach 2: DP with i >> 1  (optimal)
// ============================================================
//
// i in binary is (i >> 1) with one extra bit pushed on at the end.
// So i has the same 1s as i/2, plus 1 more if that last bit is a 1.
//
//   dp[i] = dp[i >> 1] + (i & 1)
//
// i >> 1 == i / 2 < i for every i >= 1, so dp[i >> 1] was already
// filled on an earlier pass — that's the DP invariant, smaller
// subproblem done first. Each answer is O(1) -> O(n) total.
//
//   dp[5] = dp[2] + (5 & 1) = 1 + 1 = 2   (101)
//   dp[4] = dp[2] + (4 & 1) = 1 + 0 = 1   (100)

func countBits(_ n: Int) -> [Int] {
    var dp = Array(repeating: 0, count: n + 1)
    if n == 0 {
        return dp
    }
    for i in 1...n {
        dp[i] = dp[i >> 1] + (i & 1)
    }
    return dp
}

// ============================================================
// MARK: - Demo
// ============================================================

print("Manual Approach")
print(countBitsManual(5))

print("\nDP Approach")
print(countBits(5))
