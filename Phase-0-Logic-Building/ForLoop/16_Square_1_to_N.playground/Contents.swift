import UIKit

// ==================================================
// Problem: Print square of numbers from 1 to n
// Example: n = 10
// Output: 1 4 9 16 25 36 49 64 81 100
// ==================================================

// Time Complexity: O(n)
// Space Complexity: O(1)

let n = 10

for i in 1...n {
    print(i * i, terminator: " ")
}
