import Foundation


// ──────────────────────────────────────────
// Number of Subarrays with Sum in Range
// Difficulty: Medium  |  Pattern: Prefix Sum + Sliding Window
// ──────────────────────────────────────────


// MARK: - Problem

/*
 Given array nums and range [lower, upper]
 count subarrays where lower <= sum <= upper

 Input:  nums=[2,1,4,3]  lower=3  upper=5  →  4
 Input:  nums=[1,2,3]    lower=2  upper=4  →  3
 Input:  nums=[0,0,0]    lower=0  upper=0  →  6

 Key insight:
 count(lower <= sum <= upper)
 = countAtMost(upper) - countAtMost(lower - 1)

 countAtMost(goal) = subarrays with sum <= goal
 Sliding window — expand right shrink left
*/


// MARK: - Interview Q&A

/*
 Q: What is the condition?
 A: lower <= sum <= upper
    equal to lower is valid
    equal to upper is valid

 Q: What is the complement trick?
 A: count(lower <= sum <= upper)
    = countAtMost(upper) - countAtMost(lower-1)
    Converts range problem into two simpler problems

 Q: How does countAtMost work?
 A: Sliding window — expand right shrink left
    While sum > goal shrink from left
    All subarrays ending at right = right - left + 1

 Q: Why right - left + 1?
 A: At each right all valid windows are
    [left..right] [left+1..right] ... [right..right]
    Count = right - left + 1

 Q: Why lower - 1 not lower?
 A: countAtMost(lower) includes sum == lower
    We want to exclude sum < lower
    So subtract countAtMost(lower - 1)

 Q: Why add sum += nums[right] first?
 A: Expand window before checking
    Always expand then shrink then count

 Q: Time and space?
 A: Brute     O(n²) time  O(1) space
    Optimised  O(n)  time  O(1) space
*/


// MARK: - Brute Force  O(n²) time  O(1) space

/*
 Strategy:
 - Fix start index i
 - Extend end index j from i onwards
 - Track running sum
 - If lower <= sum <= upper count it

 INTERVIEW: sum resets to 0 at every new i
 INTERVIEW: check both conditions >= lower AND <= upper
 INTERVIEW: && not comma — two separate Int conditions
*/

func subarraySumCount(_ nums: [Int],
                      _ lower: Int,
                      _ upper: Int) -> Int {

    var count = 0

    for i in 0..<nums.count {

        var sum = 0

        for j in i..<nums.count {

            sum += nums[j]

            if sum >= lower && sum <= upper {
                count += 1
            }
        }
    }

    return count
}


// MARK: - Helper  O(n) time  O(1) space

/*
 countAtMost — count subarrays with sum <= goal

 Strategy:
 - Sliding window — two pointers left and right
 - Expand right — add nums[right] to sum
 - Shrink left  — while sum > goal
 - Count all subarrays ending at right

 INTERVIEW: expand first — then shrink — then count
 INTERVIEW: while not if — shrink fully not just once
 INTERVIEW: left <= right — never cross pointers
*/

func countAtMost(_ nums: [Int], _ target: Int) -> Int {

    var count = 0
    var sum   = 0
    var left  = 0

    for right in 0..<nums.count {

        sum += nums[right]

        while sum > target && left <= right {
            sum -= nums[left]
            left += 1
        }

        count += right - left + 1
    }

    return count
}


// MARK: - Optimised ⭐️  O(n) time  O(1) space

/*
 Strategy:
 - Use complement trick
 - countAtMost(upper) - countAtMost(lower - 1)
 - Two calls to countAtMost — both O(n)
 - Total O(n) time O(1) space

 INTERVIEW: complement trick converts range to two calls
 INTERVIEW: lower - 1 not lower — include lower in answer
 INTERVIEW: one line solution using helper
*/

func subarraySumCountOptimised(_ nums: [Int],
                                _ lower: Int,
                                _ upper: Int) -> Int {

    return countAtMost(nums, upper) - countAtMost(nums, lower - 1)
}


// MARK: - Dry Run

/*
 nums=[2,1,4,3]  lower=3  upper=5

 --- Brute Force ---

 i=0:
   j=0 → sum=2   2>=3? No
   j=1 → sum=3   YES  count=1
   j=2 → sum=7   7<=5? No
   j=3 → sum=10  No

 i=1:
   j=1 → sum=1   No
   j=2 → sum=5   YES  count=2
   j=3 → sum=8   No

 i=2:
   j=2 → sum=4   YES  count=3
   j=3 → sum=7   No

 i=3:
   j=3 → sum=3   YES  count=4

 Brute = 4 ✅


 --- Optimised ---

 countAtMost(5):
 right=0 → sum=2  2<=5  count+=1   total=1
 right=1 → sum=3  3<=5  count+=2   total=3
 right=2 → sum=7  7>5   shrink
           left=1 sum=5  count+=2  total=5
 right=3 → sum=8  8>5   shrink
           left=2 sum=7  7>5 shrink
           left=3 sum=3  count+=1  total=6

 countAtMost(5) = 6

 countAtMost(2):
 right=0 → sum=2  2<=2  count+=1   total=1
 right=1 → sum=3  3>2   shrink
           left=1 sum=1  count+=1  total=2
 right=2 → sum=5  5>2   shrink
           left=2 sum=4  4>2 shrink
           left=3 stop   count+=0  total=2
 right=3 → sum=3  3>2   shrink
           left=4 stop   count+=0  total=2

 countAtMost(2) = 2

 answer = 6 - 2 = 4 ✅
*/


// MARK: - Complexity

/*
 ┌─────────────┬────────────┬────────────┐
 │             │ Brute      │ Optimised  │
 ├─────────────┼────────────┼────────────┤
 │ Time        │ O(n²)      │ O(n)       │
 │ Space       │ O(1)       │ O(1)       │
 │ Passes      │ 2 nested   │ 2 passes   │
 └─────────────┴────────────┴────────────┘
*/


// MARK: - Traps

/*
 Trap 1 — wrong complement formula
 countAtMost(upper) - countAtMost(lower)    ❌ excludes lower
 countAtMost(upper) - countAtMost(lower-1)  ✅ includes lower

 Trap 2 — wrong window count
 count += right - left                      ❌ off by one
 count += right - left + 1                  ✅ correct

 Trap 3 — not adding sum before shrinking
 while sum > target { }                     ❌ sum never grew
 sum += nums[right] first                   ✅ expand then shrink

 Trap 4 — if instead of while
 if sum > target { shrink once }            ❌ may still be too big
 while sum > target { shrink fully }        ✅ correct

 Trap 5 — both conditions needed
 if sum <= upper { }                        ❌ misses lower bound
 if sum >= lower && sum <= upper { }        ✅ both conditions
*/


// MARK: - Tests

let tests: [(nums: [Int], lower: Int, upper: Int, expected: Int)] = [

    ([2, 1, 4, 3],   3, 5,   4),    // classic case
    ([1, 2, 3],      2, 4,   3),    // simple case
    ([0, 0, 0],      0, 0,   6),    // all zeros
    ([1, 2, 3],      1, 6,   6),    // all subarrays
    ([4, 5, 6],      1, 3,   0),    // no match
    ([1],            1, 1,   1),    // single match
    ([5],            1, 3,   0),    // single no match

]

print("====== Number of Subarrays with Sum in Range ======\n")

print("--- Brute Force ---\n")

for (i, t) in tests.enumerated() {
    let r = subarraySumCount(t.nums, t.lower, t.upper)
    print("Test \(i+1): \(r == t.expected ? "✅" : "❌")  |  nums: \(t.nums)  lower: \(t.lower)  upper: \(t.upper)  Got: \(r)  Expected: \(t.expected)")
}

print("\n--- Optimised ⭐️ ---\n")

for (i, t) in tests.enumerated() {
    let r = subarraySumCountOptimised(t.nums, t.lower, t.upper)
    print("Test \(i+1): \(r == t.expected ? "✅" : "❌")  |  nums: \(t.nums)  lower: \(t.lower)  upper: \(t.upper)  Got: \(r)  Expected: \(t.expected)")
}
