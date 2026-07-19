// 160_Intersection_Of_Two_Linked_Lists — LC 160

/*
 Find the node where two lists merge (by IDENTITY, not value), or nil.
 
 Two-pointer swap trick, O(1) space: pA walks A then B, pB walks B
 then A. Both cover a+b nodes total, so they sync. If a shared tail
 exists, they meet there; if not, both hit nil together and === nil.
 
 Why the lengths cancel: pA travels a+b, pB travels b+a — equal.
 The list-swap erases the length difference without measuring it.
 
 ===/!== throughout — identity. And nil === nil is true, so the
 no-intersection case exits the while cleanly, returning nil.
 
 Complexity: Time O(a + b). Space O(1).
*/

final class ListNode {
    let value: Int
    var next: ListNode?
    
    init(_ value: Int) {
        self.value = value
    }
}

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

func traverseList(_ head: ListNode?) {
    var current = head
    while let node = current {           // binding — no force unwrap
        print(node.value, terminator: " -> ")
        current = node.next
    }
    print("nil")
}

func intersectionNode(_ headA: ListNode?, _ headB: ListNode?) -> ListNode? {
    var pointer1 = headA
    var pointer2 = headB
    
    while pointer1 !== pointer2 {
        pointer1 = pointer1 == nil ? headB : pointer1?.next   // redirect to OTHER head
        pointer2 = pointer2 == nil ? headA : pointer2?.next
    }
    return pointer1   // intersection node, or nil (both reached nil together)
}

// Test — intersecting: tail nodes must be the SAME objects
let shared = createList([8, 4, 5])

let a1 = ListNode(4)
let a2 = ListNode(1)
a1.next = a2
a2.next = shared            // A's tail IS shared

let b1 = ListNode(5)
let b2 = ListNode(6)
let b3 = ListNode(1)
b1.next = b2
b2.next = b3
b3.next = shared            // B points at the SAME objects

if let node = intersectionNode(a1, b1) {
    print("intersect at \(node.value)")     // intersect at 8
} else {
    print("no intersection")
}

// Test — no intersection: fully separate lists
let x = createList([1, 2, 3])
let y = createList([4, 5, 6])
print(intersectionNode(x, y) == nil)         // true
