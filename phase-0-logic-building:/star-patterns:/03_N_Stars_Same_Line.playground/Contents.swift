import UIKit

var greeting = "Hello, playground"


// ==================================================
// 03_N_Stars_Same_Line.swift
// Print n stars on the same line
// ==================================================

// Time Complexity: O(n)
// Space Complexity: O(1)

import Foundation

let n = 20

// ==================================================
// Main Logic
// ==================================================

for _ in 1...n {
    print("*", terminator: "")
}
