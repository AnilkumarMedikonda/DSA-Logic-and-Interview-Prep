/*
===========================================================
           138. First In First Out — Practice
===========================================================

 L1 capstone: APPLY the queue, don't build it.

 Warm-up:  brute + head-index queue (from 133)
 Problem:  LC 933  Number of Recent Calls   — solved below
 Exercise: LC 346  Moving Average           — TODO
 Exercise: LC 2073 Time to Buy Tickets      — TODO
===========================================================
*/

// MARK: - Warm-up 1: Brute Force Queue

struct Queue {

    private var queue: [Int] = []

    mutating func enqueue(_ element: Int) {
        queue.append(element)
    }

    @discardableResult
    mutating func dequeue() -> Int? {
        return queue.isEmpty ? nil : queue.removeFirst()   // O(n)
    }

    func front() -> Int? { return queue.first }
    func rear() -> Int? { return queue.last }
    func isEmpty() -> Bool { return queue.isEmpty }
    func display() { print(queue) }
}

var q = Queue()
q.enqueue(1)
q.enqueue(2)
q.enqueue(3)
q.display()        // [1, 2, 3]
q.dequeue()
q.display()        // [2, 3]


// MARK: - Warm-up 2: Head-Index Queue (amortized O(1) dequeue)

struct OptQueue {

    private var items = [Int]()
    private var head = 0

    mutating func enqueue(_ item: Int) {
        items.append(item)
    }

    @discardableResult
    mutating func dequeue() -> Int? {
        guard head < items.count else { return nil }
        let value = items[head]
        head += 1

        // compact only when dead prefix dominates
        if head > 50 && head * 2 >= items.count {
            items.removeFirst(head)
            head = 0
        }
        return value
    }

    func front() -> Int? {
        guard head < items.count else { return nil }
        return items[head]
    }

    func rear() -> Int? {
        guard head < items.count else { return nil }   // drained → nil, not dead slot
        return items.last
    }

    func isEmpty() -> Bool { return head >= items.count }
    func count() -> Int { return items.count - head }   // live only
}


// MARK: - LC 933: Number of Recent Calls
// pings arrive with INCREASING t → expired pings never return
// → evict from the FRONT, count what remains. Amortized O(1) per ping.

struct RecentCounter {

    private var pings = [Int]()
    private var head = 0

    mutating func ping(_ t: Int) -> Int {
        pings.append(t)

        // evict everything older than the window [t - 3000, t]
        while head < pings.count && pings[head] < t - 3000 {
            head += 1
        }

        if head > 50 && head * 2 >= pings.count {
            pings.removeFirst(head)
            head = 0
        }
        return pings.count - head    // live pings in window
    }
}

var counter = RecentCounter()
print(counter.ping(1))       // 1  window [-2999...1]
print(counter.ping(100))     // 2  window [-2900...100]
print(counter.ping(3001))    // 3  window [1...3001]     1 just fits
print(counter.ping(3002))    // 3  window [2...3002]     1 expired


