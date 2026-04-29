import UIKit

// ==================================================
// Problem: Keep adding numbers
// Stop when sum becomes greater than 100
// ==================================================

// Time Complexity: O(n)
// Space Complexity: O(1)

var sum = 0

for i in 1...100 {
    
    // Check BEFORE adding
    if sum + i > 100 {
        break   // Stop before exceeding 100
    }
    sum += i
}

print("Final Sum ---> \(sum)")
