import UIKit

// ============================================================
// LC 162 — Find Peak Element
// Difficulty : Medium
// Pattern    : Binary Search — Slope Based
// File       : 67_Find_Peak_Element
// Frequency  : ★★★★☆ — High (Google favourite)
// ============================================================


// MARK: - Problem
// A peak element is strictly greater than its neighbours.
// Given an array, return the index of any peak element.
//
// Constraints:
//   nums[-1] = -∞  (imaginary left boundary)
//   nums[n]  = -∞  (imaginary right boundary)
//   Peak is always guaranteed to exist.
//
// Example:
//   Input : [1, 2, 3, 1]
//   Output: 2  (nums[2] = 3)
//
//   Input : [1, 2, 1, 3, 5, 6, 4]
//   Output: 1 or 5  (any peak index valid)


// MARK: - Interview Q&A
// Q: What is the brute force approach?
// A: Linear scan — track index of maximum element. T: O(n) S: O(1)
//    Maximum element is always a valid peak.
//
// Q: What is the optimised approach?
// A: Binary search based on slope direction. T: O(log n) S: O(1)
//
// Q: How does binary search work here — array is not fully sorted?
// A: We don't need full sorted order. We follow the slope:
//    Rising slope → peak is to the right
//    Falling slope → peak is at mid or to the left
//
// Q: What is the condition at mid?
// A: nums[mid] < nums[mid+1] → rising → left = mid + 1
//    nums[mid] > nums[mid+1] → falling → right = mid
//
// Q: Why right = mid and not right = mid - 1?
// A: mid itself could be the peak. mid - 1 would skip it.
//
// Q: Why while left < right and not left <= right?
// A: When left == right == last index, mid+1 goes out of bounds.
//    left < right guarantees mid+1 is always a valid index.
//
// Q: What do we return?
// A: return left — when loop ends, left == right == peak index.
//
// Q: Why is peak always guaranteed?
// A: Boundaries are imaginary -∞, so array must rise and fall.
//    Any rising slope always leads to a peak eventually.
//
// Q: Is this peak the global maximum?
// A: Not necessarily. Any local peak is a valid answer.


// MARK: - Brute Force
// T: O(n)  S: O(1)
// Linear scan — return index of maximum element.
// Maximum is always a valid peak.

func bruteForecePeakElmenst(_ nums: [Int]) -> Int {
    var peakIndex = 0
    for i in 0..<nums.count {
        if nums[i] > nums[peakIndex] {
            peakIndex = i
        }
    }
    return peakIndex
}


// MARK: - Optimised — Binary Search (Slope Based)
// T: O(log n)  S: O(1)
//
// Key insight:
//   At any mid, check the slope direction:
//   Rising  → nums[mid] < nums[mid+1] → peak is to the RIGHT → left = mid + 1
//   Falling → nums[mid] > nums[mid+1] → peak at mid or LEFT  → right = mid
//
// Loop ends when left == right → that index is the peak.

func optmisedePeakIndex(_ nums: [Int]) -> Int {
    var left = 0
    var right = nums.count - 1

    while left < right {
        let mid = (left + right) / 2

        if nums[mid] < nums[mid + 1] {
            // Rising slope — peak lies to the right
            left = mid + 1
        } else {
            // Falling slope — peak at mid or to the left
            right = mid
        }
    }

    return left
}


// MARK: - Dry Run
// Input: [1, 2, 3, 1]
//
// left=0  right=3  mid=1
// nums[1]=2  nums[2]=3
// 2 < 3 → rising → left = 2
//
// left=2  right=3  mid=2
// nums[2]=3  nums[3]=1
// 3 > 1 → falling → right = 2
//
// left=2  right=2 → loop ends
// return 2 ✅  (nums[2] = 3)
//
// ─────────────────────────────────────
// Input: [1, 2, 1, 3, 5, 6, 4]
//
// left=0  right=6  mid=3
// nums[3]=3  nums[4]=5
// 3 < 5 → rising → left = 4
//
// left=4  right=6  mid=5
// nums[5]=6  nums[6]=4
// 6 > 4 → falling → right = 5
//
// left=4  right=5  mid=4
// nums[4]=5  nums[5]=6
// 5 < 6 → rising → left = 5
//
// left=5  right=5 → loop ends
// return 5 ✅  (nums[5] = 6)


// MARK: - Complexity
// ┌─────────────┬───────────┬───────────┐
// │             │   Time    │   Space   │
// ├─────────────┼───────────┼───────────┤
// │ Brute Force │   O(n)    │   O(1)    │
// │ Optimised   │ O(log n)  │   O(1)    │
// └─────────────┴───────────┴───────────┘


// MARK: - Traps
// 1. while left <= right → mid+1 out of bounds when left==right==last index
//    Always use while left < right
//
// 2. right = mid - 1 in else branch → skips mid itself which could be peak
//    Always use right = mid
//
// 3. Returning peakIndex that was never updated → always returns 0
//    Return left at the end
//
// 4. Tracking peakIndex manually inside loop — unnecessary
//    left == right at loop end IS the peak index


// MARK: - Tests

var nums  = [1, 2, 3, 1]
var nums2 = [1, 2, 1, 3, 5, 6, 4]
var nums3 = [1]
var nums4 = [2, 1]

print("── Brute Force ──")
print(bruteForecePeakElmenst(nums))   // 2
print(bruteForecePeakElmenst(nums2))  // 5
print(bruteForecePeakElmenst(nums3))  // 0
print(bruteForecePeakElmenst(nums4))  // 0

print()
print("── Optimised ──")
print(optmisedePeakIndex(nums))       // 2
print(optmisedePeakIndex(nums2))      // 5
print(optmisedePeakIndex(nums3))      // 0
print(optmisedePeakIndex(nums4))      // 0
