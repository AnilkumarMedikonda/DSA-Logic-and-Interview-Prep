// ==================================================
// 08_Odd_Stars.swift
// Print stars in odd numbers (1, 3, 5, 7, 9)
// ==================================================

// Time Complexity: O(n²)
// Space Complexity: O(1)

import Foundation

let n = 10

// ==================================================
// Main Logic
// ==================================================

for i in 1...n {
    if i % 2 != 0 {
        for _ in 1...i {
            print("*", terminator: "")
        }
        
        print()
    }
}
