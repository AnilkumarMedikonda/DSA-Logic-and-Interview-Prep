import Foundation

// MARK: - Print helper

func printMatrix(_ matrix: [[Int]]) {
    for row in matrix {
        print(row)
    }
    print("")
}

// MARK: - 1. Transpose in place (SQUARE only — a 3x4 transposes to 4x3
// and the storage doesn't fit)

func transpose(_ matrix: inout [[Int]]) {
    let n = matrix.count

    for i in 0..<n {
        // Inner loop starts at i+1. Starting at 0 swaps every pair TWICE
        // and puts the matrix straight back where it started.
        var j = i + 1
        while j < n {
            let temp = matrix[i][j]
            matrix[i][j] = matrix[j][i]
            matrix[j][i] = temp
            j += 1
        }
    }
}

var square = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
]

print("Before transpose:")
printMatrix(square)

transpose(&square)

print("After transpose:")
printMatrix(square)
// [1,4,7] / [2,5,8] / [3,6,9] — rows became columns

// MARK: - 2. Reverse one row in place (two pointers)

func reverse(_ row: inout [Int]) {
    var left = 0
    var right = row.count - 1

    while left < right {
        let temp = row[left]
        row[left] = row[right]
        row[right] = temp
        left += 1
        right -= 1
    }
}

var singleRow = [1, 2, 3, 4, 5]
reverse(&singleRow)
print("Reversed row: \(singleRow)")   // [5, 4, 3, 2, 1]

// MARK: - 3. Reverse every row of a matrix in place

func reverseRows(_ matrix: inout [[Int]]) {
    for i in 0..<matrix.count {
        var left = 0
        var right = matrix[i].count - 1

        while left < right {
            let temp = matrix[i][left]
            matrix[i][left] = matrix[i][right]
            matrix[i][right] = temp
            left += 1
            right -= 1
        }
    }
}

var grid = [
    [1,  2,  3,  4],
    [5,  6,  7,  8],
    [9, 10, 11, 12]
]

print("Before reversing rows:")
printMatrix(grid)

reverseRows(&grid)

print("After reversing rows:")
printMatrix(grid)

// MARK: - 4. Reverse the row ORDER in place (top row <-> bottom row)
// Swaps whole rows, not elements — different operation from #3.

func reverseRowOrder(_ matrix: inout [[Int]]) {
    var top = 0
    var bottom = matrix.count - 1

    while top < bottom {
        let temp = matrix[top]
        matrix[top] = matrix[bottom]
        matrix[bottom] = temp
        top += 1
        bottom -= 1
    }
}

var ordered = [
    [1, 2],
    [3, 4],
    [5, 6]
]

reverseRowOrder(&ordered)
print("Reversed row order:")
printMatrix(ordered)
// [5,6] / [3,4] / [1,2]

// MARK: - 5. Swap two arbitrary cells without a second matrix

func swapCells(_ matrix: inout [[Int]], _ r1: Int, _ c1: Int, _ r2: Int, _ c2: Int) {
    let temp = matrix[r1][c1]
    matrix[r1][c1] = matrix[r2][c2]
    matrix[r2][c2] = temp
}

var cells = [
    [1, 2],
    [3, 4]
]

swapCells(&cells, 0, 0, 1, 1)
print("After swapping (0,0) and (1,1):")
printMatrix(cells)
