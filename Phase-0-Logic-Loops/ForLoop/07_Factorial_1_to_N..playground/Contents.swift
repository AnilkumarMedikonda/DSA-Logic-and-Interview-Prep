import UIKit

var greeting = "Hello, playground"

import UIKit

// ==================================================
// Problem: Calculate and print factorial from 1 to n
// Example: n = 5
// Output:
// 1! = 1
// 2! = 2
// 3! = 6
// 4! = 24
// 5! = 120
// ==================================================

// Time Complexity: O(n)
// Space Complexity: O(1)

let n = 10
var result = 1   // accumulator

for i in 1...n {
    result *= i
    print("\(i)! = \(result)")
}
