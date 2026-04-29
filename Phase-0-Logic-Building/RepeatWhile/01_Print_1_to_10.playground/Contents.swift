import UIKit
// ==================================================
// Problem: Print numbers from 1 to 10
// Using: repeat-while (do-while)
// ==================================================

// Time Complexity: O(n)
// Space Complexity: O(1)

var n = 1

repeat {
    print(n, terminator: " ")
    n += 1
} while n <= 10

