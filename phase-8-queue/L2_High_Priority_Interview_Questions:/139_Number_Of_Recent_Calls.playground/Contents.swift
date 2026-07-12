/*
===========================================================
        LC 933 — Number of Recent Calls
===========================================================

 ping(t): count pings in window [t - 3000, t], inclusive.
 t is STRICTLY INCREASING → window only slides right
 → expired pings never return → evict from FRONT (FIFO).

 Eviction: strict `< t - 3000` — boundary ping (t-3000) is
 INSIDE the window and must survive.

 Complexity: amortized O(1) per ping — each timestamp is
 appended once, evicted at most once. Space O(window).
===========================================================
*/

// MARK: - Brute Force — removeFirst (O(n) per eviction)

struct RecentCounter {

    private var queue: [Int] = []

    mutating func ping(_ t: Int) -> Int {
        queue.append(t)
        while let first = queue.first, first < t - 3000 {
            queue.removeFirst()
        }
        return queue.count
    }
}

print("===== Brute =====")
var counter = RecentCounter()
print(counter.ping(1))       // 1   window [-2999...1]
print(counter.ping(100))     // 2   window [-2900...100]
print(counter.ping(3001))    // 3   window [1...3001]  — boundary survives
print(counter.ping(3002))    // 3   window [2...3002]  — 1 expired


// MARK: - Optimised — head index + compaction

struct RecentCounterOpt {

    private var queue: [Int] = []
    private var head = 0

    mutating func ping(_ t: Int) -> Int {
        queue.append(t)

        while head < queue.count, queue[head] < t - 3000 {
            head += 1        // evict = advance pointer, no shifting
        }

        // free dead prefix only when it dominates
        if head > 50 && head * 2 >= queue.count {
            queue.removeFirst(head)
            head = 0
        }

        return queue.count - head
    }
}

print("\n===== Optimised =====")
var opt = RecentCounterOpt()
print(opt.ping(1))           // 1
print(opt.ping(100))         // 2
print(opt.ping(3001))        // 3
print(opt.ping(3002))        // 3

// Case: long stream — compaction fires, counts stay correct
print("\n--- compaction case ---")
var long = RecentCounterOpt()
var last = 0
for i in 1...60 {
    last = long.ping(i * 3001)   // each ping expires the previous
}
print(last)                  // 1 — only the newest ping in window
