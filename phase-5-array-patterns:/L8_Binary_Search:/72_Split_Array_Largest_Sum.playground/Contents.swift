// MARK: - Problem
// LeetCode 410 — Split Array Largest Sum
//
// Given an array `nums` and an integer `m`, split nums into `m` non-empty
// contiguous subarrays. Minimize the largest sum among these m subarrays.
//
// Example:
// nums = [7, 2, 5, 10, 8], m = 2
// Answer: 18   (split: [7,2,5]=14 and [10,8]=18 -> largest = 18)


// MARK: - Interview Q&A
//
// Q1. How does this map to Capacity To Ship Packages?
// A1. Identical shape, different names:
//       Ship: weights[]            -> here: nums[]
//       Ship: capacity cap         -> here: max group sum cap
//       Ship: days (max allowed)   -> here: m (max groups allowed)
//       Ship: range maxWeight..sum -> here: range max(nums)..sum(nums)
//
// Q2. Why is this rated harder than Koko / Ship Capacity despite being the
//     same pattern?
// A2. The problem statement gives no explicit hint that binary search
//     applies. "Minimize the largest sum" doesn't suggest binary search
//     the way "minimum speed" or "minimum capacity" did. You have to
//     recognize the pattern yourself — that's what makes it a common
//     follow-up after Koko or Ship Capacity in real interviews.
//
// Q3. Why does the lower bound start at max(nums), not 1?
// A3. Same reasoning as Ship Capacity: a single group's cap must be able
//     to hold the largest individual element. Any cap below max(nums)
//     can never place that element in any group — it's not just
//     suboptimal, it's infeasible.
//
// Q4. Why is the upper bound sum(nums)?
// A4. A cap equal to the total sum lets everything fit into exactly one
//     group — always feasible as long as m >= 1.
//
// Q5. Why does groupsNeeded start at 1?
// A5. The first element always belongs to the first group, before any
//     overflow check happens.


// MARK: - Brute Force Approach
// Try every possible cap from max(nums) to sum(nums),
// return the smallest cap that fits within m groups.
// Time: O((sum - max) * n)   Space: O(1)

func splitArrayBruteForce(nums: [Int], m: Int) -> Int {

    var maxNum = Int.min
    var totalSum = 0

    for num in nums {
        if num > maxNum {
            maxNum = num
        }
        totalSum += num
    }

    for cap in maxNum...totalSum {
        if canSplitBrute(nums: nums, groupLimit: m, cap: cap) {
            return cap
        }
    }

    return totalSum
}

func canSplitBrute(nums: [Int], groupLimit: Int, cap: Int) -> Bool {

    var currentSum = 0
    var groupsNeeded = 1

    for i in 0..<nums.count {

        if currentSum + nums[i] > cap {
            groupsNeeded += 1
            currentSum = nums[i]
        } else {
            currentSum += nums[i]
        }
    }

    return groupsNeeded <= groupLimit
}


// MARK: - Optimised Approach
// Binary search on the answer space (cap = max allowed group sum).
// Time: O(n log(sum - max))   Space: O(1)

func splitArrayOptimised(nums: [Int], m: Int) -> Int {

    var maxNum = Int.min
    var totalSum = 0

    for num in nums {
        if num > maxNum {
            maxNum = num
        }
        totalSum += num
    }

    var left = maxNum
    var right = totalSum
    var answer = totalSum

    while left <= right {

        let mid = left + (right - left) / 2

        if canSplit(nums: nums, groupLimit: m, cap: mid) {
            answer = mid
            right = mid - 1
        } else {
            left = mid + 1
        }
    }

    return answer
}

func canSplit(nums: [Int], groupLimit: Int, cap: Int) -> Bool {

    var currentSum = 0
    var groupsNeeded = 1

    for i in 0..<nums.count {

        if currentSum + nums[i] > cap {
            groupsNeeded += 1
            currentSum = nums[i]
        } else {
            currentSum += nums[i]
        }
    }

    return groupsNeeded <= groupLimit
}


// MARK: - Dry Run
//
// nums = [7, 2, 5, 10, 8], m = 2
//
// maxNum = 10, totalSum = 32
// left = 10, right = 32, answer = 32
//
// Iteration 1: mid = 10 + (32-10)/2 = 21
//   canSplit(cap=21): 7+2+5=14, +10=24>21 -> group1=[7,2,5]
//                      group2 starts at 10: 10+8=18 -> group2=[10,8]
//                      groupsNeeded = 2 -> 2 <= 2, true
//   answer = 21, right = 20
//
// Iteration 2: mid = 10 + (20-10)/2 = 15
//   canSplit(cap=15): 7+2=9, +5=14, +10=24>15 -> group1=[7,2,5]
//                      group2 starts at 10: 10+8=18>15 -> group2=[10]
//                      group3 starts at 8: [8]
//                      groupsNeeded = 3 -> 3 <= 2, false
//   left = 16
//
// Iteration 3: mid = 16 + (20-16)/2 = 18
//   canSplit(cap=18): 7+2=9, +5=14, +10=24>18 -> group1=[7,2,5]
//                      group2 starts at 10: 10+8=18 -> group2=[10,8]
//                      groupsNeeded = 2 -> 2 <= 2, true
//   answer = 18, right = 17
//
// Iteration 4: mid = 16 + (17-16)/2 = 16
//   canSplit(cap=16): 7+2=9, +5=14, +10=24>16 -> group1=[7,2,5]
//                      group2 starts at 10: 10+8=18>16 -> group2=[10]
//                      group3 starts at 8: [8]
//                      groupsNeeded = 3 -> 3 <= 2, false
//   left = 17
//
// Iteration 5: mid = 17 + (17-17)/2 = 17
//   canSplit(cap=17): 7+2=9, +5=14, +10=24>17 -> group1=[7,2,5]
//                      group2 starts at 10: 10+8=18>17 -> group2=[10]
//                      group3 starts at 8: [8]
//                      groupsNeeded = 3 -> 3 <= 2, false
//   left = 18
//
// left = 18, right = 17 -> left > right, loop ends
//
// Return answer = 18   ✅ matches expected output


// MARK: - Complexity
//
// | Approach     | Time                  | Space |
// |--------------|------------------------|-------|
// | Brute Force  | O((sum - max) * n)     | O(1)  |
// | Optimised    | O(n log(sum - max))    | O(1)  |
//
// n = nums.count, sum = total of all elements, max = largest single element


// MARK: - Traps
//
// 1. Confusing the two integer parameters — cap (max group sum, what you're
//    binary searching over) vs. groupLimit (m, fixed for the whole problem).
//    Mixing them up either compiles fine with wrong results, or produces
//    confusing bugs depending on call-site order.
// 2. Starting left at 1 instead of max(nums) — a cap smaller than the
//    largest single element can never place that element anywhere, so
//    it's not just inefficient, it's infeasible.
// 3. Returning immediately when canSplit(mid) is true — finds *a* feasible
//    cap, not necessarily the minimum. Must keep shrinking right.
// 4. Forgetting groupsNeeded starts at 1, not 0.
// 5. Variable naming collision — naming a variable `max` shadows Swift's
//    built-in Array.max() function; safer to use `maxNum`.


// MARK: - Tests

let nums = [7, 2, 5, 10, 8]
let m = 2

print(splitArrayBruteForce(nums: nums, m: m))   // 18
print(splitArrayOptimised(nums: nums, m: m))    // 18

print(splitArrayBruteForce(nums: [1,2,3,4,5], m: 2))  // 9
print(splitArrayOptimised(nums: [1,2,3,4,5], m: 2))   // 9

print(splitArrayBruteForce(nums: [1,4,4], m: 3))  // 4
print(splitArrayOptimised(nums: [1,4,4], m: 3))   // 4

print(splitArrayBruteForce(nums: [10], m: 1))  // 10 (edge: single element, single group)
print(splitArrayOptimised(nums: [10], m: 1))   // 10
