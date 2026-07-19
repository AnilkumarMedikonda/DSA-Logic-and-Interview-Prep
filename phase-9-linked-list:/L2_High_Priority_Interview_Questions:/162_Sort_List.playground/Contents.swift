// 162_Sort_List — LC 148

/*
 Sort a list in O(n log n) time, O(1) space (excluding recursion stack)
 — merge sort ON the list. Lists split and merge naturally; no random
 access means quicksort is painful, merge sort isn't.
 
 Three pieces (two reused):
   base:  0 or 1 node → already sorted
   split: find middle with a PREVIOUS pointer, cut before slow →
          strict halves. On [2,1] this gives [2] and [1] — the
          termination-critical case. (Cut-before-slow guarantees each
          half is strictly smaller, so recursion shrinks and ends.)
   merge: 153, verbatim
 
 Complexity: Time O(n log n). Space O(log n) recursion stack.
*/

final class ListNode {
    let value: Int
    var next: ListNode?
    
    init(_ value: Int, _ next: ListNode? = nil) {
        self.value = value
        self.next = next
    }
}

func createList(_ values: [Int]) -> ListNode? {
    guard !values.isEmpty else { return nil }
    
    let head = ListNode(values[0])
    var current = head
    
    for i in 1..<values.count {
        let node = ListNode(values[i])
        current.next = node
        current = node
    }
    return head
}

func traverseList(_ head: ListNode?) {
    var current = head
    while let node = current {
        print(node.value, terminator: " -> ")
        current = node.next
    }
    print("nil")
}

// 153 — merge, binding version (no force unwrap)
func merge(_ left: ListNode?, _ right: ListNode?) -> ListNode? {
    let dummy = ListNode(0)
    var current: ListNode? = dummy
    
    var leftNode = left
    var rightNode = right
    
    while let l = leftNode, let r = rightNode {
        if l.value <= r.value {          // <= keeps it stable
            current?.next = l
            leftNode = l.next
        } else {
            current?.next = r
            rightNode = r.next
        }
        current = current?.next
    }
    
    current?.next = leftNode ?? rightNode   // legit ?? — node ref choice
    return dummy.next
}

// 162 — recursive merge sort with cut-before-slow split
func sortList(_ head: ListNode?) -> ListNode? {
    guard head != nil, head?.next != nil else { return head }   // base: 0 or 1 node
    
    var slow = head
    var fast = head
    var previous: ListNode?
    
    while fast != nil && fast?.next != nil {
        previous = slow
        slow = slow?.next
        fast = fast?.next?.next
    }
    previous?.next = nil          // CUT — sever into strict halves
    
    let left = sortList(head)     // recurse on first half
    let right = sortList(slow)    // recurse on second half
    return merge(left, right)
}

// Tests — including the termination case and adversarial inputs
traverseList(sortList(createList([4, 2, 1, 3])))      // 1 -> 2 -> 3 -> 4 -> nil
traverseList(sortList(createList([2, 1])))            // 1 -> 2 -> nil  (termination)
traverseList(sortList(createList([1])))               // 1 -> nil       (base)
traverseList(sortList(createList([])))                // nil            (empty)
traverseList(sortList(createList([5, 4, 3, 2, 1])))   // 1 -> 2 -> 3 -> 4 -> 5 -> nil (reverse)
traverseList(sortList(createList([3, 3, 1, 2, 2])))   // 1 -> 2 -> 2 -> 3 -> 3 -> nil (dupes)
