
import UIKit

// ==================================================
// Problem: Print Fibonacci series and find its sum
// Example: n = 10
// ==================================================

// Time Complexity: O(n)
// Space Complexity: O(1)

let n = 10

var a = 0
var b = 1
var sum = 0

for _ in 1...n {
    
    print(a, terminator: " ")
    
    sum += a   // accumulate before update
    
    let next = a + b
    a = b
    b = next
}

print("\nSum ---> \(sum)")
