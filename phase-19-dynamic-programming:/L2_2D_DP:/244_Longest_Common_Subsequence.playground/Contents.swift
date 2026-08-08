import Foundation

//  244_Longest_Common_Subsequence.swift
//  LeetCode 1143
//
//  PROBLEM
//  Given two strings, return the LENGTH of their longest common
//  subsequence. A subsequence keeps the original order but may
//  skip characters. Return 0 if there is none.
//
//  EXAMPLE
//  text1 = "abcde", text2 = "ace"  ->  3     ("ace")
//  text1 = "abc",   text2 = "abc"  ->  3
//  text1 = "abc",   text2 = "def"  ->  0
//
//  CONSTRAINTS
//  1 <= text1.count, text2.count <= 1000
//  lowercase English letters only
//
//  THE SIX LINES
//  1. STATE       dp[i][j] = LCS length of the first i chars of
//                 text1 and the first j chars of text2
//  2. OPTIONS     characters match    -> extend the diagonal
//                 characters differ   -> drop one char from either
//  3. COMBINER    max()   (and +1 on a match)
//  4. TRANSITION  match:  dp[i][j] = dp[i-1][j-1] + 1
//                 differ: dp[i][j] = max(dp[i-1][j], dp[i][j-1])
//  5. BASE        row 0 and column 0 are all 0 (empty string shares
//                 nothing) — the array initializer gives this free
//  6. ANSWER      dp[m][n]   (bottom-right, NOT dp[m-1][n-1])
//
//  GRID IS (m+1) x (n+1), not m x n. The extra row and column
//  stand for "empty string". This offset is where index bugs live:
//  dp[i][j] means "first i characters", so the i-th character sits
//  at array index i-1.
//
//  FIRST TRANSITION THAT BRANCHES ON A CONDITION. Every earlier
//  problem did the same arithmetic every time; this one picks a
//  different formula depending on whether the characters match.

let text1 = "abcde"
let text2 = "ace"

//====================================================
// MARK: - Solution 1 : 2D Grid
// Time  : O(m * n)
// Space : O(m * n)
//====================================================

func longestCommonSubsequence(_ text1: String, _ text2: String) -> Int {

    let chars1 = Array(text1)
    let chars2 = Array(text2)

    let m = chars1.count
    let n = chars2.count

    // guard before the closed ranges below
    if m == 0 || n == 0 {
        return 0
    }

    var dp = Array(repeating: Array(repeating: 0, count: n + 1), count: m + 1)

    for i in 1...m {
        for j in 1...n {

            if chars1[i-1] == chars2[j-1] {
                // match: extend the diagonal
                dp[i][j] = dp[i-1][j-1] + 1

            } else {
                // differ: best of dropping one char from either side
                dp[i][j] = max(dp[i-1][j], dp[i][j-1])
            }
        }
    }
    return dp[m][n]
}

print("[1] 2D Grid   :", longestCommonSubsequence(text1, text2))

print("")

//====================================================
// MARK: - Solution 2 : 1D + diagonal carry   <-- INTERVIEW ANSWER
// Time  : O(m * n)
// Space : O(n)
//====================================================
//
// Three cells are needed: ABOVE, LEFT, DIAGONAL.
// One array plus one variable covers all three:
//
//   dp[j]      not yet overwritten this row  ->  ABOVE
//   dp[j-1]    already overwritten this row  ->  LEFT
//   diagonal   dp[j] from one step ago       ->  DIAGONAL
//
// `top` captures dp[j] BEFORE it is overwritten, then becomes
// `diagonal` for the next j. Reset diagonal to 0 at each new row,
// because dp[i-1][0] is always 0.

func longestCommonSubsequenceOptimized(_ text1: String, _ text2: String) -> Int {

    let chars1 = Array(text1)
    let chars2 = Array(text2)

    let m = chars1.count
    let n = chars2.count

    if m == 0 || n == 0 {
        return 0
    }

    var dp = Array(repeating: 0, count: n + 1)

    for i in 1...m {

        // dp[i-1][0] is always 0
        var diagonal = 0

        for j in 1...n {

            // dp[j] before overwrite = the cell ABOVE
            let top = dp[j]

            if chars1[i-1] == chars2[j-1] {
                dp[j] = diagonal + 1

            } else {
                dp[j] = max(dp[j], dp[j-1])
            }

            // this row's ABOVE becomes next j's DIAGONAL
            diagonal = top
        }
    }
    return dp[n]
}

print("[2] 1D Carry  :", longestCommonSubsequenceOptimized(text1, text2))

print("")

//====================================================
// MARK: - Traced 2D grid
//====================================================

func longestCommonSubsequenceTrace(_ text1: String, _ text2: String) -> Int {

    let chars1 = Array(text1)
    let chars2 = Array(text2)

    let m = chars1.count
    let n = chars2.count

    if m == 0 || n == 0 {
        return 0
    }

    var dp = Array(repeating: Array(repeating: 0, count: n + 1), count: m + 1)

    print("text1 = \"\(text1)\"  (rows)   text2 = \"\(text2)\"  (columns)")

    print("grid is \(m + 1) x \(n + 1) — extra row and column for the empty string\n")

    for i in 1...m {
        for j in 1...n {

            if chars1[i-1] == chars2[j-1] {
                dp[i][j] = dp[i-1][j-1] + 1

                print("i=\(i) j=\(j)   \"\(chars1[i-1])\" == \"\(chars2[j-1])\"   MATCH   diagonal dp[\(i-1)][\(j-1)] (\(dp[i-1][j-1])) + 1 = \(dp[i][j])")

            } else {
                dp[i][j] = max(dp[i-1][j], dp[i][j-1])

                print("i=\(i) j=\(j)   \"\(chars1[i-1])\" != \"\(chars2[j-1])\"   max(above \(dp[i-1][j]), left \(dp[i][j-1])) = \(dp[i][j])")
            }
        }
        print("   row \(i) = \(dp[i])")
    }

    print("\nfinal grid:")

    for row in dp {
        print("   \(row)")
    }

    print("\nanswer = dp[\(m)][\(n)] = \(dp[m][n])")

    return dp[m][n]
}

print("=========================================")

print("  TRACE   2D grid")

print("=========================================")

print("result :", longestCommonSubsequenceTrace("abc", "ac"))

print("")

//====================================================
// MARK: - Traced 1D carry
//====================================================

func longestCommonSubsequenceOptimizedTrace(_ text1: String, _ text2: String) -> Int {

    let chars1 = Array(text1)
    let chars2 = Array(text2)

    let m = chars1.count
    let n = chars2.count

    if m == 0 || n == 0 {
        return 0
    }

    var dp = Array(repeating: 0, count: n + 1)

    print("start dp = \(dp)")

    for i in 1...m {

        var diagonal = 0

        print("\n--- row \(i)  char \"\(chars1[i-1])\"   diagonal reset to 0 ---")

        for j in 1...n {

            let top = dp[j]

            if chars1[i-1] == chars2[j-1] {
                dp[j] = diagonal + 1

                print("   j=\(j)  \"\(chars2[j-1])\" MATCH   diagonal \(diagonal) + 1 = \(dp[j])")

            } else {
                dp[j] = max(dp[j], dp[j-1])

                print("   j=\(j)  \"\(chars2[j-1])\" differ  max(above \(top), left \(dp[j-1])) = \(dp[j])")
            }

            diagonal = top
        }
        print("   dp = \(dp)")
    }

    print("\nanswer = dp[\(n)] = \(dp[n])")

    return dp[n]
}

print("=========================================")

print("  TRACE   1D diagonal carry")

print("=========================================")

print("result :", longestCommonSubsequenceOptimizedTrace("abc", "ac"))

print("")

//====================================================
// MARK: - Verify
//====================================================

let cases: [(String, String, Int)] = [
    ("abcde", "ace",   3),
    ("abc",   "abc",   3),
    ("abc",   "def",   0),
    ("abc",   "ac",    2),
    ("bl",    "yby",   1),
    ("ezupkr", "ubmrapg", 2),
    ("a",     "a",     1)
]

print("=========================================")

print("  VERIFY")

print("=========================================")

for (a, b, expected) in cases {

    let x = longestCommonSubsequence(a, b)
    let y = longestCommonSubsequenceOptimized(a, b)
    let ok = (x == expected && y == expected)

    print("\"\(a)\" vs \"\(b)\"  ->  2D \(x)  1D \(y)   expected \(expected)   \(ok ? "OK" : "FAIL")")
}

//====================================================
// MARK: - Interview sequence
//====================================================
//
//  1. Draw the grid with the extra empty row and column.
//  2. "If the characters match, the answer is the diagonal plus 1 —
//      both strings gained one usable character."
//  3. "If they differ, I drop one character from either string and
//      take whichever gives more — that is above vs left."
//  4. Write Solution 1.
//  5. "I only ever read above, left and diagonal, so one array plus
//      a carry variable is enough." Write Solution 2.
//
//  FOLLOW-UP: returning the actual subsequence (not just its
//  length) needs the full 2D grid to walk backwards through. The
//  1D version cannot do it — same limitation as the tails array in
//  LIS.

//====================================================
// MARK: - Traps logged
//====================================================
//
//  1. Grid is (m+1) x (n+1). Answer is dp[m][n], NOT dp[m-1][n-1]
//     like Unique Paths.
//  2. The i-th character is at index i-1, because dp[i][j] means
//     "first i characters".
//  3. `for i in 1...m` traps when a string is empty. Constraints
//     forbid it, but the guard costs nothing — this is the same
//     closed-range trap hit in Coin Change and Decode Ways.
//  4. In the 1D version, `diagonal` must reset to 0 at the start of
//     every row, and `top` must be captured BEFORE the overwrite.
//  5. On a match, do NOT also take max with above/left. The
//     diagonal + 1 is always at least as good.
