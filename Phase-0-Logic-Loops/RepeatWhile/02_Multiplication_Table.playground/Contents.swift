import UIKit

// ==================================================
// Problem: Multiplication Table (repeat-while)
// Example: n = 10
// ==================================================

// Time Complexity: O(10)
// Space Complexity: O(1)

var number = 10
var i = 1

repeat {
    print("\(number) * \(i) = \(number * i)")
    i += 1
} while i <= 10
