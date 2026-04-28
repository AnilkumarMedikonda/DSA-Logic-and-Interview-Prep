import UIKit

// ==================================================
// 05_Increasing_Triangle.swift
// Print increasing triangle pattern of stars
// ==================================================

// Time Complexity: O(n²)
// Space Complexity: O(1)

import Foundation

let n = 5

for i in 1...n {
    
    for _ in 1...i {
        print("*", terminator: "")
    }
    
    print()
}
