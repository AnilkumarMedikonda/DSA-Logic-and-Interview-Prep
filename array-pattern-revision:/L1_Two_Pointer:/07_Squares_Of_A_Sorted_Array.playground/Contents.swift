import Foundation

// ──────────────────────────────────────────
// LeetCode 977 — Squares of a Sorted Array
// Difficulty: Easy  |  Pattern: Two Pointers
// ──────────────────────────────────────────

// MARK: - Problem

/*
 Given a sorted array, return array of squares in non-decreasing order.

 Input:  [-4, -1, 0, 3, 10]
 Output: [0, 1, 9, 16, 100]

 Input:  [-7, -3, 2, 3, 11]
 Output: [4, 9, 9, 49, 121]

 Key insight:
 Largest squares always live at the two ends — never in the middle
*/

// MARK: - Interview Q&A

/*
 Q: Why largest squares at the ends?
 A: Sorted array — large negatives square to large positives, large positives stay large. Both ends hold the biggest values.

 Q: Why fill result from the back?
 A: We always place the largest square first — back to front gives ascending order

 Q: Why left <= right not left < right?
 A: left < right skips the last element when both pointers meet

 Q: Why abs() before comparing?
 A: Negative numbers — abs() gives true magnitude before squaring

 Q: Why O(n) not O(n log n)?
 A: Single pass — each element visited exactly once, no sorting needed
*/

// MARK: - Brute Force  O(n log n) time  O(n) space

/*
 Strategy:
 - Square every element
 - Sort the result
 - Return sorted array

 INTERVIEW: Start here, explain before coding
*/

func quickSort(_ nums: [Int]) ->[Int] {
    
    
    if nums.count > 1 {
        
        let pivot = nums[0]
        var less = [Int]()
        var greater = [Int]()
        var equal = [Int]()
        
        for num in nums {
            if num > pivot {
                greater.append(num)
            } else if num < pivot {
                less.append(num)
            } else {
                equal.append(num)
            }
        }
    return  quickSort(less) + equal + quickSort(greater)
    }
    
    
    return nums
}

func bruteForce(_ nums: [Int]) -> [Int] {

    var result = [Int]()
    
    for num in nums {
        result.append(num * num)
    }

    return quickSort(result)
}

// MARK: - Optimal ⭐️  O(n) time  O(n) space

/*
 Strategy:
 - left = 0, right = end, pos = end
 - compare abs(nums[left]) vs abs(nums[right])
 - bigger square → result[pos], move that pointer inward
 - pos-- every step
 - left <= right catches last element

 INTERVIEW: Fill from back — largest goes in first
 INTERVIEW: left <= right not left < right — last element must be placed
*/



func optimised(_ nums: [Int]) -> [Int] {

    var result = Array(repeating: 0, count: nums.count)
    var left   = 0
    var right  = nums.count - 1
    var pos    = nums.count - 1

    while left <= right {

        if abs(nums[left]) > abs(nums[right]) {
            result[pos] = nums[left] * nums[left]
            left += 1
        } else {
            result[pos] = nums[right] * nums[right]
            right -= 1
        }
        pos -= 1
    }

    return result
}

// MARK: - Tests

let tests: [([Int], [Int])] = [
    ([-4, -1, 0, 3, 10],   [0, 1, 9, 16, 100]),
    ([-7, -3, 2, 3, 11],   [4, 9, 9, 49, 121]),
    ([-3, -1, 0, 1, 3],    [0, 1, 1, 9, 9]),
    ([0, 1, 2],            [0, 1, 4]),
    ([-5, -3, -1],         [1, 9, 25])
]

print("--- Brute Force ---")
for (i, t) in tests.enumerated() {
    let r = bruteForce(t.0)
    print("Test \(i+1): \(r == t.1 ? "✅" : "❌") | Got: \(r) | Expected: \(t.1)")
}

print("\n--- Optimal ⭐️ ---")
for (i, t) in tests.enumerated() {
    let r = optimised(t.0)
    print("Test \(i+1): \(r == t.1 ? "✅" : "❌") | Got: \(r) | Expected: \(t.1)")
}

