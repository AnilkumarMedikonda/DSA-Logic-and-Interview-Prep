import Foundation

//
//  01_Bit_Basics.swift
//  Phase 20 — Bit Manipulation
//
//  Topic:
//  - Binary representation
//  - Decimal → Binary
//  - Binary → Decimal
//  - Bit positions
//  - Odd / Even
//
//  No bitwise operators in this file.
//  No built-in radix conversion for the actual logic.
//  `String(_:radix:)` is used only at the end for verification.
//

// ============================================================
// MARK: - Bit Basics
// ============================================================
//
// A bit has two states:
//
// 0 = OFF
// 1 = ON
//
// Place values are powers of 2:
//
//      8    4    2    1
//      2³   2²   2¹   2⁰
//
// Bit position counts from RIGHT → LEFT:
//
//      1    1    0    1
//      3    2    1    0
//      ↑    ↑    ↑    ↑
//   position
//
// Position 0 is always the rightmost bit.
//
// Example:
//
// 13 = 1101
//
//      8    4    2    1
//      1    1    0    1
//
// = 8 + 4 + 0 + 1
// = 13


// ============================================================
// MARK: - Decimal → Binary
// ============================================================
//
// Method:
//
// Divide the number by 2.
// Store the remainder.
// Continue until the number becomes 0.
// Read the remainders from BOTTOM → TOP.
//
// Example: 13
//
// 13 / 2 = 6   remainder 1
//  6 / 2 = 3   remainder 0
//  3 / 2 = 1   remainder 1
//  1 / 2 = 0   remainder 1
//
// Read bottom → top:
//
// 1101
//
// Therefore:
//
// 13 → 1101
//

func toBinary(_ number: Int, width: Int) -> String {

    var value = number
    var bits = ""

    while value > 0 {

        let remainder = value % 2

        bits = "\(remainder)" + bits

        value = value / 2
    }

    // Special case
    // 0 → "0"
    if bits.isEmpty {
        bits = "0"
    }

    // Add leading zeros if required.
    //
    // Example:
    //
    // 5 → 101
    //
    // width = 4
    //
    // 0101

    while bits.count < width {
        bits = "0" + bits
    }

    return bits
}


// ============================================================
// MARK: - Binary → Decimal
// ============================================================
//
// Walk LEFT → RIGHT.
//
// Each step:
//
// current value × 2
// then add the current bit.
//
// Example:
//
// 1011
//
// Start = 0
//
// See 1:
// 0 × 2 + 1 = 1
//
// See 0:
// 1 × 2 + 0 = 2
//
// See 1:
// 2 × 2 + 1 = 5
//
// See 1:
// 5 × 2 + 1 = 11
//
// Therefore:
//
// 1011 → 11
//
// Same result using place values:
//
// 8 + 0 + 2 + 1 = 11
//

func toDecimal(_ bits: String) -> Int {

    var value = 0

    for character in bits {

        value = value * 2

        if character == "1" {
            value = value + 1
        }
    }

    return value
}


// ============================================================
// MARK: - Bit at a Position
// ============================================================
//
// Example:
//
// 13 = 1101
//
//      1    1    0    1
//      3    2    1    0
//
// To get position 2:
//
// Divide by 2 two times.
//
// 13 / 2 = 6
//  6 / 2 = 3
//
// 3 % 2 = 1
//
// Therefore:
//
// bitAt(13, position: 2) = 1
//
// We are intentionally NOT using:
//
// &
// >>
//
// Those will be introduced later.
//

func bitAt(_ number: Int, position: Int) -> Int {

    var value = number
    var moved = 0

    while moved < position {

        value = value / 2

        moved = moved + 1
    }

    return value % 2
}


// ============================================================
// MARK: - Odd / Even
// ============================================================
//
// The rightmost bit determines whether a number is odd or even.
//
// Even:
//
// 8 = 1000
//          ↑
//          0
//
// Odd:
//
// 7 = 0111
//          ↑
//          1
//
// Therefore:
//
// last bit = 0 → Even
// last bit = 1 → Odd
//
// Later we will learn:
//
// n & 1
//
// But for now we use:
//
// bitAt(n, position: 0)
//

func isOdd(_ number: Int) -> Bool {

    return bitAt(number, position: 0) == 1
}


// ============================================================
// MARK: - Demo
// ============================================================

func runBitBasics() {

    // --------------------------------------------------------
    // Decimal → Binary
    // --------------------------------------------------------

    print("========== Decimal → Binary ==========")

    let sample = 13

    print("13 → \(toBinary(sample, width: 4))")
    print("5  → \(toBinary(5, width: 4))")
    print("10 → \(toBinary(10, width: 4))")
    print("8  → \(toBinary(8, width: 4))")
    print("0  → \(toBinary(0, width: 4))")


    // --------------------------------------------------------
    // Binary → Decimal
    // --------------------------------------------------------

    print("\n========== Binary → Decimal ==========")

    print("1011 → \(toDecimal("1011"))")
    print("0101 → \(toDecimal("0101"))")
    print("1101 → \(toDecimal("1101"))")
    print("1000 → \(toDecimal("1000"))")


    // --------------------------------------------------------
    // Bit Positions
    // --------------------------------------------------------

    print("\n========== Bit Positions of 13 ==========")

    // 13 = 1101
    //
    // Position:
    //
    // 3   2   1   0
    // 1   1   0   1

    var position = 3

    while position >= 0 {

        print(
            "position \(position) → \(bitAt(13, position: position))"
        )

        position = position - 1
    }


    // --------------------------------------------------------
    // Odd / Even
    // --------------------------------------------------------

    print("\n========== Odd / Even ==========")

    print("7 is \(isOdd(7) ? "Odd" : "Even")")
    print("8 is \(isOdd(8) ? "Odd" : "Even")")
    print("13 is \(isOdd(13) ? "Odd" : "Even")")
    print("20 is \(isOdd(20) ? "Odd" : "Even")")


    // --------------------------------------------------------
    // Practice Table
    // --------------------------------------------------------

    print("\n========== Practice Table ==========")

    let numbers = [
        1, 2, 3, 4,
        5, 7, 8, 9,
        10, 12, 13, 16
    ]

    for number in numbers {

        let mine = toBinary(number, width: 5)

        // Built-in conversion is ONLY for verification.
        let builtIn = String(number, radix: 2)

        print(
            "\(number)\t→ \(mine)\t(check: \(builtIn))"
        )
    }
}


// ============================================================
// MARK: - Run
// ============================================================

runBitBasics()


