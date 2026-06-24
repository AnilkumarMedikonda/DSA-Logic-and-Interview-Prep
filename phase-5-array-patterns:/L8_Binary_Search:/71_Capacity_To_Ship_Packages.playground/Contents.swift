// MARK: - Problem
// LeetCode 1011 — Capacity To Ship Packages Within D Days
//
// You have `weights[]` — packages that must be shipped in the given order
// (no reordering allowed). You have `days` days to ship everything.
//
// Each day, the ship loads packages one at a time, in order, up to its
// max capacity for that day. Once the next package would exceed capacity,
// that day's load stops and the next day begins.
//
// Find the minimum ship capacity such that all packages can be shipped
// within `days` days.
//
// Example:
// weights = [1,2,3,4,5,6,7,8,9,10], days = 5
// Answer: 15


// MARK: - Interview Q&A
//
// Q1. How does this map to Koko Eating Bananas?
// A1. Same binary-search-on-answer shape:
//       Koko: speed k          -> here: capacity cap
//       Koko: hours per pile   -> here: days per shipment
//       Koko: range 1..maxPile -> here: range maxWeight..sum(weights)
//
// Q2. Why can't the lower bound be 1 (or 0) like in Koko?
// A2. The ship must be able to carry the single heaviest package by itself
//     in one day. Any capacity below maxWeight can never load that package
//     at all, so it's not just suboptimal — it's infeasible. The lower
//     bound must start at maxWeight, not 1.
//
// Q3. Why is the upper bound sum(weights) instead of something else?
// A3. A capacity equal to the total sum can load every package in a single
//     day — that's always feasible (assuming days >= 1), so it's a safe
//     upper bound, just like maxPile was the safe upper bound in Koko.
//
// Q4. Why does totalDays start at 1, not 0?
// A4. The very first package always belongs to day 1, even before any
//     overflow happens. If you started at 0, you'd undercount by one day.
//
// Q5. Why is the feasibility check monotonic here too?
// A5. As capacity increases, the number of days needed never increases
//     (it can only decrease or stay the same). That false...false,
//     true...true pattern is what makes binary search valid.


// MARK: - Brute Force Approach
// Try every possible capacity from maxWeight to sum(weights),
// return the smallest one that works.
// Time: O((sum - max) * n)   Space: O(1)

func shipWithinDaysBruteForce(weights: [Int], days: Int) -> Int {

    var maxWeight = Int.min
    var totalWeight = 0

    for weight in weights {
        if weight > maxWeight {
            maxWeight = weight
        }
        totalWeight += weight
    }

    for cap in maxWeight...totalWeight {
        if canShipBrute(weights: weights, days: days, capacity: cap) {
            return cap
        }
    }

    return totalWeight
}

func canShipBrute(weights: [Int], days: Int, capacity: Int) -> Bool {

    var currentLoad = 0
    var daysNeeded = 1

    for i in 0..<weights.count {

        if currentLoad + weights[i] > capacity {
            daysNeeded += 1
            currentLoad = weights[i]
        } else {
            currentLoad += weights[i]
        }
    }

    return daysNeeded <= days
}


// MARK: - Optimised Approach
// Binary search on the answer space (capacity).
// Same feasibility check, but binary search shrinks the range
// using the monotonic property instead of trying every value.
// Time: O(n log(sum - max))   Space: O(1)

func shipWithinDaysOptimised(weights: [Int], days: Int) -> Int {

    var maxWeight = Int.min
    var totalWeight = 0

    for weight in weights {
        if weight > maxWeight {
            maxWeight = weight
        }
        totalWeight += weight
    }

    var left = maxWeight
    var right = totalWeight
    var answer = totalWeight

    while left <= right {

        let mid = left + (right - left) / 2

        if canShip(weights: weights, days: days, capacity: mid) {
            answer = mid
            right = mid - 1
        } else {
            left = mid + 1
        }
    }

    return answer
}

func canShip(weights: [Int], days: Int, capacity: Int) -> Bool {

    var currentLoad = 0
    var daysNeeded = 1

    for i in 0..<weights.count {

        if currentLoad + weights[i] > capacity {
            daysNeeded += 1
            currentLoad = weights[i]
        } else {
            currentLoad += weights[i]
        }
    }

    return daysNeeded <= days
}


// MARK: - Dry Run
//
// weights = [1,2,3,4,5,6,7,8,9,10], days = 5
//
// maxWeight = 10, totalWeight = 55
// left = 10, right = 55, answer = 55
//
// Iteration 1: mid = 10 + (55-10)/2 = 32
//   canShip(cap=32): loads -> [1,2,3,4,5,6,7]=28, +8=36>32 -> day2 starts at 8
//                     day2: 8+9=17, +10=27 -> day2 = [8,9,10]
//                     daysNeeded = 2 -> 2 <= 5, true
//   answer = 32, right = 31
//
// Iteration 2: mid = 10 + (31-10)/2 = 20
//   canShip(cap=20): day1=[1,2,3,4,5,6]=21? wait recompute:
//     1+2=3,+3=6,+4=10,+5=15,+6=21>20 -> day1=[1,2,3,4,5]=15, day2 starts at 6
//     day2: 6+7=13,+8=21>20 -> day2=[6,7], day3 starts at 8
//     day3: 8+9=17,+10=27>20 -> day3=[8,9], day4 starts at 10
//     day4: [10]
//     daysNeeded = 4 -> 4 <= 5, true
//   answer = 20, right = 19
//
// Iteration 3: mid = 10 + (19-10)/2 = 14
//   canShip(cap=14): day1=[1,2,3,4]=10,+5=15>14 -> day1=[1,2,3,4]
//     day2 starts at 5: 5+6=11,+7=18>14 -> day2=[5,6]
//     day3 starts at 7: 7+8=15>14 -> day3=[7]
//     day4 starts at 8: 8+9=17>14 -> day4=[8]
//     day5 starts at 9: 9+10=19>14 -> day5=[9]
//     day6 starts at 10: [10]
//     daysNeeded = 6 -> 6 <= 5, false
//   left = 15
//
// Iteration 4: mid = 15 + (19-15)/2 = 17
//   canShip(cap=17): day1=[1,2,3,4,5]=15,+6=21>17 -> day1 done
//     day2 starts at 6: 6+7=13,+8=21>17 -> day2=[6,7]
//     day3 starts at 8: 8+9=17,+10=27>17 -> day3=[8,9]
//     day4 starts at 10: [10]
//     daysNeeded = 4 -> 4 <= 5, true
//   answer = 17, right = 16
//
// Iteration 5: mid = 15 + (16-15)/2 = 15
//   canShip(cap=15): day1=[1,2,3,4,5]=15,+6=21>15 -> day1 done
//     day2 starts at 6: 6+7=13,+8=21>15 -> day2=[6,7]
//     day3 starts at 8: 8+9=17>15 -> day3=[8]
//     day4 starts at 9: 9+10=19>15 -> day4=[9]
//     day5 starts at 10: [10]
//     daysNeeded = 5 -> 5 <= 5, true
//   answer = 15, right = 14
//
// left = 15, right = 14 -> left > right, loop ends
//
// Return answer = 15   ✅ matches expected output


// MARK: - Complexity
//
// | Approach     | Time                    | Space |
// |--------------|-------------------------|-------|
// | Brute Force  | O((sum - max) * n)      | O(1)  |
// | Optimised    | O(n log(sum - max))     | O(1)  |
//
// n = weights.count, sum = total weight, max = heaviest package


// MARK: - Traps
//
// 1. Starting daysNeeded at 0 instead of 1 — undercounts by one day, since
//    the first package always occupies day 1 before any overflow check runs.
// 2. Starting left at 1 (like Koko) instead of maxWeight — a capacity below
//    the heaviest package can never ship that package at all, so it's not
//    just slower, it's flatly infeasible.
// 3. Returning immediately when canShip(mid) is true — finds *a* feasible
//    capacity, not necessarily the minimum one. Must keep shrinking right.
// 4. Forgetting that currentLoad resets to weights[i] (not 0) on overflow —
//    the overflowing package still needs to start the new day's load.
// 5. Off-by-one in loop condition — must be `while left <= right`, not `<`.


// MARK: - Tests

let weights = [1,2,3,4,5,6,7,8,9,10]
let days = 5

print(shipWithinDaysBruteForce(weights: weights, days: days))   // 15
print(shipWithinDaysOptimised(weights: weights, days: days))    // 15

print(shipWithinDaysBruteForce(weights: [3,2,2,4,1,4], days: 3)) // 6
print(shipWithinDaysOptimised(weights: [3,2,2,4,1,4], days: 3))  // 6

print(shipWithinDaysBruteForce(weights: [1,2,3,1,1], days: 4))  // 3
print(shipWithinDaysOptimised(weights: [1,2,3,1,1], days: 4))   // 3

print(shipWithinDaysBruteForce(weights: [5], days: 1))  // 5 (edge: single package)
print(shipWithinDaysOptimised(weights: [5], days: 1))   // 5
