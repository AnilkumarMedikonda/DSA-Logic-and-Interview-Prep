import UIKit

// ==================================================
// 15_Binary_Array_Pattern.swift
// Print binary pattern using array growth (0 & 1)
// ==================================================

// Time Complexity: O(n²)
// Space Complexity: O(n)

import Foundation

let n = 5

// ==================================================
// Main Logic
// ==================================================

var array = [1]

for i in 1...n {
    
    // Print current row
    for value in array {
        print(value, terminator: " ")
    }
    print()
    
    // Update array
    if i % 2 == 0 {
        // Even row → append opposite of last element
        let last = array.last ?? 0
        array.append(last == 0 ? 1 : 0)
        
    } else {
        // Odd row → insert opposite of first element
        let first = array.first ?? 0
        array.insert(first == 0 ? 1 : 0, at: 0)
    }
}

// ==================================================
// Output (n = 5)
// ==================================================

// 1
// 0 1
// 0 1 0
// 1 0 1 0
// 1 0 1 0 1
