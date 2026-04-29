import UIKit

// ==================================================
// 08_Armstrong_Numbers.swift
// Print all Armstrong numbers between 1 and 200
// ==================================================

// Time Complexity: O(n × digits)
// Space Complexity: O(1)

import Foundation

// ==================================================
// Function: Check Armstrong Number
// ==================================================

func isArmstrongNumber(_ n: Int) -> Bool {
    
    let count = String(n).count   // number of digits
    
    var number = n
    var sum = 0
    
    while number > 0 {
        
        let digit = number % 10
        
        var power = 1
        for _ in 0..<count {
            power *= digit
        }
        
        sum += power
        number /= 10
    }
    return sum == n
}

// ==================================================
// Main Logic
// ==================================================

print("Armstrong numbers (1 to 200):")

for i in 1...200 {
    if isArmstrongNumber(i) {
        print(i, terminator: " ")
    }
}
