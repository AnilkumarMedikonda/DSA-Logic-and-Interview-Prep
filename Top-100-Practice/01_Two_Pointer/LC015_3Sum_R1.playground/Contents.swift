//
//  LC015_3Sum_R1.playground
//  Sort + Two Pointer · Medium · Blind75
//

import Foundation

// MARK: - Problem
/*
 Return all UNIQUE triplets summing to target (0). No duplicate triplets.

 [-1,0,1,2,-1,-4] → [[-1,-1,2], [-1,0,1]]
 [0,1,1]          → []
 [0,0,0]          → [[0,0,0]]

 3 <= nums.count <= 3000
*/

// MARK: - Brute Force
// Time  O(n³) — three nested loops
// Space O(n)  — the sorted copy (output doesn't count)

func threeSumBruteForce(_ nums: [Int], _ target: Int) -> [[Int]] {

    guard nums.count >= 3 else { return [] }        // triplet needs 3

    let sorted = nums.sorted()                      // makes duplicates adjacent
    var result = [[Int]]()

    for i in 0..<sorted.count {
        if i > 0 && sorted[i] == sorted[i - 1] { continue }

        for j in (i + 1)..<sorted.count {
            if j > i + 1 && sorted[j] == sorted[j - 1] { continue }

            for k in (j + 1)..<sorted.count {
                if k > j + 1 && sorted[k] == sorted[k - 1] { continue }

                if sorted[i] + sorted[j] + sorted[k] == target {
                    result.append([sorted[i], sorted[j], sorted[k]])
                }
            }
        }
    }
    return result
}

// MARK: - Optimised · Sort + Two Pointer
// Time  O(n²) — O(n log n) sort + n × O(n) scan
// Space O(n)  — sorted copy; O(1) auxiliary if sorted in place

func threeSum(_ nums: [Int], _ target: Int) -> [[Int]] {

    guard nums.count >= 3 else { return [] }

    let sorted = nums.sorted()
    var result = [[Int]]()

    for i in 0..<sorted.count {

        if sorted[i] > target { break }                  // rest are larger — impossible
        if i > 0 && sorted[i] == sorted[i - 1] { continue }

        var left  = i + 1
        var right = sorted.count - 1

        while left < right {

            let sum = sorted[i] + sorted[left] + sorted[right]

            if sum < target {
                left += 1
            } else if sum > target {
                right -= 1
            } else {
                result.append([sorted[i], sorted[left], sorted[right]])

                left  += 1
                right -= 1

                // skip duplicates ONLY after a match
                while left < right && sorted[left]  == sorted[left - 1]  { left  += 1 }
                while left < right && sorted[right] == sorted[right + 1] { right -= 1 }
            }
        }
    }
    return result
}

// MARK: - Dry Run  [-4,-1,-1,0,1,2] (sorted), target 0
/*
 i  val  left right  sum  action
 0  -4    1    5     -3   sum < 0 → left++
 0  -4    2    5     -3   left++
 0  -4    3    5     -2   left++
 0  -4    4    5     -1   left++ → left==right, exit
 1  -1    2    5      0   MATCH [-1,-1,2] → left=3, right=4
 1  -1    3    4      0   MATCH [-1,0,1]  → left=4, right=3, exit
 2  -1              skip (duplicate of i=1)
 3   0    4    5      3   sum > 0 → right--  → exit
 4   1                break (1 > 0)
*/

// MARK: - Traps
/*
 1. guard >= 3, not >= 2 — a triplet needs three elements
 2. return [] not [[]] — [[]] is a non-empty result holding an empty triplet
 3. Dedupe loops go INSIDE the match branch — that's the only place a
    duplicate can be produced
 4. Right skip compares sorted[right + 1] — right moves DOWN, so the value
    it just passed is above it
 5. Both skip loops need `left < right` — without it, [0,0,0,0] runs off
    the array
 6. Output array is not auxiliary space
*/

// MARK: - Tests

print(threeSum([-1,0,1,2,-1,-4], 0))    // [[-1,-1,2], [-1,0,1]]
print(threeSum([0,1,1], 0))             // []
print(threeSum([0,0,0], 0))             // [[0,0,0]]
print(threeSum([0,0,0,0], 0))           // [[0,0,0]]      ← the crasher
print(threeSum([-2,0,0,2,2], 0))        // [[-2,0,2]]     ← dupes both sides
print(threeSum([1,2,3], 0))             // []             ← early break
print(threeSum([1,2], 0))               // []             ← below min size
print(threeSum([-4,-2,-2,-2,0,1,2,2,2,3,3,4,4,6,6], 0))
// [[-4,-2,6], [-4,0,4], [-4,1,3], [-4,2,2], [-2,-2,4], [-2,0,2]]

// both approaches agree
for c in [[-1,0,1,2,-1,-4], [0,0,0,0], [-2,0,0,2,2], [1,2,3]] {
    print(threeSum(c, 0).count == threeSumBruteForce(c, 0).count)   // all true
}

// MARK: - Q&A
/*
 Q: Why does sorting help here but not in LC 11?
 A: 3Sum cares about VALUES, so indices are disposable and sorting groups
    duplicates adjacently. LC 11 measures index distance — sorting would
    destroy the very thing being measured.

 Q: Why skip duplicates in two places?
 A: The i-guard prevents re-running the same fixed element. The in-match
    skips prevent re-recording the same triplet from a different pair of
    positions. Different duplicates, different fixes.

 Q: Why can the outer loop break early?
 A: Once sorted[i] > target, every remaining element is larger, so the
    smallest possible triplet already exceeds the target.

 Q: Why two pointers instead of a hashmap?
 A: Both are O(n²), but dedupe with a hashmap means sorting each triplet
    into a Set. Sorting once up front is cheaper and simpler. Hashmap wins
    only when indices must be preserved (LC 1).
*/
