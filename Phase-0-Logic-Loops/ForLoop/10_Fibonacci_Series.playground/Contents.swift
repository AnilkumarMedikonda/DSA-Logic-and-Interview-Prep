

import UIKit

// ==================================================
// Problem: Print Fibonacci series up to n terms
// Example: n = 10
// Output: 0 1 1 2 3 5 8 13 21 34
// ==================================================

// Time Complexity: O(n)
// Space Complexity: O(1)

let n = 10

var a = 0
var b = 1

for _ in 1...n {
    print(a, terminator: " ")
    
    let next = a + b
    a = b
    b = next
}
