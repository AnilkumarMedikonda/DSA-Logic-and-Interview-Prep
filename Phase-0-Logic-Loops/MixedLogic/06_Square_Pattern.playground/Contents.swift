import UIKit

// ==================================================
// 06_Square_Pattern.swift
// Print pattern where i-th row prints value i × i
// ==================================================

// Time Complexity: O(n²)
// Space Complexity: O(1)

import Foundation

let n = 5

// ==================================================
// Main Logic
// ==================================================

for i in 1...n {
    let value = i * i
    
    for _ in 1...i {
        print(value, terminator: " ")
    }
    print()
}

