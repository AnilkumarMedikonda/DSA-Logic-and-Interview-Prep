import UIKit

import UIKit

// ==================================================
// 11_Increasing_Number_Pattern.swift
// Print increasing number pattern
// ==================================================

// Time Complexity: O(n²)
// Space Complexity: O(1)

import Foundation

let n = 5

// ==================================================
// Main Logic
// ==================================================

for i in 1...n {
    
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
