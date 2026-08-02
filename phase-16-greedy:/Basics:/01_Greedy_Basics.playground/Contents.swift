import Foundation

/*
====================================================
            01_Greedy_Basics.swift
====================================================

Greedy = At every step, make the BEST LOCAL choice
         and NEVER look back.

Backtracking vs Greedy:
- Backtracking → try everything, undo, explore all branches
- Greedy       → commit once, no undo, ONE pass

Greedy works ONLY when:
Local best choice → leads to → Global best answer

Example here:
Coin Change (with standard coins [10, 5, 2, 1])
Goal: make an amount using MINIMUM number of coins
Greedy choice: always pick the LARGEST coin that fits
*/

final class GreedyBasics {
    
    func start() {
        let coins = [10, 5, 2, 1]   // sorted descending
        let amount = 28
        
        print("========== Greedy Basics ==========")
        print()
        print("Coins  -> \(coins)")
        print("Amount -> \(amount)")
        print()
        
        minCoins(coins, amount)
    }
    
    func minCoins(_ coins: [Int], _ amount: Int) {
        
        var remaining = amount
        var used = [Int]()
        
        for coin in coins {
            
            // Greedy Choice: take as many of the LARGEST coin as possible
            while remaining >= coin {
                
                print("👉 Pick \(coin), remaining \(remaining) → \(remaining - coin)")
                
                remaining -= coin
                used.append(coin)
            }
            
            // NO UNDO — we never put a coin back. That's greedy.
        }
        
        print()
        print("✅ Coins used -> \(used)")
        print("✅ Total coins -> \(used.count)")
    }
}

// MARK: - Run
let demo = GreedyBasics()
demo.start()

/*
====================================================
Output:
👉 Pick 10, remaining 28 → 18
👉 Pick 10, remaining 18 → 8
👉 Pick 5,  remaining 8  → 3
👉 Pick 2,  remaining 3  → 1
👉 Pick 1,  remaining 1  → 0

✅ Coins used  -> [10, 10, 5, 2, 1]
✅ Total coins -> 5

====================================================
KEY POINTS
====================================================
1. One pass, no recursion, no undo — compare with
   Phase 15 where Undo was a REQUIRED step
2. Greedy is FAST: usually O(n) or O(n log n)
3. But greedy is NOT always correct!
   Coins [4, 3, 1], amount 6:
   Greedy  → 4 + 1 + 1 = 3 coins ❌
   Optimal → 3 + 3     = 2 coins ✅
   (That failure case is why Coin Change LC 322 is a
    DP problem, not greedy — coming in Phase 19)
4. The interview skill = PROVING the greedy choice
   is safe, not writing the code
====================================================
*/
