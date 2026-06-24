import UIKit

// ============================================================
// MARK: - Problem
// ============================================================
// LC 34 — Find First And Last Position of Element in Sorted Array
// Given an array of integers nums sorted in ascending order,
// find the starting and ending position of a given target.
// If target is not found, return [-1, -1].
//
// Example 1: nums=[5,7,7,8,8,10], target=8  → [3, 4]
// Example 2: nums=[5,7,7,8,8,10], target=6  → [-1, -1]
// Example 3: nums=[],             target=0  → [-1, -1]
//
// Constraints:
// - Array is sorted ascending
// - Array can have duplicates
// - Must solve in O(log n)
// ============================================================


// ============================================================
// MARK: - Interview Q&A
// ============================================================
// Q1: Why two separate binary searches?
// A:  Finding first → go LEFT when found (high = mid - 1)
//     Finding last  → go RIGHT when found (low = mid + 1)
//     Can't do both directions in one loop — needs two passes.
//
// Q2: Why save result and continue instead of returning immediately?
// A:  When nums[mid] == target, we don't stop.
//     We save the index and keep searching for earlier/later occurrence.
//     Returning immediately gives ANY occurrence, not first/last.
//
// Q3: Why is one loop approach O(n) worst case?
// A:  Find any occurrence via binary search O(log n), then
//     expand left/right linearly → O(n) for [8,8,8,8,8,8].
//     Two binary searches guarantee O(log n) always.
//
// Q4: What is time and space complexity?
// A:  Brute  → Time O(n),     Space O(1)
//     Optimised → Time O(log n), Space O(1)
//
// Q5: Key difference between findFirst and findLast?
// A:  findFirst → nums[mid]==target → save, go LEFT  (high = mid-1)
//     findLast  → nums[mid]==target → save, go RIGHT (low  = mid+1)
//     Everything else is identical!
// ============================================================


// ============================================================
// MARK: - Brute Force
// ============================================================
// Approach: Linear scan — track first and last occurrence
// Time:  O(n)
// Space: O(1)
// ============================================================

func findFirstAndLastBrute(_ nums: [Int], _ target: Int) -> [Int] {

    var firstIndex: Int?
    var lastIndex: Int?

    for i in 0..<nums.count {
        if nums[i] == target {
            firstIndex = firstIndex == nil ? i : firstIndex
            lastIndex = i
        }
    }

    return [firstIndex ?? -1, lastIndex ?? -1]
}


// ============================================================
// MARK: - Optimised
// ============================================================
// Approach: Two binary searches
//   findFirst → when found, go LEFT  (high = mid - 1)
//   findLast  → when found, go RIGHT (low  = mid + 1)
// Time:  O(log n)
// Space: O(1)
// ============================================================

func findFirstOccurrence(_ nums: [Int], _ target: Int) -> Int {

    var result = -1
    var low = 0
    var high = nums.count - 1

    while low <= high {
        let mid = (low + high) / 2

        if nums[mid] == target {
            result = mid
            high = mid - 1   // go LEFT for earlier occurrence
        } else if nums[mid] < target {
            low = mid + 1
        } else {
            high = mid - 1
        }
    }

    return result
}

func findLastOccurrence(_ nums: [Int], _ target: Int) -> Int {

    var result = -1
    var low = 0
    var high = nums.count - 1

    while low <= high {
        let mid = (low + high) / 2

        if nums[mid] == target {
            result = mid
            low = mid + 1    // go RIGHT for later occurrence
        } else if nums[mid] < target {
            low = mid + 1
        } else {
            high = mid - 1
        }
    }

    return result
}

func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
    return [findFirstOccurrence(nums, target),
            findLastOccurrence(nums, target)]
}


// ============================================================
// MARK: - Dry Run
// ============================================================
// nums = [5, 7, 7, 8, 8, 10], target = 8
//
// findFirst:
// low=0  high=5
//
// Step 1: mid=2, nums[2]=7, 7<8 → low=3
// Step 2: mid=4, nums[4]=8 → result=4, high=3
// Step 3: mid=3, nums[3]=8 → result=3, high=2
// Step 4: low=3 > high=2 → exit
// return 3 ✅
//
// findLast:
// low=0  high=5
//
// Step 1: mid=2, nums[2]=7, 7<8 → low=3
// Step 2: mid=4, nums[4]=8 → result=4, low=5
// Step 3: mid=5, nums[5]=10, 10>8 → high=4
// Step 4: low=5 > high=4 → exit
// return 4 ✅
//
// Answer: [3, 4] ✅
// ============================================================


// ============================================================
// MARK: - Complexity
// ============================================================
// Brute Force:
//   Time  — O(n)      → linear scan
//   Space — O(1)      → no extra space
//
// Optimised:
//   Time  — O(log n)  → two binary searches
//   Space — O(1)      → only 3 variables each
// ============================================================


// ============================================================
// MARK: - Traps
// ============================================================
// Trap 1: Returning immediately when target found
//         → gives any occurrence, not first/last
//
// Trap 2: Using low = mid - 1 in findLast
//         → goes wrong direction, finds first not last
//
// Trap 3: One loop approach
//         → O(n) worst case for arrays like [8,8,8,8,8]
//
// Trap 4: Not handling empty array
//         → nums.count - 1 = -1, while low<=high fails safely ✅
// ============================================================


// ============================================================
// MARK: - Tests
// ============================================================

let test1 = [5, 7, 7, 8, 8, 10]; let t1 = 8   // Expected: [3, 4]
let test2 = [5, 7, 7, 8, 8, 10]; let t2 = 6   // Expected: [-1, -1]
let test3: [Int] = [];            let t3 = 0   // Expected: [-1, -1]
let test4 = [1];                  let t4 = 1   // Expected: [0, 0]
let test5 = [8, 8, 8, 8, 8];     let t5 = 8   // Expected: [0, 4]
let test6 = [1, 2, 3, 4, 5];     let t6 = 3   // Expected: [2, 2]

print("=== Brute Force ===")
print(findFirstAndLastBrute(test1, t1))   // [3, 4]
print(findFirstAndLastBrute(test2, t2))   // [-1, -1]
print(findFirstAndLastBrute(test3, t3))   // [-1, -1]
print(findFirstAndLastBrute(test4, t4))   // [0, 0]
print(findFirstAndLastBrute(test5, t5))   // [0, 4]
print(findFirstAndLastBrute(test6, t6))   // [2, 2]

print("=== Optimised ===")
print(searchRange(test1, t1))   // [3, 4]
print(searchRange(test2, t2))   // [-1, -1]
print(searchRange(test3, t3))   // [-1, -1]
print(searchRange(test4, t4))   // [0, 0]
print(searchRange(test5, t5))   // [0, 4]
print(searchRange(test6, t6))   // [2, 2]
