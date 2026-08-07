import Foundation

// MARK: - Create (3x4, non-square on purpose)

let matrix = [
    [1,  2,  3,  4],
    [5,  6,  7,  8],
    [9, 10, 11, 12]
]

// MARK: - Dimensions (safe on empty)

let rows = matrix.count

let columns: Int
if let firstRow = matrix.first {
    columns = firstRow.count
} else {
    columns = 0
}

print("Rows: \(rows), Columns: \(columns)")

// MARK: - Access

print("Top-left: \(matrix[0][0])")
print("Row 0, Col 2: \(matrix[0][2])")   // 3 — moves along the row
print("Row 2, Col 0: \(matrix[2][0])")   // 9 — moves down the column

// MARK: - Build a zero grid at runtime

let rowCount = 3
let columnCount = 4
let zeroGrid = Array(repeating: Array(repeating: 0, count: columnCount), count: rowCount)
print("Zero grid: \(zeroGrid)")

// MARK: - Mutate

var updateMatrix = [[1, 2], [3, 4]]
print("Before: \(updateMatrix)")
updateMatrix[0][1] = 10
print("After:  \(updateMatrix)")

// MARK: - Print helper

func printMatrix(_ matrix: [[Int]]) {
    for row in matrix {
        print(row)
    }
}

printMatrix(matrix)

// MARK: - Bounds check

func isValid(_ row: Int, _ col: Int, _ matrix: [[Int]]) -> Bool {
    if matrix.isEmpty {
        return false
    }
    return row >= 0 && row < matrix.count && col >= 0 && col < matrix[row].count
}

print(isValid(2, 3, matrix))   // true
print(isValid(3, 0, matrix))   // false — row out of range
print(isValid(0, 4, matrix))   // false — col out of range

// MARK: - Value semantics

var original = [[1, 2], [3, 4]]
var copy = original
copy[0][0] = 99
print("Original: \(original)")  // [[1, 2], [3, 4]] — untouched
print("Copy:     \(copy)")      // [[99, 2], [3, 4]]

// MARK: - Square check

let square = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
]

if let firstRow = square.first, square.count == firstRow.count {
    print("Square matrix")
} else {
    print("Not a square matrix")
}
