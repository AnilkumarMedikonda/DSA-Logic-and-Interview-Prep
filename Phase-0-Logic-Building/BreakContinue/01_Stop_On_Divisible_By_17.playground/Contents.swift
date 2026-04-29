import UIKit

// ==================================================
// Problem: Print numbers from 1 to 100
// Stop the loop when a number divisible by 17 appears
// ==================================================

// Time Complexity: O(n)
// Space Complexity: O(1)

for i in 1...100 {
    
    if i % 17 == 0 {
        break   // Stop loop immediately
    }
    
    print(i, terminator: " ")
}
