//  02_Memoization.swift
//
//  CONCEPT: Memoization (Top-Down DP)
//
//  Keep the naive recursion exactly as it is. Before computing,
//  check a cache. After computing, store the result.
//
//  The recursion still drives the order; the cache just refuses
//  to solve the same subproblem twice.
//
//  Time:  O(n)  — each of the n states is computed once
//  Space: O(n)  — cache + recursion stack

import Foundation

//  ---------------------------------------------------------------
//  Memoized fib — array cache
//  ---------------------------------------------------------------
//
//  -1 is the sentinel for "not computed yet".
//  Use it instead of 0, because 0 is a legitimate answer (fib(0) = 0).

func fibMemo(_ n: Int) -> Int {

    var memo = Array(repeating: -1, count: n + 1)

    return solve(n, &memo)
}

func solve(_ n: Int, _ memo: inout [Int]) -> Int {

    //  base case
    if n <= 1 {

        return n
    }

    //  cache hit — the whole point of the file
    if memo[n] != -1 {
        print("Memo \(n) -- \(memo[n])")
        return memo[n]
    }

    //  cache miss — compute, store, return
    memo[n] = solve(n - 1, &memo) + solve(n - 2, &memo)

    return memo[n]
}

print(fibMemo(20))

//  ---------------------------------------------------------------
//  What changed in the call tree
//  ---------------------------------------------------------------
//
//  Naive fib(5):
//
//                  fib(5)
//           /                \
//      fib(4)                fib(3)      <- recomputed from scratch
//      /    \                /    \
//  fib(3)  fib(2)       fib(2)  fib(1)
//
//  Memoized fib(5):
//
//                  fib(5)
//           /                \
//      fib(4)                fib(3)      <- cache hit, returns instantly
//      /    \
//  fib(3)  fib(2)
//
//  The right subtree collapses to a single array lookup.
//  Naive fib(20) = 21,891 calls. Memoized fib(20) = 39 calls.

//  ---------------------------------------------------------------
//  Dictionary cache — when the state is not a small Int
//  ---------------------------------------------------------------
//
//  Array cache needs the state to be an index: 0..<n.
//  When the state is a String, a pair, or sparse, use a dictionary.
//
//  Note the explicit if let — no `?? 0`, because a missing key and
//  a stored 0 must stay distinguishable.

func fibDict(_ n: Int, _ memo: inout [Int: Int]) -> Int {

    if n <= 1 {

        return n
    }

    if let cached = memo[n] {

        return cached
    }

    let computed = fibDict(n - 1, &memo) + fibDict(n - 2, &memo)

    memo[n] = computed

    return computed
}

var cache: [Int: Int] = [:]

print(fibDict(20, &cache))

//  ---------------------------------------------------------------
//  The three-line recipe
//  ---------------------------------------------------------------
//
//  1. base case      -> return the known answer
//  2. cache check    -> if already solved, return it
//  3. compute, store, return
//
//  Every top-down solution in problems 235–242 is this shape.
//  Only the recurrence on line 3 changes.

//  ---------------------------------------------------------------
//  Where memoization wins over tabulation (file 03)
//  ---------------------------------------------------------------
//
//  - Only the states you actually reach get computed.
//    Tabulation fills every cell whether it is needed or not.
//  - The recurrence is easier to write: it is just the naive
//    recursion you already have.
//
//  Where it loses:
//
//  - Recursion stack. Deep n can blow it; tabulation cannot.
//  - Slower constant factor from the call overhead.
