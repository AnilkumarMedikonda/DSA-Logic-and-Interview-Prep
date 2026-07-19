// 157_Remove_Nth_Node_From_End — LC 19

/*
 Remove the nth node from the END in one pass.
 
 Two-pointer gap: advance fast n+1 steps from dummy, then walk both
 until fast is nil — slow lands on the node BEFORE the target.
 
 Dummy head is what makes "remove the head" (n == length) and
 "remove the only node" work with NO special case — dummy.next
 absorbs the change.
 
 Complexity: Time O(n) single pass. Space O(1).
*/

final class ListNode {
    let val: Int
    var next: ListNode?
    
    init(_ val: Int) {
        self.val = val
    }
}

func createList(_ arr: [Int]) -> ListNode? {
    guard !arr.isEmpty else { return nil }
    
    let head = ListNode(arr[0])
    var current = head
    
    for i in 1..<arr.count {
        let node = ListNode(arr[i])
        current.next = node
        current = node
    }
    return head
}

func traverseList(_ head: ListNode?) {
    var current: ListNode? = head
    while let node = current {
        print(node.val, terminator: " -> ")
        current = node.next
    }
    print("nil")
}

func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
    let dummy = ListNode(-1)
    dummy.next = head
    
    var slow: ListNode? = dummy
    var fast: ListNode? = dummy
    
    // advance fast n+1 steps from dummy → gap of n between slow and fast
    for _ in 0...n {
        fast = fast?.next
    }
    
    // walk both until fast falls off — slow stops BEFORE the target
    while let f = fast {
        slow = slow?.next
        fast = f.next          // use the binding
    }
    
    slow?.next = slow?.next?.next   // splice the target out
    return dummy.next
}

// Tests — including the boundary cases where the pattern earns its keep
if let r = removeNthFromEnd(createList([1, 2, 3, 4, 5]), 2) { traverseList(r) } // 1 -> 2 -> 3 -> 5 -> nil
if let r = removeNthFromEnd(createList([1, 2, 3, 4, 5]), 5) { traverseList(r) } // 2 -> 3 -> 4 -> 5 -> nil (head)
if let r = removeNthFromEnd(createList([1, 2, 3, 4, 5]), 1) { traverseList(r) } // 1 -> 2 -> 3 -> 4 -> nil (tail)
print(removeNthFromEnd(createList([1]), 1) == nil)                              // true (only node)
