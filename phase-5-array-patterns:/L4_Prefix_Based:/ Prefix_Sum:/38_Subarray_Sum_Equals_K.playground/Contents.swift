import Foundation


// ──────────────────────────────────────────
// LeetCode 560 — Subarray Sum Equals K
// Difficulty: Medium  |  Pattern: Prefix Sum + HashMap
// ──────────────────────────────────────────


// MARK: - Problem

/*
 Given an array nums and integer k
 return total count of subarrays whose sum equals k

 Input:  nums = [1, 2, 3, -1, 2]  k = 4  →  2
 Input:  nums = [1, 1, 1]          k = 2  →  2
 Input:  nums = [0, 0, 0, 0]       k = 0  → 10

 Key insight:
 prefix[j] - prefix[i] = k
 means subarray from i to j sums to k
 Store prefix sums in hashmap → find complement in O(1)
*/


// MARK: - Interview Q&A

/*
 Q: Why two loops in brute force?
 A: Fix start index i — extend end index j
    Try every possible subarray starting at i

 Q: Why does sum reset at every new i?
 A: Each i starts a fresh subarray from scratch
    sum inside j loop never resets — keeps growing

 Q: What is the key insight for optimised?
 A: prefix[j] - prefix[i] = k
    means subarray i..j sums to k
    So check if (currentPrefix - k) exists in map

 Q: Why initialise map with [0: 1]?
 A: Handles subarrays starting from index 0
    Without it nums=[4] k=4 returns 0 instead of 1

 Q: Why check map BEFORE inserting current prefix?
 A: Avoid counting current index as a previous prefix
    Check first — then store

 Q: Does this handle negative numbers?
 A: Yes — prefix sum works with negatives
    Sliding window does NOT work here

 Q: Time and space?
 A: Brute     O(n²) time  O(1) space
    Optimised  O(n)  time  O(n) space
*/


// MARK: - Brute Force  O(n²) time  O(1) space

/*
 Strategy:
 - Fix start index i
 - Extend end index j from i to end
 - Accumulate sum — check if sum == k
 - Count every match

 INTERVIEW: sum resets to 0 at every new i
 INTERVIEW: sum never resets inside j loop
 INTERVIEW: works with negatives — no assumptions on values
*/

func subarraySumBrute(_ nums: [Int], _ k: Int) -> Int {

    var count = 0

    for i in 0..<nums.count {

        var sum = 0

        for j in i..<nums.count {

            sum += nums[j]

            if sum == k {
                count += 1
            }
        }
    }

    return count
}


// MARK: - Optimised ⭐️  O(n) time  O(n) space

/*
 Strategy:
 - Initialise map with [0: 1] — base case
 - Walk array growing prefix sum
 - Check if (prefix - k) exists in map
 - Add frequency to count
 - Store current prefix in map

 INTERVIEW: map[0] = 1 is critical — handles index 0 subarrays
 INTERVIEW: check map BEFORE inserting current prefix
 INTERVIEW: if let vs ?? 0 — both correct — if let more readable
 INTERVIEW: sliding window fails here — negatives break it
*/

func subarraySumOptimised(_ nums: [Int], _ k: Int) -> Int {

    var map    = [Int: Int]()
    map[0]     = 1

    var prefix = 0
    var count  = 0

    for num in nums {

        prefix += num

        if let value = map[prefix - k] {
            count += value
        }

        if let value = map[prefix] {
            map[prefix] = value + 1
        } else {
            map[prefix] = 1
        }
    }

    return count
}


// MARK: - Dry Run

/*
 nums = [1, 2, 3, -1, 2]   k = 4
 map  = [0: 1]

 num=1  → prefix=1 | prefix-k=-3 | map[-3]? nil     | count=0 | map={0:1, 1:1}
 num=2  → prefix=3 | prefix-k=-1 | map[-1]? nil     | count=0 | map={0:1, 1:1, 3:1}
 num=3  → prefix=6 | prefix-k=2  | map[2]?  nil     | count=0 | map={..., 6:1}
 num=-1 → prefix=5 | prefix-k=1  | map[1]=1 YES ✅  | count=1 | map={..., 5:1}
 num=2  → prefix=7 | prefix-k=3  | map[3]=1 YES ✅  | count=2 | map={..., 7:1}

 Answer = 2 ✅

 Subarrays found:
 prefix[4] - prefix[1] = 5 - 1 = 4 → [2, 3, -1]  ✅
 prefix[5] - prefix[2] = 7 - 3 = 4 → [3, -1, 2]  ✅
*/


// MARK: - Complexity

/*
 ┌─────────────┬────────────┬────────────┐
 │             │ Brute      │ Optimised  │
 ├─────────────┼────────────┼────────────┤
 │ Time        │ O(n²)      │ O(n)       │
 │ Space       │ O(1)       │ O(n)       │
 │ Negatives   │ ✅ works   │ ✅ works   │
 │ Loops       │ 2 nested   │ 1 pass     │
 └─────────────┴────────────┴────────────┘
*/


// MARK: - Traps

/*
 Trap 1 — forgetting base case
 map[0] = 1   missing           ❌ misses subarrays from index 0
 map[0] = 1   always set        ✅

 Trap 2 — inserting before checking
 map[prefix] = ...              ❌ counts current as previous
 count += map[prefix - k]       ❌ wrong order
 Check first — then insert      ✅

 Trap 3 — using sliding window
 Sliding window fails with negatives  ❌
 Prefix sum + hashmap works always    ✅

 Trap 4 — resetting sum inside j loop
 for j { sum = 0; sum += nums[j] }   ❌ resets every step
 for j { sum += nums[j] }            ✅ keeps growing
*/


// MARK: - Tests

let tests: [(nums: [Int], k: Int, expected: Int)] = [

    ([1, 2, 3, -1, 2],          4,   2),    // classic case
    ([1, 1, 1],                  2,   2),    // overlapping
    ([1],                        0,   0),    // no match
    ([1],                        1,   1),    // single match
    ([-1, -1, 1],                0,   1),    // negatives
    ([0, 0, 0, 0],               0,  10),    // all zeros
    ([1, -1, 1, -1, 1, -1, 1],  0,  12),   // ✅ correct is 12 not 9
 

]

print("====== LeetCode 560 — Subarray Sum Equals K ======\n")

print("--- Brute Force ---\n")

for (i, t) in tests.enumerated() {
    let r = subarraySumBrute(t.nums, t.k)
    print("Test \(i+1): \(r == t.expected ? "✅" : "❌")  |  nums: \(t.nums)  k: \(t.k)  Got: \(r)  Expected: \(t.expected)")
}

print("\n--- Optimised ⭐️ ---\n")

for (i, t) in tests.enumerated() {
    let r = subarraySumOptimised(t.nums, t.k)
    print("Test \(i+1): \(r == t.expected ? "✅" : "❌")  |  nums: \(t.nums)  k: \(t.k)  Got: \(r)  Expected: \(t.expected)")
}
