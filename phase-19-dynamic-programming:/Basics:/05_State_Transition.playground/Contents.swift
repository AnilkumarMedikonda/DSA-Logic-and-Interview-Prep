//  05_State_Transition.swift
//
//  CONCEPT: Defining the State and the Transition
//
//  Files 01–04 optimized ONE recurrence four ways. But the
//  recurrence was handed to you: dp[i] = dp[i-1] + dp[i-2].
//  In a real problem nobody hands it to you. You invent it.
//
//  Two questions, in this order:
//    STATE       what does dp[i] MEAN?
//    TRANSITION  how do I build dp[i] from smaller states?

import Foundation

//  ---------------------------------------------------------------
//  RULE 1 — the state must be a sentence, not a variable
//  ---------------------------------------------------------------
//
//  BAD:   "dp[i] is something about the array"
//  GOOD:  "dp[i] = the maximum money robbable from houses 0...i"
//
//  A valid state sentence has three parts:
//    1. what quantity      max money / number of ways / min coins
//    2. over what range    from index 0 up to and including i
//    3. under what rule    ending at i / using at most i

//  ---------------------------------------------------------------
//  RULE 2 — "ending at i" vs "up to i" are DIFFERENT states
//  ---------------------------------------------------------------
//
//  "up to i"     dp[i] considers i but need not use it.
//                dp[i] is non-decreasing. Answer is dp[n-1].
//
//  "ending at i" dp[i] MUST use element i.
//                dp[i] rises and falls. Answer is max(dp).
//
//  House Robber -> "up to i"     -> dp[n-1]
//  LIS          -> "ending at i" -> max(dp)

//  ---------------------------------------------------------------
//  RULE 3 — the transition is a CHOICE at index i
//  ---------------------------------------------------------------
//
//  max()  -> optimization   (most money, longest)
//  min()  -> minimization   (fewest coins)
//  +      -> counting       (how many ways)
//  ||     -> feasibility    (is it possible)
//
//  The combiner also fixes the base case:
//    max/min -> trivial best,  + -> 1,  || -> true

//  ---------------------------------------------------------------
//  WORKED EXAMPLE — Min Cost Climbing Stairs (LC 746)
//  ---------------------------------------------------------------
//
//  Pay cost[i] to step on i. From i move 1 or 2 forward.
//  Start free at index 0 or 1. Reach past the end for minimum cost.
//
//  1. STATE       dp[i] = min cost to REACH index i
//  2. OPTIONS     arrived from i-1, or arrived from i-2
//  3. COMBINER    min()
//  4. TRANSITION  dp[i] = min(dp[i-1] + cost[i-1], dp[i-2] + cost[i-2])
//  5. BASE        dp[0] = 0, dp[1] = 0   (starting is free)
//  6. ANSWER      dp[n]                  ("past the end" is index n)
//
//  Time:  O(n)   one pass
//  Space: O(n)   the dp array

func minCostClimb(_ cost: [Int]) -> Int {

    let n = cost.count

    //  GUARD FIRST — before allocating, before seeding.
    //  n == 0 would make dp count 1, and dp[1] would crash.
    if n < 2 {

        return 0
    }

    var dp = Array(repeating: 0, count: n + 1)

    //  dp[0] and dp[1] are already 0 from the initializer.
    //  That IS the base case — nothing to seed.

    for i in 2...n {

        dp[i] = min(dp[i - 1] + cost[i - 1], dp[i - 2] + cost[i - 2])
    }

    return dp[n]
}

print(minCostClimb([10, 15, 20]))

print(minCostClimb([1, 100, 1, 1, 1, 100, 1, 1, 100, 1]))

print(minCostClimb([]))

print(minCostClimb([5]))

//  expected: 15, 6, 0, 0

//  ---------------------------------------------------------------
//  Traced version — watch the table fill
//  ---------------------------------------------------------------

func minCostClimbTrace(_ cost: [Int]) -> Int {

    let n = cost.count

    if n < 2 {

        print("n = \(n), nothing
