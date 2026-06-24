import UIKit

// ============================================================
// LC 240 — Search a 2D Matrix II
// Difficulty : Medium
// Pattern    : Staircase Search
// File       : 69_Search_A_2D_Matrix_II
// Frequency  : ★★★★☆ — High (Amazon, Google, Facebook)
// ============================================================


// MARK: - Problem
// Given an m x n matrix where:
//   1. Each row is sorted left to right
//   2. Each column is sorted top to bottom
//   (rows are NOT globally sorted end to end)
//
// Search for a target value and return true if found.
//
// Example:
//   matrix = [[1,4,7,11,15],[2,5,8,12,19],[3,6,9,16,22],
//             [10,13,14,17,24],[18,21,23,26,30]]
//   target = 5  → true
//   target = 20 → false


// MARK: - Interview Q&A
// Q: What is the difference from LC 74?
// A: LC 74 — rows globally sorted, treat as 1D array, binary search
//    LC 240 — only row/column sorted, NOT globally sorted
//             cannot flatten → staircase search from top right
//
// Q: Why start from top right corner?
// A: Top right element has unique property:
//    everything to its LEFT is smaller
//    everything BELOW it is larger
//    So each step eliminates one full row or one full column
//
// Q: What is the movement logic?
// A: == target → return true
//    >  target → move left  (col - 1) — eliminate this column
//    <  target → move down  (row + 1) — eliminate this row
//
// Q: What is the loop condition?
// A: while row < m && col >= 0
//    row goes out of bounds below, col goes out of bounds left
//
// Q: What is the time complexity?
// A: O(m + n) — at most m steps down and n steps left
//
// Q: Can you use binary search on each row?
// A: Yes — T: O(m log n) S: O(1), but staircase is simpler and faster
//
// Q: Why not start from bottom left?
// A: Bottom left also works with same logic:
//    > target → move up    (row - 1)
//    < target → move right (col + 1)


// MARK: - Brute Force
// T: O(m×n)  S: O(1)
// Nested loop — check every element.

func bruetForece(_ nums: [[Int]], _ target: Int) -> Bool {
    for i in 0..<nums.count {
        let list = nums[i]
        for num in list {
            if num == target {
                return true
            }
        }
    }
    return false
}


// MARK: - Optimised — Staircase Search
// T: O(m+n)  S: O(1)
//
// Start from top right corner.
// At each step eliminate one full row or one full column.
//
// > target → move left  (col - 1)
// < target → move down  (row + 1)
// = target → return true

func optmised(_ nums: [[Int]], _ target: Int) -> Bool {
    let m = nums.count
    let n = nums[0].count

    var row = 0
    var col = n - 1

    while row < m && col >= 0 {
        if nums[row][col] == target {
            return true
        } else if nums[row][col] > target {
            col -= 1   // eliminate this column
        } else {
            row += 1   // eliminate this row
        }
    }

    return false
}


// MARK: - Dry Run
// matrix = [[1,4,7,11,15],[2,5,8,12,19],[3,6,9,16,22],
//           [10,13,14,17,24],[18,21,23,26,30]]
// target = 5
//
// row=0 col=4 → matrix[0][4]=15  15>5 → col=3
// row=0 col=3 → matrix[0][3]=11  11>5 → col=2
// row=0 col=2 → matrix[0][2]=7    7>5 → col=1
// row=0 col=1 → matrix[0][1]=4    4<5 → row=1
// row=1 col=1 → matrix[1][1]=5    5==5 → return true ✅
//
// ─────────────────────────────────────
// target = 20
//
// row=0 col=4 → 15 < 20 → row=1
// row=1 col=4 → 19 < 20 → row=2
// row=2 col=4 → 22 > 20 → col=3
// row=2 col=3 → 16 < 20 → row=3
// row=3 col=3 → 17 < 20 → row=4
// row=4 col=3 → 26 > 20 → col=2
// row=4 col=2 → 23 > 20 → col=1
// row=4 col=1 → 21 > 20 → col=0
// row=4 col=0 → 18 < 20 → row=5
// row=5 >= m=5 → loop ends
// return false ✅


// MARK: - Complexity
// ┌─────────────────┬───────────┬───────────┐
// │                 │   Time    │   Space   │
// ├─────────────────┼───────────┼───────────┤
// │ Brute Force     │  O(m×n)   │   O(1)    │
// │ Staircase Search│  O(m+n)   │   O(1)    │
// └─────────────────┴───────────┴───────────┘


// MARK: - Traps
// 1. while row < n instead of row < m — WRONG
//    n is column count, m is row count
//
// 2. Starting from top left — WRONG
//    top left has no elimination property
//    both right and down are larger, no decision possible
//
// 3. Trying binary search on this matrix like LC 74 — WRONG
//    matrix is not globally sorted, mid/n and mid%n won't work
//
// 4. Missing else block — infinite loop
//    All three cases must be handled: ==, >, <


// MARK: - LC 74 vs LC 240 Comparison
// ┌────────────────────┬──────────────────────┬──────────────────────┐
// │                    │       LC 74           │      LC 240          │
// ├────────────────────┼──────────────────────┼──────────────────────┤
// │ Row sorted         │ ✅                    │ ✅                   │
// │ Col sorted         │ ✅                    │ ✅                   │
// │ Globally sorted    │ ✅                    │ ❌                   │
// │ Approach           │ Binary Search         │ Staircase Search     │
// │ Time               │ O(log(m×n))           │ O(m+n)               │
// └────────────────────┴──────────────────────┴──────────────────────┘


// MARK: - Tests

let matrix = [
    [1,  4,  7,  11, 15],
    [2,  5,  8,  12, 19],
    [3,  6,  9,  16, 22],
    [10, 13, 14, 17, 24],
    [18, 21, 23, 26, 30]
]
let matrix2 = [[1]]

print("── Brute Force ──")
print(bruetForece(matrix, 5))    // true
print(bruetForece(matrix, 20))   // false
print(bruetForece(matrix2, 1))   // true
print(bruetForece(matrix2, 2))   // false

print()
print("── Staircase Search ──")
print(optmised(matrix, 5))       // true
print(optmised(matrix, 20))      // false
print(optmised(matrix2, 1))      // true
print(optmised(matrix2, 2))      // false
