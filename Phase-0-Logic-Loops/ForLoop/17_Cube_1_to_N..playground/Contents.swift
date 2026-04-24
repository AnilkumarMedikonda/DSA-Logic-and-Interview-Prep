import UIKit

// ==================================================
// Problem: Print cube of numbers from 1 to n
// Example: n = 10
// Output: 1 8 27 64 125 216 343 512 729 1000
// ==================================================

// Time Complexity: O(n)
// Space Complexity: O(1)

let n = 10

for i in 1...n {
    print(i * i * i, terminator: " ")
}
