import Foundation


// ──────────────────────────────────────────
// LeetCode 724 — Find Pivot Index
// Difficulty: Easy  |  Pattern: Prefix Sum
// ──────────────────────────────────────────


// MARK: - Problem

/*
 Given an array nums return the pivot index.

 Pivot index = index where
 sum of all elements to the LEFT equals
 sum of all elements to the RIGHT

 Pivot element itself is NOT counted on either side
 If no pivot exists return -1
 If multiple pivots exist return the leftmost one

 Input:  nums = [1, 7, 3, 6, 5, 6]  →   3
 Input:  nums = [1, 2, 3]            →  -1
 Input:  nums = [2, 1, -1]           →   0

 Key insight:
 total = leftSum + nums[i] + rightSum
 so  rightSum = total - leftSum - nums[i]
 No need to compute rightSum with a loop
*/


// MARK: - Interview Q&A

/*
 Q: What is a pivot index?
 A: Index i where sum(0..i-1) == sum(i+1..end)
    Pivot element excluded from both sides

 Q: What if pivot is at index 0?
 A: leftSum = 0 — nothing to the left
    rightSum = total - nums[0]
    No special case needed — formula handles it

 Q: What if pivot is at last index?
 A: rightSum = 0 — nothing to the right
    leftSum = total - nums[last]
    No special case needed — formula handles it

 Q: Why return leftmost pivot?
 A: Problem requirement — stop at first match

 Q: Why check before updating leftSum?
 A: leftSum must NOT include nums[i]
    Update after check keeps pivot excluded

 Q: Time and space?
 A: Brute     O(n²) time  O(1) space — two inner loops
    Optimised  O(n)  time  O(1) space — one pass
*/


// MARK: - Brute Force  O(n²) time  O(1) space

/*
 Strategy:
 - For each index i
 - Loop left  0    to i-1  → leftSum
 - Loop right i+1  to end  → rightSum
 - If leftSum == rightSum return i

 INTERVIEW: leftSum and rightSum reset every outer iteration
 INTERVIEW: left loop  0..<i      excludes pivot
 INTERVIEW: right loop i+1..<end  excludes pivot
 INTERVIEW: Weakness — recomputes sums from scratch each index
*/

func pivotIndexBrute(_ nums: [Int]) -> Int {

    for i in 0..<nums.count {

        var leftSum  = 0
        var rightSum = 0

        for j in 0..<i {
            leftSum += nums[j]
        }

        for k in (i + 1)..<nums.count {
            rightSum += nums[k]
        }

        if leftSum == rightSum {
            return i
        }
    }

    return -1
}


// MARK: - Optimised ⭐️  O(n) time  O(1) space

/*
 Strategy:
 - Compute total sum once outside loop
 - Walk left to right tracking leftSum
 - Derive rightSum = total - leftSum - nums[i]
 - Check equality before updating leftSum

 INTERVIEW: total computed once — not inside loop
 INTERVIEW: rightSum = total - leftSum - nums[i] — no inner loop
 INTERVIEW: check BEFORE updating leftSum — order matters
 INTERVIEW: O(1) space — no prefix array needed here
*/

func pivotIndexOptimised(_ nums: [Int]) -> Int {

    let total   = nums.reduce(0, +)

    var leftSum = 0

    for i in 0..<nums.count {

        let rightSum = total - leftSum - nums[i]

        if leftSum == rightSum {
            return i
        }

        leftSum += nums[i]
    }

    return -1
}


// MARK: - Dry Run

/*
 nums  = [1, 7, 3, 6, 5, 6]
 total = 1+7+3+6+5+6 = 28

 i=0 → leftSum=0   rightSum=28-0-1  =27 | 0==27?  No  | leftSum=1
 i=1 → leftSum=1   rightSum=28-1-7  =20 | 1==20?  No  | leftSum=8
 i=2 → leftSum=8   rightSum=28-8-3  =17 | 8==17?  No  | leftSum=11
 i=3 → leftSum=11  rightSum=28-11-6 =11 | 11==11? YES → return 3 ✅

 nums  = [2, 1, -1]
 total = 2

 i=0 → leftSum=0  rightSum=2-0-2=0 | 0==0? YES → return 0 ✅

 nums  = [1, 2, 3]
 total = 6

 i=0 → leftSum=0  rightSum=5 | 0==5? No | leftSum=1
 i=1 → leftSum=1  rightSum=3 | 1==3? No | leftSum=3
 i=2 → leftSum=3  rightSum=0 | 3==0? No | leftSum=6

 return -1 ✅
*/


// MARK: - Complexity

/*
 ┌─────────────┬────────────┬────────────┐
 │             │ Brute      │ Optimised  │
 ├─────────────┼────────────┼────────────┤
 │ Time        │ O(n²)      │ O(n)       │
 │ Space       │ O(1)       │ O(1)       │
 │ Passes      │ n × 2      │ 2          │
 └─────────────┴────────────┴────────────┘
*/


// MARK: - Traps

/*
 Trap 1 — including pivot in left loop
 for j in 0...i { }           ❌ includes nums[i]
 for j in 0..<i { }           ✅ excludes pivot

 Trap 2 — wrong variable in right loop
 leftSum  += nums[k]           ❌ adds to wrong side
 rightSum += nums[k]           ✅ correct variable

 Trap 3 — comparing to itself
 if rightSum == rightSum { }   ❌ always true
 if leftSum  == rightSum { }   ✅ correct comparison

 Trap 4 — updating leftSum before check
 leftSum += nums[i]            ❌ wrong order
 if leftSum == rightSum { }    ❌ pivot already included
 Check first — then update     ✅
*/


// MARK: - Tests

let tests: [(nums: [Int], expected: Int)] = [

    ([1, 7, 3, 6, 5, 6],    3),    // classic case
    ([1, 2, 3],             -1),    // no pivot
    ([2, 1, -1],             0),    // pivot at first index
    ([0],                    0),    // single element
    ([-1, -1, 0, 1, 1, 0],  5),    // pivot at last index
    ([-1, -1, -1, 0, 1, 1], 0),    // negatives pivot first
    ([1, 0],                 0),    //  index 0 is pivot

]

print("====== LeetCode 724 — Find Pivot Index ======\n")

print("--- Brute Force ---\n")

for (i, t) in tests.enumerated() {
    let r = pivotIndexBrute(t.nums)
    print("Test \(i+1): \(r == t.expected ? "✅" : "❌")  |  nums: \(t.nums)  Got: \(r)  Expected: \(t.expected)")
}

print("\n--- Optimised ⭐️ ---\n")

for (i, t) in tests.enumerated() {
    let r = pivotIndexOptimised(t.nums)
    print("Test \(i+1): \(r == t.expected ? "✅" : "❌")  |  nums: \(t.nums)  Got: \(r)  Expected: \(t.expected)")
}
