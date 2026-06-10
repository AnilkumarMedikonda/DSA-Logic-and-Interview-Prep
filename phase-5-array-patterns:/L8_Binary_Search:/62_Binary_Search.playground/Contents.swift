import UIKit

// ============================================================
// MARK: - Problem
// ============================================================
// LC 704 — Binary Search
// Given an array of integers nums sorted in ascending order
// and an integer target, return the index of target.
// If target does not exist, return -1.
//
// Example 1: nums=[-1,0,3,5,9,12], target=9  → 4
// Example 2: nums=[-1,0,3,5,9,12], target=2  → -1
//
// Constraints:
// - Array is sorted ascending
// - All elements unique
// - 1 <= nums.count <= 10000
// ============================================================


// ============================================================
// MARK: - Interview Q&A
// ============================================================
// Q1: Why binary search over linear search?
// A:  Linear → O(n) checks every element
//     Binary → O(log n) eliminates half search space each step
//     For n=1000000 → linear=1000000 steps, binary=20 steps
//
// Q2: Why low <= high not low < high?
// A:  When low == high, one element remains unchecked.
//     low <= high ensures that element is checked too.
//     low < high would miss the last element.
//
// Q3: Why mid = (low + high) / 2?
// A:  Finds middle index of current search space.
//     In Swift Int overflow isn't an issue but safe form is:
//     mid = low + (high - low) / 2
//
// Q4: Why low = mid + 1 not low = mid?
// A:  nums[mid] already checked — not target.
//     Starting from mid again would cause infinite loop.
//     mid + 1 skips the checked element.
//
// Q5: What are the 3 approaches?
// A:  1. Iterative low <= high  → O(1) space ✅ Best
//     2. Iterative low < high   → O(1) space, tricky
//     3. Recursive              → O(log n) space, call stack
//
// Q6: When does binary search apply?
// A:  Array must be SORTED. If unsorted → sort first O(n log n)
//     or use linear search O(n).
// ============================================================


// ============================================================
// MARK: - Brute Force
// ============================================================
// Approach: Linear scan — check every element
// Time:  O(n)
// Space: O(1)
// ============================================================

func linearSearch(_ nums: [Int], _ target: Int) -> Int {

    for (index, num) in nums.enumerated() {
        if num == target {
            return index
        }
    }

    return -1
}


// ============================================================
// MARK: - Optimised — Iterative
// ============================================================
// Approach: Binary search — eliminate half each step
// Time:  O(log n)
// Space: O(1)
// ============================================================

func binarySearch(_ nums: [Int], _ target: Int) -> Int {

    var low = 0
    var high = nums.count - 1

    while low <= high {

        let mid = (low + high) / 2

        if nums[mid] == target {
            return mid
        } else if nums[mid] < target {
            low = mid + 1    // target on right side
        } else {
            high = mid - 1   // target on left side
        }
    }

    return -1
}


// ============================================================
// MARK: - Approach 3 — Recursive
// ============================================================
// Time:  O(log n)
// Space: O(log n) → call stack
// ============================================================

func binarySearchRecursive(_ nums: [Int], _ target: Int, _ low: Int, _ high: Int) -> Int {

    // base case — not found
    if low > high {
        return -1
    }

    let mid = (low + high) / 2

    if nums[mid] == target {
        return mid
    } else if nums[mid] < target {
        return binarySearchRecursive(nums, target, mid + 1, high)
    } else {
        return binarySearchRecursive(nums, target, low, mid - 1)
    }
}


// ============================================================
// MARK: - Dry Run
// ============================================================
// nums = [-1, 0, 3, 5, 9, 12], target = 9
//
// low=0  high=5
//
// Step 1:
//   mid = (0+5)/2 = 2
//   nums[2] = 3
//   3 < 9 → go RIGHT → low = 3
//
// Step 2:
//   mid = (3+5)/2 = 4
//   nums[4] = 9
//   9 == 9 → return 4 ✅
//
// ─────────────────────────────────────────
// nums = [-1, 0, 3, 5, 9, 12], target = 2
//
// low=0  high=5
//
// Step 1:
//   mid=2, nums[2]=3, 3>2 → go LEFT → high=1
//
// Step 2:
//   mid=0, nums[0]=-1, -1<2 → go RIGHT → low=1
//
// Step 3:
//   mid=1, nums[1]=0, 0<2 → go RIGHT → low=2
//
// Step 4:
//   low=2 > high=1 → exit loop
//   return -1 ✅
// ============================================================


// ============================================================
// MARK: - Complexity
// ============================================================
// Brute Force:
//   Time  — O(n)      → linear scan
//   Space — O(1)      → no extra space
//
// Optimised Iterative:
//   Time  — O(log n)  → half eliminated each step
//   Space — O(1)      → only 3 variables
//
// Recursive:
//   Time  — O(log n)  → half eliminated each step
//   Space — O(log n)  → call stack depth
// ============================================================


// ============================================================
// MARK: - Traps
// ============================================================
// Trap 1: low < high instead of low <= high
//         → misses single element case
//
// Trap 2: low = mid instead of low = mid + 1
//         → infinite loop when low == mid
//
// Trap 3: mid = (low + high) / 2 overflow in other languages
//         → use mid = low + (high - low) / 2 to be safe
//
// Trap 4: Applying binary search on unsorted array
//         → wrong answer, must be sorted first
// ============================================================


// ============================================================
// MARK: - Tests
// ============================================================

let test1 = [-1, 0, 3, 5, 9, 12]; let t1 = 9    // Expected: 4
let test2 = [-1, 0, 3, 5, 9, 12]; let t2 = 2    // Expected: -1
let test3 = [5];                   let t3 = 5    // Expected: 0
let test4 = [5];                   let t4 = 3    // Expected: -1
let test5 = [1, 2, 3, 4, 5];      let t5 = 1    // Expected: 0
let test6 = [1, 2, 3, 4, 5];      let t6 = 5    // Expected: 4

print("=== Brute Force ===")
print(linearSearch(test1, t1))   // 4
print(linearSearch(test2, t2))   // -1
print(linearSearch(test3, t3))   // 0
print(linearSearch(test4, t4))   // -1
print(linearSearch(test5, t5))   // 0
print(linearSearch(test6, t6))   // 4

print("=== Optimised Iterative ===")
print(binarySearch(test1, t1))   // 4
print(binarySearch(test2, t2))   // -1
print(binarySearch(test3, t3))   // 0
print(binarySearch(test4, t4))   // -1
print(binarySearch(test5, t5))   // 0
print(binarySearch(test6, t6))   // 4

print("=== Recursive ===")
print(binarySearchRecursive(test1, t1, 0, test1.count - 1))   // 4
print(binarySearchRecursive(test2, t2, 0, test2.count - 1))   // -1
print(binarySearchRecursive(test3, t3, 0, test3.count - 1))   // 0
print(binarySearchRecursive(test4, t4, 0, test4.count - 1))   // -1
print(binarySearchRecursive(test5, t5, 0, test5.count - 1))   // 0
print(binarySearchRecursive(test6, t6, 0, test6.count - 1))   // 4
