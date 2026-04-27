import UIKit

// ==================================================
// Problem: Take 5 numbers, skip 0 using continue,
// and calculate sum of remaining numbers
// ==================================================

// Time Complexity: O(n)
// Space Complexity: O(1)

// Input (simulated in Playground)
let numbers = [10, 0, 5, 0, 3]

var sum = 0

for num in numbers {
    
    if num == 0 {
        continue   // Skip zero
    }
    
    sum += num
}

print("Sum ---> \(sum)")
