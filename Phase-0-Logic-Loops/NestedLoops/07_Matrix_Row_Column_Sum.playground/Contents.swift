


import UIKit

// ==================================================
// Problem: Print a matrix and find row & column sums
// ==================================================

// Time Complexity: O(n²)
// Space Complexity: O(1)

// Step 1: Define matrix
let matrix = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
]

// --------------------------------------------------
// Step 2: Print matrix
// --------------------------------------------------

print("Matrix:")

for i in 0..<matrix.count {
    
    for j in 0..<matrix[i].count {
        print(matrix[i][j], terminator: " ")
    }
    
    print()
}

// --------------------------------------------------
// Step 3: Row Sum
// --------------------------------------------------

print("\nRow Sums:")

for i in 0..<matrix.count {
    
    var rowSum = 0
    
    for j in 0..<matrix[i].count {
        rowSum += matrix[i][j]
    }
    
    print("Row \(i + 1) → \(rowSum)")
}

// --------------------------------------------------
// Step 4: Column Sum
// --------------------------------------------------

print("\nColumn Sums:")

for j in 0..<matrix[0].count {
    
    var colSum = 0
    
    for i in 0..<matrix.count {
        colSum += matrix[i][j]
    }
    print("Column \(j + 1) → \(colSum)")
}
