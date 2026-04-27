
import UIKit

// ==================================================
// Problem: Count number of digits in a number
// Using: repeat-while (do-while)
// Example: 12345 → 5 digits
// ==================================================

// Time Complexity: O(d)
// Space Complexity: O(1)

var number = 1234589
var temp = number   
var digitCount = 0

repeat {
    temp /= 10
    digitCount += 1
    
} while temp > 0

print("Digits ---> \(digitCount)")
