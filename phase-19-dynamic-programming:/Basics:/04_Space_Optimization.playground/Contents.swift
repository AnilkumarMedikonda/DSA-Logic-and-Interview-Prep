//  04_Space_Optimization.swift
//
//  CONCEPT: Space Optimization (Rolling Variables)
//
//  Look at the transition from file 03:
//
//      dp[i] = dp[i - 1] + dp[i - 2]
//
//  It reads only the two cells before i. It never looks at
//  dp[i - 3] or anything older. So the whole array is not needed —
//  only a two-cell window that slides forward.
//
//  Time:  O(n)  — unchanged
//  Space: O(n) -> O(1)

import Foundation

//  ---------------------------------------------------------------
//  Two rolling variables
//  ---------------------------------------------------------------

func fibOptimized(_ n: Int) -> Int {

    if n <= 1 {

        return n
    }

    //  prev2 stands in for dp[i - 2]
    //  prev1 stands in for dp[i - 1]
    var prev2 = 0

    var prev1 = 1

    for _ in 2...n {

        let current = prev1 + prev2

        //  slide the window forward by one
        prev2 = prev1

        prev1 = current
    }

    return prev1
}

print(fibOptimized(20))

//  ---------------------------------------------------------------
//  The window sliding, step by step for n = 5
//  ---------------------------------------------------------------
//
//  start      prev2 = 0   prev1 = 1
//  i = 2      current = 1 + 0 = 1    ->  prev2 = 1   prev1 = 1
//  i = 3      current = 1 + 1 = 2    ->  prev2 = 1   prev1 = 2
//  i = 4      current = 2 + 1 = 3    ->  prev2 = 2   prev1 = 3
//  i = 5      current = 3 + 2 = 5    ->  prev2 = 3   prev1 = 5
//
//  answer = prev1 = 5
//
//  The array from file 03 was [0, 1, 1, 2, 3, 5].
//  Those values all still appear here — they just get overwritten
//  as soon as they fall out of the two-cell window.

//  ---------------------------------------------------------------
//  ORDER OF ASSIGNMENT — the bug that bites everyone
//  ---------------------------------------------------------------
//
//  This is WRONG:
//
//      prev1 = prev1 + prev2      // prev1 is now the new value
//      prev2 = prev1              // prev2 gets the NEW prev1, not the old one
//
//  prev2 must be updated from the OLD prev1. Either hold the sum in
//  a `current` constant first (as above), or use a tuple swap:

func fibTuple(_ n: Int) -> Int {

    if n <= 1 {

        return n
    }

    var prev2 = 0

    var prev1 = 1

    for _ in 2...n {

        (prev2, prev1) = (prev1, prev1 + prev2)
    }

    return prev1
}

print(fibTuple(20))

//  The tuple form evaluates the whole right side before assigning,
//  so the old prev1 is used on both sides. Safe, and idiomatic Swift.

//  ---------------------------------------------------------------
//  WHEN THIS IS ALLOWED
//  ---------------------------------------------------------------
//
//  Only when the transition reads a FIXED, SMALL number of recent
//  cells. Count how far back the recurrence reaches:
//
//      dp[i] = dp[i-1] + dp[i-2]              reaches back 2  -> 2 variables
//      dp[i] = max(dp[i-1], dp[i-2] + a[i])   reaches back 2  -> 2 variables
//      dp[i] = min over all j < i             reaches back i  -> KEEP THE ARRAY
//
//  Longest Increasing Subsequence is the third kind. Every dp[i]
//  scans every earlier dp[j], so there is no window to slide and
//  the array must stay. Do not force this optimization where the
//  recurrence does not allow it.
//
//  ---------------------------------------------------------------
//  WHEN NOT TO DO IT
//  ---------------------------------------------------------------
//
//  If the problem asks you to RECONSTRUCT the answer — which coins,
//  which houses, which subsequence — you need the full table to
//  walk back through. Optimizing space throws away the history.
//
//  Coin Change asks for the count, so O(1) space is fine on the
//  1D version. "Print the actual coins used" would not be.

//  ---------------------------------------------------------------
//  Interview sequence
//  ---------------------------------------------------------------
//
//  1. brute force recursion     "O(2^n), here is why"
//  2. add memo                  "O(n) time, O(n) space"
//  3. convert to tabulation     "same recurrence, no stack"
//  4. collapse to variables     "only two cells are ever read"
//
//  Say step 4 out loud even if you do not have time to code it.
//  Naming the optimization scores nearly as well as writing it.
