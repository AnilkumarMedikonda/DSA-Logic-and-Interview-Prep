import UIKit

// ==================================================
// Problem: Print all possible pairs (i, j)
// where both i and j range from 1 to n
// Example: n = 3
// Output:
// (1,1) (1,2) (1,3)
// (2,1) (2,2) (2,3)
// (3,1) (3,2) (3,3)
// ==================================================

// Time Complexity: O(n²)
// Space Complexity: O(1)

let n = 3

for i in 1...n {              // Outer loop → rows (i)
    
    for j in 1...n {          // Inner loop → columns (j)
        print("(\(i),\(j))", terminator: " ")
    }
    
    print()   // Move to next row
}
