import UIKit

// ==================================================
// 10_Max_Digit_Sum_Number.swift
// Find the number between 1 and n that has the
// maximum digit sum, and print that number with its sum
// ==================================================

// Time Complexity: O(n × digits)
// Space Complexity: O(1)

import Foundation

// ==================================================
// Function: Calculate Digit Sum
// ==================================================

func digitSum(_ n: Int) -> Int {
    
    var number = n
    var sum = 0
    
    while number > 0 {
        sum += number % 10
        number /= 10
    }
    
    return sum
}

// ==================================================
// Main Logic
// ==================================================

let n = 100

var maxSum = Int.min
var resultNumber = 0

for i in 1...n {
    
    let currentSum = digitSum(i)
    
    if currentSum > maxSum {
        maxSum = currentSum
        resultNumber = i
    }
}

// ==================================================
// Output
// ==================================================

print("Number =", resultNumber)
print("Max Digit Sum =", maxSum)

