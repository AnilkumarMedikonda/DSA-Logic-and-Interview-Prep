// 144_Create_Node

/*
 A Node is the basic building block of a Linked List.
 Think of a node as a box that contains:
 - Value – the actual information.
 - Next  – a reference (pointer) to the next node.
*/

final class ListNode {
    var val: Int
    var next: ListNode?
    
    init(_ val: Int) {
        self.val = val
    }
}

let node1 = ListNode(1)
let node2 = ListNode(2)
let node3 = ListNode(3)

node1.next = node2
node2.next = node3

// Print the chain — explicit if-let, no optional interpolation
print("\(node1.val) -> \(node2.val) -> \(node3.val)")

if let tail = node3.next {
    print("node3 -> \(tail.val)")
} else {
    print("node3 -> nil")   // prints this: node3 is the last node
}
