import Foundation


// ──────────────────────────────────────────
// LeetCode 1442 — Count Triplets Equal XOR
// Difficulty: Medium  |  Pattern: Prefix XOR
// ──────────────────────────────────────────


// MARK: - Problem

/*
 Given array arr find number of triplets (i, j, k)
 where 0 <= i < j <= k < arr.length

 XOR(arr[i..j-1]) == XOR(arr[j..k])

 Input:  arr = [2, 3, 1, 6, 7]  →  4
 Input:  arr = [2, 3]            →  0
 Input:  arr = [1, 1, 1, 1, 1]  →  10

 Key insight:
 If A == B then A ^ B = 0
 So XOR of entire arr[i..k] = 0
 For each such subarray count += k - i
 (j can be any position between i+1 and k)
*/


// MARK: - Interview Q&A

/*
 Q: What does triplet (i, j, k) mean?
 A: Split subarray arr[i..k] at j
    Part A = arr[i..j-1]
    Part B = arr[j..k]
    Find where XOR(A) == XOR(B)

 Q: Why count += k - i?
 A: If XOR(arr[i..k]) = 0
    j can be any value from i+1 to k
    Number of choices = k - i
    Each choice = one valid triplet

 Q: Why two hashmaps?
 A: countMap tracks frequency of each prefix
    indexMap tracks sum of indices
    Together they give cnt * k - indexSum

 Q: Why indexMap[0] = 0 not -1?
 A: Base case at index 0
    indexSum starts at 0
    -1 gives wrong formula result

 Q: Why update maps AFTER count?
 A: Avoid counting current index as previous
    Check first then update

 Q: Time and space?
 A: Brute     O(n²) time  O(1) space
    Optimised  O(n)  time  O(n) space
*/


// MARK: - Brute Force  O(n²) time  O(1) space

/*
 Strategy:
 - Fix start index i
 - Extend end index k from i+1
 - XOR all elements from i to k
 - If XOR = 0 add k-i to count

 INTERVIEW: start xor with arr[i] not 0
 INTERVIEW: count += k-i not count += 1
 INTERVIEW: XOR = 0 means valid subarray found
*/

func countTriplets(_ arr: [Int]) -> Int {

    var count = 0

    for i in 0..<arr.count {

        var xor = arr[i]

        for k in (i + 1)..<arr.count {

            xor ^= arr[k]

            if xor == 0 {
                count += k - i
            }
        }
    }

    return count
}


// MARK: - Optimised ⭐️  O(n) time  O(n) space

/*
 Strategy:
 - Build prefix XOR walking array
 - Use countMap — prefix frequency
 - Use indexMap — sum of indices
 - When prefix seen before
   count += cnt * k - indexSum
 - Update maps after count

 INTERVIEW: countMap[0] = 1  indexMap[0] = 0
 INTERVIEW: formula is cnt * k - idx
 INTERVIEW: indexMap accumulates k+1 not k
 INTERVIEW: update AFTER using maps
*/

func countTripletsOptimised(_ arr: [Int]) -> Int {

    var countMap: [Int: Int] = [:]
    var indexMap: [Int: Int] = [:]

    countMap[0] = 1
    indexMap[0] = 0

    var count  = 0
    var prefix = 0

    for k in 0..<arr.count {

        prefix ^= arr[k]

        if let cnt = countMap[prefix],
           let idx = indexMap[prefix] {
            count += cnt * k - idx
        }

        countMap[prefix, default: 0] += 1
        indexMap[prefix, default: 0] += k + 1
    }

    return count
}


// MARK: - Dry Run

/*
 arr = [2, 3, 1, 6, 7]
 countMap = [0:1]  indexMap = [0:0]

 k=0 → prefix=2
   map[2]? NO
   countMap={0:1,2:1}  indexMap={0:0,2:1}

 k=1 → prefix=1
   map[1]? NO
   countMap={0:1,2:1,1:1}  indexMap={0:0,2:1,1:2}

 k=2 → prefix=0
   cnt=1  idx=0
   count += 1*2-0 = 2   total=2 ✅
   countMap={0:2,...}  indexMap={0:0+3=3,...}

 k=3 → prefix=6
   map[6]? NO
   countMap={...,6:1}  indexMap={...,6:4}

 k=4 → prefix=1
   cnt=1  idx=2
   count += 1*4-2 = 2   total=4 ✅
   countMap={...,1:2}  indexMap={...,1:2+5=7}

 Answer = 4 ✅
*/


// MARK: - Brute vs Optimised

/*
 Brute:
 XOR(i..k) = 0 → count += k-i
 Two loops — simple and clear

 Optimised:
 prefix seen before → count += cnt*k - idx
 One pass — hashmap trick

 Formula explained:
 Each previous i contributes (k - i) to count
 Total = sum of (k - i) for all matching i
       = cnt*k - sum(i)
       = cnt*k - indexSum
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
 Trap 1 — wrong count formula
 count += 1          ❌ misses multiple j positions
 count += k - i      ✅ all valid splits

 Trap 2 — wrong base case
 indexMap[0] = -1    ❌ gives wrong formula
 indexMap[0] = 0     ✅ correct base case

 Trap 3 — updating before count
 countMap += 1       ❌ counts current as previous
 count first         ✅ then update maps

 Trap 4 — wrong indexMap accumulation
 indexMap = k        ❌ overwrites previous
 indexMap += k+1     ✅ accumulates all indices
*/


// MARK: - Tests

let tests: [(arr: [Int], expected: Int)] = [

    ([2, 3, 1, 6, 7],   4),    // ✅
    ([2, 3],            0),    // ✅
    ([1, 1, 1, 1, 1],  10),    // ✅
    ([0, 0],            1),    // ✅
    ([1, 1],            1),    // ✅
    ([3, 2, 1],         2),    // ✅ fixed 1→2
    ([0, 0, 0],         4),    // ✅ fixed 6→4

]

print("====== LeetCode 1442 — Count Triplets Equal XOR ======\n")

print("--- Brute Force ---\n")

for (i, t) in tests.enumerated() {
    let r = countTriplets(t.arr)
    print("Test \(i+1): \(r == t.expected ? "✅" : "❌")  |  arr: \(t.arr)  Got: \(r)  Expected: \(t.expected)")
}

print("\n--- Optimised ⭐️ ---\n")

for (i, t) in tests.enumerated() {
    let r = countTripletsOptimised(t.arr)
    print("Test \(i+1): \(r == t.expected ? "✅" : "❌")  |  arr: \(t.arr)  Got: \(r)  Expected: \(t.expected)")
}
