import Foundation

// MARK: - Grid (3x4 on purpose — a square grid hides row/column swaps)

let matrix = [
    [1,  2,  3,  4],
    [5,  6,  7,  8],
    [9, 10, 11, 12]
]

let rows = matrix.count

let columns: Int
if rows > 0 {
    columns = matrix[0].count
} else {
    columns = 0
}

// MARK: - 1. Row-wise

print("Row-wise:")
for row in 0..<rows {
    for col in 0..<columns {
        print(matrix[row][col], terminator: " ")
    }
    print("")
}

// MARK: - 2. Column-wise

print("\nColumn-wise:")
for col in 0..<columns {
    for row in 0..<rows {
        print(matrix[row][col], terminator: " ")
    }
    print("")
}
// Loop order flipped, subscript order did NOT — still matrix[row][col].

// MARK: - Square grid for diagonals (diagonals need rows == columns)

let square = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
]

let n = square.count

// MARK: - 3. Main diagonal (i == j)

print("\nMain diagonal:")
for i in 0..<n {
    print(square[i][i], terminator: " ")
}
print("")

// MARK: - 4. Anti-diagonal (i + j == n - 1)

print("\nAnti-diagonal:")
for i in 0..<n {
    print(square[i][n - 1 - i], terminator: " ")
}
print("")

// MARK: - 5. Boundary only (one continuous walk, clockwise)

print("\nBoundary:")
if rows > 0 && columns > 0 {
    // Top row, left to right
    for col in 0..<columns {
        print(matrix[0][col], terminator: " ")
    }

    // Right column, top+1 down to bottom
    for row in 1..<rows {
        print(matrix[row][columns - 1], terminator: " ")
    }

    // Bottom row, right-1 back to left
    var bottomCol = columns - 2
    while bottomCol >= 0 {
        print(matrix[rows - 1][bottomCol], terminator: " ")
        bottomCol -= 1
    }

    // Left column, bottom-1 up to top+1
    var leftRow = rows - 2
    while leftRow >= 1 {
        print(matrix[leftRow][0], terminator: " ")
        leftRow -= 1
    }

    print("")
}
// EDGE: on a 1-row grid ([[1,2,3,4]]) the top-row pass already covered
// everything, then the right-column pass walks it again — 4 prints twice.
// Spiral Matrix fixes this with a `top <= bottom && left <= right` guard
// before each pass. Worth running once to see it fail.

// MARK: - 6. Reverse row-wise

print("\nReverse row-wise:")
var reverseRow = rows - 1
while reverseRow >= 0 {
    var reverseCol = columns - 1
    while reverseCol >= 0 {
        print(matrix[reverseRow][reverseCol], terminator: " ")
        reverseCol -= 1
    }
    print("")
    reverseRow -= 1
}
