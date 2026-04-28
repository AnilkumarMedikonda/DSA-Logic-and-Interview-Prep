import UIKit

// ==================================================
// 10_Alternating_Stars_Spaces.swift
// Print stars and spaces alternating (b = blank space)
// ==================================================

// Time Complexity: O(n²)
// Space Complexity: O(n)

import Foundation

let n = 5

// ==================================================
// Main Logic
// ==================================================

// Initial array → bbbb*
var values = Array(repeating: "b", count: n - 1)
values.append("*")

for _ in 1...n {
    
    // Print current row
    for ch in values {
        print(ch, terminator: "")
    }
    
    print()
    
    // Expand pattern
    values.append("b")
    values.append("*")
    
    // Remove first element → shift left
    if !values.isEmpty {
        values.removeFirst()
    }
}

// ==================================================
// Output (n = 5)
// ==================================================

// bbbb*
// bbb*b*
// bb*b*b*
// b*b*b*b*
// *b*b*b*b*


// ==================================================
// Part 2: Reverse Pattern
// ==================================================

print("\n--- Reverse ---")

// Start with last row → *b*b*b*b*
var reverseValues = ["*"]
for _ in 1..<n {
    reverseValues.append("b")
    reverseValues.append("*")
}

for _ in 1...n {
    
    for ch in reverseValues {
        print(ch, terminator: "")
    }
    print()
    
    // Shrink pattern
    if reverseValues.count >= 2 {
        reverseValues.removeFirst()
        reverseValues.removeFirst()
    }
    
    // Rebuild left side
    reverseValues.insert("b", at: 0)
}

// ==================================================
// Output (n = 5)
// ==================================================

// Forward:
// bbbb*
// bbb*b*
// bb*b*b*
// b*b*b*b*
// *b*b*b*b*

// Reverse:
// *b*b*b*b*
// b*b*b*b*
// bb*b*b*
// bbb*b*
// bbbb*
