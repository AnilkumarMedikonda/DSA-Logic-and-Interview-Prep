// ==================================================
// 06_Right_Aligned_Triangle.swift
// Print right-aligned triangle pattern of stars
// ==================================================

// Time Complexity: O(n²)
// Space Complexity: O(1)

import Foundation

let n = 5

for i in 1...n {
    
    // spaces (safe)
    for _ in 0..<(n - i) {
        print(" ", terminator: "")
    }
    
    // stars
    for _ in 1...i {
        print("*", terminator: "")
    }
    
    print()
}
