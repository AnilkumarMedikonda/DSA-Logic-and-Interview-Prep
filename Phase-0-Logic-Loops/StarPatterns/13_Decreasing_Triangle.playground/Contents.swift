import UIKit


// ==================================================
// 13_Increasing_Continuous_Triangle.swift
// Print increasing triangle with continuous numbers
// ==================================================

// Time Complexity: O(n²)
// Space Complexity: O(1)

import Foundation

let n = 5

// ==================================================
// Main Logic
// ==================================================

var current = 1   // next number to print

for i in 1...n {
    
    for _ in 1...i {
        print(current, terminator: " ")
        current += 1
    }
    
    print()
}

// ==================================================
// Output (n = 5)
// ==================================================

// 1
// 2 3
// 4 5 6
// 7 8 9 10
// 11 12 13 14 15
