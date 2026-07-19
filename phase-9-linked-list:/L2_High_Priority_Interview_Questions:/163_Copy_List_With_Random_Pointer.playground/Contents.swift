import Foundation

// MARK: - Node

final class Node {
    let val: Int
    var next: Node?
    var random: Node?

    init(_ val: Int) {
        self.val = val
    }
}

// MARK: - Print Linked List

func printList(_ head: Node?) {
    var current = head
    while let node = current {
        let nextValue: String
        if let next = node.next { nextValue = "\(next.val)" } else { nextValue = "nil" }

        let randomValue: String
        if let random = node.random { randomValue = "\(random.val)" } else { randomValue = "nil" }

        print("Node: \(node.val), Next: \(nextValue), Random: \(randomValue)")
        current = node.next
    }
    print("--------------------------------")
}

// MARK: - Create Test Data

func createTestList() -> Node {
    let node1 = Node(1)
    let node2 = Node(2)
    let node3 = Node(3)
    let node4 = Node(4)

    node1.next = node2
    node2.next = node3
    node3.next = node4

    node1.random = node3
    node2.random = node1
    node3.random = node4
    node4.random = node2

    return node1
}

////////////////////////////////////////////////////////////
// MARK: - Solution 1 (HashMap)
// Time: O(n)  Space: O(n)
////////////////////////////////////////////////////////////

class HashMapSolution {

    func copyRandomList(_ head: Node?) -> Node? {
        guard let head = head else { return nil }

        var map: [ObjectIdentifier: Node] = [:]   // identity → copy

        // Step 1: create every copy first
        var current: Node? = head
        while let node = current {
            map[ObjectIdentifier(node)] = Node(node.val)
            current = node.next
        }

        // Step 2: wire next & random via the map
        current = head
        while let node = current {
            if let copy = map[ObjectIdentifier(node)] {
                if let next = node.next {
                    copy.next = map[ObjectIdentifier(next)]
                }
                if let random = node.random {
                    copy.random = map[ObjectIdentifier(random)]
                }
            }
            current = node.next
        }

        return map[ObjectIdentifier(head)]
    }
}

////////////////////////////////////////////////////////////
// MARK: - Solution 2 (Interleaving)
// Time: O(n)  Space: O(1)
////////////////////////////////////////////////////////////

class InterleavingSolution {

    func copyRandomList(_ head: Node?) -> Node? {
        guard let head = head else { return nil }

        // Step 1: weave copies in — A → A' → B → B'
        var current: Node? = head
        while let node = current {
            let copy = Node(node.val)
            copy.next = node.next
            node.next = copy
            current = copy.next
        }

        // Step 2: set randoms — copy of X is always X.next
        current = head
        while let node = current {
            if let random = node.random {
                node.next?.random = random.next
            }
            current = node.next?.next
        }

        // Step 3: unweave — restore original first, then link copy
        current = head
        let copiedHead = head.next
        var copiedCurrent = copiedHead

        while let node = current {
            node.next = copiedCurrent?.next
            current = node.next
            copiedCurrent?.next = current?.next
            copiedCurrent = copiedCurrent?.next
        }

        return copiedHead
    }
}

////////////////////////////////////////////////////////////
// MARK: - Tests
////////////////////////////////////////////////////////////

print("========== HashMap ==========")
let original1 = createTestList()
print("Original");           printList(original1)
let hashMapCopy = HashMapSolution().copyRandomList(original1)
print("Copied");             printList(hashMapCopy)
print("Original After Copy"); printList(original1)   // must be intact

print("\n========== Interleaving ==========")
let original2 = createTestList()
print("Original");           printList(original2)
let interleavingCopy = InterleavingSolution().copyRandomList(original2)
print("Copied");             printList(interleavingCopy)
print("Original After Copy"); printList(original2)   // must be restored

// Deep-copy check — copies must be DISTINCT objects
// Deep-copy check — copies must be DISTINCT objects
if let c = hashMapCopy {
    print("\ndistinct node: \(original1 !== c), distinct random: \(original1.random !== c.random)")   // true, true
}
