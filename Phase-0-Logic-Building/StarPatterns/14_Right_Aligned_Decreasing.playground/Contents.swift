import Foundation


// ==================================================
// 14_Cyclic_Floyd_Triangle.swift
// Print increasing triangle with numbers cycling (0–9)
// ==================================================

// Time Complexity: O(n²)
// Space Complexity: O(1)

let n = 7

// ==================================================
// Main Logic
// ==================================================

var current = 1   // next number to print

for i in 1...n {
    
    for _ in 1...i {
        
        // Reset when reaching 10 → cycle back to 0
        if current == 10 {
            current = 0
        }
        
        print(current, terminator: " ")
        current += 1
    }
    
    print()
}

// ==================================================
// Output (n = 7)
// ==================================================

// 1
// 2 3
// 4 5 6
// 7 8 9 0
// 1 2 3 4 5
// 6 7 8 9 0 1
// 2 3 4 5 6 7 8
