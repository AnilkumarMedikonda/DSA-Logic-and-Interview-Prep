import UIKit

import UIKit

// ==================================================
// Problem: Check whether a given number is prime
// Example: 5 → Prime, 4 → Not Prime
// Using: for loop
// ==================================================

// Time Complexity: O(n)
// Space Complexity: O(1)

func isPrimeNumber(_ number: Int) -> Bool {
    // Base condition
    if number <= 1 { return false }   // 0 and 1 are not prime
    
    // Check divisibility
    for i in 2..<number {
        if number % i == 0 {
            return false
        }
    }
    
    return true
}


// --------------------------------------------------
// Test Cases
// --------------------------------------------------

let number = 5

if isPrimeNumber(number) {
    print("\(number) is Prime")
} else {
    print("\(number) is Not Prime")
}
