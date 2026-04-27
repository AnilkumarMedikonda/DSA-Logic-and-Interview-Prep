import UIKit
// ==================================================
// 07_Sum_Odd_Even_Digits.swift
// Find sum of odd digits and even digits of a number
// ==================================================

// Time Complexity: O(digits)
// Space Complexity: O(1)

import Foundation

// Input
let number = 12345

// Variables
var temp = number
var oddSum = 0
var evenSum = 0

// ==================================================
// Main Logic
// ==================================================

while temp > 0 {
    
    let digit = temp % 10
    
    if digit % 2 == 0 {
        evenSum += digit
    } else {
        oddSum += digit
    }
    
    temp /= 10
}

// ==================================================
// Output
// ==================================================

print("Odd Sum =", oddSum)
print("Even Sum =", evenSum)


