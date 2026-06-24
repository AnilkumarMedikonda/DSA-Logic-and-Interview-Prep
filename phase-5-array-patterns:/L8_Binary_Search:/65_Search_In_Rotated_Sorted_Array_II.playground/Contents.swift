import UIKit

// ============================================================
// MARK: - Problem
// ============================================================
// LC 81 — Search In Rotated Sorted Array II
// Given a rotated sorted array nums with duplicates and a
// target, return true if target exists, false otherwise.
//
// Example 1: nums=[2,5,6,0,0,1,2], target=0  → true
// Example 2: nums=[2,5,6,0,0,1,2], target=3  → false
// Example 3: nums=[1,0,1,1,1],     target=0  → true
//
// Constraints:
// - Array was sorted then rotated at unknown pivot
// - Array CAN have duplicates
// - Return true/false not index
// ============================================================


// ============================================================
// MARK: - Interview Q&A
// ============================================================
// Q1: What is the only difference from LC 33?
// A:  LC 33 → unique elements, return index
//     LC 81 → duplicates allowed, return true/false
//     One extra condition: when nums[low]==nums[mid]==nums[high]
//     → can't determine sorted half → shrink both sides
//
// Q2: Why does duplicate cause a problem?
// A:  nums = [1,0,1,1,1], low=0, mid=2, high=4
//     nums[low]=1, nums[mid]=1, nums[high]=1 → all equal
//     Can't tell if left [1,0,1] or right [1,1,1] is sorted
//     → must shrink: low++, high--
//
// Q3: Why worst case becomes O(n) with duplicates?
// A:  In worst case all elements same e.g. [1,1,1,1,1]
//     Every iteration just does low++, high--
//     → n iterations → O(n)
//
// Q4: What is average case complexity?
// A:  O(log n) — duplicates at pivot are rare in practice
//     Only degrades to O(n) when many duplicates at boundaries
//
// Q5: Why return Bool instead of index?
// A:  With duplicates, multiple valid indices exist.
//     Problem only asks if target exists, not where.
// ============================================================


// ============================================================
// MARK: - Brute Force
// ============================================================
// Approach: Linear scan
// Time:  O(n)
// Space: O(1)
// ============================================================

func searchBrute(_ nums: [Int], _ target: Int) -> Bool {

    for num in nums {
        if num == target {
            return true
        }
    }

    return false
}


// ============================================================
// MARK: - Optimised
// ============================================================
// Approach: Modified binary search with duplicate handling
//   Extra check: nums[low]==nums[mid]==nums[high] → shrink
//   Rest is identical to LC 33
// Time:  O(log n) average, O(n) worst case
// Space: O(1)
// ============================================================

func searchOptimised(_ nums: [Int], _ target: Int) -> Bool {

    var low = 0
    var high = nums.count - 1

    while low <= high {

        let mid = (low + high) / 2

        if nums[mid] == target { return true }

        // handle duplicates — can't determine sorted half
        if nums[low] == nums[mid] && nums[mid] == nums[high] {
            low += 1
            high -= 1

        // LEFT half is sorted
        } else if nums[low] <= nums[mid] {
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

    return false
}


// ============================================================
// MARK: - Dry Run
// ============================================================
// nums = [1, 0, 1, 1, 1], target = 0
//
// low=0  high=4
//
// Step 1:
//   mid=2, nums[2]=1
//   nums[low]=1 == nums[mid]=1 == nums[high]=1 → DUPLICATE
//   low=1, high=3
//
// Step 2:
//   low=1  high=3  mid=2
//   nums[2]=1
//   nums[low]=0 <= nums[mid]=1 → LEFT sorted
//   target=0 in [0..1]? YES → high = mid-1 = 1
//
// Step 3:
//   low=1  high=1  mid=1
//   nums[1]=0 == target=0 → return true ✅
//
// ─────────────────────────────────────────
// nums = [2,5,6,0,0,1,2], target = 3
//
// low=0  high=6
//
// Step 1:
//   mid=3, nums[3]=0
//   nums[low]=2 <= nums[mid]=0? NO → RIGHT sorted
//   target=3 in [0..2]? NO → high = mid-1 = 2
//
// Step 2:
//   low=0  high=2  mid=1
//   nums[1]=5
//   nums[low]=2 <= nums[mid]=5 → LEFT sorted
//   target=3 in [2..5]? YES → high = mid-1 = 0
//
// Step 3:
//   low=0  high=0  mid=0
//   nums[0]=2
//   nums[low]=2 <= nums[mid]=2 → LEFT sorted
//   target=3 in [2..2]? NO → low = mid+1 = 1
//
// low=1 > high=0 → exit
// return false ✅
// ============================================================


// ============================================================
// MARK: - LC 33 vs LC 81
// ============================================================
// LC 33 (unique):
//   if nums[low] <= nums[mid] → left sorted
//   else → right sorted
//
// LC 81 (duplicates) — adds ONE extra check:
//   if nums[low] == nums[mid] == nums[high] → shrink
//   else if nums[low] <= nums[mid] → left sorted
//   else → right sorted
// ============================================================


// ============================================================
// MARK: - Complexity
// ============================================================
// Brute Force:
//   Time  — O(n)      → linear scan
//   Space — O(1)      → no extra space
//
// Optimised:
//   Time  — O(log n) average → binary search
//           O(n) worst case  → all duplicates [1,1,1,1,1]
//   Space — O(1)             → only 3 variables
// ============================================================


// ============================================================
// MARK: - Traps
// ============================================================
// Trap 1: Skipping duplicate check
//         → infinite loop or wrong answer on [1,0,1,1,1]
//
// Trap 2: Only checking nums[low]==nums[mid] (missing nums[high])
//         → incomplete duplicate detection
//
// Trap 3: Claiming O(log n) always
//         → worst case is O(n) with all duplicates
//
// Trap 4: Swapping go LEFT / go RIGHT directions
//         → go RIGHT: low = mid + 1
//         → go LEFT:  high = mid - 1
// ============================================================


// ============================================================
// MARK: - Tests
// ============================================================

let test1 = [2, 5, 6, 0, 0, 1, 2]; let t1 = 0   // Expected: true
let test2 = [2, 5, 6, 0, 0, 1, 2]; let t2 = 3   // Expected: false
let test3 = [1, 0, 1, 1, 1];       let t3 = 0   // Expected: true
let test4 = [1, 1, 1, 1, 1];       let t4 = 2   // Expected: false
let test5 = [1];                    let t5 = 1   // Expected: true
let test6 = [2, 2, 2, 0, 2, 2];    let t6 = 0   // Expected: true

print("=== Brute Force ===")
print(searchBrute(test1, t1))   // true
print(searchBrute(test2, t2))   // false
print(searchBrute(test3, t3))   // true
print(searchBrute(test4, t4))   // false
print(searchBrute(test5, t5))   // true
print(searchBrute(test6, t6))   // true

print("=== Optimised ===")
print(searchOptimised(test1, t1))   // true
print(searchOptimised(test2, t2))   // false
print(searchOptimised(test3, t3))   // true
print(searchOptimised(test4, t4))   // false
print(searchOptimised(test5, t5))   // true
print(searchOptimised(test6, t6))   // true
