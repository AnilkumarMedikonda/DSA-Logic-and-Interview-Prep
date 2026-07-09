/*
===========================================================
               133. Queue Basics and Operations
===========================================================

🎯 Practice Order

1. Basic Queue using Array (This Playground) ✅
2. Queue using Front Index (Optimized)
3. Queue using Generics
4. Circular Queue
5. Queue using Two Stacks

-----------------------------------------------------------
Definition
-----------------------------------------------------------

Queue is a Linear Data Structure that follows the
FIFO (First In First Out) principle.

The first element inserted is the first element removed.

-----------------------------------------------------------
Terminology
-----------------------------------------------------------

Front = First Element

Rear = Last Element

Enqueue = Insert at Rear

Dequeue = Remove from Front

-----------------------------------------------------------
Visualization
-----------------------------------------------------------

Front                     Rear
  ↓                         ↓

10 ----> 20 ----> 30 ----> 40

enqueue(50)

10 ----> 20 ----> 30 ----> 40 ----> 50
                                  ↑
                                Rear

dequeue()

Removed = 10

20 ----> 30 ----> 40 ----> 50
↑
Front

-----------------------------------------------------------
Operations
-----------------------------------------------------------

enqueue()   -> Insert element
dequeue()   -> Remove first element
front()     -> First element
rear()      -> Last element
isEmpty()   -> Queue empty?
count()     -> Number of elements

-----------------------------------------------------------
Time Complexity (Current Implementation)
-----------------------------------------------------------

enqueue()  -> O(1)

dequeue()  -> O(n)
Reason: removeFirst() shifts all elements.

front()    -> O(1)

rear()     -> O(1)

isEmpty()  -> O(1)

count()    -> O(1)

-----------------------------------------------------------
Interview Points
-----------------------------------------------------------

Queue follows FIFO.

Insert at Rear.

Delete from Front.

Front = First Element.

Rear = Last Element.

removeFirst() in Swift Array is O(n).

Optimized Queue uses Front Index
(or Circular Queue).

-----------------------------------------------------------
Applications
-----------------------------------------------------------

• Breadth First Search (BFS)

• Binary Tree Level Order Traversal

• CPU Scheduling

• Printer Queue

• Task Scheduling

• Producer Consumer

===========================================================
*/


// MARK: - Problem 133: Queue Basics (Brute Force vs Optimized)

// MARK: - Brute Force — array + removeFirst
// dequeue O(n): every removal shifts all remaining elements


struct QueueBrute {
    private var elements: [Int] = []

    mutating func enqueue(_ element: Int) {
        elements.append(element)
    }

    mutating func dequeue() -> Int? {
        guard !elements.isEmpty else { return nil }
        return elements.removeFirst()   // ❌ O(n)
    }

    func front() -> Int? { elements.first }
    func rear() -> Int? { elements.last }
    func isEmpty() -> Bool { elements.isEmpty }
    func count() -> Int { elements.count }
    func display() -> [Int] { elements }
}

// MARK: - Optimized — head-index queue
// dequeue amortized O(1): advance head, compact when dead prefix dominates


struct Queue {
    private var elements: [Int] = []
    private var head: Int = 0

    mutating func enqueue(_ element: Int) {
        elements.append(element)
    }

    mutating func dequeue() -> Int? {
        guard head < elements.count else { return nil }
        let element = elements[head]
        head += 1

        if head > 50 && head * 2 >= elements.count {
            elements.removeFirst(head)
            head = 0                     // reset after compaction
        }
        return element
    }

    func front() -> Int? {
        guard head < elements.count else { return nil }
        return elements[head]
    }

    func rear() -> Int? {
        guard head < elements.count else { return nil }
        return elements.last
    }

    func isEmpty() -> Bool { head >= elements.count }
    func count() -> Int { elements.count - head }
    func display() -> [Int] { Array(elements[head...]) }
}

// MARK: - Test Drive

print("===== Brute Force =====")

var qb = QueueBrute()
for i in 1...5 { qb.enqueue(i) }

if let removed = qb.dequeue() {
    print("removed: \(removed)")        // 1
}
print("remaining:", qb.display())       // [2, 3, 4, 5]

print("\n===== Optimized =====")

var queue = Queue()
for i in 1...10 { queue.enqueue(i) }

if let element = queue.front() {
    print("front: \(element)")          // 1
}
if let element = queue.rear() {
    print("rear: \(element)")           // 10
}

if let removed = queue.dequeue() {
    print("removed: \(removed)")        // 1
}
print("remaining:", queue.display())    // [2...10]
print("count:", queue.count())          // 9

// Case A: drain fully — rear must be nil, not a dead element
print("\n--- Case A: drain ---")
var qa = Queue()
qa.enqueue(1)
_ = qa.dequeue()
print("rear:", qa.rear() as Any)        // nil
print("isEmpty:", qa.isEmpty())         // true

// Case B: compaction fires (55 dequeues) — order must continue
print("\n--- Case B: compaction ---")
var qc = Queue()
for i in 1...60 { qc.enqueue(i) }
for _ in 1...55 { _ = qc.dequeue() }
print("front:", qc.front() as Any)      // 56
print("count:", qc.count())             // 5
print("remaining:", qc.display())       // [56, 57, 58, 59, 60]
