import UIKit

// ============================================================
// LC 153 — Find Minimum in Rotated Sorted Array
// Difficulty : Medium
// Pattern    : Binary Search — Rotated Array
// File       : 66_Find_Minimum_In_Rotated_Sorted_Array
// ============================================================


// MARK: - Problem
// Given a sorted array that has been rotated at an unknown pivot,
// find the minimum element.
// All values are unique.
//
// Example:
//   Input : [3, 4, 5, 1, 2]
//   Output: 1
//
//   Input : [4, 5, 6, 7, 0, 1, 2]
//   Output: 0


// MARK: - Interview Q&A
// Q: What is the brute force approach?
// A: Linear scan — track minimum across all elements. T: O(n) S: O(1)
//
// Q: What is the optimised approach?
// A: Binary search. Identify which half mid is in, capture boundary minimum,
//    discard the sorted half. T: O(log n) S: O(1)
//
// Q: How do you identify which half mid is in?
// A: nums[left] <= nums[mid] → mid is in LEFT half (values are high)
//    nums[left] >  nums[mid] → mid is in RIGHT half (values dropped)
//
// Q: Why capture nums[left] in the LEFT branch?
// A: Left half is sorted — nums[left] is its smallest value, so it is a
//    candidate for the global minimum.
//
// Q: Why capture nums[mid] in the RIGHT branch?
// A: mid itself could be the minimum (start of right half), so capture it
//    before shrinking the window.
//
// Q: Why use high = mid and not high = mid - 1 in the RIGHT branch?
// A: mid could be the answer. Using mid - 1 would skip it.
//
// Q: What is the termination condition?
// A: left > right — at that point minNumber holds the answer.
//
// Q: Does this handle a non-rotated array like [1, 2, 3, 4, 5]?
// A: Yes. nums[left] <= nums[mid] always → left branch always runs →
//    captures nums[0] = 1 correctly.
//
// Q: Does this handle a single element array?
// A: Yes. left == right == mid → LEFT branch runs → captures nums[0].


// MARK: - Brute Force
// T: O(n)  S: O(1)
// Linear scan — track running minimum across all elements.

func minNumberBruteForce(_ nums: [Int]) -> Int {
    var minNumber = Int.max
    for num in nums {
        minNumber = min(minNumber, num)
    }
    return minNumber
}


// MARK: - Optimised — Binary Search
// T: O(log n)  S: O(1)
//
// Key insight:
//   Rotated array = LEFT sorted half + RIGHT sorted half joined together.
//   Minimum is always at the START of the RIGHT half.
//
// At each mid:
//   LEFT branch  → nums[left] <= nums[mid] → left half is sorted
//                  capture nums[left], discard left half (low = mid + 1)
//   RIGHT branch → nums[left] >  nums[mid] → right half, mid could be min
//                  capture nums[mid], shrink right (high = mid)

func minNumberOptimised(_ nums: [Int]) -> Int {
    var left = 0
    var right = nums.count - 1
    var minNumber = Int.max

    while left <= right {
        let mid = (left + right) / 2

        if nums[left] <= nums[mid] {
            // mid is in LEFT sorted half
            // nums[left] is smallest in this half — capture it
            minNumber = min(minNumber, nums[left])
            left = mid + 1
        } else {
            // mid is in RIGHT half — nums[mid] could be the minimum
            minNumber = min(minNumber, nums[mid])
            right = mid
        }
    }

    return minNumber
}


// MARK: - Dry Run
// Input: [3, 4, 5, 1, 2]
//
// left=0  right=4  mid=2  nums[mid]=5  nums[left]=3
// 3 <= 5 → LEFT  minNumber=min(∞,3)=3   left=3
//
// left=3  right=4  mid=3  nums[mid]=1  nums[left]=1
// 1 <= 1 → LEFT  minNumber=min(3,1)=1   left=4
//
// left=4  right=4  mid=4  nums[mid]=2  nums[left]=2
// 2 <= 2 → LEFT  minNumber=min(1,2)=1   left=5
//
// left=5 > right=4 → loop ends
// return 1 ✅
//
// Input: [2, 1]
//
// left=0  right=1  mid=0  nums[mid]=2  nums[left]=2
// 2 <= 2 → LEFT  minNumber=min(∞,2)=2   left=1
//
// left=1  right=1  mid=1  nums[mid]=1  nums[left]=1
// 1 <= 1 → LEFT  minNumber=min(2,1)=1   left=2
//
// left=2 > right=1 → loop ends
// return 1 ✅


// MARK: - Complexity
// ┌─────────────┬───────────┬───────────┐
// │             │   Time    │   Space   │
// ├─────────────┼───────────┼───────────┤
// │ Brute Force │   O(n)    │   O(1)    │
// │ Optimised   │ O(log n)  │   O(1)    │
// └─────────────┴───────────┴───────────┘


// MARK: - Traps
// 1. Using nums[right] instead of nums[mid] in else branch — WRONG
//    nums[mid] is the candidate, not nums[right]
//
// 2. Using high = mid - 1 in else branch — WRONG
//    mid itself could be the minimum, skipping it gives wrong answer
//
// 3. Using if / if instead of if / else — WRONG
//    both branches can run in same iteration, corrupting the window
//
// 4. Condition nums[mid] <= nums[high] in else — misleading
//    when first branch is false, else is always correct, no extra check needed


// MARK: - Tests

print("── Brute Force ──")
print(minNumberBruteForce([3, 4, 5, 1, 2]))        // 1
print(minNumberBruteForce([4, 5, 6, 7, 0, 1, 2]))  // 0
print(minNumberBruteForce([1]))                     // 1
print(minNumberBruteForce([2, 1]))                  // 1
print(minNumberBruteForce([1, 2, 3, 4, 5]))         // 1 — not rotated

print()
print("── Optimised ──")
print(minNumberOptimised([3, 4, 5, 1, 2]))          // 1
print(minNumberOptimised([4, 5, 6, 7, 0, 1, 2]))    // 0
print(minNumberOptimised([1]))                       // 1
print(minNumberOptimised([2, 1]))                    // 1
print(minNumberOptimised([1, 2, 3, 4, 5]))           // 1 — not rotated
