import UIKit

// ==================================================
// Problem: Find sum of first n natural numbers
// Example: n = 10 → Sum = 55
// ==================================================

// Time Complexity: O(n)
// Space Complexity: O(1)

let n = 10
var sum = 0

for i in 1...n {
    sum += i
}

print("Sum ---> \(sum)")
