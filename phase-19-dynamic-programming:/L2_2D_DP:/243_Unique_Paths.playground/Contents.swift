import Foundation

//  243_Unique_Paths.swift
//  LeetCode 62
//
//  PROBLEM
//  A robot starts at the TOP-LEFT of an m x n grid and can move
//  only RIGHT or DOWN. How many unique paths reach the BOTTOM-RIGHT?
//
//  EXAMPLE
//  m = 3, n = 3  ->  6
//  m = 3, n = 2  ->  3       (RDD, DRD, DDR)
//  m = 3, n = 7  ->  28
//
//  CONSTRAINTS
//  1 <= m, n <= 100
//
//  THE SIX LINES
//  1. STATE       dp[i][j] = number of ways to reach cell (i, j)
//  2. OPTIONS     arrive from ABOVE (i-1, j) or from LEFT (i, j-1)
//  3. COMBINER    +   (counting problem)
//  4. TRANSITION  dp[i][j] = dp[i-1][j] + dp[i][j-1]
//  5. BASE        whole first ROW = 1, whole first COLUMN = 1
//                 (only one path along an edge — keep going straight)
//  6. ANSWER      dp[m-1][n-1]
//
//  FIRST 2D PROBLEM. In 1D you seeded one or two cells. Here you
//  seed an entire row AND an entire column.
//
//  RANGE NOTE: both loops use half-open `1..<m`. When m == 1 that
//  is an EMPTY range and Swift handles it fine — no guard needed.
//  A closed range `1...m` would have trapped, which is the crash
//  hit in Coin Change and Decode Ways. Same trap, different operator.

//====================================================
// MARK: - Solution 1 : 2D Grid
// Time  : O(m * n)
// Space : O(m * n)
//====================================================

func uniquePaths(_ m: Int, _ n: Int) -> Int {

    // outer count = ROWS (m), inner count = COLUMNS (n)
    var dp = Array(repeating: Array(repeating: 0, count: n), count: m)

    // first row: only one way — keep going right
    for j in 0..<n {
        dp[0][j] = 1
    }

    // first column: only one way — keep going down
    for i in 0..<m {
        dp[i][0] = 1
    }

    for i in 1..<m {
        for j in 1..<n {
            dp[i][j] = dp[i-1][j] + dp[i][j-1]
        }
    }
    return dp[m-1][n-1]
}

print("[1] 2D Grid    :", uniquePaths(3, 3))

print("")

//====================================================
// MARK: - Solution 2 : Rolling Row   <-- INTERVIEW ANSWER
// Time  : O(m * n)
// Space : O(n)   one row instead of the whole grid
//====================================================
//
// One array holds two rows' worth of information, because of WHEN
// each slot is overwritten:
//   dp[j]    not yet touched this row  ->  the cell ABOVE
//   dp[j-1]  already updated this row  ->  the cell LEFT
//
// LEFT-TO-RIGHT IS MANDATORY. Looping backwards would make dp[j-1]
// hold the OLD row's value, giving above + above-left. Wrong.
// (Partition Equal Subset Sum needed backwards for the mirror
//  reason. Direction controls read-before or read-after overwrite.)

func uniquePathsOptimized(_ m: Int, _ n: Int) -> Int {

    // starts as the first row: all 1
    var dp = Array(repeating: 1, count: n)

    for _ in 1..<m {
        for j in 1..<n {
            dp[j] = dp[j] + dp[j-1]
        }
    }
    return dp[n-1]
}

print("[2] Rolling Row:", uniquePathsOptimized(3, 3))

print("")

//====================================================
// MARK: - Traced 2D grid
//====================================================

func uniquePathsTrace(_ m: Int, _ n: Int) -> Int {

    var dp = Array(repeating: Array(repeating: 0, count: n), count: m)

    for j in 0..<n {
        dp[0][j] = 1
    }

    for i in 0..<m {
        dp[i][0] = 1
    }

    print("grid \(m) x \(n)")

    print("after seeding first row and first column:")

    for row in dp {
        print("   \(row)")
    }

    for i in 1..<m {
        for j in 1..<n {
            dp[i][j] = dp[i-1][j] + dp[i][j-1]

            print("\ndp[\(i)][\(j)] = above dp[\(i-1)][\(j)] (\(dp[i-1][j])) + left dp[\(i)][\(j-1)] (\(dp[i][j-1])) = \(dp[i][j])")
        }
    }

    print("\nfinal grid:")

    for row in dp {
        print("   \(row)")
    }

    return dp[m-1][n-1]
}

print("=========================================")

print("  TRACE   2D grid  3 x 3")

print("=========================================")

print("result :", uniquePathsTrace(3, 3))

print("")

//====================================================
// MARK: - Traced rolling row
//====================================================

func uniquePathsOptimizedTrace(_ m: Int, _ n: Int) -> Int {

    var dp = Array(repeating: 1, count: n)

    print("start (row 0) dp = \(dp)")

    for i in 1..<m {
        print("\n--- processing row \(i) ---")

        for j in 1..<n {
            let above = dp[j]
            let left = dp[j-1]

            dp[j] = above + left

            print("   j=\(j)   above (old dp[\(j)]) = \(above)   left (new dp[\(j-1)]) = \(left)   ->  dp[\(j)] = \(dp[j])")
        }
        print("   dp = \(dp)")
    }

    print("\nanswer = dp[\(n-1)] = \(dp[n-1])")

    return dp[n-1]
}

print("=========================================")

print("  TRACE   rolling row  3 x 3")

print("=========================================")

print("result :", uniquePathsOptimizedTrace(3, 3))

print("")

//====================================================
// MARK: - Verify
//====================================================

let cases: [(Int, Int, Int)] = [
    (3, 3,   6),
    (3, 2,   3),
    (3, 7,  28),
    (1, 1,   1),
    (1, 10,  1),
    (10, 1,  1),
    (7, 3,  28)
]

print("=========================================")

print("  VERIFY")

print("=========================================")

for (m, n, expected) in cases {

    let a = uniquePaths(m, n)
    let b = uniquePathsOptimized(m, n)
    let ok = (a == expected && b == expected)

    print("m=\(m) n=\(n)  ->  2D \(a)  roll \(b)   expected \(expected)   \(ok ? "OK" : "FAIL")")
}

//====================================================
// MARK: - Interview sequence
//====================================================
//
//  1. Draw the grid. Say "first row and first column are all 1 —
//     only one path along an edge."
//  2. Say "every other cell is above + left."
//  3. Write Solution 1.
//  4. Say "each row only needs the row above, so I can collapse
//     this to one array of size n." Write Solution 2.
//  5. FOLLOW-UP worth mentioning: this also has a pure math answer.
//     Any path is exactly m-1 downs and n-1 rights in some order,
//     so the count is C(m+n-2, m-1) — O(min(m,n)) time, O(1) space.
//     Do NOT lead with it; they want the DP.
//
//  Showing the collapse in step 4 scores more than starting there.

//====================================================
// MARK: - Traps logged
//====================================================
//
//  1. 2D array sizing: outer count = m (rows), inner count = n
//     (columns). Getting this backwards crashed in problem 240.
//  2. Rolling row MUST go left-to-right. Backwards gives
//     above + above-left instead of above + left.
//  3. Both loops start at 1 — row 0 and column 0 are already seeded.
//  4. Half-open `1..<m` is empty (safe) when m == 1. Closed `1...m`
//     would trap. Prefer half-open for DP loops.
