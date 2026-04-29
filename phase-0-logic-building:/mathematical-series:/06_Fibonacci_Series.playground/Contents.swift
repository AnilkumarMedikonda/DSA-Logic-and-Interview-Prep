import UIKit

// ==================================================
// Problem: Print Fibonacci Series (first n terms)
// ==================================================

// Time Complexity: O(n)
// Space Complexity: O(1)

let n = 10

var a = 0
var b = 1

print("Fibonacci Series:")

for _ in 1...n {
    
    print(a, terminator: " ")
    
    let next = a + b
    a = b
    b = next
}
