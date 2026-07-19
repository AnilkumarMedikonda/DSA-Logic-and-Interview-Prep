// 149_Search_Node — full playground

import UIKit

/*
 Search a linked list two ways:
 - search(_:_:)  → Bool  (does the value exist?)
 - indexOf(_:_:) → Int?  (where? — nil if absent, NOT -1)
 
 Int? instead of a -1 sentinel: the type says "maybe absent",
 so the caller is FORCED to handle the miss. This is the house
 no-sentinel rule expressed as an API.
 
 Both: traversal with early return. Check THIS node first,
 then advance. Fall-through past the tail = not found.
 
 Complexity (both): Time O(n) — worst case walks every node.
 Space O(1) — two locals, no extra structure.
 
 Phase 9 recurring traps (all three appeared in this problem):
 1. Lost walker — building without current / without advancing
 2. Optional interpolation in print → Optional(2) output
 3. Guard placed AFTER the line that crashes on bad input
*/

final class ListNode {
    let value: Int
    var next: ListNode?
    
    init(_ value: Int) {
        self.value = value
    }
}

func createList(_ values: [Int]) -> ListNode? {
    guard !values.isEmpty else { return nil }   // guard BEFORE values[0]
    
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

// 149a — existence
func search(_ head: ListNode?, _ target: Int) -> Bool {
    var current: ListNode? = head
    
    while let node = current {
        if node.value == target {
            return true
        }
        current = node.next
    }
    return false   // fell past the tail
}

// 149b — position of first match
func indexOf(_ head: ListNode?, _ target: Int) -> Int? {
    var current: ListNode? = head
    var index = 0
    
    while let node = current {
        if node.value == target {   // check THIS node
            return index
        }
        current = node.next         // then advance both
        index += 1
    }
    return nil   // fell past the tail
}

// Verify
let head = createList([1, 2, 3, 4, 5])
traverse(head)                        // 1 -> 2 -> 3 -> 4 -> 5 -> nil

// call sites: explicit if let — no optional interpolation
if let index = indexOf(head, 3) {
    print("3 found at index \(index)")   // 3 found at index 2
} else {
    print("3 not found")
}

if let index = indexOf(head, 99) {
    print("99 found at index \(index)")
} else {
    print("99 not found")                // 99 not found
}

print(search(head, 5))                   // true
print(search(head, 42))                  // false
print(search(nil, 1))                    // false — empty list
