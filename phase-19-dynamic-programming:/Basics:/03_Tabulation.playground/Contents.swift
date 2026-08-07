//  03_Tabulation.swift
//
//  CONCEPT: Tabulation (Bottom-Up DP)
//
//  Memoization asked "what do I need?" and recursed down.
//  Tabulation asks "what can I build?" and loops up.
//
//  No recursion, no call stack, no cache-miss branch.
//  Fill dp[0], dp[1], then dp[2] from them, then dp[3], and so on
//  until dp[n] is the answer.
//
//  Time:  O(n)  — one pass
//  Space: O(n)  — the dp array (removed in file 04)

import Foundation

//  ---------------------------------------------------------------
//  Tabulated fib
//  ---------------------------------------------------------------

func fibTab(_ n: Int) -> Int {

    //  guard the small inputs so dp[1] is safe to write
    if n <= 1 {

        return n
    }

    var dp = Array(repeating: 0, count: n + 1)

    //  base cases — seeded by hand
    dp[0] = 0

    dp[1] = 1

    //  transition — every cell from the two before it
    for i in 2...n {

        dp[i] = dp[i - 1] + dp[i - 2]
    }

    return dp[n]
}

print(fibTab(20))

//  ---------------------------------------------------------------
//  The array filling, step by step
//  ---------------------------------------------------------------
//
//  index:   0    1    2    3    4    5
//         [ 0 ,  1 ,  _ ,  _ ,  _ ,  _ ]   seeded
//         [ 0 ,  1 ,  1 ,  _ ,  _ ,  _ ]   i=2: 1 + 0
//         [ 0 ,  1 ,  1 ,  2 ,  _ ,  _ ]   i=3: 1 + 1
//         [ 0 ,  1 ,  1 ,  2 ,  3 ,  _ ]   i=4: 2 + 1
//         [ 0 ,  1 ,  1 ,  2 ,  3 ,  5 ]   i=5: 3 + 2
//
//  Compare with the memo trace from file 02. The STORE lines there
//  printed memo[2], memo[3], memo[4], memo[5] — the same order.
//  Tabulation just writes that order directly instead of
//  discovering it through recursion.

//  ---------------------------------------------------------------
//  With a trace
//  ---------------------------------------------------------------

func fibTabTrace(_ n: Int) -> Int {

    if n <= 1 {

        return n
    }

    var dp = Array(repeating: 0, count: n + 1)

    dp[0] = 0

    dp[1] = 1

    print("seed  dp = \(dp)")

    for i in 2...n {

        dp[i] = dp[i - 1] + dp[i - 2]

        print("i=\(i)   dp[\(i)] = dp[\(i-1)] + dp[\(i-2)] = \(dp[i-1]) + \(dp[i-2]) = \(dp[i])")
    }

    return dp[n]
}

print(fibTabTrace(6))

//  ---------------------------------------------------------------
//  The four things to write down, in order
//  ---------------------------------------------------------------
//
//  1. STATE        what does dp[i] mean?
//                  "dp[i] = the i-th fibonacci number"
//
//  2. BASE CASE    which cells are known without computing?
//                  dp[0] = 0, dp[1] = 1
//
//  3. TRANSITION   how is dp[i] built from earlier cells?
//                  dp[i] = dp[i-1] + dp[i-2]
//
//  4. ANSWER       which cell holds the result?
//                  dp[n]
//
//  Get these four right and the code writes itself.
//  Get the STATE wrong and nothing else can be fixed.
//  File 05 is entirely about step 1 and 3.

//  ---------------------------------------------------------------
//  Tabulation vs memoization — how to choose
//  ---------------------------------------------------------------
//
//  Tabulation wins when:
//    - n is large        no stack overflow risk
//    - every state is needed anyway     no wasted cells
//    - you want O(1) space              only possible bottom-up (file 04)
//
//  Memoization wins when:
//    - the state space is sparse        only reachable states get computed
//    - the recurrence is easier to see top-down
//    - the state is not a clean index   dictionary cache
//
//  In an interview: solve it top-down first because the recurrence
//  is easier to reason about, then say "this converts to bottom-up
//  by filling the table in increasing order of n." That sentence
//  shows you understand both are the same recurrence.
