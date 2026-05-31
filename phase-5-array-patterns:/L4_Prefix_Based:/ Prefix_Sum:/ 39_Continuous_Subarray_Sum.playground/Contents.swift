import Foundation


// ──────────────────────────────────────────
// LeetCode 523 — Continuous Subarray Sum
// Difficulty: Medium  |  Pattern: Prefix Sum + HashMap
// ──────────────────────────────────────────


// MARK: - Problem

/*
 Given an array nums and integer k
 return true if there exists a subarray of length
 at least 2 whose sum is a multiple of k

 Multiple of k means sum % k == 0

 Input:  nums = [23, 2, 4, 6, 7]   k = 6  →  true
 Input:  nums = [23, 2, 6, 4, 7]   k = 13 →  false
 Input:  nums = [0, 0]              k = 1  →  true

 Key insight:
 If two prefix sums have same remainder when divided by k
 then subarray between them is a multiple of k
 prefix[i] % k == prefix[j] % k
 means (prefix[j] - prefix[i]) % k == 0
*/


// MARK: - Interview Q&A

/*
 Q: What does multiple of k mean?
 A: sum % k == 0
    Examples for k=6: 6, 12, 18, 24, 42 ...

 Q: Why length at least 2?
 A: Problem requirement — single element not allowed
    j - i + 1 >= 2 in brute force
    i - firstIndex >= 2 in optimised

 Q: What is the key insight?
 A: Same remainder at two indices means
    subarray between them sums to multiple of k
    prefix[i] % k == prefix[j] % k
    → (prefix[j] - prefix[i]) % k == 0

 Q: Why map[0] = -1 as base case?
 A: Handles subarrays starting from index 0
    gap = i - (-1) = i + 1 gives correct length

 Q: Why store only first occurrence in map?
 A: Maximise gap between indices
    Larger gap = longer subarray = more likely >= 2

 Q: Why never overwrite existing map entry?
 A: Earlier index gives larger gap
    Always keep earliest occurrence

 Q: Time and space?
 A: Brute     O(n²) time  O(1) space
    Optimised  O(n)  time  O(k) space — at most k remainders
*/


// MARK: - Brute Force  O(n²) time  O(1) space

/*
 Strategy:
 - Fix start index i
 - Extend end index j from i onwards
 - Track running sum
 - Check sum % k == 0 and length >= 2

 INTERVIEW: sum resets to 0 at every new i
 INTERVIEW: length check j - i + 1 >= 2
 INTERVIEW: comma separated conditions — clean Swift style
*/

func countSubArraySum(_ nums: [Int], _ k: Int) -> Bool {

    for i in 0..<nums.count {

        var sum = 0

        for j in i..<nums.count {

            sum += nums[j]

            if sum % k == 0,
               j - i + 1 >= 2 {
                return true
            }
        }
    }

    return false
}


// MARK: - Optimised ⭐️  O(n) time  O(k) space

/*
 Strategy:
 - Initialise map with [0: -1] — base case
 - Walk array growing prefix sum
 - Compute remainder = prefix % k
 - If remainder seen before check gap >= 2
 - If not seen store remainder → current index

 INTERVIEW: map[0] = -1 handles subarrays from index 0
 INTERVIEW: store remainder not prefix as key
 INTERVIEW: never overwrite — keep earliest index
 INTERVIEW: if let for safe unwrap — no force unwrap
 INTERVIEW: gap = i - firstIndex not i - firstIndex + 1
*/

func checkSubArraySum(_ nums: [Int], _ k: Int) -> Bool {

    var map  = [Int: Int]()
    map[0]   = -1

    var prefix = 0

    for i in 0..<nums.count {

        prefix += nums[i]

        let remainder = prefix % k

        if let firstIndex = map[remainder] {

            if i - firstIndex >= 2 {
                return true
            }

        } else {

            map[remainder] = i
        }
    }

    return false
}


// MARK: - Dry Run

/*
 nums = [23, 2, 4, 6, 7]  k = 6
 map  = [0: -1]

 i=0 → prefix=23  rem=5  | map[5]? NO       | store map[5]=0
 i=1 → prefix=25  rem=1  | map[1]? NO       | store map[1]=1
 i=2 → prefix=29  rem=5  | map[5]=0  2-0=2  | 2>=2? YES ✅ return true

 Subarray found:
 same remainder 5 at index 0 and index 2
 subarray between = nums[1..2] = [2, 4]
 sum = 6  →  6 % 6 == 0 ✅
 length = 2 ✅
*/


// MARK: - Complexity

/*
 ┌─────────────┬────────────┬────────────┐
 │             │ Brute      │ Optimised  │
 ├─────────────┼────────────┼────────────┤
 │ Time        │ O(n²)      │ O(n)       │
 │ Space       │ O(1)       │ O(k)       │
 │ Passes      │ 2 nested   │ 1 pass     │
 └─────────────┴────────────┴────────────┘
*/


// MARK: - Traps

/*
 Trap 1 — wrong length check
 j - i + 1 > 2    ❌ misses length exactly 2
 j - i + 1 >= 2   ✅ includes length 2

 Trap 2 — storing prefix instead of remainder
 map[prefix] = i    ❌ wrong key
 map[remainder] = i ✅ correct key

 Trap 3 — overwriting existing map entry
 map[remainder] = i            ❌ loses earliest index
 if map[remainder] == nil { }  ✅ keep first occurrence

 Trap 4 — force unwrap crash
 i - map[remainder]! >= 2      ❌ crashes if nil
 if let firstIndex = map[remainder] { } ✅ safe

 Trap 5 — forgetting base case
 map[0] = -1  missing          ❌ misses index 0 subarrays
 map[0] = -1  always set       ✅
*/


// MARK: - Tests

let tests: [(nums: [Int], k: Int, expected: Bool)] = [

    ([23, 2, 4, 6, 7],   6,   true),    // [2,4] sum=6
    ([23, 2, 6, 4, 7],   13,  false),   // no valid subarray
    ([0, 0],             1,   true),    // [0,0] sum=0
    ([0, 0],             6,   true),    // [0,0] sum=0
    ([5, 0, 0, 0],       3,   true),    // [0,0] sum=0
    ([1, 0],             2,   false),   // sum=1 not multiple
    ([23, 2, 4, 6, 6],   7,   true),    // [6,6] sum=12

]

print("====== LeetCode 523 — Continuous Subarray Sum ======\n")

print("--- Brute Force ---\n")

for (i, t) in tests.enumerated() {
    let r = countSubArraySum(t.nums, t.k)
    print("Test \(i+1): \(r == t.expected ? "✅" : "❌")  |  nums: \(t.nums)  k: \(t.k)  Got: \(r)  Expected: \(t.expected)")
}

print("\n--- Optimised ⭐️ ---\n")

for (i, t) in tests.enumerated() {
    let r = checkSubArraySum(t.nums, t.k)
    print("Test \(i+1): \(r == t.expected ? "✅" : "❌")  |  nums: \(t.nums)  k: \(t.k)  Got: \(r)  Expected: \(t.expected)")
}
