import UIKit


// ==================================================
// Problem: Find the sum of first n even numbers
// ==================================================

// Time Complexity: O(n)
// Space Complexity: O(1)

let n = 20
var sum = 0

for i in 1...n {
    
    if i % 2 == 0 {
        sum += i
    }
}

print("Sum of even numbers from 1 to \(n) = \(sum)")
