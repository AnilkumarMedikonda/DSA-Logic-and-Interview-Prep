import UIKit

// ==================================================
// Problem: Print prime numbers from 1 to 100
// Using: for loop (pure integer logic, no sqrt)
// ==================================================

// Time Complexity: O(n²)
// Space Complexity: O(1)

for i in 1...100 {
    if isPrime(i) {
        print(i, terminator: " ")
    }
}

// --------------------------------------------------
// Helper Function: Prime Check (no sqrt)
// --------------------------------------------------

func isPrime(_ number: Int) -> Bool {
    
    if number <= 1 { return false }   // 0 and 1 are not prime
    
    for i in 2..<number {             // check all numbers before it
        if number % i == 0 {
            return false
        }
    }
    
    return true
}
