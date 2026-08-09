//  235_Climbing_Stairs.swift
//  LeetCode 70 — Climbing Stairs
//
//  PROBLEM
//  You are climbing a staircase with n steps. Each move you climb
//  either 1 step or 2 steps. How many distinct ways can you reach
//  the top?
//
//  EXAMPLE
//  Input:  n = 3
//  Output: 3
//  Explanation: 1+1+1, 1+2, 2+1  (order matters)
//
//  CONSTRAINTS
//  1 <= n <= 45
//
//  ---------------------------------------------------------------
//  THE SIX LINES
//  ---------------------------------------------------------------
//
//  1. STATE       dp[i] = number of distinct ways to reach step i
//  2. OPTIONS     I arrived at i from i-1 (one step) or i-2 (two steps)
//  3. COMBINER    +   (counting problem — total the branches)
//  4. TRANSITION  dp[i] = dp[i-1] + dp[i-2]
//  5. BASE        dp[1] = 1, dp[2] = 2
//  6. ANSWER      dp[n]
//
//  This is Fibonacci shifted by one. Recognize it, but still say
//  the derivation out loud — the interviewer grades the reasoning.


//  ---------------------------------------------------------------
//  SOLUTION 1 — Naive recursion
//  Time:  O(2^n)   every call branches twice, depth n
//  Space: O(n)     recursion stack
//  ---------------------------------------------------------------

func climbStairsNaive(_ n: Int) -> Int {

    if n <= 2 {

        return n == 1 ? 1 : 2
    }

    return climbStairsNaive(n - 1) + climbStairsNaive(n - 2)
}


//  ---------------------------------------------------------------
//  SOLUTION 2 — Memoization (top-down)
//  Time:  O(n)     each n computed once
//  Space: O(n)     memo array + stack
//  ---------------------------------------------------------------

func climbStairsMemo(_ n: Int) -> Int {

    var memo = Array(repeating: -1, count: n + 1)

    return solve(n, &memo)
}

func solve(_ n: Int, _ memo: inout [Int]) -> Int {

    if n <= 2 {

        return n == 1 ? 1 : 2
    }

    if memo[n] != -1 {

        return memo[n]
    }

    memo[n] = solve(n - 1, &memo) + solve(n - 2, &memo)

    return memo[n]
}


//  ---------------------------------------------------------------
//  SOLUTION 3 — Tabulation (bottom-up)
//  Time:  O(n)     one pass
//  Space: O(n)     the dp array
//  ---------------------------------------------------------------

func climbStairsTabulation(_ n: Int) -> Int {

    //  guard BEFORE allocating — dp[2] would crash when n == 1
    if n <= 2 {

        return n == 1 ? 1 : 2
    }

    var dp = Array(repeating: 0, count: n + 1)

    dp[1] = 1

    dp[2] = 2

    for i in 3...n {

        dp[i] = dp[i - 1] + dp[i - 2]
    }

    return dp[n]
}


//  ---------------------------------------------------------------
//  SOLUTION 4 — Space optimized (INTERVIEW ANSWER)
//  Time:  O(n)
//  Space: O(1)     transition reaches back only 2 cells
//  ---------------------------------------------------------------

func climbStairsOptimized(_ n: Int) -> Int {

    if n <= 2 {

        return n == 1 ? 1 : 2
    }

    var prev2 = 1

    var prev1 = 2

    //  no index needed — the transition reads no array
    for _ in 3...n {

        let current = prev1 + prev2

        prev2 = prev1

        prev1 = current
    }

    return prev1
}


//  ---------------------------------------------------------------
//  Verify all four agree
//  ---------------------------------------------------------------

let testCases = [1, 2, 3, 4, 5, 10]

for n in testCases {

    let a = climbStairsNaive(n)

    let b = climbStairsMemo(n)

    let c = climbStairsTabulation(n)

    let d = climbStairsOptimized(n)

    let ok = (a == b && b == c && c == d)

    print("n = \(n)   naive: \(a)   memo: \(b)   tab: \(c)   opt: \(d)   \(ok ? "OK" : "MISMATCH")")
}

//  n = 1    1 1 1 1
//  n = 2    2 2 2 2
//  n = 3    3 3 3 3
//  n = 4    5 5 5 5
//  n = 5    8 8 8 8
//  n = 10   89 89 89 89


//  ---------------------------------------------------------------
//  TRAPS LOGGED
//  ---------------------------------------------------------------
//
//  1. Returning `n` for base cases works ONLY because the answer
//     happens to equal the input at n = 1 and n = 2. Write the
//     values you mean, not the coincidence.
//
//  2. Guard before allocating. dp[2] = 2 crashes for n == 1.
//
//  3. Naive recursion here is O(2^n), NOT O(n^2). Naming the wrong
//     complexity undercuts the whole optimization story.
//
//  4. In the optimized loop the index is unused — use `for _ in`.
//     (Min Cost Climbing Stairs DOES need the index, because its
//      transition reads cost[i-1]. Do not generalize either way.)
