//
//  166_LRU_Cache.playground — LC 146
//
//  Category   : Design + HashMap + Doubly Linked List
//  Difficulty : Hard
//  Companies  : Apple, Amazon, Google, Meta, Microsoft, Uber
//
//  get()  -> O(1)
//  put()  -> O(1)
//  Space  -> O(capacity)
//

/*
------------------------------------------------------------
Problem
------------------------------------------------------------
get(key)        -> value, or -1 if absent. Counts as a USE (becomes MRU).
put(key, value) -> insert or update; becomes MRU.
                   If over capacity, evict the LRU entry.

------------------------------------------------------------
Why two structures
------------------------------------------------------------
HashMap            -> O(1) lookup by key, but has NO order.
Doubly Linked List -> O(1) insert/remove/move, and keeps recency order.

Together: dict maps key -> node; list keeps nodes ordered MRU..LRU.

Why DOUBLY linked (the interview "why"):
To unlink a node from the middle in O(1) you need its prev pointer.
Singly linked would require walking from head to find the predecessor — O(n).

------------------------------------------------------------
Layout
------------------------------------------------------------
HEAD (dummy) <-> MRU <-> ... <-> LRU <-> TAIL (dummy)

Sentinels mean insert/remove never special-case an empty list or the ends.

------------------------------------------------------------
Dry Run — capacity = 2
------------------------------------------------------------
put(1,10)   HEAD (1,10) TAIL
put(2,20)   HEAD (2,20) (1,10) TAIL
get(1) -> 10 HEAD (1,10) (2,20) TAIL      // 1 moves to front
put(3,30)   insert -> HEAD (3,30) (1,10) (2,20) TAIL
            over capacity -> evict tail.prev = (2,20)
            HEAD (3,30) (1,10) TAIL
*/

import Foundation

//======================================================
// MARK: - Node
//======================================================

final class Node {

    let key: Int          // stored so eviction knows which dict entry to drop
    var value: Int

    var prev: Node?
    var next: Node?

    init(_ key: Int, _ value: Int) {
        self.key = key
        self.value = value
    }
}

//======================================================
// MARK: - LRU Cache
//======================================================

final class LRUCache {

    private let capacity: Int

    private var cache: [Int: Node] = [:]        // key -> node

    private let head = Node(0, 0)               // dummy — MRU side
    private let tail = Node(0, 0)               // dummy — LRU side

    init(_ capacity: Int) {
        self.capacity = capacity

        head.next = tail
        tail.prev = head
    }

    //==================================================
    // MARK: GET
    //==================================================

    func get(_ key: Int) -> Int {

        guard let node = cache[key] else {
            return -1                            // the -1 IS the signal
        }

        // accessed -> becomes MRU
        remove(node)
        insertAtFront(node)

        return node.value
    }

    //==================================================
    // MARK: PUT
    //==================================================

    func put(_ key: Int, _ value: Int) {

        // exists -> update + move to front
        if let node = cache[key] {
            node.value = value
            remove(node)
            insertAtFront(node)
            return
        }

        // new entry
        let node = Node(key, value)
        cache[key] = node
        insertAtFront(node)

        // over capacity -> evict LRU (tail.prev)
        if cache.count > capacity {
            if let lru = tail.prev, lru !== head {
                remove(lru)
                cache.removeValue(forKey: lru.key)   // MUST clear the dict too
            }
        }
    }

    //==================================================
    // MARK: Private helpers
    //==================================================

    private func remove(_ node: Node) {
        let previous = node.prev
        let next = node.next

        previous?.next = next
        next?.prev = previous
    }

    private func insertAtFront(_ node: Node) {
        node.next = head.next
        node.prev = head

        head.next?.prev = node
        head.next = node
    }

    //==================================================
    // MARK: Debug print
    //==================================================

    func printCache() {
        print("MRU -> ", terminator: "")

        var current = head.next
        while let node = current, node !== tail {
            print("(\(node.key),\(node.value))", terminator: " ")
            current = node.next
        }

        print("<- LRU")
    }
}

//======================================================
// MARK: - Tests
//======================================================

let cache = LRUCache(2)

print("put(1,10)");
cache.put(1, 10);
cache.printCache()
print("put(2,20)");
cache.put(2, 20);  cache.printCache()

print("get(1) -> \(cache.get(1))");     cache.printCache()   // 10, 1 becomes MRU
print("put(3,30)");  cache.put(3, 30);  cache.printCache()   // evicts (2,20)

print("get(2) -> \(cache.get(2))")                            // -1
print("put(4,40)");  cache.put(4, 40);  cache.printCache()   // evicts (1,10)

print("get(1) -> \(cache.get(1))")                            // -1
print("get(3) -> \(cache.get(3))")                            // 30
print("get(4) -> \(cache.get(4))")                            // 40

print("\n-- update existing key --")
let c2 = LRUCache(2)
c2.put(1, 10)
c2.put(2, 20)
c2.put(1, 99)          // update, no eviction
c2.printCache()        // MRU -> (1,99) (2,20) <- LRU
print("get(1) -> \(c2.get(1))")   // 99
