import UIKit

// ──────────────────────────────────────────
// 77_Max_Consecutive_Ones_III
// LeetCode 1004  |  Difficulty: Medium  |  Pattern: Sliding Window
// ──────────────────────────────────────────

// MARK: - Problem

/*
 Given a binary array nums and integer k, return max consecutive 1's
 if you can flip at most k 0's to 1's.

 Input:  nums = [1,1,1,0,0,0,1,1,1,1,0], k = 2  →  6
 Input:  nums = [0,0,1,1,0,0,1,1,1,0,1,1,0,0,0,1,1,1,1], k = 3  →  10
 Input:  nums = [0,0,0], k = 0  →  0
 Input:  nums = [1,1,1,1], k = 5  →  4

 Key insight:
 zeroCount <= k  → valid window
 zeroCount > k   → invalid, shrink
*/

// MARK: - Interview Q&A

/*
 Q: Why track zeroCount instead of a hashmap?
 A: Only two possible values (0/1) — a single counter is enough,
    no need for frequency map like the character problems

 Q: Why while not if when shrinking?
 A: Unlike maxFreq in LC424, zeroCount can need more than 1 shrink
    step to get back under k — not monotonic the same way

 Q: Time and space?
 A: O(n) time | O(1) space
*/

// MARK: - Brute Force
// T - O(n²)   S - O(1)

func bruteForceMaxConsecutiveOnes(nums: [Int], k: Int) -> Int {

    var maxLength = 0

    for i in 0..<nums.count {

        var zeroCount = 0

        for j in i..<nums.count {

            if nums[j] == 0 {
                zeroCount += 1
            }

            if zeroCount <= k {
                let length = j - i + 1
                maxLength = maxLength > length ? maxLength : length
            } else {
                break
            }
        }
    }

    return maxLength
}

// MARK: - Optimal ⭐️
// T - O(n)   S - O(1)

func optimisedMaxConsecutiveOnes(nums: [Int], k: Int) -> Int {

    var maxLength = 0
    var left = 0
    var zeroCount = 0

    for right in 0..<nums.count {

        if nums[right] == 0 {
            zeroCount += 1
        }

        while zeroCount > k {
            if nums[left] == 0 {
                zeroCount -= 1
            }
            left += 1
        }

        let length = right - left + 1
        maxLength = maxLength > length ? maxLength : length
    }

    return maxLength
}

// MARK: - Dry Run
/*
 nums = [1,1,1,0,0,0,1,1,1,1,0], k = 2

 right=0..2  all 1's            zeroCount=0   maxLength=3
 right=3     0                  zeroCount=1   maxLength=4
 right=4     0                  zeroCount=2   maxLength=5
 right=5     0                  zeroCount=3>2 → shrink left=0(1,no change),left=1
                                  still 3>2 → shrink left=1(1,no change),left=2
                                  still 3>2 → shrink left=2(1,no change),left=3
                                  nums[3]=0 → zeroCount=2, left=4
                                  length = 5-4+1 = 2, maxLength stays 5
 right=6..9  all 1's            zeroCount=2   length grows to 9-4+1=6  maxLength=6
 right=10    0                  zeroCount=3>2 → shrink until back to 2
                                  length stays <=6

 Final answer: 6
*/

// MARK: - Complexity

/*
 ┌─────────────┬───────────┬───────────┐
 │ Approach    │ Time      │ Space     │
 ├─────────────┼───────────┼───────────┤
 │ Brute Force │ O(n²)     │ O(1)      │
 │ Optimised   │ O(n)      │ O(1)      │
 └─────────────┴───────────┴───────────┘
*/

// MARK: - Traps

/*
 1. k = 0 → window can only contain 1's, shrinks immediately past any 0.
 2. while, not if — zeroCount may need multiple shrink steps to recover.
 3. Only decrement zeroCount when the character leaving is actually a 0.
 4. All-1's array with large k → entire array is the answer, unused
    flips simply don't matter.
*/

// MARK: - Test Cases

print("--- Brute Force ---")
print(bruteForceMaxConsecutiveOnes(nums: [1,1,1,0,0,0,1,1,1,1,0], k: 2))                                  // 6
print(bruteForceMaxConsecutiveOnes(nums: [0,0,1,1,0,0,1,1,1,0,1,1,0,0,0,1,1,1,1], k: 3))                  // 10
print(bruteForceMaxConsecutiveOnes(nums: [0,0,0], k: 0))                                                   // 0
print(bruteForceMaxConsecutiveOnes(nums: [1,1,1,1], k: 5))                                                 // 4

print("--- Optimal ⭐️ ---")
print(optimisedMaxConsecutiveOnes(nums: [1,1,1,0,0,0,1,1,1,1,0], k: 2))                                  // 6
print(optimisedMaxConsecutiveOnes(nums: [0,0,1,1,0,0,1,1,1,0,1,1,0,0,0,1,1,1,1], k: 3))                  // 10
print(optimisedMaxConsecutiveOnes(nums: [0,0,0], k: 0))                                                   // 0
print(optimisedMaxConsecutiveOnes(nums: [1,1,1,1], k: 5))                                                 // 4
