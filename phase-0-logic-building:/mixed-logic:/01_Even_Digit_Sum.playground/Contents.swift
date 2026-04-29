import UIKit

// ==================================================
// Topic: Even Digit Sum
// ==================================================

// Problem:
// Print all numbers between 1 and 100 whose sum of digits is even.

// ==================================================
// Approach
// ==================================================

// For each number:
// 1. Extract digits
// 2. Calculate digit sum
// 3. Check if digit sum is even
// 4. Print number if condition is true

// ==================================================
// Code
// ==================================================

import Foundation

for i in 1...100 {
    
    var digitSum = 0
    var n = i
    
    // Step 1: Calculate digit sum
    while n > 0 {
        digitSum += n % 10
        n /= 10
    }
    
    // Step 2: Check even condition
    if digitSum % 2 == 0 {
        print(i, terminator: " ")
    }
}

// ==================================================
// Example
// ==================================================

// 11 → 1 + 1 = 2 → even → print
// 23 → 2 + 3 = 5 → odd → skip
// 44 → 4 + 4 = 8 → even → print

// ==================================================
// Key Concepts
// ==================================================

// Digit extraction:
// digit = n % 10
// n = n / 10

// Condition:
// digitSum % 2 == 0 → even

// ==================================================
// Time & Space Complexity
// ==================================================

// Time Complexity: O(n × digits) ≈ O(n)
// Space Complexity: O(1)

// ==================================================
// Edge Cases
// ==================================================

// i = 0 → digit sum = 0 (even)
// single digit numbers → direct check
// large numbers → more digits to process

// ==================================================
// Common Mistakes
// ==================================================

// ❌ Printing digit sum instead of number
// ❌ Not resetting digitSum inside loop
// ❌ Modifying original number without temp variable

// ==================================================
// Interview Tip
// ==================================================

// This pattern is used in:
// - Armstrong number
// - Palindrome number
// - Digit-based filtering problems

// Master digit extraction → unlocks many problems
// ==================================================
