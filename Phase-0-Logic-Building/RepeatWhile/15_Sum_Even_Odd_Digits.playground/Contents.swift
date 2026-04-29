
import UIKit

// ==================================================
// Problem: Find sum of even and odd digits separately
// Example: 534678
// Even digits → 4 + 6 + 8 = 18
// Odd digits  → 5 + 3 + 7 = 15
// ==================================================

// Time Complexity: O(d)
// Space Complexity: O(1)

var number = 534678
var temp = number        // preserve original (optional)

var evenSum = 0
var oddSum = 0

repeat {
    let digit = temp % 10
    
    if digit % 2 == 0 {
        evenSum += digit
    } else {
        oddSum += digit
    }
    
    temp /= 10
    
} while temp > 0

print("Even Sum ---> \(evenSum)")
print("Odd Sum  ---> \(oddSum)")

