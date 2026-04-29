import UIKit

// ==================================================
// 20_Increasing_Number_Triangle.swift
// Print increasing number triangle
// ==================================================

// Time Complexity: O(n²)
// Space Complexity: O(1)

import Foundation

let n = 5

// ==================================================
// Main Logic
// ==================================================

for i in 1...n {
    
    // Print numbers from 1 → i
    for j in 1...i {
        print(j, terminator: "")
    }
    print()
}
// ==================================================
// Output (n = 5)
// ==================================================
// 1
// 12
// 123
// 1234
// 12345
