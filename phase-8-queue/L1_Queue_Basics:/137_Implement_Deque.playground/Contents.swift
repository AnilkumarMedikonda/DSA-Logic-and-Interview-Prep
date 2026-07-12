/*
===========================================================
              137. Implement Deque (LC 641)
===========================================================

 Deque = Double-Ended Queue — insert/delete at BOTH ends.

 Backward wrap (the one new idea vs 136):
   (index - 1 + capacity) % capacity
 Swift `%` keeps sign: (-1) % 5 = -1 → crash without +capacity.

 Brute:     insertFront/deleteFront O(n) — array shifts
 Optimised: all ops O(1), space O(k) — ring buffer
===========================================================
*/

// MARK: - Brute Force — plain array (unbounded)

struct DequeBrute {

    private var deque: [Int] = []

    mutating func insertFront(_ value: Int) {
        deque.insert(value, at: 0)      // O(n) shift
    }

    mutating func insertRear(_ value: Int) {
        deque.append(value)
    }

    @discardableResult
    mutating func deleteFront() -> Int {
        guard !deque.isEmpty else { return -1 }
        return deque.removeFirst()      // O(n) shift
    }

    @discardableResult
    mutating func deleteRear() -> Int {
        guard !deque.isEmpty else { return -1 }
        return deque.removeLast()
    }

    func getFront() -> Int {
        guard !deque.isEmpty else { return -1 }
        return deque.first!
    }

    func getRear() -> Int {
        guard !deque.isEmpty else { return -1 }
        return deque.last!
    }

    func isEmpty() -> Bool {
        return deque.isEmpty
    }
}

var dq = DequeBrute()
dq.insertFront(1)
dq.insertRear(3)
dq.insertFront(0)
dq.insertRear(2)                 // [0, 1, 3, 2]
dq.deleteRear()                  // 2
dq.deleteFront()                 // 0
print(dq.getFront(), dq.getRear())   // 1 3


// MARK: - Optimised — Circular Deque
// front + count only; rear is DERIVED — one less variable to keep in sync

struct MyCircularDeque {

    private var deque: [Int]
    private var front: Int
    private var count: Int
    private let capacity: Int

    init(_ k: Int) {
        capacity = k
        deque = Array(repeating: -1, count: k)
        front = 0
        count = 0
    }

    mutating func insertFront(_ value: Int) -> Bool {
        if isFull() { return false }
        front = (front - 1 + capacity) % capacity   // backward wrap
        deque[front] = value
        count += 1
        return true
    }

    mutating func insertLast(_ value: Int) -> Bool {
        if isFull() { return false }
        let rear = (front + count) % capacity        // next free slot at back
        deque[rear] = value
        count += 1
        return true
    }

    mutating func deleteFront() -> Bool {
        if isEmpty() { return false }
        front = (front + 1) % capacity               // forward wrap (136)
        count -= 1
        return true
    }

    mutating func deleteLast() -> Bool {
        if isEmpty() { return false }
        count -= 1        // rear is derived from count, so shrinking count IS the delete
        return true
    }

    func getFront() -> Int {
        return isEmpty() ? -1 : deque[front]
    }

    func getRear() -> Int {
        guard !isEmpty() else { return -1 }
        return deque[(front + count - 1) % capacity]   // derived rear
    }

    func isEmpty() -> Bool {
        return count == 0
    }

    func isFull() -> Bool {
        return count == capacity
    }
}

// MARK: - Tests

var cd = MyCircularDeque(3)
print(cd.insertLast(1))    // true
print(cd.insertLast(2))    // true
print(cd.insertFront(3))   // true  — 3 wraps to physical index 2
print(cd.insertFront(4))   // false — full
print(cd.getRear())        // 2
print(cd.isFull())         // true
print(cd.deleteLast())     // true
print(cd.insertFront(4))   // true
print(cd.getFront())       // 4

// drain test — Front/Rear must be -1
var cd2 = MyCircularDeque(2)
_ = cd2.insertFront(7)
_ = cd2.deleteLast()
print(cd2.getFront())      // -1
print(cd2.getRear())       // -1
