import UIKit

// ==================================================
// Problem: Reverse a number
// Example: 1234 → 4321
// Using: repeat-while (do-while)
// ==================================================

// Time Complexity: O(d)
// Space Complexity: O(1)

var number = 1234
var temp = number          // preserve original
var reverseNumber = 0

repeat {
    let digit = temp % 10          // extract last digit
    reverseNumber = reverseNumber * 10 + digit
    temp /= 10                     // remove last digit
    
} while temp > 0

print("Reverse ---> \(reverseNumber)")
