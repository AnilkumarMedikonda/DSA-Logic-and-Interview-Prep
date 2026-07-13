// 147_Insert_Node — full playground

import UIKit

/*
 Insert a value at a given position. Three cases:
 - position 0 → new node becomes head (also covers empty list)
 - middle     → walk to node BEFORE position, rewire
 - position ≥ length → degrades into tail append
 
 Rewire rule: grab the old arrow BEFORE you overwrite it.
 
 Rewrite-debt note (logged): createList rebuilt from memory with
 `var current: ListNode?` — nil current made `current?.next = node`
 a silent no-op on i=1, head never connected. Fix: peel values[0]
 as head, current starts non-optional at head.
*/

final class ListNode {
    let value: Int
    var next: ListNode?
    
    init(_ value: Int) {
        self.value = value
    }
}

// 145 — peel-first: head and current are NON-optional
func createList(_ values: [Int]) -> ListNode? {
    guard !values.isEmpty else { return nil }
    
    let head = ListNode(values[0])
    var current = head            // ← non-optional, no ?. anywhere
    
    for i in 1..<values.count {
        let node = ListNode(values[i])
        current.next = node   // attach
        current = node        // advance
    }
    return head
}

// 146 — while let: unwrap, work, advance via the BINDING
func traverse(_ head: ListNode?) {
    var current: ListNode? = head
    
    while let node = current {
        print(node.value, terminator: " -> ")
        current = node.next   // ← node, not current?.next
    }
    print("nil")
}

// 147 — inserts at ANY position (name must not lie)
func insert(_ head: ListNode?, _ value: Int, at position: Int) -> ListNode? {
    let newNode = ListNode(value)
    
    // Case 1: new head (covers empty list too)
    if position == 0 {
        newNode.next = head
        return newNode
    }
    
    // Non-zero position into empty list
    guard let head = head else { return newNode }
    
    // Case 2: walk to the node BEFORE the insertion point.
    // Tail-existence condition makes over-length positions append.
    var current = head
    var index = 0
    while index < position - 1, let next = current.next {
        current = next
        index += 1
    }
    
    // Rewire — grab the tail FIRST, then attach
    newNode.next = current.next
    current.next = newNode
    
    return head
}

// Verify
var head = createList([1, 2, 3, 4, 5, 5])
traverse(head)                    // 1 -> 2 -> 3 -> 4 -> 5 -> 5 -> nil

head = insert(head, 10, at: 0)    // head insert
traverse(head)                    // 10 -> 1 -> 2 -> 3 -> 4 -> 5 -> 5 -> nil

head = insert(head, 99, at: 3)    // middle insert
traverse(head)                    // 10 -> 1 -> 2 -> 99 -> 3 -> 4 -> 5 -> 5 -> nil

head = insert(head, 7, at: 100)   // over-length → tail append
traverse(head)                    // ... -> 5 -> 7 -> nil

head = insert(nil, 5, at: 0)      // empty list
traverse(head)                    // 5 -> nil
