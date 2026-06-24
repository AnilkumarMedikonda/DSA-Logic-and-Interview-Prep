import UIKit

// ============================================================
// LC 74 — Search a 2D Matrix
// Difficulty : Medium
// Pattern    : Binary Search — 2D Matrix
// File       : 68_Search_A_2D_Matrix
// Frequency  : ★★★★★ — Very High (Amazon, Google, Facebook)
// ============================================================


// MARK: - Problem
// Given an m x n matrix with two properties:
//   1. Each row is sorted left to right
//   2. First element of each row > last element of previous row
//
// Search for a target value and return true if found.
//
// Example:
//   matrix = [[1,3,5,7],[10,11,16,20],[23,30,34,60]]
//   target = 3  → true
//   target = 13 → false


// MARK: - Interview Q&A
// Q: What is the brute force approach?
// A: Nested loop — check every element. T: O(m×n) S: O(1)
//
// Q: What is the optimised approach?
// A: Treat the matrix as a 1D sorted array and binary search.
//    T: O(log(m×n)) S: O(1) using mid/n and mid%n index mapping.
//
// Q: How do you map 1D index to 2D position?
// A: row = mid / n   (integer division → row index)
//    col = mid % n   (remainder → column index)
//
// Q: Example of index mapping?
// A: matrix with n=4 columns, mid=6
//    row = 6/4 = 1, col = 6%4 = 2 → matrix[1][2]
//
// Q: What is left and right initialised to?
// A: left = 0, right = m * n - 1
//
// Q: Why does binary search work here?
// A: Both row-wise and column-wise order guarantee the entire
//    matrix is one continuous sorted sequence.
//
// Q: What is the difference between flatMap and space optimised?
// A: flatMap creates a new array → S: O(m×n)
//    mid/n and mid%n indexes directly → S: O(1)
//
// Q: Follow up — what if rows are sorted but first element
//    of row is NOT greater than last of previous row?
// A: LC 240 — Search a 2D Matrix II, different approach needed.


// MARK: - Brute Force
// T: O(m×n)  S: O(1)
// Nested loop — check every element.

func bruetForece(_ nums: [[Int]], _ target: Int) -> Bool {
    for i in 0..<nums.count {
        let list = nums[i]
        for j in 0..<list.count {
            if list[j] == target {
                return true
            }
        }
    }
    return false
}


// MARK: - Optimised v1 — FlatMap + Binary Search
// T: O(log(m×n))  S: O(m×n)
// Flatten matrix into 1D array, then standard binary search.

func optmmised(_ nums: [[Int]], _ target: Int) -> Bool {
    var numbers = nums.flatMap({ $0 })
    var left = 0
    var right = numbers.count - 1

    while left <= right {
        let mid = (left + right) / 2
        if numbers[mid] == target {
            return true
        } else if numbers[mid] < target {
            left = mid + 1
        } else {
            right = mid - 1
        }
    }
    return false
}


// MARK: - Optimised v2 — Space Optimised (mid/n, mid%n)
// T: O(log(m×n))  S: O(1)
// No flattening — directly index matrix using mid/n and mid%n.
//
// Key formula:
//   row = mid / n   → which row
//   col = mid % n   → which column

func optmmisedTwo(_ nums: [[Int]], _ target: Int) -> Bool {
    let m = nums.count
    let n = nums[0].count

    var left = 0
    var right = m * n - 1

    while left <= right {
        let mid = (left + right) / 2
        let row = mid / n
        let col = mid % n

        if nums[row][col] == target {
            return true
        } else if nums[row][col] < target {
            left = mid + 1
        } else {
            right = mid - 1
        }
    }
    return false
}


// MARK: - Dry Run
// matrix = [[1,3,5,7],[10,11,16,20],[23,30,34,60]]
// target = 3, m=3, n=4, right=11
//
// left=0  right=11  mid=5
// row=1 col=1 → matrix[1][1]=11
// 11 > 3 → right=4
//
// left=0  right=4   mid=2
// row=0 col=2 → matrix[0][2]=5
// 5 > 3 → right=1
//
// left=0  right=1   mid=0
// row=0 col=0 → matrix[0][0]=1
// 1 < 3 → left=1
//
// left=1  right=1   mid=1
// row=0 col=1 → matrix[0][1]=3
// 3 == 3 → return true ✅


// MARK: - Complexity
// ┌──────────────────┬──────────────┬───────────┐
// │                  │     Time     │   Space   │
// ├──────────────────┼──────────────┼───────────┤
// │ Brute Force      │   O(m×n)     │   O(1)    │
// │ FlatMap          │ O(log(m×n))  │  O(m×n)   │
// │ Space Optimised  │ O(log(m×n))  │   O(1)    │
// └──────────────────┴──────────────┴───────────┘


// MARK: - Traps
// 1. Using nums[left][mid] instead of nums[row][col] — WRONG
//    left is a pointer, not a row index
//
// 2. Forgetting right = m * n - 1, using nums.count - 1 instead — WRONG
//    right must cover all elements across all rows
//
// 3. while left < right — misses last element
//    Always use while left <= right for search problems
//
// 4. flatMap approach — valid but S: O(m×n)
//    Interviewer may ask for O(1) space — use mid/n and mid%n


// MARK: - Tests

let matrix = [
    [1,  3,  5,  7],
    [10, 11, 16, 20],
    [23, 30, 34, 60]
]
let matrix2 = [[1]]

print("── Brute Force ──")
print(bruetForece(matrix, 3))    // true
print(bruetForece(matrix, 13))   // false
print(bruetForece(matrix2, 1))   // true
print(bruetForece(matrix2, 2))   // false

print()
print("── FlatMap ──")
print(optmmised(matrix, 3))      // true
print(optmmised(matrix, 13))     // false
print(optmmised(matrix2, 1))     // true
print(optmmised(matrix2, 2))     // false

print()
print("── Space Optimised ──")
print(optmmisedTwo(matrix, 3))   // true
print(optmmisedTwo(matrix, 13))  // false
print(optmmisedTwo(matrix2, 1))  // true
print(optmmisedTwo(matrix2, 2))  // false
