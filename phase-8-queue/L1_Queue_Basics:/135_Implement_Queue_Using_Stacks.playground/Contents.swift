/*
 Problem 134 — Implement Queue Using Two Stacks (LC 232)
 Queue = FIFO, Stack = LIFO → reverse twice = original order
 */

// MARK: - Brute Force (enqueue costly)
// enqueue O(n), dequeue/front O(1)

struct Queue {

    private var stack1: [Int] = []
    private var stack2: [Int] = []

    mutating func enqueue(_ value: Int) {
        // flip old elements out
        while !stack1.isEmpty {
            stack2.append(stack1.removeLast())
        }

        // new element goes to bottom
        stack1.append(value)

        // flip back → oldest ends up on top
        while !stack2.isEmpty {
            stack1.append(stack2.removeLast())
        }
    }

    @discardableResult
    mutating func dequeue() -> Int? {
        return stack1.isEmpty ? nil : stack1.removeLast()
    }

    func front() -> Int? {
        return stack1.last
    }

    func isEmpty() -> Bool {
        return stack1.isEmpty
    }

    func display() {
        print(stack1.reversed())  // queue order: front → back
    }
}

var queue = Queue()
queue.enqueue(1)
queue.enqueue(2)
queue.enqueue(3)
queue.display()               // [1, 2, 3]
print(queue.dequeue()!)       // 1
print(queue.front()!)         // 2


// MARK: - Optimised (lazy transfer)
// enqueue O(1), dequeue/front amortized O(1) — each element crosses at most once

struct OptQueue {

    private var inputStack: [Int] = []
    private var outputStack: [Int] = []

    mutating func enqueue(_ value: Int) {
        inputStack.append(value)
    }

    @discardableResult
    mutating func dequeue() -> Int? {
        transfer()
        return outputStack.isEmpty ? nil : outputStack.removeLast()
    }

    mutating func front() -> Int? {
        transfer()
        return outputStack.last
    }

    func isEmpty() -> Bool {
        return inputStack.isEmpty && outputStack.isEmpty
    }

    func count() -> Int {
        return inputStack.count + outputStack.count
    }

    // only when outputStack runs dry
    private mutating func transfer() {
        guard outputStack.isEmpty else { return }
        while !inputStack.isEmpty {
            outputStack.append(inputStack.removeLast())
        }
    }
}

var optQueue = OptQueue()
optQueue.enqueue(10)
optQueue.enqueue(20)
optQueue.enqueue(30)

print(optQueue.dequeue()!)    // 10
print(optQueue.dequeue()!)    // 20
optQueue.enqueue(40)
print(optQueue.front()!)      // 30
print(optQueue.count())       // 2
print(optQueue.isEmpty())     // false
