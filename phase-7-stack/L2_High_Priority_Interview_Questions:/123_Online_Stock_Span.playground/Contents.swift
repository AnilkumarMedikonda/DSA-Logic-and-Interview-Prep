import Foundation

/*
 =========================================================
    123 - ONLINE STOCK SPAN  (LC 901)  ⭐ NeetCode
 =========================================================

 Problem
 -------
 Prices arrive ONE AT A TIME. For each price, return its
 SPAN: how many consecutive days ending today (inclusive)
 had price <= today's.

 Arrivals: 100, 80, 60, 70, 60, 75, 85
 Returns:    1,  1,  1,  2,  1,  4,  6

 Interview rate: 🟡 Medium — Amazon; the pattern's
 "previous greater with counts" variant.

 ---------------------------------------------------------

 Pattern: Monotonic Stack — knob 3 turned to ABSORPTION.
 (Full waiting-room model: see 121's pattern block.)

 New vs 121/122:
 • Direction: PREVIOUS greater — but online arrival order
   means the stack naturally holds the past. No reversal.
 • Compare: <= (equal prices COUNT toward the span —
   unlike 122's strict <).
 • Push (price, span) PAIRS — a popped waiter hands over
   its ENTIRE accumulated span, so nothing is recounted.
   Same trick as Min Stack's sticky note; the note is a count.

 STATUS: cold-derived ✅ — this solution closed the
 121/122/123 rewrite debt. The while-let idiom below is
 an improvement over the reference form.

 =========================================================
 */

//==========================================================
// MARK: - Brute Force — walk backwards per day, O(n²)
//==========================================================

func stockSpanBrute(_ prices: [Int]) -> [Int] {

    var result = [Int]()

    for i in 0..<prices.count {

        let today = prices[i]
        var span = 0
        var back = i                    // walks LEFT (previous days)

        while back >= 0 {
            if prices[back] > today {
                break                   // first strictly greater ends the span
            } else {
                span += 1               // self counts (prices[i] > prices[i] is false)
            }
            back -= 1
        }

        result.append(span)
    }

    return result
}

//==========================================================
// MARK: - Optimised — Monotonic Stack with absorption, batch form
//==========================================================

func stockSpanOptimised(_ prices: [Int]) -> [Int] {

    var result = [Int]()
    var stack = [(price: Int, span: Int)]()

    for price in prices {

        var span = 1                    // myself

        // while-let idiom: the binding IS the empty check —
        // no index arithmetic, no force-unwrap possible
        while let last = stack.last, last.price <= price {
            span += last.span           // absorb its whole history
            stack.removeLast()
        }

        stack.append((price, span))
        result.append(span)
    }

    return result
}

//==========================================================
// MARK: - LC 901's actual interface — the ONLINE class form
//==========================================================
/*
 Same algorithm, re-homed: the stack becomes state, the
 loop body becomes next(). Works online because each call
 is self-contained — the monotonic invariant guarantees
 the stack never needs future information.
 */

class StockSpanner {

    private var stack = [(price: Int, span: Int)]()

    func next(_ price: Int) -> Int {

        var span = 1

        while let last = stack.last, last.price <= price {
            span += last.span
            stack.removeLast()
        }

        stack.append((price, span))
        return span
    }
}

//==========================================================
// MARK: - Dry Run (watch the absorption)
//==========================================================
/*
 arrivals: 100, 80, 60, 70, 60, 75, 85

 100: empty → push (100,1) → 1          stack [(100,1)]
 80:  100 > 80 → push (80,1) → 1        stack [(100,1),(80,1)]
 60:  80 > 60 → push (60,1) → 1         stack [...,(80,1),(60,1)]
 70:  60 <= 70 → absorb 1 → span 2
      80 > 70 → stop → push (70,2) → 2  stack [...,(80,1),(70,2)]
 60:  70 > 60 → push (60,1) → 1         stack [...,(70,2),(60,1)]
 75:  60 <= 75 → absorb 1 → span 2
      70 <= 75 → absorb 2 → span 4      ← 70's 2 ALREADY contains
      80 > 75 → stop → push (75,4) → 4     the first 60. no recount.
 85:  75 <= 85 → absorb 4 → span 5
      80 <= 85 → absorb 1 → span 6
      100 > 85 → stop → push (85,6) → 6

 Returns: [1, 1, 1, 2, 1, 4, 6] ✅
 */

//==========================================================
// MARK: - Complexity
//==========================================================
/*
 Brute    : T O(n²) — rising prices scan all the way back daily
 Optimised: T O(n) total / O(1) AMORTIZED per next() call —
            each price pushed once, popped at most once.
            A single next() can pop many (85 pops 2), but
            those pops were "paid for" by earlier pushes.
            S O(n) — strictly falling prices park everyone.
 */

//==========================================================
// MARK: - Traps
//==========================================================
/*
 1. < instead of <= — equal prices count toward the span
    (opposite of 122's strict <). Always confirm tie
    behavior with the interviewer.
 2. Pushing bare prices — a popped price can't hand over
    its history. The (price, span) pair IS the absorption.
 3. span starting at 0 — forgets to count today itself.
 4. Recounting absorbed days — popped span already contains
    everything it absorbed earlier. Add it, don't re-walk.
 5. Batch function when LC asks for the online class —
    right algorithm, wrong container. (My attempt gap.)
 6. Misleading names: `right` walking left; array named
    like the loop variable. (My attempt.)
 */

//==========================================================
// MARK: - Tests
//==========================================================

let prices = [100, 80, 60, 70, 60, 75, 85]
let expected = [1, 1, 1, 2, 1, 4, 6]

let bruteResult = stockSpanBrute(prices)
let optimisedResult = stockSpanOptimised(prices)

print("brute     :", bruteResult, bruteResult == expected ? "✅" : "❌")
print("optimised :", optimisedResult, optimisedResult == expected ? "✅" : "❌")

// The online class, fed one at a time
let spanner = StockSpanner()
var onlineResult = [Int]()
for price in prices {
    onlineResult.append(spanner.next(price))
}
print("online    :", onlineResult, onlineResult == expected ? "✅" : "❌")

// Edge cases
let flat = StockSpanner()
print("flat 50,50,50 :", [flat.next(50), flat.next(50), flat.next(50)],
      "== [1, 2, 3] — equal absorbs (<=)")

let rising = StockSpanner()
print("rising 1,2,3,4:", [rising.next(1), rising.next(2), rising.next(3), rising.next(4)],
      "== [1, 2, 3, 4]")

//==========================================================
// MARK: - Interview Q&A
//==========================================================
/*
 Q1: Why (price, span) pairs?
 A : A popped waiter hands over its accumulated span so
     nothing is recounted — 70's span of 2 already contains
     the 60 before it. Compute-at-write, same family as
     Min Stack's sticky note.

 Q2: How is next() O(1) when one call can pop many?
 A : Amortized — each price is pushed exactly once and
     popped at most once across ALL calls. A heavy pop was
     prepaid by earlier cheap pushes.

 Q3: Why does this work online (no future needed)?
 A : The span only looks BACKWARD, and the monotonic stack
     holds exactly the still-relevant past — everything
     absorbed is accounted for, everything popped is done.

 Q4: <= vs < ?
 A : Spec says "less than or equal" — flat prices extend
     the span ([50,50,50] → 1,2,3). 122 used strict < .
     Tie behavior is the classic hidden requirement.

 Q5: Related?
 A : 122 Daily Temperatures (next greater, distance),
     LC 84 Histogram (next smaller, area), LC 856/1019 —
     same skeleton, knobs turned.

 =========================================================
 */
