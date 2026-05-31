import Foundation


// ──────────────────────────────────────────
// LeetCode 525 — Contiguous Array
// Difficulty: Medium  |  Pattern: Prefix Sum + HashMap
// ──────────────────────────────────────────


// MARK: - Problem

/*
 Given binary array nums of 0s and 1s
 return length of longest subarray with
 equal number of 0s and 1s

 Input:  nums = [0, 1]           →  2
 Input:  nums = [0, 1, 0]        →  2
 Input:  nums = [0, 1, 0, 1, 1]  →  4

 Key insight:
 Replace 0 with -1
 Equal 0s and 1s → subarray sum = 0
 Same prefix sum at two indices →
 subarray between them sums to 0
*/


// MARK: - Interview Q&A

/*
 Q: Why replace 0 with -1?
 A: Equal 0s and 1s means they cancel out
    1 + (-1) = 0
    Converts equal count problem to sum = 0 problem

 Q: What is the key insight?
 A: Same prefix sum at index i and j means
    subarray between them sums to 0
    length = i - firstIndex

 Q: Why map[0] = -1?
 A: Handles subarrays starting from index 0
    length = i - (-1) = i + 1

 Q: Why store first occurrence only?
 A: Earlier index gives larger gap
    Larger gap = longer subarray
    Never overwrite existing map entry

 Q: Why use if let not force unwrap?
 A: Force unwrap crashes if key not in map
    if let safely unwraps optional
    Use unwrapped value directly — cleaner

 Q: Time and space?
 A: Brute     O(n²) time  O(1) space
    Optimised  O(n)  time  O(n) space
*/


// MARK: - Brute Force  O(n²) time  O(1) space

/*
 Strategy:
 - For each index i extend j outward
 - Add +1 for 1 and -1 for 0
 - If sum == 0 update maxLength
 - Track j - i + 1 as current length

 INTERVIEW: sum resets to 0 at every new i
 INTERVIEW: 0 treated as -1 — not stored — computed on fly
 INTERVIEW: max(maxLength, j - i + 1) — length formula
*/

func findMaxLength(_ nums: [Int]) -> Int {

    var maxLength = 0

    for i in 0..<nums.count {

        var sum = 0

        for j in i..<nums.count {

            if nums[j] == 1 { sum += 1 }

            if nums[j] == 0 { sum -= 1 }

            if sum == 0 {
                maxLength = max(maxLength, j - i + 1)
            }
        }
    }

    return maxLength
}


// MARK: - Optimised ⭐️  O(n) time  O(n) space

/*
 Strategy:
 - Initialise map with [0: -1] — base case
 - Walk array growing prefix sum
 - Add +1 for 1 and -1 for 0
 - If prefix in map → length = i - firstIndex
 - If prefix not in map → store first occurrence

 INTERVIEW: map[0] = -1 — handles subarrays from index 0
 INTERVIEW: store first occurrence only — maximise length
 INTERVIEW: use if let — avoid force unwrap
 INTERVIEW: length = i - index — not i - index + 1
*/

func findMaxLengthOptimised(_ nums: [Int]) -> Int {

    var map       = [Int: Int]()
    map[0]        = -1

    var prefixSum = 0
    var maxLength = 0

    for i in 0..<nums.count {

        prefixSum += nums[i] == 0 ? -1 : 1

        if let index = map[prefixSum] {

            maxLength = max(i - index, maxLength)

        } else {

            map[prefixSum] = i
        }
    }

    return maxLength
}


// MARK: - Dry Run

/*
 nums = [0,  1,  0,  1,  1]
 map  = [0: -1]

 Replace 0 → -1:
 vals = [-1, 1, -1,  1,  1]

 i=0 → prefix=-1 | map[-1]? NO        | store map[-1]=0
 i=1 → prefix=0  | map[0]=-1          | 1-(-1)=2  maxLen=2
 i=2 → prefix=-1 | map[-1]=0          | 2-0=2     maxLen=2
 i=3 → prefix=0  | map[0]=-1          | 3-(-1)=4  maxLen=4 ✅
 i=4 → prefix=1  | map[1]? NO         | store map[1]=4

 Answer = 4 ✅

 Subarray found:
 Same prefix 0 at index -1 and index 3
 subarray = nums[0..3] = [0,1,0,1]
 two 0s and two 1s ✅
*/


// MARK: - Complexity

/*
 ┌─────────────┬────────────┬────────────┐
 │             │ Brute      │ Optimised  │
 ├─────────────┼────────────┼────────────┤
 │ Time        │ O(n²)      │ O(n)       │
 │ Space       │ O(1)       │ O(n)       │
 │ Passes      │ 2 nested   │ 1 pass     │
 └─────────────┴────────────┴────────────┘
*/


// MARK: - Traps

/*
 Trap 1 — not replacing 0 with -1
 if sum == 0 counts zeros only     ❌
 replace 0 → -1 to cancel with 1s  ✅

 Trap 2 — wrong length formula
 maxLength = max(i - index + 1)    ❌ off by one
 maxLength = max(i - index)        ✅ correct

 Trap 3 — overwriting map entry
 map[prefixSum] = i                ❌ loses earliest index
 store only if not in map          ✅ keep first occurrence

 Trap 4 — force unwrap
 i - map[prefixSum]!               ⚠️ crashes if nil
 if let index = map[prefixSum]     ✅ safe unwrap
 use index directly                ✅ already unwrapped

 Trap 5 — wrong base case
 map[0] = 0                        ❌ wrong index
 map[0] = -1                       ✅ before array starts
*/


// MARK: - Tests

let tests: [(nums: [Int], expected: Int)] = [

    ([0, 1],              2),    // simple case
    ([0, 1, 0],           2),    // odd length
    ([0, 1, 0, 1, 1],     4),    // classic case
    ([0, 0, 1, 0, 0, 0, 1, 1], 6),  // longer array
    ([0, 0, 0, 1, 1, 1],  6),    // all match
    ([0, 0, 0],           0),    // no match
    ([1, 1, 1, 1],        0),    // all ones no match

]

print("====== LeetCode 525 — Contiguous Array ======\n")

print("--- Brute Force ---\n")

for (i, t) in tests.enumerated() {
    let r = findMaxLength(t.nums)
    print("Test \(i+1): \(r == t.expected ? "✅" : "❌")  |  nums: \(t.nums)  Got: \(r)  Expected: \(t.expected)")
}

print("\n--- Optimised ⭐️ ---\n")

for (i, t) in tests.enumerated() {
    let r = findMaxLengthOptimised(t.nums)
    print("Test \(i+1): \(r == t.expected ? "✅" : "❌")  |  nums: \(t.nums)  Got: \(r)  Expected: \(t.expected)")
}
