/*
===========================================================
            136. Implement Circular Queue (LC 622)
===========================================================

 A Circular Queue connects the last position back to the
 first. Freed front slots get reused — no shifting, no waste.

 Wrap trick:  index = (index + 1) % capacity
 Full vs Empty resolved by `count` (not by pointer positions).

 Complexity: all operations O(1), space O(k)
===========================================================
*/

struct MyCircularQueue {

    private var queue: [Int]
    private var front: Int
    private var rear: Int
    private var count: Int
    private let capacity: Int

    init(_ k: Int) {
        capacity = k
        queue = Array(repeating: -1, count: k)
        front = 0
        rear = -1
        count = 0
    }

    mutating func enQueue(_ value: Int) -> Bool {
        if isFull() {
            return false
        }
        rear = (rear + 1) % capacity     // wrap to reuse freed slots
        queue[rear] = value
        count += 1
        return true
    }

    mutating func deQueue() -> Bool {
        if isEmpty() {
            return false
        }
        front = (front + 1) % capacity
        count -= 1
        return true
    }

    func Front() -> Int {
        return isEmpty() ? -1 : queue[front]   // guard: stale slot otherwise
    }

    func Rear() -> Int {
        return isEmpty() ? -1 : queue[rear]
    }

    func isEmpty() -> Bool {
        return count == 0
    }

    func isFull() -> Bool {
        return count == capacity
    }
}

// MARK: - Test Drive

var queue = MyCircularQueue(3)

print(queue.enQueue(1))   // true
print(queue.enQueue(2))   // true
print(queue.enQueue(3))   // true
print(queue.enQueue(4))   // false — full
print(queue.deQueue())    // true  — frees index 0
print(queue.enQueue(4))   // true  — 4 wraps into index 0
print(queue.Rear())       // 4
print(queue.Front())      // 2

// Case A: drain fully — Front/Rear must be -1, not stale
print("\n--- Case A: drain ---")
var qa = MyCircularQueue(3)
_ = qa.enQueue(10)
_ = qa.enQueue(20)
_ = qa.deQueue()
_ = qa.deQueue()
print(qa.Front())         // -1
print(qa.Rear())          // -1
print(qa.isEmpty())       // true

// Case B: wrap multiple times — order must hold
print("\n--- Case B: multi-wrap ---")
var qb = MyCircularQueue(2)
_ = qb.enQueue(1)
_ = qb.enQueue(2)
_ = qb.deQueue()
_ = qb.enQueue(3)         // wraps
_ = qb.deQueue()
_ = qb.enQueue(4)         // wraps again
print(qb.Front())         // 3
print(qb.Rear())          // 4
print(qb.isFull())        // true
