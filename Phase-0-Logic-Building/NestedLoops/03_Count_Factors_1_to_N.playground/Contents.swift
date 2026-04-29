import UIKit

// ==================================================
// Problem: Count number of factors for each number
// from 1 to n
// Example: n = 10
// ==================================================

// Time Complexity: O(n²)
// Space Complexity: O(1)

let n = 10

for i in 1...n {
    
    var count = 0
    
    for j in 1...i {
        if i % j == 0 {
            count += 1
        }
    }
    
    print("Number: \(i) → Factors Count: \(count)")
}
