import UIKit

// ──────────────────────────────────────────
// LeetCode 1314 — Matrix Block Sum
// Difficulty: Medium  |  Pattern: Prefix 2D
// ──────────────────────────────────────────


// MARK: - Problem

/*
 Given matrix mat and integer k
 Return matrix answer where
 answer[i][j] = sum of all elements
 where |r-i| <= k AND |c-j| <= k

 mat = [        k = 1
   [1, 2, 3],
   [4, 5, 6],
   [7, 8, 9]
 ]

 Answer = [
   [12, 21, 16],
   [27, 45, 33],
   [24, 39, 28]
 ]

 Key insight:
 For each cell find rectangle boundary
 top    = max(0,      i-k)
 bottom = min(rows-1, i+k)
 left   = max(0,      j-k)
 right  = min(cols-1, j+k)

 Brute  → loop rectangle every cell O(k²)
 Optimised → 2D prefix O(1) per cell
*/


// MARK: - Interview Q&A

/*
 Q: What does |r-i| <= k mean?
 A: Look k steps up down left right
    from current cell (i,j)

 Q: Why clamp with max and min?
 A: Cannot go outside matrix boundary
    max(0, i-k)      prevents negative index
    min(rows-1, i+k) prevents out of bounds

 Q: Why build prefix?
 A: Instead of looping rectangle each time
    Use sumRegion O(1) — much faster

 Q: sumRegion formula?
 A: prefix[r2+1][c2+1]   big rectangle
  - prefix[r1][c2+1]     remove top strip
  - prefix[r2+1][c1]     remove left strip
  + prefix[r1][c1]       add corner back

 Q: Why add corner back?
 A: Top and left both include corner
    Subtracted twice — add back once

 Q: Time and space?
 A: Brute     O(n×m×k²) time  O(n×m) space
    Optimised  O(n×m)    time  O(n×m) space
*/


// MARK: - Visual

/*
 mat = [        k = 1
   [1, 2, 3],
   [4, 5, 6],
   [7, 8, 9]
 ]

 cell(0,0): top=0 bottom=1 left=0 right=1
 [1, 2]
 [4, 5]
 sum = 12 ✅

 cell(1,1): top=0 bottom=2 left=0 right=2
 [1, 2, 3]
 [4, 5, 6]
 [7, 8, 9]
 sum = 45 ✅

 cell(2,2): top=1 bottom=2 left=1 right=2
 [5, 6]
 [8, 9]
 sum = 28 ✅
*/


func solve() {


    // MARK: - Brute Force  O(n×m×k²) time  O(n×m) space

    /*
     Strategy:
     - For each cell (i,j) calculate boundary
     - top bottom left right with clamp
     - Loop rectangle and sum all elements
     - Store in answer[i][j]

     INTERVIEW: top bottom left right — clear naming
     INTERVIEW: max and min for clamping
     INTERVIEW: answer[i][j] = sum OUTSIDE both loops
     INTERVIEW: weakness — k large makes it very slow
    */

    func matrixBlockSumBrute(_ mat: [[Int]],
                              _ k: Int) -> [[Int]] {

        let rows = mat.count
        let cols = mat[0].count

        var answer = Array(
            repeating: Array(repeating: 0, count: cols),
            count: rows
        )

        for i in 0..<rows {
            for j in 0..<cols {

                // clamp boundary
                let top    = max(0,      i - k)
                let bottom = min(rows-1, i + k)
                let left   = max(0,      j - k)
                let right  = min(cols-1, j + k)

                var sum = 0

                // loop rectangle
                for r in top...bottom {
                    for c in left...right {
                        sum += mat[r][c]
                    }
                }

                answer[i][j] = sum    // outside both loops ✅
            }
        }

        return answer
    }


    // MARK: - Optimised ⭐️  O(n×m) time  O(n×m) space

    /*
     Strategy:
     Step 1 — Build 2D prefix array
     Step 2 — sumRegion function using prefix
     Step 3 — For each cell use sumRegion

     Build formula:
     prefix[i][j] = mat[i-1][j-1]     current cell
                  + prefix[i-1][j]    top
                  + prefix[i][j-1]    left
                  - prefix[i-1][j-1]  top-left fix

     Query formula:
     sumRegion(r1,c1,r2,c2)
     = prefix[r2+1][c2+1]   big rectangle
     - prefix[r1][c2+1]     remove top
     - prefix[r2+1][c1]     remove left
     + prefix[r1][c1]       add corner back

     INTERVIEW: prefix size (rows+1) × (cols+1)
     INTERVIEW: subtract top-left — counted twice
     INTERVIEW: add corner back — subtracted twice
     INTERVIEW: top bottom left right same as brute
    */

    func matrixBlockSumOptimised(_ mat: [[Int]],
                                  _ k: Int) -> [[Int]] {

        let rows = mat.count
        let cols = mat[0].count


        // Step 1 — Build 2D prefix
        // size (rows+1) × (cols+1)
        // extra zeros at top and left
        var prefix = Array(
            repeating: Array(repeating: 0, count: cols + 1),
            count: rows + 1
        )

        for i in 1...rows {
            for j in 1...cols {
                prefix[i][j] = mat[i-1][j-1]    // current cell
                             + prefix[i-1][j]    // top
                             + prefix[i][j-1]    // left
                             - prefix[i-1][j-1]  // top-left fix
            }
        }


        // Step 2 — sumRegion using prefix
        // big rectangle - top - left + corner
        func sumRegion(_ r1: Int, _ c1: Int,
                       _ r2: Int, _ c2: Int) -> Int {

            return prefix[r2+1][c2+1]    // big rectangle
                 - prefix[r1][c2+1]      // remove top
                 - prefix[r2+1][c1]      // remove left
                 + prefix[r1][c1]        // add corner back
        }


        // Step 3 — Build answer using sumRegion
        var answer = Array(
            repeating: Array(repeating: 0, count: cols),
            count: rows
        )

        for i in 0..<rows {
            for j in 0..<cols {

                // clamp boundary — same as brute
                let top    = max(0,      i - k)
                let bottom = min(rows-1, i + k)
                let left   = max(0,      j - k)
                let right  = min(cols-1, j + k)

                // O(1) query using prefix
                answer[i][j] = sumRegion(top,    left,
                                         bottom, right)
            }
        }

        return answer
    }


    // MARK: - Dry Run

    /*
     mat = [[1,2,3],[4,5,6],[7,8,9]]  k=1

     prefix (4×4):
     [ 0,  0,  0,  0]
     [ 0,  1,  3,  6]
     [ 0,  5, 12, 21]
     [ 0, 12, 27, 45]

     cell(0,0): top=0 bottom=1 left=0 right=1
     sumRegion(0,0,1,1)
     = prefix[2][2] - prefix[0][2]
     - prefix[2][0] + prefix[0][0]
     = 12 - 0 - 0 + 0 = 12 ✅

     cell(1,1): top=0 bottom=2 left=0 right=2
     sumRegion(0,0,2,2)
     = prefix[3][3] - prefix[0][3]
     - prefix[3][0] + prefix[0][0]
     = 45 - 0 - 0 + 0 = 45 ✅

     cell(2,2): top=1 bottom=2 left=1 right=2
     sumRegion(1,1,2,2)
     = prefix[3][3] - prefix[1][3]
     - prefix[3][1] + prefix[1][1]
     = 45 - 6 - 12 + 1 = 28 ✅
    */


    // MARK: - Complexity

    /*
     ┌─────────────┬────────────────┬────────────┐
     │             │ Brute          │ Optimised  │
     ├─────────────┼────────────────┼────────────┤
     │ Time        │ O(n×m×k²)      │ O(n×m)     │
     │ Space       │ O(n×m)         │ O(n×m)     │
     │ Per cell    │ O(k²)          │ O(1)       │
     └─────────────┴────────────────┴────────────┘
    */


    // MARK: - Traps

    /*
     Trap 1 — no clamping
     top = i - k           ❌ negative crash
     top = max(0, i-k)     ✅ safe

     Trap 2 — wrong bottom clamp
     bottom = i + k              ❌ out of bounds
     bottom = min(rows-1, i+k)   ✅ safe

     Trap 3 — answer inside loop
     for r { answer[i][j] = sum }  ❌ partial sum
     answer[i][j] = sum outside    ✅ complete sum

     Trap 4 — forgetting corner back
     - prefix[r1][c2+1]
     - prefix[r2+1][c1]     ❌ corner twice
     + prefix[r1][c1]       ✅ add back once
    */


    // MARK: - Tests

    let tests: [(mat: [[Int]], k: Int, expected: [[Int]])] = [

        ([[1,2,3],[4,5,6],[7,8,9]],          1,
         [[12,21,16],[27,45,33],[24,39,28]]),

        ([[1,2,3],[4,5,6],[7,8,9]],          2,
         [[45,45,45],[45,45,45],[45,45,45]]),

        ([[1]],                               1,
         [[1]]),

        ([[1,2],[3,4]],                       1,
         [[10,10],[10,10]]),

    ]

    print("====== LeetCode 1314 — Matrix Block Sum ======\n")

    print("--- Brute Force ---\n")

    for (i, t) in tests.enumerated() {
        let r = matrixBlockSumBrute(t.mat, t.k)
        print("Test \(i+1): \(r == t.expected ? "✅" : "❌")  |  k:\(t.k)  Got: \(r)")
    }

    print("\n--- Optimised ⭐️ ---\n")

    for (i, t) in tests.enumerated() {
        let r = matrixBlockSumOptimised(t.mat, t.k)
        print("Test \(i+1): \(r == t.expected ? "✅" : "❌")  |  k:\(t.k)  Got: \(r)")
    }
}

solve()
