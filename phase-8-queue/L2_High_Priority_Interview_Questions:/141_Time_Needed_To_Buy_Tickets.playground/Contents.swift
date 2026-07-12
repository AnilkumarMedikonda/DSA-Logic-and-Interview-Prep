// 141_Time_Needed_To_Buy_Tickets.playground
// LC 2073 — Easy — Phase 8: Queue

import Foundation

// MARK: - 1. Problem
/*
 n people in a queue. tickets[i] = tickets person i wants.
 Each purchase = 1 second, buys exactly ONE ticket, then:
   - still needs more → goes to BACK of queue
   - done → leaves the queue
 Return: total seconds until person at index k has bought ALL their tickets.

 Example: tickets = [2,3,2], k = 2 → 6
 Key insight: when k buys their LAST ticket, the clock stops —
 people BEHIND k never get that final round.
*/

// MARK: - 2. Brute Force — Simulate the Queue
// Literally act out the queue: dequeue → buy (time++) → re-enqueue if more needed.
// Stop the moment person k hits 0.
func timeRequiredToBuyBruteForce(tickets: [Int], k: Int) -> Int {

    var remainingTickets = tickets
    var queue: [Int] = Array(0..<tickets.count)   // store INDICES, not counts
    var time = 0

    while !queue.isEmpty {

        let person = queue.removeFirst()          // front of queue buys
        remainingTickets[person] -= 1
        time += 1                                 // every purchase costs 1 sec

        if remainingTickets[person] == 0 {
            if person == k {
                return time                       // k finished → stop here
            }
            // someone else finished → just drop them (no re-enqueue)
        } else {
            queue.append(person)                  // needs more → back of line
        }
    }

    return time
}

// MARK: - 3. Optimised — Per-Person Counting (No Queue!)
/*
 Ask per person i: "how many tickets does i buy BEFORE k finishes?"

 k makes exactly tickets[k] rounds (one purchase per round).

 Case i <= k (at or ahead of k in line):
   → present for ALL of k's rounds
   → buys min(tickets[i], tickets[k])

 Case i > k (behind k):
   → in k's FINAL round, k buys last ticket and clock stops
     BEFORE reaching people behind → they miss 1 round
   → buys min(tickets[i], tickets[k] - 1)

 Sum all contributions = total seconds.
*/
func timeRequiredToBuy(tickets: [Int], k: Int) -> Int {

    var time = 0

    for i in 0..<tickets.count {
        if i <= k {
            time += min(tickets[i], tickets[k])
        } else {
            time += min(tickets[i], tickets[k] - 1)
        }
    }

    return time
}

// MARK: - 4. Dry Run
/*
 tickets = [2,3,2], k = 2

 BRUTE FORCE (queue simulation):
 sec | buyer | remaining | queue after
  1  |   0   | [1,3,2]   | 1,2,0
  2  |   1   | [1,2,2]   | 2,0,1
  3  |   2   | [1,2,1]   | 0,1,2
  4  |   0   | [0,2,1]   | 1,2      (0 done, leaves)
  5  |   1   | [0,1,1]   | 2,1
  6  |   2   | [0,1,0]   | k DONE → return 6

 OPTIMISED (per-person math):
 i=0 (i<=k): min(2, 2) = 2   ← buys both before k finishes
 i=1 (i<=k): min(3, 2) = 2   ← only 2 of 3, then k is done
 i=2 (i==k): min(2, 2) = 2   ← k's own tickets
 total = 2 + 2 + 2 = 6 ✅

 Note person 1 wanted 3 but only contributes 2 —
 k finished before person 1's 3rd turn ever came.
*/

// MARK: - 5. Complexity
/*
 Brute Force:
   Time  : O(n · sum(tickets)) — loop runs once per purchase,
           and Array.removeFirst() is O(n) per call
   Space : O(n) for the queue + remaining copy

 Optimised:
   Time  : O(n) — single pass
   Space : O(1)
*/

// MARK: - 6. Traps
/*
 1. FINAL ROUND CUTOFF: people behind k (i > k) get tickets[k] - 1
    rounds, not tickets[k]. Forgetting the -1 is THE classic bug.

 2. i == k belongs in the <= branch: min(tickets[k], tickets[k])
    = tickets[k], which is exactly k's own purchases. Self-consistent.

 3. Brute force: increment time on EVERY purchase, not per round.

 4. Early leavers: min() automatically caps people who need fewer
    tickets than k — they stop contributing once they're done.

 5. Complexity of simulation is sum-driven, NOT n-driven:
    [100,100,100] has n=3 but ~300 iterations.
*/

// MARK: - 7. Tests
let tests: [(tickets: [Int], k: Int, expected: Int)] = [
    ([2, 3, 2], 2, 6),      // LC example
    ([5, 1, 1, 1], 0, 8),   // LC example: k first, needs the most
    ([1], 0, 1),            // single person
    ([1, 1, 1, 1], 3, 4),   // everyone needs 1, k is last
    ([3, 1, 2], 1, 2),      // k needs 1 → people behind contribute 0
    ([4, 4, 4], 0, 10)      // k first: 4 + min(4,3) + min(4,3) = 10
]

for test in tests {
    let brute = timeRequiredToBuyBruteForce(tickets: test.tickets, k: test.k)
    let optimised = timeRequiredToBuy(tickets: test.tickets, k: test.k)
    let pass = brute == test.expected && optimised == test.expected
    print("\(pass ? "✅" : "❌") tickets=\(test.tickets) k=\(test.k) → brute=\(brute) opt=\(optimised) expected=\(test.expected)")
}

// MARK: - 8. Interview Q&A
/*
 Q: Why tickets[k] - 1 for people behind k?
 A: k's last purchase ends the clock mid-round — the round never
    reaches anyone standing behind k.

 Q: Can you solve it without simulating?
 A: Yes — k makes tickets[k] rounds; count each person's purchases
    with min() per position. O(n)/O(1). (This is what they're fishing for.)

 Q: Why is simulation not O(n)?
 A: Loop count = total purchases = sum(tickets). Plus removeFirst()
    on Swift Array is O(n) — use a head-index pointer for O(1) dequeue.

 Q: What if k needs only 1 ticket?
 A: People behind contribute min(x, 0) = 0 — k buys once and leaves
    before the queue behind ever moves. Formula handles it for free.

 iOS BRIDGE: simulation → closed-form math is the same instinct as
 replacing a polling loop with a computed value: don't tick a Timer
 to count intervals, compute elapsed / interval directly.
*/
