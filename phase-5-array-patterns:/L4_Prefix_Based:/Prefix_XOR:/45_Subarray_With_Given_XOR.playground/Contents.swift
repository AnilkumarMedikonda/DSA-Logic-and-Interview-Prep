import Foundation


// ──────────────────────────────────────────
// LeetCode 1542 — Subarray With Given XOR
// Difficulty: Medium  |  Pattern: Prefix XOR + HashMap
// ──────────────────────────────────────────


// MARK: - Problem

/*
 Given array nums and integer k
 Count subarrays where XOR of all elements = k

 Input:  nums = [4, 2, 2, 6, 4]  k = 6  →  4
 Input:  nums = [5, 6, 7, 8, 9]  k = 5  →  2
 Input:  nums = [1, 2, 3]        k = 2  →  2

 Key insight:
 Same as Subarray Sum = K
 But - replaced with ^
 prefix ^ k = previous prefix
 Check map for (prefix ^ k)
*/


// MARK: - Interview Q&A

/*
 Q: How is this similar to Subarray Sum = K?
 A: Sum = K  → check map[prefix - k]
    XOR = K  → check map[prefix ^ k]
    Same pattern — just - replaced with ^

 Q: Why prefix ^ k gives previous prefix?
 A: prefix[j] ^ prefix[i] = k
    XOR both sides with k
    prefix[j] ^ k = prefix[i]
    So check if (currentPrefix ^ k) in map

 Q: Why map[0] = 1?
 A: Handles subarrays starting from index 0
    Without it misses valid subarrays

 Q: Why check before storing?
 A: Avoid counting current index as previous
    Check first — then store

 Q: Time and space?
 A: Brute     O(n²) time  O(n) space
    Optimised  O(n)  time  O(n) space
*/


// MARK: - Brute Force  O(n²) time  O(n) space

/*
 Strategy:
 - Fix start index i
 - Extend end index j from i
 - XOR all elements from i to j manually
 - If xor == k count it

 INTERVIEW: xor resets to 0 at every new i
 INTERVIEW: no predefined functions — manual loop
 INTERVIEW: works with any values including 0
*/

func subArrayXOR(_ nums: [Int], _ k: Int) -> Int {

    var count = 0

    for i in 0..<nums.count {

        var xor = 0

        for j in i..<nums.count {

            xor ^= nums[j]

            if xor == k {
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
 - Walk array growing prefix XOR
 - Check if (prefix ^ k) exists in map
 - Add frequency to count
 - Store current prefix in map

 INTERVIEW: map[0] = 1 critical — handles index 0
 INTERVIEW: check map BEFORE storing current prefix
 INTERVIEW: prefix ^ k not prefix - k
 INTERVIEW: map[prefix, default: 0] += 1 — Swifty
*/

func subArrayXOROptimised(_ nums: [Int], _ k: Int) -> Int {

    var map    = [Int: Int]()
    map[0]     = 1

    var prefix = 0
    var count  = 0

    for i in 0..<nums.count {

        prefix ^= nums[i]

        if let value = map[prefix ^ k] {
            count += value
        }

        map[prefix, default: 0] += 1
    }

    return count
}


// MARK: - Dry Run

/*
 nums = [4, 2, 2, 6, 4]  k = 6
 map  = [0: 1]

 i=0 → prefix=4   prefix^k=4^6=2  map[2]? NO        map={0:1, 4:1}
 i=1 → prefix=6   prefix^k=6^6=0  map[0]=1 ✅ cnt=1  map={0:1, 4:1, 6:1}
 i=2 → prefix=4   prefix^k=4^6=2  map[2]? NO        map={0:1, 4:2, 6:1}
 i=3 → prefix=2   prefix^k=2^6=4  map[4]=2 ✅ cnt=3  map={0:1, 4:2, 6:1, 2:1}
 i=4 → prefix=6   prefix^k=6^6=0  map[0]=1 ✅ cnt=4  map={0:1, 4:2, 6:2, 2:1}

 Answer = 4 ✅

 Subarrays found:
 [4,2]       → 4^2     = 6 ✅
 [4,2,2,6,4] → ...     = 6 ✅
 [2,2,6]     → 2^2^6   = 6 ✅
 [6]         → 6       = 6 ✅
*/


// MARK: - Sum vs XOR comparison

/*
 Subarray Sum = K:
 prefix += num
 check  map[prefix - k]
 store  map[prefix] += 1

 Subarray XOR = K:
 prefix ^= num
 check  map[prefix ^ k]   ← ^ not -
 store  map[prefix] += 1

 Only one difference:
 - replaced with ^
*/


// MARK: - Complexity

/*
 ┌─────────────┬────────────┬────────────┐
 │             │ Brute      │ Optimised  │
 ├─────────────┼────────────┼────────────┤
 │ Time        │ O(n²)      │ O(n)       │
 │ Space       │ O(1)       │ O(n)       │
 │ Loops       │ 2 nested   │ 1 pass     │
 └─────────────┴────────────┴────────────┘
*/


// MARK: - Traps

/*
 Trap 1 — wrong complement
 map[prefix - k]   ❌ sum pattern
 map[prefix ^ k]   ✅ XOR pattern

 Trap 2 — forgetting base case
 map[0] = 1 missing   ❌ misses index 0 subarrays
 map[0] = 1 always    ✅

 Trap 3 — storing before checking
 map[prefix] += 1     ❌ counts current as previous
 check first          ✅ then store

 Trap 4 — resetting xor in brute force
 var xor = 0 outside i loop   ❌ carries over
 var xor = 0 inside i loop    ✅ fresh each start
*/


// MARK: - Tests

let tests: [(nums: [Int], k: Int, expected: Int)] = [

    ([4, 2, 2, 6, 4],   6,   4),    // ✅
    ([5, 6, 7, 8, 9],   5,   2),    // ✅
    ([1, 2, 3],         2,   1),    // ✅
    ([1],               1,   1),    // ✅
    ([1],               2,   0),    // ✅
    ([0, 0, 0],         0,   6),    // ✅
    ([4, 2, 2, 6, 4],   0,   2),    // ✅ 

]
print("====== LeetCode 1542 — Subarray With Given XOR ======\n")

print("--- Brute Force ---\n")

for (i, t) in tests.enumerated() {
    let r = subArrayXOR(t.nums, t.k)
    print("Test \(i+1): \(r == t.expected ? "✅" : "❌")  |  nums: \(t.nums)  k: \(t.k)  Got: \(r)  Expected: \(t.expected)")
}

print("\n--- Optimised ⭐️ ---\n")

for (i, t) in tests.enumerated() {
    let r = subArrayXOROptimised(t.nums, t.k)
    print("Test \(i+1): \(r == t.expected ? "✅" : "❌")  |  nums: \(t.nums)  k: \(t.k)  Got: \(r)  Expected: \(t.expected)")
}
