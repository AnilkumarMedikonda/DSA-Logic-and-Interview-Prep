import UIKit
// ==================================================
// Problem: Print numbers divisible by 7 up to n
// ==================================================

// Approach:
// Start from 7 and increment by 7

// Time Complexity: O(n/7)
// Space Complexity: O(1)

var n = 100
var i = 7

while i <= n {
    print(i, terminator: " ")
    i += 7
}
