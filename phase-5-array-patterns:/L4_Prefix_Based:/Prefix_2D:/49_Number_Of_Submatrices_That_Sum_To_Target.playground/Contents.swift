import UIKit


// ──────────────────────────────────────────
// LeetCode 1074 — Number of Submatrices That Sum to Target
// Difficulty: Hard  |  Pattern: Prefix 2D + HashMap
// ──────────────────────────────────────────


// MARK: - Problem

/*
 Given matrix and target
 Return number of submatrices that sum to target

 matrix = [
   [0, 1, 0],
   [1, 1, 1],
   [0, 1, 0]
 ]
 target = 0

 Answer = 4

 Key insight:
 Fix top and bottom rows
 Compress columns to 1D colSum array
 Apply Subarray Sum K on colSum
 Same as LeetCode 560!
*/


// MARK: - Interview Q&A

/*
 Q: How do you reduce 2D to 1D?
 A: Fix top and bottom rows
    Sum each column between them
    colSum[c] += matrix[bottom][c]
    Now colSum is 1D array

 Q: Why += not = for colSum?
 A: Need to accumulate rows
    bottom=0 → row 0 only
    bottom=1 → row 0 + row 1
    bottom=2 → row 0 + row 1 + row 2

 Q: Why map[0] = 1?
 A: Base case — empty prefix
    Handles subarrays from index 0

 Q: Why map resets inside bottom loop?
 A: Each (top,bottom) pair is independent
    Fresh hashmap for each column sum array

 Q: Time and space?
 A: Brute     O(n²×m²) time  O(1) space
    Optimised  O(n²×m)  time  O(m) space
*/


// MARK: - Dry Run

/*
 matrix = [[0,1,0],[1,1,1],[0,1,0]]  target=0

 top=0:
   colSum = [0,0,0]

   bottom=0:
     colSum = [0,1,0]
     map={0:1} prefix=0
     sum=0 → prefix=0  map[0-0]=1  count=1  ✅
     sum=1 → prefix=1  map[1-0]=0  count=1
     sum=0 → prefix=1  map[1-0]=1  count=2  ✅

   bottom=1:
     colSum = [1,2,1]
     no subarray sums to 0

   bottom=2:
     colSum = [1,3,1]
     no subarray sums to 0

 top=1:
   bottom=1: colSum=[1,1,1] → no match
   bottom=2: colSum=[1,2,1] → no match

 top=2:
   bottom=2:
     colSum = [0,1,0]
     count += 2  → total=4 ✅

 Answer = 4 ✅
*/


// MARK: - 1D vs 2D connection

/*
 LeetCode 560 — Subarray Sum K (1D):
 prefix += num
 count  += map[prefix - k]
 map[prefix] += 1

 LeetCode 1074 — Submatrices Sum Target (2D):
 Fix top and bottom rows
 Build colSum → 1D array
 Apply exact same 560 logic on colSum ✅
*/


// MARK: - Complexity

/*
 ┌─────────────┬────────────┬────────────┐
 │             │ Brute      │ Optimised  │
 ├─────────────┼────────────┼────────────┤
 │ Time        │ O(n²×m²)   │ O(n²×m)    │
 │ Space       │ O(1)       │ O(m)       │
 │ Loops       │ 6 nested   │ 3 + hash   │
 └─────────────┴────────────┴────────────┘
*/


// MARK: - Traps

/*
 Trap 1 — wrong colSum update
 colSum[c] = matrix[bottom][c]    ❌ overwrites
 colSum[c] += matrix[bottom][c]   ✅ accumulates

 Trap 2 — forgetting map[0] = 1
 map[0] missing    ❌ misses index 0
 map[0] = 1        ✅ base case

 Trap 3 — return wrong value
 return 0      ❌ always wrong
 return count  ✅ correct

 Trap 4 — map not resetting
 map outside bottom loop   ❌ carries over
 map inside bottom loop    ✅ fresh each time
*/


func solve() {


    // MARK: - Brute Force  O(n²×m²) time  O(1) space

    /*
     Strategy:
     - Fix top bottom left right boundaries
     - Compute rectangle sum with two inner loops
     - If sum == target count it

     INTERVIEW: 6 nested loops total
     INTERVIEW: sum resets for every rectangle
     INTERVIEW: weakness — very slow for large matrix
    */

    func numsInMatrix(_ matrix: [[Int]],
                      _ target: Int) -> Int {

        let rows = matrix.count
        let cols = matrix[0].count
        var count = 0

        for top in 0..<rows {
            for bottom in top..<rows {
                for left in 0..<cols {
                    for right in left..<cols {

                        var sum = 0

                        for r in top...bottom {
                            for c in left...right {
                                sum += matrix[r][c]
                            }
                        }

                        if sum == target {
                            count += 1
                        }
                    }
                }
            }
        }

        return count
    }


    // MARK: - Optimised ⭐️  O(n²×m) time  O(m) space

    /*
     Strategy:
     Step 1 — Fix top row
     Step 2 — Extend bottom row
     Step 3 — Build colSum array using +=
     Step 4 — Apply Subarray Sum K on colSum

     INTERVIEW: colSum resets for each new top
     INTERVIEW: colSum accumulates rows using +=
     INTERVIEW: map resets for each bottom row
     INTERVIEW: map[0]=1 base case — must have
     INTERVIEW: check map BEFORE storing prefix
    */

    func numsInMatrix2(_ matrix: [[Int]],
                       _ target: Int) -> Int {

        let rows = matrix.count
        let cols = matrix[0].count
        var count = 0

        for top in 0..<rows {

            // resets for each new top row
            var colSum = [Int](repeating: 0, count: cols)

            for bottom in top..<rows {

                // Step 1 — accumulate colSum
                for c in 0..<cols {
                    colSum[c] += matrix[bottom][c]
                }

                // Step 2 — apply subarray sum k
                var map    = [Int: Int]()
                map[0]     = 1
                var prefix = 0

                for sum in colSum {

                    prefix += sum

                    // check complement
                    if let value = map[prefix - target] {
                        count += value
                    }

                    // store current prefix
                    if let value = map[prefix] {
                        map[prefix] = value + 1
                    } else {
                        map[prefix] = 1
                    }
                }
            }
        }

        return count
    }


    // MARK: - Tests

    let tests: [(matrix: [[Int]], target: Int, expected: Int)] = [

        ([[0,1,0],[1,1,1],[0,1,0]],   0,   4),   // classic case
        ([[1,-1],[-1,1]],             0,   5),   // negatives
        ([[904]],                      0,   0),   // no match
        ([[1,1],[1,1]],               4,   1),   // full matrix
        ([[0,0],[0,0]],               0,   9),   // all zeros ✅ fixed

    ]

    print("====== LeetCode 1074 — Submatrices Sum To Target ======\n")

    print("--- Brute Force ---\n")

    for (i, t) in tests.enumerated() {
        let r = numsInMatrix(t.matrix, t.target)
        print("Test \(i+1): \(r == t.expected ? "✅" : "❌")  |  target:\(t.target)  Got: \(r)  Expected: \(t.expected)")
    }

    print("\n--- Optimised ⭐️ ---\n")

    for (i, t) in tests.enumerated() {
        let r = numsInMatrix2(t.matrix, t.target)
        print("Test \(i+1): \(r == t.expected ? "✅" : "❌")  |  target:\(t.target)  Got: \(r)  Expected: \(t.expected)")
    }
}

solve()
