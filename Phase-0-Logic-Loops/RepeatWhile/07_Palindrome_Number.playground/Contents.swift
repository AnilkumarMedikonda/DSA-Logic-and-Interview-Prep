import UIKit

// ==================================================
// Problem: Check whether a number is a palindrome
// Example: 121 → Palindrome
// ==================================================

// Time Complexity: O(d)
// Space Complexity: O(1)

var number = 121
var temp = number      // preserve original
var reverse = 0

repeat {
    let digit = temp % 10
    reverse = reverse * 10 + digit
    temp /= 10
    
} while temp > 0

if reverse == number {
    print("Palindrome Number")
} else {
    print("Not Palindrome Number")
}
