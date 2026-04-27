import UIKit
// ==================================================
// Problem: Find the sum of Fibonacci series (first n terms)
// ==================================================

// Time Complexity: O(n)
// Space Complexity: O(1)

let n = 10

var a = 0
var b = 1
var sum = 0

print("Fibonacci Series:")

for _ in 1...n {
    
    sum += a
    print(a, terminator: " ")
    
    let next = a + b
    a = b
    b = next
}

print("\nSum of first \(n) Fibonacci numbers = \(sum)")
