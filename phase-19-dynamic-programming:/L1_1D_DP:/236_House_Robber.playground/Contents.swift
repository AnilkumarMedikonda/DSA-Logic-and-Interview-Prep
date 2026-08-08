//  235_Climbing_Stairs.swift
//  LeetCode 70 — Climbing Stairs
//
//  PROBLEM
//  Climbing a staircase with n steps. Each move you climb either
//  1 step or 2 steps. How many distinct ways to reach the top?
//
//  EXAMPLE
//  Input:  n = 3
//  Output: 3        (1+1+1, 1+2, 2+1 — order matters)
//
//  CONSTRAINTS
//  1 <= n <= 45
//
//  THE SIX LINES
//  1. STATE       dp[i] = number of distinct ways to reach step i
//  2. OPTIONS     arrived at i from i-1 (one step) or i-2 (two steps)
//  3. COMBINER    +   (counting problem)
//  4. TRANSITION  dp[i] = dp[i-1] + dp[i-2]
//  5. BASE        dp[1] = 1, dp[2] = 2
//  6. ANSWER      dp[n]

let n = 5

print("=========================================")

print("  CLIMBING STAIRS   n = \(n)")

print("=========================================\n")


//====================================================
// MARK: - Solution 1 : Recursion
// Time  : O(2^n)   every call branches twice, depth n
// Space : O(n)     recursion stack
//====================================================

func climbStairsRecursion(_ n: Int) -> Int {

    if n == 1 {

        return 1
    }

    if n == 2 {

        return 2
    }

    return climbStairsRecursion(n - 1) + climbStairsRecursion(n - 2)
}

print("[1] RECURSION")

print("    ways  =", climbStairsRecursion(n))

print("    note  = fib(3) rebuilt on both branches -> exponential\n")


//====================================================
// MARK: - Solution 2 : Memoization  (top-down)
// Time  : O(n)     each n computed once
// Space : O(n)     memo array + stack
//====================================================

func climbStairsMemo(_ n: Int, _ dp: inout [Int]) -> Int {

    if n == 1 {

        return 1
    }

    if n == 2 {

        return 2
    }

    // already calculated
    if dp[n] != -1 {

        return dp[n]
    }

    // calculate and store
    dp[n] = climbStairsMemo(n - 1, &dp) + climbStairsMemo(n - 2, &dp)

    return dp[n]
}

var memo = Array(repeating: -1, count: n + 1)

print("[2] MEMOIZATION")

print("    ways  =", climbStairsMemo(n, &memo))

print("    memo  =", memo)

print("    note  = -1 slots were never reached\n")


//====================================================
// MARK: - Solution 3 : Tabulation  (bottom-up)
// Time  : O(n)     one pass
// Space : O(n)     the dp array
//====================================================

func climbStairsTabulation(_ n: Int) -> Int {

    // guard BEFORE allocating — dp[2] would crash when n == 1
    if n <= 2 {

        return n == 1 ? 1 : 2
    }

    var dp = Array(repeating: 0, count: n + 1)

    dp[1] = 1

    dp[2] = 2

    print("    seed  dp =", dp)

    for i in 3...n {

        dp[i] = dp[i - 1] + dp[i - 2]

        print("    i=\(i)   dp[\(i)] = \(dp[i-1]) + \(dp[i-2]) = \(dp[i])")
    }

    print("    final dp =", dp)

    return dp[n]
}

print("[3] TABULATION")

print("    ways  =", climbStairsTabulation(n), "\n")


//====================================================
// MARK: - Solution 4 : Space Optimization  (INTERVIEW ANSWER)
// Time  : O(n)
// Space : O(1)     transition reaches back only 2 cells
//====================================================

func climbStairsSpace(_ n: Int) -> Int {

    if n <= 2 {

        return n == 1 ? 1 : 2
    }

    var prev2 = 1      // ways to reach step 1

    var prev1 = 2      // ways to reach step 2

    for i in 3...n {

        let current = prev1 + prev2

        print("    step \(i)   current = \(prev1) + \(prev2) = \(current)")

        prev2 = prev1

        prev1 = current
    }

    return prev1
}

print("[4] SPACE OPTIMIZATION")

print("    ways  =", climbStairsSpace(n), "\n")


//====================================================
// MARK: - Verify all four agree
//====================================================

print("=========================================")

print("  VERIFY")

print("=========================================")

for value in [1, 2, 3, 4, 5, 10] {

    var scratch = Array(repeating: -1, count: value + 1)

    let a = climbStairsRecursion(value)

    let b = climbStairsMemo(value, &scratch)

    let c = climbStairsTabulation(value)

    let d = climbStairsSpace(value)

    let ok = (a == b && b == c && c == d)

    print("n=\(value)   \(a) \(b) \(c) \(d)   \(ok ? "OK" : "MISMATCH")")
}

//  n=1    1 1 1 1     OK
//  n=2    2 2 2 2     OK
//  n=3    3 3 3 3     OK
//  n=4    5 5 5 5     OK
//  n=5    8 8 8 8     OK
//  n=10   89 89 89 89 OK


//====================================================
// MARK: - Traps logged
//====================================================
//
//  1. `return n` for base cases works ONLY because the answer
//     equals the input at n = 1 and n = 2. Write the values you
//     mean, not the coincidence.
//  2. Guard before allocating — dp[2] = 2 crashes when n == 1.
//  3. Naive recursion is O(2^n), NOT O(n^2).
//  4. Strip the prints before submitting; the optimized loop's
//     index is then unused -> `for _ in 3...n`.
