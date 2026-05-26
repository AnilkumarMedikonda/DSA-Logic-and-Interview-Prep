import Foundation

// ──────────────────────────────────────────
// LeetCode 75 — Sort Colors
// Difficulty: Medium  |  Pattern: Two Pointers
// Also known as: Dutch National Flag Problem
// ──────────────────────────────────────────

// MARK: - Problem

/*
 Given array with only 0s, 1s, 2s — sort in-place.
 Cannot use built-in sort.

 Input:  [2, 0, 2, 1, 1, 0]
 Output: [0, 0, 1, 1, 2, 2]

 Input:  [2, 0, 1]
 Output: [0, 1, 2]
*/

// MARK: - Interview Q&A

/*
 Q: Why three pointers not two?
 A: low and high only know boundaries — mid scans the unknown zone in between

 Q: Why mid doesn't move when swapping with high?
 A: Element from high is unseen — must check it again next iteration

 Q: Why mid moves when swapping with low?
 A: Element from low is already seen (it was 1) — safe to move forward

 Q: Loop condition — why mid <= high not mid < high?
 A: mid must process the element at high before stopping

 Q: Time and space?
 A: O(n) time — single pass | O(1) space — in-place
*/

// MARK: - Brute Force  O(n) time  O(n) space

/*
 Strategy:
 - Pass 1 → collect all 0s
 - Pass 2 → collect all 1s
 - Pass 3 → collect all 2s

 INTERVIEW: Start here, explain before coding
*/

func bruteForce(_ nums: inout [Int]) {

    var result = [Int]()

    for num in nums { if num == 0 { result.append(num) } }
    for num in nums { if num == 1 { result.append(num) } }
    for num in nums { if num == 2 { result.append(num) } }

    nums = result
}

// MARK: - Optimal ⭐️  O(n) time  O(1) space

/*
 Strategy:
 - low = 0, mid = 0, high = end
 - nums[mid] == 0 → swap(mid, low)  low++  mid++
 - nums[mid] == 1 → mid++
 - nums[mid] == 2 → swap(mid, high)  high--  (mid stays)

 INTERVIEW: mid is the scanner — low and high are destinations
 INTERVIEW: swap first, then move pointers
*/

func optimised(_ nums: inout [Int]) {

    var low  = 0
    var mid  = 0
    var high = nums.count - 1

    while mid <= high {

        if nums[mid] == 0 {
            nums.swapAt(low, mid)
            low += 1
            mid += 1
        } else if nums[mid] == 1 {
            mid += 1
        } else {
            nums.swapAt(high, mid)
            high -= 1
        }
    }
}

// MARK: - Tests

let tests: [([Int], [Int])] = [
    ([2, 0, 2, 1, 1, 0],  [0, 0, 1, 1, 2, 2]),
    ([2, 0, 1],           [0, 1, 2]),
    ([0],                 [0]),
    ([1],                 [1]),
    ([2, 2, 2],           [2, 2, 2]),
    ([0, 0, 0],           [0, 0, 0]),
    ([1, 2, 0],           [0, 1, 2])
]

print("--- Brute Force ---")
for (i, t) in tests.enumerated() {
    var input = t.0
    bruteForce(&input)
    print("Test \(i+1): \(input == t.1 ? "✅" : "❌") | Got: \(input) | Expected: \(t.1)")
}

print("\n--- Optimal ⭐️ ---")
for (i, t) in tests.enumerated() {
    var input = t.0
    optimised(&input)
    print("Test \(i+1): \(input == t.1 ? "✅" : "❌") | Got: \(input) | Expected: \(t.1)")
}

