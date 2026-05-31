import Foundation


// ──────────────────────────────────────────
// LeetCode 1310 — XOR Queries of a Subarray
// Difficulty: Medium  |  Pattern: Prefix XOR
// ──────────────────────────────────────────


// MARK: - Problem

/*
 Given array nums and queries
 Each query [L, R] asks:
 XOR of all elements from index L to R

 Input:
 nums    = [1, 3, 4, 8]
 queries = [[0,1],[1,2],[0,3],[3,3]]

 Output: [2, 7, 14, 8]

 query[0,1] → 1^3     = 2
 query[1,2] → 3^4     = 7
 query[0,3] → 1^3^4^8 = 14
 query[3,3] → 8       = 8

 Key insight:
 Same as Range Sum Query
 But + replaced with ^
 prefix[i] = prefix[i-1] ^ nums[i]
 xor(L,R)  = prefix[R+1] ^ prefix[L]
*/


// MARK: - Interview Q&A

/*
 Q: How is this similar to Range Sum Query?
 A: Prefix Sum → prefix[R+1] - prefix[L]
    Prefix XOR → prefix[R+1] ^ prefix[L]
    Same pattern — just + and - replaced with ^

 Q: Why ^ works instead of - ?
 A: XOR is its own inverse
    A ^ A = 0
    So XOR-ing cancels just like subtracting

 Q: Why prefix[0] = 0?
 A: 0 is identity for XOR
    Any number ^ 0 = same number
    Safe base case

 Q: Why prefix size is nums.count + 1?
 A: Extra slot at index 0
    Avoids index out of bounds
    Same as prefix sum pattern

 Q: Time and space?
 A: Brute     O(n×q) time  O(n) space
    Optimised  O(n+q) time  O(n) space
*/


// MARK: - Brute Force  O(n×q) time  O(n) space

/*
 Strategy:
 - For each query [L, R]
 - Loop from L to R
 - XOR every element
 - Append to result

 INTERVIEW: xor resets to 0 inside query loop
 INTERVIEW: closed range L...R includes both ends
 INTERVIEW: Weakness — O(n) per query
*/

func xorQueriesBrute(_ arr: [Int],
                     _ queries: [[Int]]) -> [Int] {

    var result = [Int]()

    for query in queries {

        var xor = 0
        let l   = query[0]
        let r   = query[1]

        for i in l...r {
            xor = xor ^ arr[i]
        }

        result.append(xor)
    }

    return result
}


// MARK: - Optimised ⭐️  O(n+q) time  O(n) space

/*
 Strategy:
 - Build prefix XOR array once in O(n)
 - prefix[i+1] = prefix[i] ^ arr[i]
 - Answer every query in O(1)
 - xor(L,R) = prefix[R+1] ^ prefix[L]

 INTERVIEW: prefix size arr.count + 1
 INTERVIEW: prefix[0] = 0 base case automatic
 INTERVIEW: same formula as range sum query
 INTERVIEW: ^ is its own inverse — no need for -
*/

func xorQueriesOptimised(_ arr: [Int],
                          _ queries: [[Int]]) -> [Int] {

    var prefix = Array(repeating: 0, count: arr.count + 1)

    for i in 0..<arr.count {
        prefix[i + 1] = prefix[i] ^ arr[i]
    }

    var result = [Int]()

    for query in queries {

        let l = query[0]
        let r = query[1]

        result.append(prefix[r + 1] ^ prefix[l])
    }

    return result
}


// MARK: - Dry Run

/*
 nums    = [1,  3,  4,  8]
 index     0   1   2   3

 Building prefix XOR:
 prefix[0] = 0
 prefix[1] = 0 ^ 1  = 1
 prefix[2] = 1 ^ 3  = 2
 prefix[3] = 2 ^ 4  = 6
 prefix[4] = 6 ^ 8  = 14

 prefix = [0,  1,  2,  6,  14]
 index     0   1   2   3    4

 Queries:
 [0,1] = prefix[2] ^ prefix[0] = 2  ^ 0  = 2  ✅
 [1,2] = prefix[3] ^ prefix[1] = 6  ^ 1  = 7  ✅
 [0,3] = prefix[4] ^ prefix[0] = 14 ^ 0  = 14 ✅
 [3,3] = prefix[4] ^ prefix[3] = 14 ^ 6  = 8  ✅
*/


// MARK: - Prefix Sum vs Prefix XOR

/*
 Prefix Sum:
 prefix[i+1] = prefix[i] + arr[i]
 range sum   = prefix[R+1] - prefix[L]

 Prefix XOR:
 prefix[i+1] = prefix[i] ^ arr[i]
 range xor   = prefix[R+1] ^ prefix[L]

 Only difference:
 + replaced with ^
 - replaced with ^
*/


// MARK: - Complexity

/*
 ┌─────────────┬────────────┬────────────┐
 │             │ Brute      │ Optimised  │
 ├─────────────┼────────────┼────────────┤
 │ Time        │ O(n×q)     │ O(n+q)     │
 │ Space       │ O(n)       │ O(n)       │
 │ Build       │ O(1)       │ O(n)       │
 │ Each query  │ O(n)       │ O(1)       │
 └─────────────┴────────────┴────────────┘
*/


// MARK: - Traps

/*
 Trap 1 — wrong prefix size
 Array(repeating: 0, count: arr.count)      ❌
 Array(repeating: 0, count: arr.count + 1)  ✅

 Trap 2 — wrong formula
 prefix[R] ^ prefix[L]     ❌ off by one
 prefix[R+1] ^ prefix[L]   ✅ correct

 Trap 3 — xor not resetting
 var xor = 0 outside loop   ❌ carries over
 var xor = 0 inside loop    ✅ fresh each query

 Trap 4 — wrong identity
 var xor = 1   ❌ wrong start
 var xor = 0   ✅ identity for XOR
*/


// MARK: - Tests

let nums    = [1, 3, 4, 8]
let queries = [[0, 1], [1, 2], [0, 3], [3, 3]]

let tests: [(arr: [Int], queries: [[Int]], expected: [Int])] = [

    ([1, 3, 4, 8],   [[0,1],[1,2],[0,3],[3,3]],  [2, 7, 14, 8]),
    ([1, 3],         [[0,1]],                     [2]),
    ([5],            [[0,0]],                     [5]),
    ([2, 4, 8, 16],  [[0,3],[1,3],[2,3],[3,3]],   [30, 28, 24, 16]),
    ([0, 0, 0],      [[0,2],[0,1],[1,2]],          [0, 0, 0]),

]

print("====== LeetCode 1310 — XOR Queries of a Subarray ======\n")

print("--- Brute Force ---\n")

for (i, t) in tests.enumerated() {
    let r = xorQueriesBrute(t.arr, t.queries)
    print("Test \(i+1): \(r == t.expected ? "✅" : "❌")  |  arr: \(t.arr)  Got: \(r)  Expected: \(t.expected)")
}

print("\n--- Optimised ⭐️ ---\n")

for (i, t) in tests.enumerated() {
    let r = xorQueriesOptimised(t.arr, t.queries)
    print("Test \(i+1): \(r == t.expected ? "✅" : "❌")  |  arr: \(t.arr)  Got: \(r)  Expected: \(t.expected)")
}
