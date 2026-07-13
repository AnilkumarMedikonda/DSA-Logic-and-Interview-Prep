// 148_Delete_Node — full playground

import UIKit

/*
 Delete the node at a given position. Return the (possibly new) head.
 
 Cases:
 - position 0        → head moves forward one (return head?.next)
 - middle / tail     → walk to position-1, skip over the victim
 - past the end      → NO-OP (the if-let on victim is the bounds check)
 - empty list        → nil
 
 Mirror of 147: same walk to position-1, but no new node —
 one arrow changes: current.next = victim.next.
 
 Trap: over-length delete must do NOTHING. The walk stops early at
 the tail, but current.next is nil there → if let victim fails → no-op.
 Skipping without that unwrap would delete the tail by mistake.
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
    
    for i in 1..<values.count {
        let node = ListNode(values[i])
        current.next = node   // attach
        current = node        // advance
    }
    return head
}

// 146
func traverse(_ head: ListNode?) {
    var current: ListNode? = head
    
    while let node = current {
        print(node.value, terminator: " -> ")
        current = node.next
    }
    print("nil")
}

// 148
func delete(_ head: ListNode?, at position: Int) -> ListNode? {
    // Case 1: delete head — covers empty list too (nil stays nil)
    if position == 0 {
        return head?.next
    }
    
    guard let head = head else { return nil }
    
    // Case 2: walk to the node BEFORE the victim — same loop as 147
    var current = head
    var index = 0
    while index < position - 1, let next = current.next {
        current = next
        index += 1
    }
    
    // The skip. Unwrapping the victim IS the bounds check:
    // position past the end → current.next is nil → no-op.
    if let victim = current.next {
        current.next = victim.next
    }
    
    return head
}

// Verify — all five cases
var head = createList([1, 2, 3, 4, 5])
traverse(head)                  // 1 -> 2 -> 3 -> 4 -> 5 -> nil

head = delete(head, at: 0)      // delete head
traverse(head)                  // 2 -> 3 -> 4 -> 5 -> nil

head = delete(head, at: 2)      // delete middle (value 4)
traverse(head)                  // 2 -> 3 -> 5 -> nil

head = delete(head, at: 2)      // delete tail (value 5)
traverse(head)                  // 2 -> 3 -> nil

head = delete(head, at: 100)    // past the end → NO-OP
traverse(head)                  // 2 -> 3 -> nil (unchanged)

head = delete(nil, at: 0)       // empty list
traverse(head)                  // nil
