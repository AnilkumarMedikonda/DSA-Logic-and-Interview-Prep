// MARK: - Problem
// LeetCode 875 — Koko Eating Bananas
//
// Koko has `n` piles of bananas. She has `h` hours total.
// Each hour she picks one pile and eats at most `k` bananas from it.
// If the pile has fewer than `k` bananas, she eats the whole pile and the
// rest of that hour is wasted (she can't move to another pile in the same hour).
//
// Find the minimum integer eating speed `k` such that she can finish all
// piles within `h` hours.
//
// Example:
// piles = [3, 6, 7, 11], h = 8
// Answer: 4


// MARK: - Interview Q&A
//
// Q1. Why can't we just do sum(piles) / h?
// A1. Because each pile is processed independently — leftover bananas in one
//     pile don't combine with another pile. Pooling the totals ignores the
//     per-pile hour cost (see trace below).
//
// Q2. Why do we need ceiling division in the feasibility check?
// A2. Koko eats in whole hours. If a pile isn't fully eaten in n full hours,
//     the leftover still costs one more full hour. ceil(pile / k) captures this.
//
// Q3. Why does the search space go from 1 to maxPile?
// A3. k = 1 is the slowest valid speed (must eat at least 1 banana/hour).
//     k = maxPile is the fastest *useful* speed — it finishes the largest
//     pile in exactly one hour. Anything faster wastes potential since only
//     one pile can be worked on per hour.
//
// Q4. Why is the feasibility check monotonic, and why does that justify binary search?
// A4. As k increases, total hours needed never increases (it can only decrease
//     or stay the same). So the feasibility results look like:
//     false, false, false, ..., true, true, true
//     This sorted true/false pattern is exactly what binary search exploits.
//
// Q5. Why not return immediately when canFinish(mid) is true?
// A5. mid being feasible doesn't mean it's the *smallest* feasible k. There
//     could be a smaller k that's also feasible. Save it as a candidate
//     answer, then keep searching the left half for something smaller.


// MARK: - Brute Force Approach
// Try every possible k from 1 to maxPile, return the smallest k that works.
// Time: O(maxPile * n)   Space: O(1)

func minEatingSpeedBruteForce(piles: [Int], h: Int) -> Int {

    var maxPile = Int.min

    for pile in piles {
        if pile > maxPile {
            maxPile = pile
        }
    }

    for k in 1...maxPile {
        if canFinishBrute(piles: piles, h: h, k: k) {
            return k
        }
    }

    return maxPile
}

func canFinishBrute(piles: [Int], h: Int, k: Int) -> Bool {

    var totalHours = 0

    for i in 0..<piles.count {

        var hoursForThisPile = piles[i] / k

        if piles[i] % k != 0 {
            hoursForThisPile += 1
        }

        totalHours += hoursForThisPile
    }

    return totalHours <= h
}


// MARK: - Optimised Approach
// Binary search on the answer space (k = eating speed).
// Same feasibility check, but instead of trying every k linearly,
// binary search shrinks the range using the monotonic property.
// Time: O(n log maxPile)   Space: O(1)

func minEatingSpeedOptimised(piles: [Int], h: Int) -> Int {

    var maxPile = Int.min

    for pile in piles {
        if pile > maxPile {
            maxPile = pile
        }
    }

    var left = 1
    var right = maxPile
    var answer = maxPile

    while left <= right {

        let mid = left + (right - left) / 2

        if canEatBananas(piles: piles, h: h, k: mid) {
            answer = mid
            right = mid - 1
        } else {
            left = mid + 1
        }
    }

    return answer
}

func canEatBananas(piles: [Int], h: Int, k: Int) -> Bool {

    var totalHours = 0

    for i in 0..<piles.count {

        var hoursOfThePile = piles[i] / k

        if piles[i] % k != 0 {
            hoursOfThePile += 1
        }

        totalHours += hoursOfThePile
    }

    return totalHours <= h
}


// MARK: - Dry Run
//
// piles = [3, 6, 7, 11], h = 8
//
// maxPile = 11
// left = 1, right = 11, answer = 11
//
// Iteration 1: mid = 1 + (11-1)/2 = 6
//   canEatBananas(k=6): hours = ceil(3/6)+ceil(6/6)+ceil(7/6)+ceil(11/6)
//                              = 1 + 1 + 2 + 2 = 6   -> 6 <= 8, true
//   answer = 6, right = 5
//
// Iteration 2: mid = 1 + (5-1)/2 = 3
//   canEatBananas(k=3): hours = ceil(3/3)+ceil(6/3)+ceil(7/3)+ceil(11/3)
//                              = 1 + 2 + 3 + 4 = 10  -> 10 <= 8, false
//   left = 4
//
// Iteration 3: mid = 4 + (5-4)/2 = 4
//   canEatBananas(k=4): hours = ceil(3/4)+ceil(6/4)+ceil(7/4)+ceil(11/4)
//                              = 1 + 2 + 2 + 3 = 8   -> 8 <= 8, true
//   answer = 4, right = 3
//
// Loop ends: left = 4, right = 3 -> left > right, stop
//
// Return answer = 4   ✅ matches expected output


// MARK: - Complexity
//
// | Approach     | Time            | Space |
// |--------------|-----------------|-------|
// | Brute Force  | O(maxPile * n)  | O(1)  |
// | Optimised    | O(n log maxPile)| O(1)  |
//
// n = piles.count, maxPile = largest pile value


// MARK: - Traps
//
// 1. Forgetting ceiling division — using piles[i] / k alone undercounts hours
//    whenever there's a remainder.
// 2. Returning immediately when canFinish(mid) is true — this finds *a*
//    feasible k, not necessarily the *minimum* one. Must keep searching left.
// 3. Starting left at 0 instead of 1 — k = 0 causes division by zero inside
//    the feasibility check.
// 4. Using sum(piles) / h instead of per-pile division — ignores that each
//    pile's leftover hours don't combine with other piles.
// 5. Off-by-one in loop condition — must be `while left <= right`, not `<`,
//    otherwise the case left == right is never checked.


// MARK: - Tests

let piles = [3, 6, 7, 11]
let h = 8

print(minEatingSpeedBruteForce(piles: piles, h: h))   // 4
print(minEatingSpeedOptimised(piles: piles, h: h))    // 4

print(minEatingSpeedBruteForce(piles: [30, 11, 23, 4, 20], h: 5))  // 30
print(minEatingSpeedOptimised(piles: [30, 11, 23, 4, 20], h: 5))   // 30

print(minEatingSpeedBruteForce(piles: [30, 11, 23, 4, 20], h: 6))  // 23
print(minEatingSpeedOptimised(piles: [30, 11, 23, 4, 20], h: 6))   // 23

print(minEatingSpeedBruteForce(piles: [1, 1, 1, 1], h: 4))  // 1 (edge: minimum possible speed)
print(minEatingSpeedOptimised(piles: [1, 1, 1, 1], h: 4))   // 1
