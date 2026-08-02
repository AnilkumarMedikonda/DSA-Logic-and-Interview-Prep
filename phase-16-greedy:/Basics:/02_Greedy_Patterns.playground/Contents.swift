import Foundation

/*
====================================================
            02_Greedy_Patterns.swift
====================================================

When does Greedy WORK and when does it FAIL?

WORKS: local best → global best (provable)
FAILS: an early "best" choice blocks a better future

Two demos below:
1. Greedy SUCCESS — Activity Selection (max meetings)
2. Greedy FAILURE — Coin Change with coins [4, 3, 1]
*/

final class GreedyPatterns {
    
    func start() {
        print("========== Greedy Patterns ==========")
        print()
        
        demoSuccess()
        print()
        demoFailure()
    }
    
    // ------------------------------------------------
    // DEMO 1 : Greedy SUCCESS — Activity Selection
    // Pick maximum number of non-overlapping meetings
    // Greedy choice: always pick the meeting that
    // ENDS EARLIEST → leaves most room for the rest
    // ------------------------------------------------
    func demoSuccess() {
        
        // (start, end) — already sorted by END time
        let meetings = [(1, 2), (1, 3), (2, 4), (3, 5), (4, 6)]
        
        print("--- Greedy SUCCESS: Max Meetings ---")
        print("Meetings (start, end) -> \(meetings)")
        print()
        
        var count = 0
        var lastEnd = 0
        
        for meeting in meetings {
            
            let start = meeting.0
            let end = meeting.1
            
            // Greedy Choice: take it if it starts after last one ended
            if start >= lastEnd {
                print("👉 Take (\(start), \(end))")
                count += 1
                lastEnd = end
            } else {
                print("⊘ Skip (\(start), \(end)) — overlaps")
            }
        }
        
        print()
        print("✅ Max meetings -> \(count)")
    }
    
    // ------------------------------------------------
    // DEMO 2 : Greedy FAILURE — Coin Change [4, 3, 1]
    // Greedy picks largest first → WRONG answer
    // ------------------------------------------------
    func demoFailure() {
        
        let coins = [4, 3, 1]
        let amount = 6
        
        print("--- Greedy FAILURE: Coin Change ---")
        print("Coins -> \(coins), Amount -> \(amount)")
        print()
        
        var remaining = amount
        var used = [Int]()
        
        for coin in coins {
            while remaining >= coin {
                print("👉 Pick \(coin), remaining \(remaining) → \(remaining - coin)")
                remaining -= coin
                used.append(coin)
            }
        }
        
        print()
        print("❌ Greedy  -> \(used) = \(used.count) coins")
        print("✅ Optimal -> [3, 3] = 2 coins")
        print()
        print("Why greedy failed: picking 4 first BLOCKED the")
        print("two-3s solution. Early local best ≠ global best.")
        print("This is why LC 322 Coin Change needs DP (Phase 19).")
    }
}

// MARK: - Run
let demo = GreedyPatterns()
demo.start()

/*
====================================================
KEY POINTS
====================================================
1. Greedy works when you can PROVE the exchange
   argument: "swapping my greedy choice for any other
   choice never improves the answer"
   - Earliest-end meeting: swapping it for a later-
     ending one can only REDUCE remaining room ✓

2. Greedy fails when an early choice can block a
   better combination later (coins [4,3,1])

3. Interview test for "is this greedy?":
   → Can a locally worse choice EVER win later?
     NO  → greedy
     YES → DP / backtracking

4. Sorting is often step 0 of greedy — meetings were
   sorted by END time; that ordering IS the strategy
   (more in 03_Sorting_Greedy)
====================================================
*/
