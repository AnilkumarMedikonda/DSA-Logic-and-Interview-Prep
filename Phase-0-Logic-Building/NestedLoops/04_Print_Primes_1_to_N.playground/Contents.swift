import UIKit

// ==================================================
// Problem: Print all prime numbers from 1 to n
// Example: n = 100
// ==================================================

// Time Complexity: O(n²)
// Space Complexity: O(1)

let n = 100

for i in 1...n {
    if isPrime(i) {
        print(i, terminator: " ")
    }
}

// --------------------------------------------------
// Helper Function: Check Prime
// --------------------------------------------------

func isPrime(_ number: Int) -> Bool {
    
    if number <= 1 { return false }   // 0 and 1 are not prime
    
    for i in 2..<number {
        if number % i == 0 {
            return false
        }
    }
    
    return true
}
