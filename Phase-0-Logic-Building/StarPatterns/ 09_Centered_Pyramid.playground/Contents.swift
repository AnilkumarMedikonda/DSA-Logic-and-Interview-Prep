import UIKit

// ==================================================
// 09_Pyramid_Stars.swift
// Print centered pyramid pattern using "*"
// ==================================================

// Time Complexity: O(n²)
// Space Complexity: O(n)

import Foundation

let n = 5
let width = 2 * n + 1

// ==================================================
// Main Logic
// ==================================================

var values = Array(repeating: " ", count: width)

var left = n
var right = n

values[n] = "*"

for _ in 1...n {
    
    for ch in values {
        print(ch, terminator: "")
    }
    
    print()
    
    left -= 1
    right += 1
    
    if left >= 0 {
        values[left] = "*"
    }
    
    if right < values.count {
        values[right] = "*"
    }
}

// ==================================================
// Output (n = 5)
// ==================================================

//      *
//     ***
//    *****
//   *******
//  *********
