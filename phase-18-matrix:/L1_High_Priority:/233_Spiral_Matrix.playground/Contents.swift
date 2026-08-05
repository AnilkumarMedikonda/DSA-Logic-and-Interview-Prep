import Foundation

/*
 233_Spiral_Matrix — LeetCode 54 (Medium) — DEBUG BUILD

 PROBLEM
 Given an m x n matrix, return all of its elements in spiral order:
 right along the top row, down the right column, left along the bottom
 row, up the left column, then move one layer inward and repeat.

 EXAMPLE
 Input:  [[1, 2, 3],
          [4, 5, 6],
          [7, 8, 9]]
 Output: [1, 2, 3, 6, 9, 8, 7, 4, 5]

 CONSTRAINTS
 m == matrix.count, n == matrix[0].count
 1 <= m, n <= 10
 -100 <= matrix[i][j] <= 100
 The grid is NOT necessarily square.

 COMPLEXITY
 Time:  O(m * n) — every cell appended exactly once.
 Space: O(1) extra, ignoring the output array.

 NOTE
 This file exists to trace the boundary movement. The print statements
 are not part of the solution — commit the clean version separately.
 */


func spiralOrderDebug(_ matrix: [[Int]]) -> [Int] {

    guard !matrix.isEmpty else {

        print("Empty matrix -> []")

        return []
    }

    let rows = matrix.count

    let cols = matrix[0].count

    var top = 0

    var bottom = rows - 1

    var left = 0

    var right = cols - 1

    var result: [Int] = []

    var layer = 0

    print("Grid \(rows)x\(cols) | start: top=\(top) bottom=\(bottom) left=\(left) right=\(right)\n")

    while top <= bottom && left <= right {

        print("--- Layer \(layer) | top=\(top) bottom=\(bottom) left=\(left) right=\(right) ---")

        // Pass 1 — Left to Right along the top row

        print("  Pass 1 (top row \(top), cols \(left)...\(right)):", terminator: " ")

        for col in left...right {

            print(matrix[top][col], terminator: " ")

            result.append(matrix[top][col])
        }

        print("")

        top += 1

        print("  top -> \(top)")

        // Pass 2 — Top to Bottom down the right column

        if top <= bottom {

            print("  Pass 2 (right col \(right), rows \(top)...\(bottom)):", terminator: " ")

            for row in top...bottom {

                print(matrix[row][right], terminator: " ")

                result.append(matrix[row][right])
            }

            print("")

        } else {

            print("  Pass 2 SKIPPED — top(\(top)) > bottom(\(bottom)), rows exhausted")
        }

        right -= 1

        print("  right -> \(right)")


        // Pass 3 — Right to Left along the bottom row.
        // top <= bottom stops a single remaining row being walked twice.

        if left <= right && top <= bottom {

            print("  Pass 3 (bottom row \(bottom), cols \(right) down to \(left)):", terminator: " ")

            var col = right

            while col >= left {

                print(matrix[bottom][col], terminator: " ")

                result.append(matrix[bottom][col])

                col -= 1
            }

            print("")

        } else {

            print("  Pass 3 SKIPPED — left=\(left) right=\(right) top=\(top) bottom=\(bottom)")
        }

        bottom -= 1

        print("  bottom -> \(bottom)")


        // Pass 4 — Bottom to Top up the left column.
        // left <= right stops a single remaining column being walked twice.

        if top <= bottom && left <= right {

            print("  Pass 4 (left col \(left), rows \(bottom) up to \(top)):", terminator: " ")

            var row = bottom

            while row >= top {

                print(matrix[row][left], terminator: " ")

                result.append(matrix[row][left])

                row -= 1
            }

            print("")

        } else {

            print("  Pass 4 SKIPPED — top=\(top) bottom=\(bottom) left=\(left) right=\(right)")
        }

        left += 1

        print("  left -> \(left)")

        print("  result so far: \(result)\n")

        layer += 1
    }

    print("Loop exit — top=\(top) bottom=\(bottom) left=\(left) right=\(right)")

    print("Final: \(result)\n")

    return result
}


// MARK: - Traces

print("===== 3x3 — two layers, second is the lone centre cell =====")

let square = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
]

let a = spiralOrderDebug(square)


print("===== 3x4 wide — non-square, catches rows/cols mix-ups =====")

let wide = [
    [1,  2,  3,  4],
    [5,  6,  7,  8],
    [9, 10, 11, 12]
]

let b = spiralOrderDebug(wide)


print("===== 1x4 — Passes 2, 3, 4 all SKIP =====")

let singleRow = [[1, 2, 3, 4]]

let c = spiralOrderDebug(singleRow)

print("===== 3x1 — Passes 3 and 4 SKIP on right = -1 =====")

let singleColumn = [[1], [2], [3]]

let d = spiralOrderDebug(singleColumn)
