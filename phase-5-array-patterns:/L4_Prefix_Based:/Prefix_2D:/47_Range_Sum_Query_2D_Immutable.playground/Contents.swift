import UIKit


// ──────────────────────────────────────────
// LeetCode 304 — Range Sum Query 2D Immutable
// Difficulty: Medium  |  Pattern: Prefix 2D
// ──────────────────────────────────────────


// MARK: - Problem

/*
 Given 2D matrix handle multiple queries
 sumRegion(r1, c1, r2, c2)
 Return sum of rectangle from (r1,c1) to (r2,c2)

 matrix = [
   [3, 0, 1, 4, 2],
   [5, 6, 3, 2, 1],
   [1, 2, 0, 1, 5],
   [4, 1, 0, 1, 7],
   [1, 0, 3, 0, 5]
 ]

 sumRegion(2,1,4,3) →  8
 sumRegion(1,1,2,2) → 11
 sumRegion(1,2,2,4) → 12

 Key insight:
 Build 2D prefix array once
 Answer every query in O(1)
 prefix[i][j] = sum of matrix[0..i-1][0..j-1]
*/


// MARK: - Interview Q&A

/*
 Q: Why prefix size (rows+1) × (cols+1)?
 A: Extra row and col of zeros at top and left
    Handles first element query safely
    Avoids index out of bounds

 Q: Why subtract prefix[i-1][j-1]?
 A: top and left both include top-left corner
    Gets counted twice — subtract once to fix

 Q: Build formula?
 A: prefix[i][j] = matrix[i-1][j-1]
                 + prefix[i-1][j]     top
                 + prefix[i][j-1]     left
                 - prefix[i-1][j-1]   top-left fix

 Q: Query formula?
 A: prefix[r2+1][c2+1]   big rectangle
  - prefix[r1][c2+1]     remove top
  - prefix[r2+1][c1]     remove left
  + prefix[r1][c1]       add corner back

 Q: Why wrap in func solve()?
 A: Swift Playgrounds main actor isolation
    Global variables cause errors
    Wrapping in function fixes it

 Q: Time and space?
 A: Brute     O(n×m) per query  O(1) space
    Optimised  O(1)   per query  O(n×m) space
*/


// MARK: - Dry Run

/*
 prefix (6×6):
 [ 0,  0,  0,  0,  0,  0]
 [ 0,  3,  3,  4,  8, 10]
 [ 0,  8, 14, 18, 24, 27]
 [ 0,  9, 17, 21, 28, 36]
 [ 0, 13, 22, 26, 34, 49]
 [ 0, 14, 23, 30, 38, 58]

 sumRegion(2,1,4,3):
 = prefix[5][4] - prefix[2][4]
 - prefix[5][1] + prefix[2][1]
 = 38 - 24 - 14 + 8
 = 8 ✅

 sumRegion(1,1,2,2):
 = prefix[3][3] - prefix[1][3]
 - prefix[3][1] + prefix[1][1]
 = 21 - 4 - 9 + 3
 = 11 ✅

 sumRegion(1,2,2,4):
 = prefix[3][5] - prefix[1][5]
 - prefix[3][2] + prefix[1][2]
 = 36 - 10 - 17 + 3
 = 12 ✅
*/


// MARK: - 1D vs 2D Comparison

/*
 1D Prefix:
 Build: prefix[i] = prefix[i-1] + arr[i]
 Query: prefix[R+1] - prefix[L]

 2D Prefix:
 Build: prefix[i][j] = matrix[i-1][j-1]
                     + prefix[i-1][j]
                     + prefix[i][j-1]
                     - prefix[i-1][j-1]
 Query: prefix[r2+1][c2+1]
      - prefix[r1][c2+1]
      - prefix[r2+1][c1]
      + prefix[r1][c1]

 Same idea — just two dimensions
*/


// MARK: - Complexity

/*
 ┌─────────────┬──────────────┬────────────┐
 │             │ Brute        │ Optimised  │
 ├─────────────┼──────────────┼────────────┤
 │ Build       │ O(1)         │ O(n×m)     │
 │ sumRegion   │ O(n×m)       │ O(1)       │
 │ Space       │ O(1)         │ O(n×m)     │
 │ 10k queries │ 10k × n×m   │ 10k × 1    │
 └─────────────┴──────────────┴────────────┘
*/


// MARK: - Traps

/*
 Trap 1 — wrong prefix size
 Array(count: rows)          ❌ crashes
 Array(count: rows + 1)      ✅ correct

 Trap 2 — wrong matrix index
 prefix[i][j] = matrix[i][j]       ❌
 prefix[i][j] = matrix[i-1][j-1]   ✅

 Trap 3 — forgetting top-left subtraction
 + prefix[i-1][j] + prefix[i][j-1]           ❌
 + prefix[i-1][j] + prefix[i][j-1]
 - prefix[i-1][j-1] + matrix[i-1][j-1]       ✅

 Trap 4 — wrong query formula
 prefix[r2][c2]       ❌ off by one
 prefix[r2+1][c2+1]   ✅ correct

 Trap 5 — forgetting corner back
 - prefix[r1][c2+1]
 - prefix[r2+1][c1]         ❌ corner twice
 + prefix[r1][c1]           ✅ add back once
*/


// MARK: - Solution

func solve() {


    // MARK: Setup

    let matrix = [
        [3, 0, 1, 4, 2],
        [5, 6, 3, 2, 1],
        [1, 2, 0, 1, 5],
        [4, 1, 0, 1, 7],
        [1, 0, 3, 0, 5]
    ]

    let rows = matrix.count
    let cols = matrix[0].count


    // MARK: Brute Force  O(n×m) per query  O(1) space

    /*
     Strategy:
     - Loop rows r1 to r2
     - Loop cols c1 to c2
     - Add every element

     INTERVIEW: two nested loops
     INTERVIEW: closed range includes both ends
     INTERVIEW: weakness — recomputes every query
    */

    func sumRegionBrute(_ r1: Int, _ c1: Int,
                        _ r2: Int, _ c2: Int) -> Int {

        var sum = 0

        for r in r1...r2 {
            for c in c1...c2 {
                sum += matrix[r][c]
            }
        }

        return sum
    }


    // MARK: Build Prefix  O(n×m) time  O(n×m) space

    /*
     Size (rows+1) × (cols+1)
     Extra zeros at top and left
     Handles first element safely

     Formula:
     prefix[i][j] = matrix[i-1][j-1]  current
                  + prefix[i-1][j]    top
                  + prefix[i][j-1]    left
                  - prefix[i-1][j-1]  top-left fix
    */

    var prefix = Array(
        repeating: Array(repeating: 0, count: cols + 1),
        count: rows + 1
    )

    for i in 1...rows {
        for j in 1...cols {
            prefix[i][j] = matrix[i-1][j-1]   // current cell
                         + prefix[i-1][j]      // top
                         + prefix[i][j-1]      // left
                         - prefix[i-1][j-1]    // top-left fix
        }
    }


    // MARK: Optimised ⭐️  O(1) per query  O(n×m) space

    /*
     Formula:
     = prefix[r2+1][c2+1]   big rectangle
     - prefix[r1][c2+1]     remove top
     - prefix[r2+1][c1]     remove left
     + prefix[r1][c1]       add corner back

     INTERVIEW: four lookups — O(1) always
     INTERVIEW: same idea as 1D prefix sum
    */

    func sumRegion(_ r1: Int, _ c1: Int,
                   _ r2: Int, _ c2: Int) -> Int {

        return prefix[r2+1][c2+1]    // big rectangle
             - prefix[r1][c2+1]     // remove top
             - prefix[r2+1][c1]     // remove left
             + prefix[r1][c1]       // add corner back
    }


    // MARK: Tests

    typealias RegionQuery = (r1: Int, c1: Int,
                             r2: Int, c2: Int,
                             expected: Int)

    let tests: [RegionQuery] = [

        (2, 1, 4, 3,   8),    // classic case
        (1, 1, 2, 2,  11),    // small rectangle
        (1, 2, 2, 4,  12),    // right side
        (0, 0, 4, 4,  58),    // entire matrix
        (0, 0, 0, 0,   3),    // single cell
        (4, 4, 4, 4,   5),    // last cell
        (0, 0, 0, 4,  10),    // first row

    ]

    print("====== LeetCode 304 — Range Sum Query 2D ======\n")

    print("--- Brute Force ---\n")

    for (i, t) in tests.enumerated() {
        let r = sumRegionBrute(t.r1, t.c1, t.r2, t.c2)
        print("Test \(i+1): \(r == t.expected ? "✅" : "❌")  |  (\(t.r1),\(t.c1),\(t.r2),\(t.c2))  Got: \(r)  Expected: \(t.expected)")
    }

    print("\n--- Optimised ⭐️ ---\n")

    for (i, t) in tests.enumerated() {
        let r = sumRegion(t.r1, t.c1, t.r2, t.c2)
        print("Test \(i+1): \(r == t.expected ? "✅" : "❌")  |  (\(t.r1),\(t.c1),\(t.r2),\(t.c2))  Got: \(r)  Expected: \(t.expected)")
    }
}


// MARK: - Run

solve()
