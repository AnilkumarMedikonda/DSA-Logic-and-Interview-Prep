import UIKit

// ==================================================
// Problem: Calculate Harmonic Series
// Series: 1 + 1/2 + 1/3 + ... + 1/n
// ==================================================

// Time Complexity: O(n)
// Space Complexity: O(1)

let n = 10
var sum = 0.0

print("Harmonic Series:")

for i in 1...5 {
    
    let value = 1.0 / Double(i)
    print(value, terminator: " ")
    
    sum += value
}

print("\nSum = \(sum)")
