import UIKit

var greeting = "Hello, playground"

import UIKit

// ==================================================
// Problem: Print all factors of a number
// Example: number = 20
// Output: 1 2 4 5 10 20
// ==================================================

// Time Complexity: O(n)
// Space Complexity: O(1)

let number = 20

for i in 1...number {
    if number % i == 0 {
        print(i, terminator: " ")
    }
}
