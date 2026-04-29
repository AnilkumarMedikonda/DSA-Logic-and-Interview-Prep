import UIKit

// ==================================================
// Topic: Exponential Series
// Series: x − x²/2! + x³/3! − x⁴/4! + ... up to n terms
// ==================================================

// ==================================================
// Approach 1: Brute Force (Nested Loop)
// ==================================================

// Time Complexity: O(n²)
// Space Complexity: O(1)

// Idea:
// - Calculate power (x^i) using inner loop
// - Calculate factorial (i!)
// - Use i % 2 for alternating sign

import Foundation

let x1 = 2.0
let n1 = 5

var result1 = 0.0
var factorial1 = 1.0

print("Brute Force Series:")

for i in 1...n1 {
    
    factorial1 *= Double(i)
    
    var power = 1.0
    for _ in 1...i {
        power *= x1
    }
    
    if i % 2 != 0 {
        result1 += power / factorial1
    } else {
        result1 -= power / factorial1
    }
}

print("Result (Brute Force) = \(result1)\n")

// ==================================================
// Approach 2: Optimized (No Nested Loop)
// ==================================================

// Time Complexity: O(n)
// Space Complexity: O(1)

// Idea:
// - Reuse previous power and factorial
// - Flip sign using sign *= -1

let x2 = 2.0
let n2 = 5

var result2 = 0.0
var power2 = x2
var factorial2 = 1.0
var sign = 1.0

print("Optimized Series:")

for i in 1...n2 {
    
    factorial2 *= Double(i)
    
    let term = sign * (power2 / factorial2)
    result2 += term
    
    power2 *= x2
    sign *= -1
}

print("Result (Optimized) = \(result2)")

// ==================================================
// Key Points
// ==================================================

// term = sign × (power / factorial)

// power update → power *= x
// factorial update → factorial *= i
// sign update → sign *= -1

// ==================================================
// Edge Cases
// ==================================================

// n = 0 → result = 0
// x = 0 → result = 0
// n = 1 → result = x

// ==================================================
// Common Mistakes
// ==================================================

// ❌ Using i^i instead of x^i
// ❌ Forgetting factorial
// ❌ Not alternating signs
// ❌ Using Int instead of Double

// ==================================================
// Interview Tip
// ==================================================

// Start with brute force → then optimize to O(n)
// Shows strong problem-solving skills
// ==================================================
