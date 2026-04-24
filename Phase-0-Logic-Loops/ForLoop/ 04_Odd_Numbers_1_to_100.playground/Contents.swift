import UIKit

// ==================================================
// Problem: Print all odd numbers from 1 to 100
// Using: for loop
// ==================================================

// Time Complexity: O(n)
// Space Complexity: O(1)

for i in 1...100 {
    if i % 2 != 0 {
        print(i, terminator: " ")
    }
}
