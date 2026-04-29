import UIKit

// ==================================================
// Problem: Find sum of odd numbers from 1 to n
// Example: n = 100
// ==================================================

// Time Complexity: O(n)
// Space Complexity: O(1)

let n = 100
var sum = 0

for i in 1...n {
    if i % 2 != 0 {
        sum += i
    }
}

print("Sum of Odd Numbers ---> \(sum)")
