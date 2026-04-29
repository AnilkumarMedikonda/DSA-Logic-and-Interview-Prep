
import UIKit

// ==================================================
// Problem: Print numbers from 1 to 100 divisible by 7
// Output: 7 14 21 28 ... 98
// ==================================================

// Time Complexity: O(n)
// Space Complexity: O(1)

for i in 1...100 {
    if i % 7 == 0 {
        print(i, terminator: " ")
    }
}
