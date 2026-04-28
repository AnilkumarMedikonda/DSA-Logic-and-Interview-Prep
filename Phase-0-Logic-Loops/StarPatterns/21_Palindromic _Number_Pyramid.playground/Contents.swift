import UIKit

// ==================================================
// 21_Palindromic_Number_Pyramid.swift
// Print palindromic number pyramid
// ==================================================

// Time Complexity: O(n²)
// Space Complexity: O(1)

import Foundation

// ==================================================
// Main Logic
// ==================================================

let n = 5

for i in 1...n {
    
    // Spaces (safe range)
    for _ in 0..<(n - i) {
        print(" ", terminator: "")
    }
    
    // Increasing
    for j in 1...i {
        print(j, terminator: "")
    }
    
    // Decreasing
    var value = i - 1
    for _ in 1..<i {
        print(value, terminator: "")
        value -= 1
    }
    
    print()
}

// ==================================================
// Output (n = 5)
// ==================================================

//     1
//    121
//   12321
//  1234321
// 123454321
