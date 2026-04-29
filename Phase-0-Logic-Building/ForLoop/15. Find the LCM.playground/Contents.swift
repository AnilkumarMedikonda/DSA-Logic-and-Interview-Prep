import UIKit

// ==================================================
// Problem: Find LCM using for loop
// Example: 12, 18 → LCM = 36
// ==================================================

// Time Complexity: O(n)
// Space Complexity: O(1)

let a = 12
let b = 18

var lcm = 0

// Start from max(a, b)
for i in max(a, b)...(a * b) {
    
    if i % a == 0 && i % b == 0 {
        lcm = i
        break
    }
}

print("LCM ---> \(lcm)")
