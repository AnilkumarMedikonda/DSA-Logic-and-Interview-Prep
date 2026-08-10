import Foundation

//
//  04_Bit_Tricks.swift
//  Phase 20 — Bit Manipulation
//
//  Topics:
//  1. Check Bit
//  2. Set Bit
//  3. Clear Bit
//  4. Toggle Bit
//  5. Remove Rightmost 1
//  6. Get Rightmost 1
//  7. Check Power of 2
//  8. Count Set Bits
//

// ============================================================
// MARK: - 1. Check Bit
// ============================================================
//
// Check whether a particular position contains 0 or 1.
//
// Formula:
//
// (number >> position) & 1
//
// Example:
//
// 13 = 1101
//
// Position:
//
// Bit:       1   1   0   1
// Position:  3   2   1   0
//
// Check position 2:
//
// 13 >> 2
//
// 1101
// 0110
// 0011
//
// 0011 & 0001
// 0001
//
// Result = 1
//

func checkBit(_ number: Int, position: Int) -> Bool {
    return ((number >> position) & 1) == 1
}

print("========== CHECK BIT ==========")

print("13, position 0:", checkBit(13, position: 0))
print("13, position 1:", checkBit(13, position: 1))
print("13, position 2:", checkBit(13, position: 2))
print("13, position 3:", checkBit(13, position: 3))


// ============================================================
// MARK: - 2. Set Bit
// ============================================================
//
// Set = make the selected bit 1.
//
// Formula:
//
// number | (1 << position)
//
// Example:
//
// 8 = 1000
//
// Position:
//
// Bit:       1   0   0   0
// Position:  3   2   1   0
//
// Set position 1:
//
// 1 << 1
//
// 0001
// 0010
//
// Now:
//
// 1000
// 0010
// ----
// 1010
//
// 1010 = 10
//

func setBit(_ number: Int, position: Int) -> Int {
    return number | (1 << position)
}

print("\n========== SET BIT ==========")

print(
    "8 → set position 1:",
    setBit(8, position: 1)
)


// ============================================================
// MARK: - 3. Clear Bit
// ============================================================
//
// Clear = make the selected bit 0.
//
// Formula:
//
// number & ~(1 << position)
//
// Example:
//
// 15 = 1111
//
// Clear position 2:
//
// 1 << 2
//
// 0001
// 0100
//
// NOT:
//
// ~0100
//
// Conceptually:
//
// 1011
//
// Now:
//
// 1111
// 1011
// ----
// 1011
//
// 1011 = 11
//

func clearBit(_ number: Int, position: Int) -> Int {
    return number & ~(1 << position)
}

print("\n========== CLEAR BIT ==========")

print(
    "15 → clear position 2:",
    clearBit(15, position: 2)
)


// ============================================================
// MARK: - 4. Toggle Bit
// ============================================================
//
// Toggle:
//
// 0 → 1
// 1 → 0
//
// Formula:
//
// number ^ (1 << position)
//
// Example:
//
// 8 = 1000
//
// Toggle position 1:
//
// 1 << 1
//
// 0001
// 0010
//
// XOR:
//
// 1000
// 0010
// ----
// 1010
//
// 1010 = 10
//

func toggleBit(_ number: Int, position: Int) -> Int {
    return number ^ (1 << position)
}

print("\n========== TOGGLE BIT ==========")

print(
    "8 → toggle position 1:",
    toggleBit(8, position: 1)
)


// ============================================================
// MARK: - 5. Remove Rightmost 1
// ============================================================
//
// Formula:
//
// number & (number - 1)
//
// This removes the rightmost 1 bit.
//
// Example:
//
// 12 = 1100
//
// 12 - 1 = 11
//
// 11 = 1011
//
// AND:
//
// 1100
// 1011
// ----
// 1000
//
// 1000 = 8
//
// One 1 has been removed.
//

func removeRightmostOne(_ number: Int) -> Int {
    return number & (number - 1)
}

print("\n========== REMOVE RIGHTMOST 1 ==========")

print(
    "12 →",
    removeRightmostOne(12)
)


// ============================================================
// MARK: - 6. Get Rightmost 1
// ============================================================
//
// Formula:
//
// number & -number
//
// This keeps ONLY the rightmost 1.
//
// Example:
//
// 12 = 1100
//
// Rightmost 1:
//
// 0100
//
// 0100 = 4
//

func getRightmostOne(_ number: Int) -> Int {
    return number & -number
}

print("\n========== GET RIGHTMOST 1 ==========")

print(
    "12 →",
    getRightmostOne(12)
)


// ============================================================
// MARK: - 7. Check Power of 2
// ============================================================
//
// A power of 2 contains only ONE 1.
//
// Examples:
//
// 1  = 0001
// 2  = 0010
// 4  = 0100
// 8  = 1000
// 16 = 10000
//
// Formula:
//
// number > 0
// &&
// (number & (number - 1)) == 0
//
// Example:
//
// 8 = 1000
// 7 = 0111
//
// 1000
// 0111
// ----
// 0000
//
// Result = 0
//
// Therefore 8 is a power of 2.
//

func isPowerOfTwo(_ number: Int) -> Bool {
    return number > 0 &&
           (number & (number - 1)) == 0
}

print("\n========== POWER OF 2 ==========")

print("1  :", isPowerOfTwo(1))
print("2  :", isPowerOfTwo(2))
print("4  :", isPowerOfTwo(4))
print("8  :", isPowerOfTwo(8))
print("10 :", isPowerOfTwo(10))
print("16 :", isPowerOfTwo(16))


// ============================================================
// MARK: - 8. Count Set Bits
// ============================================================
//
// Set bit = 1.
//
// Example:
//
// 13 = 1101
//
// Number of 1s:
//
// 1101
// ↑ ↑ ↑
// 1 1 1
//
// Count = 3
//
// We use:
//
// n & (n - 1)
//
// to remove one 1 each time.
//

func countSetBits(_ number: Int) -> Int {

    var n = number
    var count = 0

    while n != 0 {

        n = n & (n - 1)

        count += 1
    }

    return count
}

print("\n========== COUNT SET BITS ==========")

print("13 →", countSetBits(13))
print("7  →", countSetBits(7))
print("8  →", countSetBits(8))
print("10 →", countSetBits(10))


// ============================================================
// MARK: - 9. Binary Practice
// ============================================================

print("\n========== BINARY PRACTICE ==========")

let numbers = [1, 2, 4, 5, 7, 8, 10, 12, 13, 16]

for number in numbers {
    print(
        "\(number) → \(String(number, radix: 2))"
    )
}


// ============================================================
// MARK: - Cheat Sheet
// ============================================================
//
// CHECK BIT
//
// (n >> i) & 1
//
// Check whether bit at position i is 0 or 1.
//
//
// SET BIT
//
// n | (1 << i)
//
// Make bit = 1.
//
//
// CLEAR BIT
//
// n & ~(1 << i)
//
// Make bit = 0.
//
//
// TOGGLE BIT
//
// n ^ (1 << i)
//
// 0 → 1
// 1 → 0
//
//
// REMOVE RIGHTMOST 1
//
// n & (n - 1)
//
//
// GET RIGHTMOST 1
//
// n & -n
//
//
// POWER OF 2
//
// n > 0 && (n & (n - 1)) == 0
//
//
// COUNT SET BITS
//
// n = n & (n - 1)
//
// ============================================================
