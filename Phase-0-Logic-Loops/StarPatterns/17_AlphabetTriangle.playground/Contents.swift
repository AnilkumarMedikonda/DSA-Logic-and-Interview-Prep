import UIKit

// ==================================================
// 17_Repeated_Alphabet_Triangle.swift
// Print triangle with repeated uppercase alphabets
// ==================================================

// Time Complexity: O(n²)
// Space Complexity: O(1)

import Foundation

let n = 5

// ==================================================
// Main Logic
// ==================================================

for i in 1...n {
    
    // Convert row number → alphabet
    let char = Character(UnicodeScalar(64 + i)!)
    
    // Print same character i times
    for _ in 1...i {
        print(char, terminator: " ")
    }
    
    print()
}

// ==================================================
// Output (n = 5)
// ==================================================

