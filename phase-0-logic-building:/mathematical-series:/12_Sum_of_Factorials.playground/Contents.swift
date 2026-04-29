import UIKit
// ==================================================
// Problem: Sum of factorial series
// Series: 1! + 2! + 3! + ... + n!
// ==================================================

// Time Complexity: O(n)
// Space Complexity: O(1)

let n = 5

var factorial = 1
var sum = 0

print("Factorial Series:")

for i in 1...n {
    
    factorial *= i      // reuse previous factorial
    print(factorial, terminator: " ")
    
    sum += factorial
}

print("\nSum = \(sum)")
