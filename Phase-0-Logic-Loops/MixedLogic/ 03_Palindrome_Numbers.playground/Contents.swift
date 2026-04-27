import UIKit

// ==================================================
// 03_Palindrome_Numbers.swift
// Print all palindrome numbers between 1 and 500
// ==================================================

// Time Complexity: O(n × digits)
// Space Complexity: O(1)

import Foundation

// ==================================================
// Function: Check Palindrome
// ==================================================

func isPalindrome(_ number: Int) -> Bool {
    
    var temp = number
    var reverse = 0
    
    while temp > 0 {
        let digit = temp % 10
        reverse = reverse * 10 + digit
        temp /= 10
    }
    
    return reverse == number
}

// ==================================================
// Main Logic
// ==================================================

print("Palindrome numbers (1 to 500):")

for i in 1...500 {
    if isPalindrome(i) {
        print(i, terminator: " ")
    }
}


