import UIKit
// ==================================================
// Problem: Find the sum of first n natural numbers
// ==================================================

// Time Complexity: O(n)
// Space Complexity: O(1)

let n = 10
var sum = 0

for i in 1...n {
    sum += i
}

print("Sum of first \(n) natural numbers = \(sum)")
