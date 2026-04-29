import UIKit

import UIKit

// ==================================================
// 19_Alphabet_Centered_Pyramid_Comparison.swift
// Your approach vs corrected single-loop approach
// ==================================================

// Time Complexity: O(n²)
// Space Complexity: O(1)

import Foundation

let n = 5

// ==================================================
// Your Approach (Dynamic width) ⚠️
// ==================================================

var value = 5
var sapce = 4
var current1 = 1

for _ in 1...n {
    
    for j in 1...value {
        if j <= sapce {
            print(" ", terminator: " ")
        } else {
            let char = Character(UnicodeScalar(64 + current1)!)
            print(char, terminator: " ")
            current1 += 1
        }
    }
    
    value += 1
    sapce -= 1
    print()
}

// ==================================================
// Separator
// ==================================================

print("\n------- Corrected Version -------\n")

// ==================================================
// Corrected Single Loop Approach ✅
// ==================================================

let total = 2 * n - 1
var current2 = 1

for i in 1...n {
    
    for j in 1...total {
        
        if j <= (n - i) {
            print(" ", terminator: " ")
        }
        else if j <= (n - i) + (2 * i - 1) {
            let char = Character(UnicodeScalar(64 + current2)!)
            print(char, terminator: " ")
            current2 += 1
        }
    }
    
    print()
}

// ==================================================
// Output
// ==================================================

// Your version → slightly misaligned pyramid
// Correct version → proper centered pyramid
