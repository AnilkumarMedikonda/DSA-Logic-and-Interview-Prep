import UIKit
// ==================================================
// Problem: Print only even numbers from 1 to n
// Skip all odd numbers using continue
// ==================================================

// Time Complexity: O(n)
// Space Complexity: O(1)

let n = 100

for number in 1...n {
    
    if number % 2 != 0 {
        continue   // Skip odd numbers
    }
    print(number, terminator: " ")
}
