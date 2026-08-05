import Foundation

/*
 234_Set_Matrix_Zeroes — LeetCode 73 (Medium)

 PROBLEM
 Given an m x n matrix, if an element is 0, set its entire row and column
 to 0. You must do it IN PLACE.

 EXAMPLE
 Input:  [[1, 1, 1],      Output: [[1, 0, 1],
          [1, 0, 1],               [0, 0, 0],
          [1, 1, 1]]               [1, 0, 1]]

 CONSTRAINTS
 m == matrix.count, n == matrix[0].count
 1 <= m, n <= 200
 -2^31 <= matrix[i][j] <= 2^31 - 1

 APPROACHES
 1. Sentinel marking  — Time O((m*n)*(m+n)), Space O(1)
 2. Two flag arrays   — Time O(m*n),         Space O(m + n)
 3. First row/column  — Time O(m*n),         Space O(1)   <- follow-up answer

 KEY IDEA (3)
 matrix[0][col] flags "column col has a zero".
 matrix[row][0] flags "row row has a zero".
 matrix[0][0] is shared by both, so it keeps ONE meaning (row 0) and a
 separate Bool tracks column 0. Write order: interior, then row 0, then
 column 0 — clearing the flags earlier destroys the bookkeeping.
 */


// MARK: - Print helper

func printMatrix(_ label: String, _ matrix: [[Int]]) {

    print(label)

    for row in matrix {

        print(row)
    }

    print("")
}


// MARK: - 1. Sentinel marking
// Time: O((m*n)*(m+n))   Space: O(1)
// The sentinel stops a freshly written 0 being mistaken for an original
// zero and re-triggering — the cascade bug that wipes the whole grid.
// Int.min is safe ONLY because LC 73 bounds values to the 32-bit range.

func setZeroesBruteForce(_ matrix: inout [[Int]]) {

    guard !matrix.isEmpty else {

        print("Empty matrix — nothing to do\n")

        return
    }

    let rows = matrix.count

    let columns = matrix[0].count

    let mark = Int.min

    printMatrix("Input:", matrix)

    print("PASS 1 — find zeroes, mark row and column")

    for row in 0..<rows {

        for col in 0..<columns {

            if matrix[row][col] == 0 {

                print("  zero at (\(row),\(col))")

                // Bound is `columns`, NOT `col`. Using `col` marks only the
                // cells LEFT of the zero and leaves the right side intact.

                print("    row \(row):", terminator: " ")

                for c in 0..<columns {

                    // != 0 protects original zeroes — if one became `mark`,
                    // the outer scan would skip it and never sweep its line.

                    if matrix[row][c] != 0 {

                        print("(\(row),\(c))", terminator: " ")

                        matrix[row][c] = mark
                    }
                }

                print("")

                print("    col \(col):", terminator: " ")

                for r in 0..<rows {

                    if matrix[r][col] != 0 {

                        print("(\(r),\(col))", terminator: " ")

                        matrix[r][col] = mark
                    }
                }

                print("")
            }
        }
    }

    print("  marked grid (sentinel shown as M):")

    for row in 0..<rows {

        print("   ", terminator: " ")

        for col in 0..<columns {

            if matrix[row][col] == mark {
                print("M", terminator: " ")
            } else {
                print(matrix[row][col], terminator: " ")
            }
        }
        print("")
    }

    print("")
    print("PASS 2 — convert sentinels to 0")

    for row in 0..<rows {

        for col in 0..<columns {

            if matrix[row][col] == mark {

                matrix[row][col] = 0
            }
        }
    }

    printMatrix("Final:", matrix)
    print("--------------------------------------------------\n")
}


// MARK: - 2. Two flag arrays
// Time: O(m*n)   Space: O(m + n)
// The middle step. Most interviewers accept this before the follow-up.

func setZeroesFlagArrays(_ matrix: inout [[Int]]) {

    guard !matrix.isEmpty else { return }

    let rows = matrix.count

    let columns = matrix[0].count

    var zeroRows = Array(repeating: false, count: rows)

    var zeroColumns = Array(repeating: false, count: columns)

    printMatrix("Input:", matrix)
    print("PASS 1 — record which rows and columns hold a zero")

    for row in 0..<rows {

        for col in 0..<columns {

            if matrix[row][col] == 0 {
                print("  zero at (\(row),\(col)) -> zeroRows[\(row)] = true, zeroColumns[\(col)] = true")

                zeroRows[row] = true

                zeroColumns[col] = true
            }
        }
    }

    print("  zeroRows    = \(zeroRows)")
    print("  zeroColumns = \(zeroColumns)\n")
    print("PASS 2 — write")

    for row in 0..<rows {

        for col in 0..<columns {

            if zeroRows[row] || zeroColumns[col] {

                matrix[row][col] = 0
            }
        }
    }

    printMatrix("Final:", matrix)
    print("--------------------------------------------------\n")
}


// MARK: - 3. Optimal — first row and column as flag storage
// Time: O(m*n)   Space: O(1)

func setZeroes(_ matrix: inout [[Int]]) {

    guard !matrix.isEmpty else { return }

    let rows = matrix.count

    let columns = matrix[0].count

    var firstColumnHasZero = false

    printMatrix("Input:", matrix)

    print("PASS 1 — scan and set flags")

    for row in 0..<rows {

        if matrix[row][0] == 0 {
            firstColumnHasZero = true

            print("  (\(row),0) is 0 -> firstColumnHasZero = true")
        }

        // Start at col 1 — column 0 is owned by the Bool above

        for col in 1..<columns {

            if matrix[row][col] == 0 {
                print("  (\(row),\(col)) is 0 -> matrix[\(row)][0] = 0, matrix[0][\(col)] = 0")

                matrix[row][0] = 0

                matrix[0][col] = 0
            }
        }
    }

    print("  row flags (col 0):", terminator: " ")

    for row in 0..<rows {
        print(matrix[row][0], terminator: " ")
    }

    print("")

    print("  col flags (row 0):", terminator: " ")

    for col in 0..<columns {
        print(matrix[0][col], terminator: " ")
    }

    print("\n")

    print("PASS 2 — write interior (rows 1..., cols 1...)")

    for row in 1..<rows {

        for col in 1..<columns {

            if matrix[row][0] == 0 || matrix[0][col] == 0 {

                if matrix[row][col] != 0 {
                    print("  (\(row),\(col)) zeroed — rowFlag=\(matrix[row][0]) colFlag=\(matrix[0][col])")
                }
                matrix[row][col] = 0
            }
        }
    }

    print("")

    print("PASS 3 — row 0 (matrix[0][0] = \(matrix[0][0]))")

    if matrix[0][0] == 0 {

        print("  row 0 had a zero -> clearing row 0")

        for col in 0..<columns {
            matrix[0][col] = 0
        }

    } else {
        print("  row 0 clean")
    }

    print("")

    // MUST be last — clearing column 0 earlier wipes the row flags
    // that pass 2 still needs to read.

    print("PASS 4 — column 0 (firstColumnHasZero = \(firstColumnHasZero))")

    if firstColumnHasZero {

        print("  clearing column 0")

        for row in 0..<rows {
            matrix[row][0] = 0
        }

    } else {
        print("  column 0 clean")
    }

    print("")
    printMatrix("Final:", matrix)
    print("--------------------------------------------------\n")
}


// MARK: - Shared test inputs

let case1 = [
    [1, 1, 1],
    [1, 0, 1],
    [1, 1, 1]
]

let case2 = [
    [1, 0, 3],
    [4, 5, 6]
]

let case3 = [
    [0, 1, 2, 0],
    [3, 4, 5, 2],
    [1, 3, 1, 5]
]

let case4 = [
    [1, 2, 3],
    [0, 5, 6],
    [7, 8, 9]
]

let case5 = [
    [0, 2],
    [3, 4]
]

let case6 = [
    [1, 2],
    [3, 4]
]


// MARK: - Brute force runs

print("########## APPROACH 1 — SENTINEL MARKING ##########\n")

print("=== CASE 1: interior zero ===")

var b1 = case1
setZeroesBruteForce(&b1)
// [1,0,1] / [0,0,0] / [1,0,1]


print("=== CASE 2: zero NOT in the last column ===")
print("(the case a `0..<col` row bound fails — watch the `row 0:` line)")

var b2 = case2
setZeroesBruteForce(&b2)
// correct: [0,0,0] / [4,0,6]
// with 0..<col: [0,0,3] / [4,0,6] — the 3 survives


print("=== CASE 3: two zeroes, overlapping sweeps ===")

var b3 = case3
setZeroesBruteForce(&b3)
// [0,0,0,0] / [0,4,5,0] / [0,3,1,0]


// MARK: - Flag array runs

print("########## APPROACH 2 — TWO FLAG ARRAYS ##########\n")

print("=== CASE 2 ===")

var f2 = case2
setZeroesFlagArrays(&f2)


print("=== CASE 3 ===")

var f3 = case3
setZeroesFlagArrays(&f3)


// MARK: - Optimal runs
print("########## APPROACH 3 — FIRST ROW / COLUMN ##########\n")
print("=== CASE 1: interior zero ===")

var o1 = case1
setZeroes(&o1)

print("=== CASE 3: zeroes in row 0 and last column ===")

var o3 = case3
setZeroes(&o3)

print("=== CASE 4: zero in column 0 — watch firstColumnHasZero ===")

var o4 = case4
setZeroes(&o4)
// [0,2,3] / [0,0,0] / [0,8,9]


print("=== CASE 5: zero at [0][0] — the shared cell ===")

var o5 = case5
setZeroes(&o5)
// [0,0] / [0,4]

print("=== CASE 6: no zeroes — every pass no-ops ===")

var o6 = case6
setZeroes(&o6)
// unchanged
