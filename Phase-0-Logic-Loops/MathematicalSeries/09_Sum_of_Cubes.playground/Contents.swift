import UIKit

// ==================================================
// Problem: Calculate the sum of cubes
// Series: 1³ + 2³ + 3³ + ... + n³
// ==================================================

// Time Complexity: O(n)
// Space Complexity: O(1)

let n = 10
var sum = 0

for i in 1...n {
    sum += i * i * i
}

print("Sum of cubes from 1 to \(n) = \(sum)")
