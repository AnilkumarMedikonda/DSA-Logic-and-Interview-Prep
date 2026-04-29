import UIKit

// ==================================================
// Topic: Strong Number
// ==================================================

// Definition:
// A number is called a Strong Number if:
// sum of factorials of its digits == the number

// Example:
// 145 → 1! + 4! + 5! = 1 + 24 + 120 = 145 ✅

// ==================================================
// Approach 1: Basic (Using Loop for Factorial)
// ==================================================

// Time Complexity: O(d × k)
// d = number of digits
// k = digit value (max 9)

// Space Complexity: O(1)

import Foundation

let number = 145
var temp = number
var sum = 0

print("Factorials:")

while temp > 0 {
    
    let digit = temp % 10
    
    var fact = 1
    for i in 1...digit {
        fact *= i
    }
    
    print(fact, terminator: " ")
    sum += fact
    
    temp /= 10
}

print("\nSum = \(sum)")

if sum == number {
    print("Strong Number")
} else {
    print("Not Strong Number")
}

// ==================================================
// Approach 2: Optimized (Precomputed Factorials)
// ==================================================

// Time Complexity: O(d)
// Space Complexity: O(1)

// Precompute factorials of digits (0–9)

let factorials = [1, 1, 2, 6, 24, 120, 720, 5040, 40320, 362880]

let number2 = 145
var temp2 = number2
var sum2 = 0

while temp2 > 0 {
    
    let digit = temp2 % 10
    sum2 += factorials[digit]   // direct lookup
    
    temp2 /= 10
}

print("\nOptimized Sum = \(sum2)")

if sum2 == number2 {
    print("Strong Number")
} else {
    print("Not Strong Number")
}

// ==================================================
// Key Points
// ==================================================

// Extract digit → digit = number % 10
// Remove digit → number /= 10

// Always preserve original number

// ==================================================
// Edge Cases
// ==================================================

// number = 0 → 0! = 1 → Not Strong
// single digit numbers → check carefully

// ==================================================
// Common Mistakes
// ==================================================

// ❌ Modifying digit while computing factorial
// ❌ Losing original number
// ❌ Using wrong factorial loop (1..<digit)

// ==================================================
// Interview Tip
// ==================================================

// Start with basic approach → then optimize using array
// Shows strong problem-solving ability
// ==================================================
