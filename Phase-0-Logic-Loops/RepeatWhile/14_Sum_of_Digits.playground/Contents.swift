import UIKit

// ==================================================
// Problem: Find sum of digits of a number
// Example: 5345 → 5 + 3 + 4 + 5 = 17
// Using: repeat-while (do-while)
// ==================================================

// Time Complexity: O(d)
// Space Complexity: O(1)

var number = 5345
var temp = number      // preserve original
var sum = 0

repeat {
    let digit = temp % 10
    sum += digit
    temp /= 10
    
} while temp > 0

print("Sum of Digits ---> \(sum)")
