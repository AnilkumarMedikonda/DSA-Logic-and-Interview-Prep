import UIKit
// ==================================================
// 01_Binary_Even_Ones.swift
// Print numbers (1 to n) whose binary representation
// contains an even number of 1s
// ==================================================

// Time Complexity: O(n × log n)
// Space Complexity: O(1)

import Foundation

let n = 10

// ==================================================
// Main Logic
// ==================================================

print("Numbers with even number of 1s in binary:")

for i in 1...n {
    
    var number = i
    var count = 0
    
    // Count 1s in binary
    while number > 0 {
        if number % 2 == 1 {
            count += 1
        }
        number /= 2
    }
    
    // Check even count
    if count % 2 == 0 {
        print(i, terminator: " ")
    }
}

// ==================================================
// Edge Cases
// ==================================================

// i = 0 → binary = 0 → count = 0 (even)
// Large n → more bits to process

// ==================================================
// Common Mistakes
// ==================================================

// ❌ Using %10 instead of %2
// ❌ Dividing by 10 instead of 2
// ❌ Printing wrong variable
// ❌ Checking count == 2 instead of even condition
