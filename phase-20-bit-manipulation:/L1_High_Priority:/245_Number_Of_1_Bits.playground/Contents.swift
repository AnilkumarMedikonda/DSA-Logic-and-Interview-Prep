//
//  245_Number_Of_1_Bits.swift
//  Phase 20 — Bit Manipulation / L1 High Priority
//
//  LeetCode 191 — Number of 1 Bits (Hamming Weight)
//
//  Statement:
//  Given an unsigned integer, return the number of '1' bits it has
//  (its Hamming weight).
//
//  Example:
//    Input : n = 11   (binary 0000...1011)
//    Output: 3
//
//    Input : n = 128  (binary 1000 0000)
//    Output: 1
//
//  Constraints:
//    - Input is a 32-bit UNSIGNED integer -> use UInt32, not Int.
//      A signed right shift on a negative Int sign-extends and the
//      loop never reaches 0.
//

import Foundation

// ============================================================
// MARK: - Approach 1: Brian Kernighan  (n & (n - 1))
// ============================================================
//
// n & (n - 1) clears the RIGHTMOST set bit each pass, so the loop
// runs once per 1 bit — not once per bit position.
//
//   11 = 1011
//   1011 & 1010 = 1010   count 1
//   1010 & 1001 = 1000   count 2
//   1000 & 0111 = 0000   count 3  -> done
//
// Time: O(set bits), Space: O(1)
// 1 << 31 finishes in ONE pass; a shift-32-times loop takes 32.
// That difference is the LC 191 follow-up.

func hammingCount(_ n: UInt32) -> Int {
    var number = n
    var count = 0
    while number != 0 {
        number = number & (number - 1)
        count += 1
    }
    return count
}

// ============================================================
// MARK: - Approach 2: Manual divide  (% 2, / 2)
// ============================================================
//
// Check the last bit, then drop it by halving. No bit operators.
//
// Time: O(bit width) = O(32), Space: O(1)
// Always 32 passes regardless of how many 1s — slower than above.

func hammingCountManual(_ n: UInt32) -> Int {
    var number = n
    var count = 0
    while number > 0 {
        let bit = number % 2
        if bit == 1 {
            count += 1
        }
        number = number / 2
    }
    return count
}

// ============================================================
// MARK: - Demo
// ============================================================

print("-- Brian Kernighan --")

print("11  -> \(hammingCount(11))")

print("13  -> \(hammingCount(13))")

print("128 -> \(hammingCount(128))")

print("UInt32.max -> \(hammingCount(UInt32.max))")

print("\n-- Manual divide --")

print("11  -> \(hammingCountManual(11))")

print("13  -> \(hammingCountManual(13))")

print("128 -> \(hammingCountManual(128))")

print("UInt32.max -> \(hammingCountManual(UInt32.max))")
