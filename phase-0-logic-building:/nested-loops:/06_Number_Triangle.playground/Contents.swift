import UIKit

// ==================================================
// Problem: Generate and print a number triangle
// Example: n = 5
// Output:
// 1
// 1 2
// 1 2 3
// 1 2 3 4
// 1 2 3 4 5
// ==================================================

// Time Complexity: O(n²)
// Space Complexity: O(1)

let n = 5

for i in 1...n {              // Outer loop → rows
    
    for j in 1...i {          // Inner loop → numbers per row
        print(j, terminator: " ")
    }
    
    print()                   // Move to next line
}
