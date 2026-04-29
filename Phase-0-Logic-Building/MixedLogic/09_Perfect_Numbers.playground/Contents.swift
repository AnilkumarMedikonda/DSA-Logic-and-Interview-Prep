import UIKit
// ==================================================
// 09_Perfect_Numbers.swift
// Print all Perfect numbers between 1 and 100
// ==================================================

// Time Complexity: O(n √n)
// Space Complexity: O(1)

import Foundation

func isPerfectNumber(_ n: Int) -> Bool {
    
    if n <= 1 { return false }
    
    var sum = 1
    let limit = Int(Double(n).squareRoot())
    
    if limit >= 2 {
        for i in 2...limit {
            if n % i == 0 {
                sum += i
                if i != n / i {
                    sum += n / i
                }
            }
        }
    }
    
    return sum == n
}

// ==================================================
// Main Logic
// ==================================================

print("Perfect numbers (1 to 100):")

for i in 1...100 {
    if isPerfectNumber(i) {
        print(i, terminator: " ")
    }
}
