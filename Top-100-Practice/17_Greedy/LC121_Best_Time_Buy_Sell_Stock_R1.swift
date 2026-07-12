import Foundation

// LC121_Best_Time_Buy_Sell_Stock_R1
// PROBLEM: Max profit from ONE buy-sell transaction. Return 0 if none.
// Rules: buy BEFORE sell · exactly one transaction · no short-selling
// [7,1,5,3,6,4] → 5 (buy@1, sell@6) · [7,6,4,3,1] → 0 (only falls)
// Trap probe: [2,4,1] → 2 (min appears AFTER the best sell)
//
// SEED: one transaction → best sell needs cheapest earlier buy
//       → carry min-so-far → profit floor is 0 (doing nothing allowed)
//
// R1 RESULT: ✅ PASS · traps hit: identity Int.min→0, untested falling market
// R2 due: ~Aug 2

var prices = [7,1,5,3,6,4]
var prices2 = [2,4,1]

// Brute Force
// T: O(n²) · S: O(1)
// Outer loop = buy day, inner loop = sell day, track best profit
// Interview: SPOKEN only — "wasted work: re-scanning earlier days
// for the cheapest buy, when min-so-far could be carried forward"

func maxProfitBrute(_ prices: [Int]) -> Int {

    var maxProfit = 0
    guard prices.count > 1 else { return maxProfit }

    for i in 0..<prices.count {
        for j in i+1..<prices.count {
            let profit = prices[j] - prices[i]
            maxProfit = profit > maxProfit ? profit : maxProfit
        }
    }

    return maxProfit
}

print("------- Brute Force ------")
print(maxProfitBrute(prices))               // 5
print(maxProfitBrute(prices2))              // 2
print(maxProfitBrute([7,6,4,3,1]))          // 0

// Optimised — One Pass Min Track
// T: O(n) single pass · S: O(1) two variables
// Carry the cheapest price so far; each day, profit = today − min.
// TRAP: identity is 0, not Int.min — falling market never enters
// the else branch, so Int.min would leak out. 0 encodes
// "doing nothing is allowed."

func maxProfitOptimised(_ prices: [Int]) -> Int {

    guard prices.count > 1 else { return 0 }

    var minPrice = prices[0]
    var maxProfit = 0

    for price in prices {
        if price < minPrice {
            minPrice = price
        } else {
            let currentProfit = price - minPrice
            maxProfit = currentProfit > maxProfit ? currentProfit : maxProfit
        }
    }

    return maxProfit
}

print("------- Optimised ------")
print(maxProfitOptimised(prices))           // 5
print(maxProfitOptimised(prices2))          // 2
print(maxProfitOptimised([7,6,4,3,1]))      // 0 ← the Int.min catcher
print(maxProfitOptimised([5]))              // 0 (guard)
print(maxProfitOptimised([2,4,1]))          // 2 (min after best sell)
