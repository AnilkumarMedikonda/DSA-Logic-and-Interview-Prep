import Foundation

// ──────────────────────────────────────────
// LeetCode 2161 — Partition Array Around Pivot
// Difficulty: Medium  |  Pattern: Two Pointers
// Also known as: Dutch National Flag variant
// ──────────────────────────────────────────

// MARK: - Problem

/*
 Rearrange array so elements less than pivot come first,
 equal in middle, greater at end. Order within groups doesn't matter.

 Input:  [9, 12, 5, 10, 14, 3, 10]  pivot = 10
 Output: [9, 5, 3, 10, 10, 12, 14]

 Input:  [3, 1, 2]  pivot = 2
 Output: [1, 3, 2]  or any valid partition
*/

// MARK: - Interview Q&A

/*
 Q: How is this different from Sort Colors?
 A: Same structure — just replace 0/1/2 with < pivot / == pivot / > pivot

 Q: Why mid stays after swap with high?
 A: Element from high is unseen — must check it again

 Q: Why mid moves after swap with low?
 A: Element from low is already seen — safe to move forward

 Q: Time and space?
 A: O(n) time — single pass | O(1) space — in-place
*/

// MARK: - Helper — isValidPartition

/*
 Order within each group doesn't matter — so we can't do exact match.
 Instead validate the structure:
   - no less element appears after a pivot or greater
   - no pivot element appears after a greater

 Walk left to right tracking two flags:
   seenPivot   → true once we hit an == pivot element
   seenGreater → true once we hit a  >  pivot element

 If less appears after seenPivot or seenGreater  → invalid
 If equal appears after seenGreater              → invalid
*/

func isValidPartition(_ nums: [Int], pivot: Int) -> Bool {

    var seenPivot   = false
    var seenGreater = false

    for num in nums {

        if num < pivot  { if seenPivot || seenGreater { return false } }

        if num == pivot { seenPivot = true;  if seenGreater { return false } }

        if num > pivot  { seenGreater = true }
    }

    return true
}

// MARK: - Brute Force  O(n) time  O(n) space

/*
 Strategy:
 - Collect less than pivot    → less
 - Collect equal to pivot     → equal
 - Collect greater than pivot → greater
 - Combine less + equal + greater

 INTERVIEW: Start here, explain before coding
*/

func bruteForce(_ nums: inout [Int], pivot: Int) {

    var less    = [Int]()
    var equal   = [Int]()
    var greater = [Int]()

    for num in nums {
        if num < pivot       { less.append(num)    }
        else if num == pivot { equal.append(num)   }
        else                 { greater.append(num) }
    }

    nums = less + equal + greater
}

// MARK: - Optimal ⭐️  O(n) time  O(1) space

/*
 Strategy:
 - low = 0, mid = 0, high = end
 - nums[mid] < pivot  → swap(mid, low)  low++  mid++
 - nums[mid] == pivot → mid++
 - nums[mid] > pivot  → swap(mid, high)  high--  (mid stays)

 INTERVIEW: Identical structure to Sort Colors
 INTERVIEW: mid stays after swap with high — unseen element must be rechecked
 INTERVIEW: mid moves after swap with low  — element from low already seen
*/

func optimised(_ nums: inout [Int], pivot: Int) {

    var low  = 0
    var mid  = 0
    var high = nums.count - 1

    while mid <= high {

        if nums[mid] < pivot {
            nums.swapAt(mid, low)
            low += 1
            mid += 1
        } else if nums[mid] == pivot {
            mid += 1
        } else {
            nums.swapAt(high, mid)
            high -= 1
        }
    }
}

// MARK: - Tests

let tests: [(nums: [Int], pivot: Int)] = [
    ([9, 12, 5, 10, 14, 3, 10], 10),
    ([3, 1, 2],                  2),
    ([1, 2, 3],                  2),
    ([2, 2, 2],                  2),
    ([5],                        5),
    ([1, 3, 2, 4],               3)
]

print("--- Brute Force ---")
for (i, t) in tests.enumerated() {
    var input = t.nums
    bruteForce(&input, pivot: t.pivot)
    let valid = isValidPartition(input, pivot: t.pivot)
    print("Test \(i+1): \(valid ? "✅" : "❌") | Got: \(input)")
}

print("\n--- Optimal ⭐️ ---")
for (i, t) in tests.enumerated() {
    var input = t.nums
    optimised(&input, pivot: t.pivot)
    let valid = isValidPartition(input, pivot: t.pivot)
    print("Test \(i+1): \(valid ? "✅" : "❌") | Got: \(input)")
}
