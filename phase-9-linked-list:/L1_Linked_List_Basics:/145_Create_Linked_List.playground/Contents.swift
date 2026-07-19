// 145_Create_Linked_List

/*
 Build a linked list from an array and return the head.
 Pattern: peel off values[0] as head → guarantees non-optional
 head/current. Then for each remaining value: attach + advance.
 
 Trap: attaching without advancing (current.next = node, but no
 current = node) → every value overwrites the same .next.
*/

final class ListNode {
    var value: Int
    var next: ListNode?
    
    init(_ value: Int) {
        self.value = value
        self.next = nil
    }
}

func createLinkedList(_ values: [Int]) -> ListNode? {
    guard values.count > 0 else { return nil }
    
    let head = ListNode(values[0])   // head exists — non-optional
    var current = head               // current non-optional too
    
    for i in 1..<values.count {
        let node = ListNode(values[i])
        current.next = node   // attach
        current = node        // advance (the bookkeeping line)
    }
    return head
}

// Verify
if let head = createLinkedList([1, 2, 3, 4]) {
    // temporary verification print — full traversal is 146's job
    var current: ListNode? = head
    while let node = current {
        print(node.value, terminator: " -> ")
        current = node.next
    }
    print("nil")
} else {
    print("empty list")
}
