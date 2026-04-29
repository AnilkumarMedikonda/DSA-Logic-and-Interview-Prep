
import UIKit

// ==================================================
// Problem: Factorial of a number
// Example: 5! = 5 × 4 × 3 × 2 × 1 = 120
// Using: repeat-while (do-while)
// ==================================================

// Time Complexity: O(n)
// Space Complexity: O(1)

var n = 5
var temp = n          // preserve original (optional)
var result = 1

repeat {
    result *= temp
    temp -= 1
} while temp > 0

print("Factorial ---> \(result)")
