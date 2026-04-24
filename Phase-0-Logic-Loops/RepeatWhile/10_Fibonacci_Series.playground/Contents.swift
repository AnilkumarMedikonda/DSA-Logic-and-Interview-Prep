import UIKit

// ==================================================
// Problem: Print Fibonacci Series
// Example: 0 1 1 2 3 5 8 13 ...
// Using: repeat-while (do-while)
// ==================================================

// Time Complexity: O(n)
// Space Complexity: O(1)

var terms = 10          // number of terms to print
var count = 1

var a = 0               // first number
var b = 1               // second number

repeat {
    print(a, terminator: " ")
    
    let next = a + b    // calculate next number
    a = b               // shift forward
    b = next
    
    count += 1
    
} while count <= terms
