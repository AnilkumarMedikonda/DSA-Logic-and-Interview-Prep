import UIKit

// ==================================================
// 04_Square_Stars.swift
// Print square pattern of stars (n × n)
// ==================================================

// Time Complexity: O(n²)
// Space Complexity: O(1)

import Foundation

let n = 5

for _ in 1...n {
    
    for _ in 1...n {
        print("*", terminator: "")
    }
    
    print()
}
