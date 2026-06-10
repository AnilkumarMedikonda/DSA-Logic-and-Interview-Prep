import UIKit

// ============================================================
// MARK: - Problem
// ============================================================
// LC 33 — Search In Rotated Sorted Array
// Given a rotated sorted array nums and a target,
// return the index of target. If not found return -1.
//
// Example 1: nums=[4,5,6,7,0,1,2], target=0  → 4
// Example 2: nums=[4,5,6,7,0,1,2], target=3  → -1
// Example 3: nums=[1],             target=0  → -1
//
// Constraints:
// - Array was sorted then rotated at unknown pivot
// - All elements unique
// - Must solve in O(log n)
// ============================================================


// ============================================================
// MARK: - Interview Q&A
// ============================================================
// Q1: What is a rotated sorted array?
// A:  Original: [0,1,2,4,5,6,7]
//     Rotated:  [4,5,6,7,0,1,2] → cut at pivot and rearranged
//     One part moved to front, rest stays behind.
//
// Q2: Why can we still use binary search?
// A:  Even after rotation, ONE half is always sorted.
//     We identify the sorted half and check if target is there.
//     If yes → search that half. If no → search other half.
//
// Q3: How do we identify which half is sorted?
// A:  if nums[low] <= nums[mid] → LEFT half is sorted
//     else                      → RIGHT half is sorted
//
// Q4: How do we check if target is in sorted half?
// A:  Left sorted:  nums[low] <= target < nums[mid]
//     Right sorted: nums[mid] < target <= nums[high]
//
// Q5: What is time and space complexity?
// A:  Brute     → Time O(n),     Space O(1)
//     Optimised → Time O(log n), Space O(1)
//
// Q6: What changes for LC 81 (with duplicates)?
// A:  When nums[low] == nums[mid] == nums[high]
//     Can't determine sorted half → low++, high--
//     Worst case becomes O(n)
// ============================================================


// ============================================================
// MARK: - Brute Force
// ============================================================
// Approach: Linear scan
// Time:  O(n)
// Space: O(1)
// ============================================================

func searchBrute(_ nums: [Int], _ target: Int) -> Int {

    for (index, num) in nums.enumerated() {
        if num == target {
            return index
        }
    }

    return -1
}

// ============================================================
// MARK: - Optimised
// ============================================================
// Approach: Modified binary search
//   At each step identify sorted half
//   Check if target is in sorted half
//   Search accordingly
// Time:  O(log n)
// Space: O(1)
// ============================================================

func searchOptimised(_ nums: [Int], _ target: Int) -> Int {

    var low = 0
    var high = nums.count - 1

    while low <= high {

        let mid = (low + high) / 2

        if nums[mid] == target { return mid }

        // LEFT half is sorted
        if nums[low] <= nums[mid] {
            if nums[low] <= target && target < nums[mid] {
                high = mid - 1   // target in left → go LEFT
            } else {
                low = mid + 1    // target not in left → go RIGHT
            }
        // RIGHT half is sorted
        } else {
            if nums[mid] < target && target <= nums[high] {
                low = mid + 1    // target in right → go RIGHT
            } else {
                high = mid - 1   // target not in right → go LEFT
            }
        }
    }
    return -1
}


// ============================================================
// MARK: - Dry Run
// ============================================================
// nums = [4, 5, 6, 7, 0, 1, 2], target = 0
//
// low=0  high=6
//
// Step 1:
//   mid=3, nums[3]=7
//   nums[low]=4 <= nums[mid]=7 → LEFT sorted
//   target=0 in [4..7]? NO → low = 4
//
// Step 2:
//   low=4  high=6  mid=5
//   nums[5]=1
//   nums[low]=0 <= nums[mid]=1 → LEFT sorted
//   target=0 in [0..1]? YES → high = 4
//
// Step 3:
//   low=4  high=4  mid=4
//   nums[4]=0 == target=0 → return 4 ✅
//
// ─────────────────────────────────────────
// nums = [6, 7, 0, 1, 2, 4, 5], target = 4
//
// low=0  high=6
//
// Step 1:
//   mid=3, nums[3]=1
//   nums[low]=6 <= nums[mid]=1? NO → RIGHT sorted
//   target=4 in [1..5]? YES → low = 4
//
// Step 2:
//   low=4  high=6  mid=5
//   nums[5]=4 == target=4 → return 5 ✅
// ============================================================

// ============================================================
// MARK: - Complexity
// ============================================================
// Brute Force:
//   Time  — O(n)      → linear scan
//   Space — O(1)      → no extra space
//
// Optimised:
//   Time  — O(log n)  → half eliminated each step
//   Space — O(1)      → only 3 variables
// ============================================================


// ============================================================
// MARK: - Traps
// ============================================================
// Trap 1: Using regular binary search without rotation check
//         → wrong answer for rotated arrays
//
// Trap 2: go RIGHT → low = mid - 1 (wrong!)
//         Always: go RIGHT → low = mid + 1
//                 go LEFT  → high = mid - 1
//
// Trap 3: Flipping directions in right sorted half
//         → target in right → go RIGHT (low = mid + 1)
//         → target not in right → go LEFT (high = mid - 1)
//
// Trap 4: Using if instead of else if for sorted half check
//         → both blocks run, corrupting low/high
// ============================================================


// ============================================================
// MARK: - Tests
// ============================================================

let test1 = [4, 5, 6, 7, 0, 1, 2]; let t1 = 0   // Expected: 4
let test2 = [4, 5, 6, 7, 0, 1, 2]; let t2 = 3   // Expected: -1
let test3 = [1];                    let t3 = 0   // Expected: -1
let test4 = [1];                    let t4 = 1   // Expected: 0
let test5 = [6, 7, 0, 1, 2, 4, 5]; let t5 = 4   // Expected: 5
let test6 = [3, 1];                 let t6 = 1   // Expected: 1

print("=== Brute Force ===")
print(searchBrute(test1, t1))   // 4
print(searchBrute(test2, t2))   // -1
print(searchBrute(test3, t3))   // -1
print(searchBrute(test4, t4))   // 0
print(searchBrute(test5, t5))   // 5
print(searchBrute(test6, t6))   // 1

print("=== Optimised ===")
print(searchOptimised(test1, t1))   // 4
print(searchOptimised(test2, t2))   // -1
print(searchOptimised(test3, t3))   // -1
print(searchOptimised(test4, t4))   // 0
print(searchOptimised(test5, t5))   // 5
print(searchOptimised(test6, t6))   // 1
