import Foundation

/*
 232_Rotate_Image — LeetCode 48 (Medium)

 PROBLEM
 You are given an n x n 2D matrix representing an image. Rotate the image
 90 degrees clockwise, IN PLACE. You must not allocate another 2D matrix.

 EXAMPLE
 Input:  [[1, 2, 3],      Output: [[7, 4, 1],
          [4, 5, 6],               [8, 5, 2],
          [7, 8, 9]]               [9, 6, 3]]

 CONSTRAINTS
 n == matrix.count == matrix[i].count
 1 <= n <= 20
 -1000 <= matrix[i][j] <= 1000

 APPROACH
 Brute force: place each element at result[col][n - 1 - row] in a fresh grid.
 Correct, but O(n^2) space — violates the in-place constraint.

 Optimal: transpose across the main diagonal, then reverse each row.
 Order matters — reversing the ROW ORDER instead gives counter-clockwise.

 COMPLEXITY
 Brute force — Time: O(n^2), Space: O(n^2)
 Optimal     — Time: O(n^2) (each cell touched twice, once per pass)
               Space: O(1) extra

 NOTE
 Print statements are for the dry-run trace only. Strip them from the
 committed solution.
 */


// MARK: - Print helper

func printMatrix(_ label: String, _ matrix: [[Int]]) {

    print(label)

    for row in matrix {

        print(row)
    }

    print("")
}


// MARK: - Brute force — O(n^2) time, O(n^2) space

func rotateBruteForce(_ matrix: [[Int]]) -> [[Int]] {

    let n = matrix.count

    var result = Array(repeating: Array(repeating: 0, count: n), count: n)

    for row in 0..<n {

        for col in 0..<n {

            result[col][n - 1 - row] = matrix[row][col]

            print("  (\(row),\(col)) value \(matrix[row][col]) -> (\(col),\(n - 1 - row))")
        }
    }

    return result
}


// MARK: - Optimal — O(n^2) time, O(1) space
// Step 1: transpose      Step 2: reverse each row

func rotate(_ matrix: inout [[Int]]) {

    let n = matrix.count

    // Step 1 — transpose.
    // Inner loop starts at row + 1; starting at 0 swaps every pair twice.

    print("Step 1 — transpose:")

    for row in 0..<n {

        for col in row + 1..<n {

            print("  swap (\(row),\(col))=\(matrix[row][col]) with (\(col),\(row))=\(matrix[col][row])")

            let temp = matrix[row][col]

            matrix[row][col] = matrix[col][row]

            matrix[col][row] = temp
        }
    }

    printMatrix("After transpose:", matrix)


    // Step 2 — reverse each row with two pointers.

    print("Step 2 — reverse each row:")

    for row in 0..<n {

        var left = 0

        var right = n - 1

        while left < right {

            print("  row \(row): swap col \(left)=\(matrix[row][left]) with col \(right)=\(matrix[row][right])")

            let temp = matrix[row][left]

            matrix[row][left] = matrix[row][right]

            matrix[row][right] = temp

            left += 1

            right -= 1
        }
    }

    printMatrix("After reversing rows:", matrix)
}


// MARK: - Counter-clockwise (interview follow-up)
// Same transpose, then reverse the ROW ORDER instead of each row.
// Time: O(n^2), Space: O(1)

func rotateCounterClockwise(_ matrix: inout [[Int]]) {

    let n = matrix.count

    for row in 0..<n {

        for col in row + 1..<n {

            let temp = matrix[row][col]

            matrix[row][col] = matrix[col][row]

            matrix[col][row] = temp
        }
    }

    var top = 0

    var bottom = n - 1

    while top < bottom {

        let temp = matrix[top]

        matrix[top] = matrix[bottom]

        matrix[bottom] = temp

        top += 1

        bottom -= 1
    }
}


// MARK: - Test 1: 3x3 (odd — centre cell never moves)

let odd = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
]

print("=== BRUTE FORCE (3x3) ===")

printMatrix("Input:", odd)

let bruteResult = rotateBruteForce(odd)

printMatrix("\nResult:", bruteResult)
// [7,4,1] / [8,5,2] / [9,6,3]

print("=== OPTIMAL (3x3) ===")

var oddMatrix = odd

printMatrix("Input:", oddMatrix)

rotate(&oddMatrix)

// MARK: - Test 2: 4x4 (even — no centre cell to mask inner-bound errors)

print("=== OPTIMAL (4x4) ===")

var evenMatrix = [
    [ 1,  2,  3,  4],
    [ 5,  6,  7,  8],
    [ 9, 10, 11, 12],
    [13, 14, 15, 16]
]

printMatrix("Input:", evenMatrix)

rotate(&evenMatrix)
// expected: [13,9,5,1] / [14,10,6,2] / [15,11,7,3] / [16,12,8,4]

// MARK: - Test 3: 1x1 edge case

print("=== OPTIMAL (1x1) ===")

var single = [[7]]

rotate(&single)

printMatrix("Result:", single)   // [[7]] — both loops no-op


// MARK: - Test 4: counter-clockwise

print("=== COUNTER-CLOCKWISE (3x3) ===")

var ccw = odd
rotateCounterClockwise(&ccw)
printMatrix("Result:", ccw)
// [3,6,9] / [2,5,8] / [1,4,7]
