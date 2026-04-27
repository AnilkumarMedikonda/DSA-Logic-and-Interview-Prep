import UIKit

var greeting = "Hello, playground"


import UIKit

// ==================================================
// Problem: Factorial using for loop
// Example: 5! = 120
// ==================================================

// Time Complexity: O(n)
// Space Complexity: O(1)

let n = 5
var result = 1

for i in 1...n {
    result *= i
}

print("Factorial ---> \(result)")
