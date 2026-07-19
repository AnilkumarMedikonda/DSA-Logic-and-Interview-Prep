// 150_Find_Length — full playground

import UIKit

/*
 Count the NODES (boxes, not values). Empty list → 0.
 Return type is plain Int — a count always exists, no optional.
 
 146's walk with a counter instead of a print.
 Keep the while-let binding even when the value is unused:
 `while let node = current` gives the clean advance `current = node.next`.
 `while let _ = current` forces `current = current?.next` — two
 optional-handlings where one suffices.
 
 Complexity: Time O(n) — visits every node once.
 Space O(1) — one Int + one pointer, genuinely constant
 (no hash structure hiding O(n) — the R1 trap).
*/

final class ListNode {
    let value: Int
    var next: ListNode?
    
    init(_ value: Int) {
        self.value = value
    }
}

// 145 — reviewed version
func createList(_ values: [Int]) -> ListNode? {
    guard !values.isEmpty else { return nil }
    
    let head = ListNode(values[0])
    var current = head            // non-optional walker
    
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

// 150
func length(_ head: ListNode?) -> Int {
    var count = 0
    var current: ListNode? = head
    
    while let node = current {
        count += 1
        current = node.next   // use the binding
    }
    return count
}

// Verify
let head = createList([1, 2, 4, 5, 6])
traverse(head)                 // 1 -> 2 -> 4 -> 5 -> 6 -> nil

print(length(head))            // 5
print(length(nil))             // 0 — empty list
print(length(createList([7]))) // 1 — single node
