// 152_Reverse_Linked_List — LC 206

/*
 Reverse the list. 1 -> 2 -> 3 -> nil  becomes  3 -> 2 -> 1 -> nil.
 
 Iterative — three pointers, FOUR lines in strict order:
   save   next = current.next   (rescue forward link BEFORE breaking it)
   flip   current.next = prev   (point backward)
   adv    prev = current
   adv    current = next
 
 Mantra: SAVE NEXT FIRST. Flip before save → you lose the whole
 remaining list (the orphan trap, at full scale).
 
 Recursive: reverse the REST first, then head.next.next = head
 re-points the node behind you back at head; head.next = nil.
 
 Complexity (both): Time O(n). Space — iterative O(1), recursive O(n) stack.
*/

final class ListNode {
    let val: Int
    var next: ListNode?
    
    init(_ val: Int) {
        self.val = val
    }
}

// 145
func createList(_ arr: [Int]) -> ListNode? {
    guard !arr.isEmpty else { return nil }
    
    let head = ListNode(arr[0])
    var current = head
    
    for i in 1..<arr.count {          // index loop — no dropFirst
        let node = ListNode(arr[i])
        current.next = node
        current = node
    }
    return head
}

// 146
func traverseList(_ head: ListNode?) {
    var current: ListNode? = head
    while let node = current {
        print(node.val, terminator: " -> ")
        current = node.next
    }
    print("nil")
}

// 152 — iterative
func reverseList(_ head: ListNode?) -> ListNode? {
    var prev: ListNode? = nil
    var current = head
    
    while let node = current {
        let next = node.next   // save
        node.next = prev       // flip
        prev = node            // advance prev
        current = next         // advance current
    }
    return prev                // new head
}

// 152 — recursive (follow-up)
func reverseListRecursive(_ head: ListNode?) -> ListNode? {
    // base: empty or single node — nothing to flip
    guard let head = head, head.next != nil else { return head }
    
    let newHead = reverseListRecursive(head.next)  // reverse the REST
    head.next?.next = head   // node behind me points back at me
    head.next = nil          // I become the tail
    return newHead           // same new head bubbles up unchanged
}

// Test
let head = createList([1, 2, 3, 4, 5])
print("Original:")
traverseList(head)

let reversed = reverseList(head)
print("Reversed (iterative):")
traverseList(reversed)

// reversed is now 5->4->3->2->1; reverse it back with recursion
let backAgain = reverseListRecursive(reversed)
print("Reversed again (recursive):")
traverseList(backAgain)
