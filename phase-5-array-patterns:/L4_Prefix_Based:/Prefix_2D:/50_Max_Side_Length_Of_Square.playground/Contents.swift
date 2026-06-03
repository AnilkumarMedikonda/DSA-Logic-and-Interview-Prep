import UIKit


// ──────────────────────────────────────────
// LeetCode 1292 — Max Side Length of Square
// Difficulty: Medium  |  Pattern: Prefix 2D
// ──────────────────────────────────────────


// MARK: - Problem

/*
 Given matrix and threshold
 Find largest side length of square
 where sum of all elements <= threshold

 matrix = [
   [1, 1, 3, 2, 4, 3, 2],
   [1, 1, 3, 2, 4, 3, 2],
   [1, 1, 3, 2, 4, 3, 2]
 ]
 threshold = 4

 Answer = 2

 Key insight:
 Build 2D prefix once
 For each cell try every square size
 Use sumRegion O(1) to check sum
*/


// MARK: - Interview Q&A

/*
 Q: What is a square submatrix?
 A: Rectangle where rows == cols
    side=1 → 1×1
    side=2 → 2×2
    side=3 → 3×3

 Q: How do you get square sum?
 A: Use 2D prefix sumRegion
    r1=i  c1=j
    r2=i+side-1  c2=j+side-1

 Q: Why break when sum > threshold?
 A: Larger square includes smaller square
    If side=2 fails side=3 will also fail
    No need to check bigger sizes

 Q: What is optimised approach?
 A: Binary search on side length
    side can be 0 to min(rows,cols)
    Binary search for largest valid side
    T - O(n×m×log(min(n,m)))

 Q: Time and space?
 A: Brute     O(n×m×min(n,m)) time  O(n×m) space
    Optimised  O(n×m×log(min(n,m))) time  O(n×m) space
*/


// MARK: - Step by Step Logic

/*
 matrix = [
   [1, 1, 3, 2, 4, 3, 2],
   [1, 1, 3, 2, 4, 3, 2],
   [1, 1, 3, 2, 4, 3, 2]
 ]
 threshold = 4

 Step 1 — Build 2D prefix:
 prefix[i][j] = sum from (0,0) to (i-1,j-1)

 Step 2 — For each cell (i,j) as top-left:
 Try side = 1, 2, 3...

 Step 3 — For each side:
 r2 = i + side - 1
 c2 = j + side - 1
 sum = sumRegion(i, j, r2, c2)

 Step 4 — Check sum:
 sum <= threshold → valid → try bigger side
 sum >  threshold → stop → break

 Step 5 — Track maxSide

 Example cell (0,0):
 side=1: sum=1  1<=4 ✅ maxSide=1
 side=2: sum=4  4<=4 ✅ maxSide=2
 side=3: sum=15 15>4 ✗ break

 Answer = 2 ✅
*/


func solve() {


    // MARK: - Brute Force  O(n×m×min(n,m))  O(n×m) space

    /*
     Strategy:
     - Build 2D prefix array
     - For each cell try every square size
     - Use sumRegion to check sum in O(1)
     - If sum <= threshold update maxSide
     - If sum > threshold break inner loop

     INTERVIEW: square means r2-r1 == c2-c1
     INTERVIEW: break when sum > threshold
     INTERVIEW: i+side-1 < rows boundary check
     INTERVIEW: sumRegion O(1) — no extra loop
    */

    func maxSideLength(_ matrix: [[Int]],
                       _ threshold: Int) -> Int {

        let rows = matrix.count
        let cols = matrix[0].count


        // Step 1 — Build 2D prefix
        // size (rows+1) × (cols+1)
        // extra zeros at top and left

        var prefix = Array(
            repeating: Array(repeating: 0, count: cols + 1),
            count: rows + 1
        )

        for i in 1...rows {
            for j in 1...cols {
                prefix[i][j] = matrix[i-1][j-1]   // current
                             + prefix[i-1][j]      // top
                             + prefix[i][j-1]      // left
                             - prefix[i-1][j-1]    // top-left fix
            }
        }


        // Step 2 — sumRegion formula
        // big rectangle - top - left + corner

        func sumRegion(_ r1: Int, _ c1: Int,
                       _ r2: Int, _ c2: Int) -> Int {
            return prefix[r2+1][c2+1]    // big rectangle
                 - prefix[r1][c2+1]     // remove top
                 - prefix[r2+1][c1]     // remove left
                 + prefix[r1][c1]       // add corner back
        }


        // Step 3 — Try every square

        var maxSide = 0

        for i in 0..<rows {
            for j in 0..<cols {

                var side = 1

                // keep growing square while inside bounds
                while i + side - 1 < rows &&
                      j + side - 1 < cols {

                    let sum = sumRegion(
                        i, j,
                        i + side - 1,
                        j + side - 1
                    )

                    if sum <= threshold {
                        // valid square — update maxSide
                        if side > maxSide {
                            maxSide = side
                        }
                        side += 1       // try bigger square
                    } else {
                        break           // too big — stop
                    }
                }
            }
        }

        return maxSide
    }


    // MARK: - Optimised ⭐️  Binary Search on Side

    /*
     Strategy:
     - Build 2D prefix array (same as brute)
     - For each cell binary search on side length
     - lo=1 hi=min(rows-i, cols-j)
     - If sum <= threshold → try bigger (lo=mid)
     - If sum > threshold  → try smaller (hi=mid-1)

     INTERVIEW: binary search works because
               if side=k valid → side=k-1 also valid
               monotonic property ✅
     INTERVIEW: lo=1 hi=min(rows-i, cols-j)
     INTERVIEW: mid = (lo+hi+1)/2 — upper binary search
    */

    func maxSideLengthOptimised(_ matrix: [[Int]],
                                 _ threshold: Int) -> Int {

        let rows = matrix.count
        let cols = matrix[0].count

        // Build 2D prefix — same as brute
        var prefix = Array(
            repeating: Array(repeating: 0, count: cols + 1),
            count: rows + 1
        )

        for i in 1...rows {
            for j in 1...cols {
                prefix[i][j] = matrix[i-1][j-1]
                             + prefix[i-1][j]
                             + prefix[i][j-1]
                             - prefix[i-1][j-1]
            }
        }

        func sumRegion(_ r1: Int, _ c1: Int,
                       _ r2: Int, _ c2: Int) -> Int {
            return prefix[r2+1][c2+1]
                 - prefix[r1][c2+1]
                 - prefix[r2+1][c1]
                 + prefix[r1][c1]
        }

        var maxSide = 0

        for i in 0..<rows {
            for j in 0..<cols {

                // binary search on side length
                var lo = 1
                var hi = min(rows - i, cols - j)

                while lo <= hi {

                    let mid = (lo + hi + 1) / 2
                    let sum = sumRegion(
                        i, j,
                        i + mid - 1,
                        j + mid - 1
                    )

                    if sum <= threshold {
                        if mid > maxSide {
                            maxSide = mid
                        }
                        lo = mid + 1    // try bigger
                    } else {
                        hi = mid - 1    // try smaller
                    }
                }
            }
        }

        return maxSide
    }


    // MARK: - Dry Run

    /*
     matrix = [
       [1, 1, 3, 2, 4, 3, 2],
       [1, 1, 3, 2, 4, 3, 2],
       [1, 1, 3, 2, 4, 3, 2]
     ]
     threshold = 4

     cell(0,0):
     side=1 → sum=1  1<=4 ✅ maxSide=1  side=2
     side=2 → sum=4  4<=4 ✅ maxSide=2  side=3
     side=3 → sum=15 15>4 ✗  break

     cell(0,1):
     side=1 → sum=1  ✅ maxSide=2
     side=2 → sum=4  ✅ maxSide=2
     side=3 → sum=12 ✗  break

     Answer = 2 ✅
    */


    // MARK: - Complexity

    /*
     ┌─────────────┬──────────────────────┬────────────────────────┐
     │             │ Brute                │ Optimised              │
     ├─────────────┼──────────────────────┼────────────────────────┤
     │ Time        │ O(n×m×min(n,m))      │ O(n×m×log(min(n,m)))   │
     │ Space       │ O(n×m)               │ O(n×m)                 │
     └─────────────┴──────────────────────┴────────────────────────┘
    */


    // MARK: - Traps

    /*
     Trap 1 — wrong square boundary
     i + side < rows       ❌ off by one
     i + side - 1 < rows   ✅ correct

     Trap 2 — not breaking when sum > threshold
     Always try all sides  ❌ slow
     Break when sum > threshold ✅ correct

     Trap 3 — wrong binary search mid
     mid = (lo + hi) / 2      ❌ infinite loop
     mid = (lo + hi + 1) / 2  ✅ upper binary search

     Trap 4 — wrong prefix formula
     prefix[i][j] = matrix[i][j]       ❌
     prefix[i][j] = matrix[i-1][j-1]   ✅
    */


    // MARK: - Tests

    let tests: [(matrix: [[Int]], threshold: Int, expected: Int)] = [

        ([[1,1,3,2,4,3,2],[1,1,3,2,4,3,2],[1,1,3,2,4,3,2]],  4,  2),
        ([[1,1,3,2,4,3,2],[1,1,3,2,4,3,2],[1,1,3,2,4,3,2]], 100, 3),
        ([[1,1],[1,1]],                                        3,  1),
        ([[1]],                                                1,  1),
        ([[1]],                                                0,  0),
        ([[2,2],[2,2]],                                        4,  1),

    ]

    print("====== LeetCode 1292 — Max Side Length of Square ======\n")

    print("--- Brute Force ---\n")

    for (i, t) in tests.enumerated() {
        let r = maxSideLength(t.matrix, t.threshold)
        print("Test \(i+1): \(r == t.expected ? "✅" : "❌")  |  threshold:\(t.threshold)  Got: \(r)  Expected: \(t.expected)")
    }

    print("\n--- Optimised ⭐️ Binary Search ---\n")

    for (i, t) in tests.enumerated() {
        let r = maxSideLengthOptimised(t.matrix, t.threshold)
        print("Test \(i+1): \(r == t.expected ? "✅" : "❌")  |  threshold:\(t.threshold)  Got: \(r)  Expected: \(t.expected)")
    }
}

solve()
