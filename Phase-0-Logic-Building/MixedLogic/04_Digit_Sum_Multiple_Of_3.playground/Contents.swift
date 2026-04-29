import UIKit


// ==================================================
// 04_Digit_Sum_Multiple_Of_3.swift
// Print numbers (1–100) whose digit sum is divisible by 3
// ==================================================

// Time Complexity: O(n × digits)
// Space Complexity: O(1)

import Foundation

// ==================================================
// Function: Check digit sum divisible by 3
// ==================================================

func isDivisibleBy3DigitSum(_ n: Int) -> Bool {
    
    var number = n
    var digitSum = 0
    
    while number > 0 {
        digitSum += number % 10
        number /= 10
    }
    
    return digitSum % 3 == 0
}

// ==================================================
// Main Logic
// ==================================================

print("Numbers with digit sum divisible by 3:")

for i in 1...100 {
    if isDivisibleBy3DigitSum(i) {
        print(i, terminator: " ")
    }
}
