// LC 141 — Linked List Cycle

import UIKit

/*
 Detect whether the list loops back on itself. Floyd's tortoise & hare.
 
 Insight: this IS find-middle (151) + an identity check. Slow steps 1,
 fast steps 2. On a straight list fast hits nil → false. In a cycle,
 fast gains 1 step on slow each iteration, the gap closes, they collide.
 
 === not ==: comparing NODE IDENTITY (same object), not values.
 
 Loop condition is about FAST (it takes the double step): fast and
 fast.next must both exist → while let f = fast, let fNext = f.next.
 
 Complexity: Time O(n). Space O(1) — two pointers, no set of seen nodes.
*/

final class ListNode {
    let value: Int
    var next: ListNode?
    
    init(_ value: Int) {
        self.value = value
    }
}

// 145
func createList(_ values: [Int]) -> ListNode? {
    guard !values.isEmpty else { return nil }
    
    let head = ListNode(values[0])
    var current = head
    
    for i in 1..<values.count {          // index loop — no dropFirst
        let node = ListNode(values[i])
        current.next = node
        current = node
    }
    return head
}

// 141
func hasCycle(_ head: ListNode?) -> Bool {
    var slow = head
    var fast = head
    
    while let f = fast, let fNext = f.next {
        slow = slow?.next     // 1 step
        fast = fNext.next     // 2 steps
        if slow === fast {    // identity — same node object
            return true
        }
    }
    return false              // fast hit nil — straight list
}

// Test harness: link the tail back to node at cycleIndex
func createCycle(_ head: ListNode?, cycleIndex: Int) {
    guard cycleIndex >= 0 else { return }
    
    var current = head
    var cycleTarget: ListNode?
    var lastNode: ListNode?
    var index = 0
    
    while let node = current {
        if index == cycleIndex {
            cycleTarget = node
        }
        lastNode = node
        current = node.next
        index += 1
    }
    lastNode?.next = cycleTarget   // tail → target = cycle
}

// Test — BOTH cases
let straight = createList([1, 2, 3, 4, 5])
print(hasCycle(straight))                  // false

let cyclic = createList([1, 2, 3, 4, 5])
createCycle(cyclic, cycleIndex: 1)         // tail → index 1
print(hasCycle(cyclic))                    // true

print(hasCycle(nil))                       // false — empty
print(hasCycle(createList([1])))           // false — single, no cycle
