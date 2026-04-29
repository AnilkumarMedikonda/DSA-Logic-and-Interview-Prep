
import UIKit

// ==================================================
// Problem: Find and print sum of factors of a number
// Example: n = 20
// Factors: 1 2 4 5 10 20
// Sum = 42
// ==================================================

// Time Complexity: O(n)
// Space Complexity: O(1)

let n = 20
var sumOfFactors = 0

for i in 1...n {
    if n % i == 0 {
        print(i, terminator: " ")
        sumOfFactors += i
    }
}

print("\nSum of Factors ---> \(sumOfFactors)")
