import UIKit

// ==================================================
// Problem: Print numbers from 1 to 100
// Skip numbers divisible by 5 using continue
// ==================================================

// Time Complexity: O(n)
// Space Complexity: O(1)

for i in 1...100 {
    
    if i % 5 == 0 {
        continue   // Skip this number
    }
    print(i, terminator: " ")
}
