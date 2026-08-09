//  01_DP_Basics.swift
//
//  CONCEPT: What is Dynamic Programming?
//
//  DP = recursion + remembering answers you already computed.
//
//  A problem is a DP problem only if BOTH hold:
//
//  1. Overlapping Subproblems
//     The same smaller input gets solved more than once.
//     (If every subproblem is unique, it's plain divide & conquer —
//      merge sort, binary search. Caching there buys nothing.)
//
//  2. Optimal Substructure
//     The answer for n is built from the answers for smaller inputs.
//     fib(n) = fib(n-1) + fib(n-2)
//
//  Complexity of the naive version below:
//  Time:  O(2^n)  — branching factor 2, depth n
//  Space: O(n)    — recursion stack depth

import Foundation

//  ---------------------------------------------------------------
//  Naive recursion — correct, but exponential
//  ---------------------------------------------------------------

func fibNaive(_ n: Int) -> Int {

    if n <= 1 {

        return n
    }

    return fibNaive(n - 1) + fibNaive(n - 2)
}

//  ---------------------------------------------------------------
//  Why it is slow — the call tree for fib(5)
//  ---------------------------------------------------------------
//
//                        fib(5)
//                 /                  \
//            fib(4)                  fib(3)
//           /      \                /      \
//      fib(3)      fib(2)      fib(2)      fib(1)
//      /    \      /    \      /    \
//  fib(2) fib(1) fib(1) fib(0) fib(1) fib(0)
//   /   \
// fib(1) fib(0)
//
//  fib(3) is computed 2 times.
//  fib(2) is computed 3 times.
//  fib(1) is computed 5 times.
//
//  THAT repetition is the overlapping subproblem.
//  Every DP technique in files 02–04 exists to kill it.

//  ---------------------------------------------------------------
//  Proof by counting calls
//  ---------------------------------------------------------------

var callCount = 0

@MainActor
func fibCounted(_ n: Int) -> Int {

    callCount += 1

    if n <= 1 {

        return n
    }

    return fibCounted(n - 1) + fibCounted(n - 2)
}

let result = fibCounted(20)

print("fib(20) = \(result)")

print("calls made = \(callCount)")

//  fib(20) = 6765
//  calls made = 21891
//
//  21,891 calls to produce 21 distinct values.
//  Bump n to 40 and it is ~331 million calls.

//  ---------------------------------------------------------------
//  The three forms every DP problem takes
//  ---------------------------------------------------------------
//
//  Naive recursion   ->  O(2^n) time, O(n) space      (this file)
//  Memoization       ->  O(n)   time, O(n) space      (file 02, top-down)
//  Tabulation        ->  O(n)   time, O(n) space      (file 03, bottom-up)
//  Space optimized   ->  O(n)   time, O(1) space      (file 04)
//
//  In an interview: state the naive recurrence first, name the
//  repetition out loud, then optimize. That sequence is the answer
//  they are grading, not the final code.
