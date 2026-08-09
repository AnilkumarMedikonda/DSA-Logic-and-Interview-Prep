//  238_Coin_Change.swift
//  LeetCode 322 — Coin Change
//
//  PROBLEM
//  Given coin denominations and a target amount, return the FEWEST
//  coins needed. Infinite supply of each coin. Return -1 if impossible.
//
//  EXAMPLE
//  coins = [1, 2, 5], amount = 11  ->  3      (5 + 5 + 1)
//  coins = [2], amount = 3         ->  -1
//
//  CONSTRAINTS
//  1 <= coins.count <= 12
//  1 <= coins[i] <= 2^31 - 1
//  0 <= amount <= 10^4        <-- amount CAN be 0
//
//  THE SIX LINES
//  1. STATE       dp[x] = fewest coins to make amount x  (indexed by AMOUNT)
//  2. OPTIONS     one branch per coin c: use c -> dp[x - c] + 1
//  3. COMBINER    min()
//  4. TRANSITION  dp[x] = min(dp[x], dp[x - c] + 1)  for every c
//  5. BASE        dp[0] = 0
//  6. ANSWER      dp[amount], or -1 if still the sentinel
//
//  SENTINEL: amount + 1 — worst real answer is all 1-coins = `amount`,
//  so amount + 1 is provably impossible AND safe to add 1 to.
//  UNBOUNDED KNAPSACK — coins reusable. (240 is 0/1: items used once.)

import Foundation

let coins = [1, 2, 5]
let amount = 11

print("=========================================")
print("  COIN CHANGE   coins = \(coins)  amount = \(amount)")
print("=========================================\n")

//====================================================
// MARK: - Solution 1 : Recursion
// Time  : O(coins^amount)
// Space : O(amount)   recursion stack
//====================================================

func coinChangeRecursion(_ coins: [Int], _ amount: Int) -> Int {
    let impossible = amount + 1
    let result = coinChangeHelper(coins, amount, impossible, 0)
    return result >= impossible ? -1 : result
}

func coinChangeHelper(_ coins: [Int], _ amount: Int, _ impossible: Int, _ depth: Int) -> Int {
    let pad = String(repeating: "│  ", count: depth)

    if amount == 0 {
        print("\(pad)├─ amount 0  -> 0")
        return 0
    }
    if amount < 0 {
        print("\(pad)├─ amount \(amount)  -> impossible")
        return impossible
    }
    print("\(pad)├─ solve(\(amount))")

    var answer = impossible
    for coin in coins {
        let result = coinChangeHelper(coins, amount - coin, impossible, depth + 1)
        if result < impossible {
            answer = min(answer, result + 1)
            print("\(pad)│  coin \(coin)  -> \(result) + 1 = \(result + 1)   best so far \(answer)")
        }
    }
    print("\(pad)│  RETURN \(answer) for amount \(amount)")
    return answer
}

print("[1] RECURSION  (small input — exponential)")
print("    fewest =", coinChangeRecursion([1, 2], 4), "\n")

//====================================================
// MARK: - Solution 2 : Memoization  (top-down)
// Time  : O(amount * coins.count)
// Space : O(amount)   memo + stack
//====================================================

func coinChangeMemo(_ coins: [Int], _ amount: Int) -> Int {
    let impossible = amount + 1
    var memo = Array(repeating: -1, count: amount + 1)
    let result = coinChangeMemoHelper(coins, amount, impossible, &memo)
    print("    memo   =", memo)
    return result >= impossible ? -1 : result
}

func coinChangeMemoHelper(_ coins: [Int], _ amount: Int, _ impossible: Int, _ memo: inout [Int]) -> Int {
    if amount == 0 { return 0 }
    if amount < 0 { return impossible }

    if memo[amount] != -1 {
        print("    HIT  memo[\(amount)] = \(memo[amount])")
        return memo[amount]
    }

    var answer = impossible
    for coin in coins {
        let result = coinChangeMemoHelper(coins, amount - coin, impossible, &memo)
        if result < impossible {
            answer = min(answer, result + 1)
        }
    }
    memo[amount] = answer
    print("    STORE memo[\(amount)] = \(answer)")
    return answer
}

print("[2] MEMOIZATION")
print("    fewest =", coinChangeMemo(coins, amount), "\n")

//====================================================
// MARK: - Solution 3 : Tabulation  (INTERVIEW ANSWER)
// Time  : O(amount * coins.count)
// Space : O(amount)
//====================================================

func coinChangeDP(_ coins: [Int], _ amount: Int) -> Int {
    // guard BEFORE the loop — 1...0 is an invalid range and traps
    if amount == 0 { return 0 }

    let impossible = amount + 1
    var dp = Array(repeating: impossible, count: amount + 1)
    dp[0] = 0

    for value in 1...amount {
        for coin in coins {
            if value < coin { continue }                    // dp[negative]
            if dp[value - coin] >= impossible { continue }  // source unreachable
            dp[value] = min(dp[value], dp[value - coin] + 1)
        }
    }
    return dp[amount] > amount ? -1 : dp[amount]
}

print("[3] TABULATION")
print("    fewest =", coinChangeDP(coins, amount), "\n")

//====================================================
// MARK: - Traced tabulation — every candidate
//====================================================

func coinChangeDPTrace(_ coins: [Int], _ amount: Int) -> Int {
    if amount == 0 {
        print("amount = 0 -> 0")
        return 0
    }

    let impossible = amount + 1
    var dp = Array(repeating: impossible, count: amount + 1)
    dp[0] = 0
    print("sentinel = \(impossible)   (worst real answer is \(amount) one-coins)")

    for value in 1...amount {
        print("\nvalue = \(value)")

        for coin in coins {
            if value < coin {
                print("   coin \(coin)   skip — bigger than value")
                continue
            }
            let source = dp[value - coin]
            if source >= impossible {
                print("   coin \(coin)   skip — dp[\(value - coin)] unreachable")
                continue
            }
            let candidate = source + 1
            let before = dp[value]
            dp[value] = min(dp[value], candidate)
            let shown = before >= impossible ? "inf" : "\(before)"
            print("   coin \(coin)   dp[\(value - coin)] + 1 = \(candidate)   dp[\(value)]: \(shown) -> \(dp[value])")
        }
        print("   dp = \(dp.map { $0 > amount ? -1 : $0 })")
    }
    return dp[amount] > amount ? -1 : dp[amount]
}

print("=========================================")
print("  TRACE   coins = [1, 3, 4]  amount = 6")
print("  (the case where GREEDY fails)")
print("=========================================")
print("\nresult =", coinChangeDPTrace([1, 3, 4], 6))

//====================================================
// MARK: - Verify
//====================================================

print("\n=========================================")
print("  VERIFY")
print("=========================================")

let cases: [([Int], Int, Int)] = [
    ([1, 2, 5],  11,  3),
    ([2],         3, -1),
    ([1],         0,  0),
    ([1, 3, 4],   6,  2),
    ([2, 5, 10], 27, -1),
    ([186, 419, 83, 408], 6249, 20)
]

for (c, a, expected) in cases {
    let got = coinChangeDP(c, a)
    print("coins \(c)  amount \(a)  ->  \(got)   expected \(expected)   \(got == expected ? "OK" : "FAIL")")
}

//====================================================
// MARK: - Why there is NO O(1) space version
//====================================================
//
// Climbing Stairs and House Robber reached back a FIXED distance
// (i-1, i-2), so two rolling variables sufficed.
// Here the transition reaches back by `coin`, which varies and can
// be as large as the amount. No fixed window to slide, so the full
// dp array stays. Same reason LIS (239) cannot be space-optimized.

//====================================================
// MARK: - Traps logged
//====================================================
//
//  1. `for value in 1...amount` TRAPS when amount == 0, and the
//     constraints allow it. Guard first.
//  2. The naive recursion must convert the sentinel to -1 in a
//     WRAPPER — the sentinel must survive internally for min().
//  3. Int.max sentinel: `Int.max + 1` traps on overflow. Use
//     amount + 1, provably above any valid answer.
//  4. Final check is `> amount`, not `== impossible` — an
//     unreachable cell can end up at amount + 2.
//  5. GREEDY FAILS. coins = [1, 3, 4], amount = 6: greedy takes
//     4 + 1 + 1 = 3, correct answer is 3 + 3 = 2. Always test it.
