//
//  247_Reverse_Bits.swift
//  Phase 20 — Bit Manipulation / L1 High Priority
//
//  LeetCode 190 — Reverse Bits
//
//  Statement:
//  Reverse the bits of a given 32-bit unsigned integer.
//
//  Example:
//    Input : n = 13
//            00000000000000000000000000001101
//    Output: 2952790016
//            10110000000000000000000000000000
//    The trailing 1101 becomes the leading bits.
//
//  Constraints:
//    - Input is a 32-bit UNSIGNED integer -> use UInt32.
//      On Int, the reversed value's top bit lands on the SIGN bit
//      and the result reads as negative. UInt32 has no sign bit, so
//      all 32 positions are value bits — this is exactly why LC 190
//      specifies unsigned.
//
//  Both approaches — Time: O(1) (always 32 iterations, independent
//  of input), Space: O(1).
//

import Foundation

// ============================================================
// MARK: - Approach 1: Manual  (% 2, * 2, / 2)
// ============================================================
//
// Pull the last bit off the input, push it onto the result, 32 times.
// Building result with * 2 + bit reverses order: the FIRST bit taken
// (input's position 0) ends up MOST significant in the result.
//
//   take bit -> shift result up -> add bit -> shrink input
//
// Exactly 32 passes, even for input 0 — that fixed count is the O(1).

func reverseBitManual(_ n: UInt32) -> UInt32 {
    var number = n
    var result: UInt32 = 0
    for _ in 0..<32 {
        let bit = number % 2
        result = result * 2 + bit
        number = number / 2
    }
    return result
}

// ============================================================
// MARK: - Approach 2: Bit operators  (& 1, << 1, >> 1)
// ============================================================
//
// Same algorithm, operator vocabulary:
//   number % 2  ->  number & 1     (read last bit)
//   result * 2  ->  result << 1    (make room)
//   + bit       ->  | bit          (drop it in)
//   number / 2  ->  number >> 1    (discard last bit)
//
// >> 1 on UInt32 is a LOGICAL shift — fills with 0, so the loop
// drains to 0. On a negative Int it would sign-extend and never end.

func reverseBits(_ n: UInt32) -> UInt32 {
    var number = n
    var result: UInt32 = 0
    for _ in 0..<32 {
        let bit = number & 1
        result = (result << 1) | bit
        number = number >> 1
    }
    return result
}

// ============================================================
// MARK: - Demo
// ============================================================

print("========== MANUAL APPROACH ==========")
print("13 -> \(reverseBitManual(13))")

print("\n========== BIT APPROACH ==========")
print("13 -> \(reverseBits(13))")

print("\n========== CHECK: reverse twice = original ==========")
print("reverse(reverse(13)) -> \(reverseBits(reverseBits(13)))")
