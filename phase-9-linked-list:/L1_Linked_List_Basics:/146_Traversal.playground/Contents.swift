// 146_Traversal

/*
 Walk the list head → tail, printing every value, ending with nil.
 Idiom: while let node = current — unwrap, work, advance.
 Empty list falls through the loop and prints just "nil".
 
 Trap: print(value) then print("->") separately — default terminator
 is \n, so the arrow lands on the next line. One call, one terminator.
*/

final class ListNode {
    let value: Int          // traversal never mutates values — let
    var next: ListNode?
    
    init(_ value: Int) {
        self.value = value
    }
}

// From 145 — reused, not re-derived
func createLinkedList(_ values: [Int]) -> ListNode? {
    guard values.count > 0 else { return nil }
    
    let head = ListNode(values[0])
    var current = head
    
    for i in 1..<values.count {
        let node = ListNode(values[i])
        current.next = node   // attach
        current = node        // advance
    }
    return head
}

func traverse(_ head: ListNode?) {
    var current: ListNode? = head
    
    while let node = current {
        print(node.value, terminator: " -> ")
        current = node.next
    }
    print("nil")   // closes the chain; also the empty-list output
}

// Verify
if let head = createLinkedList([1, 2, 3, 4]) {
    traverse(head)
}

traverse(nil)   // edge case: empty list
