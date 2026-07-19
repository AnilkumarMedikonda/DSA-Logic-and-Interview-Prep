// 158_Reorder_List — LC 143

/*
 Reorder L0→L1→…→Ln  into  L0→Ln→L1→Ln-1→…  in place. No new nodes.
 
 Composition of three L2 primitives:
   1. find middle (156)     — split into two halves
   2. reverse 2nd half (152)
   3. weave alternately     — one from each, NOT a sorted merge
 
 Middle convention: this uses fast.next.next → FIRST middle, so on
 EVEN lengths the first half keeps the extra node. That's what reorder
 wants (second half must be ≤ first half so the weave exhausts cleanly).
 Note: opposite of LC 876 (156), which wanted the second middle.
 
 The cut — middle.next = nil — is the step people forget. Without it
 the halves stay joined and the reversal tangles.
 
 Weave saves BOTH nexts before rewiring (doubled reversal-discipline).
 
 Complexity: Time O(n) — find + reverse + weave all O(n). Space O(1).
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
    while let node = current {
        print(node.value, terminator: " -> ")
        current = node.next
    }
    print("nil")
}

// 156 — first-middle convention (fast.next.next), correct for reorder
func middleNode(_ head: ListNode?) -> ListNode? {
    var slow = head
    var fast = head
    while fast?.next != nil && fast?.next?.next != nil {
        slow = slow?.next
        fast = fast?.next?.next
    }
    return slow
}

// 152
func reverseList(_ head: ListNode?) -> ListNode? {
    var current = head
    var previous: ListNode?
    while let node = current {
        let next = node.next
        node.next = previous
        previous = node
        current = next
    }
    return previous
}

// 158
func reorderList(_ head: ListNode?) {
    guard head != nil, head?.next != nil else { return }   // 0 or 1 node
    
    let middle = middleNode(head)
    var second = reverseList(middle?.next)
    middle?.next = nil                    // CUT — split into two halves
    
    var first = head
    while second != nil {
        let temp1 = first?.next           // save both nexts first
        let temp2 = second?.next
        first?.next = second              // weave
        second?.next = temp1
        first = temp1                     // advance both
        second = temp2
    }
}

// Tests — both parities + guard edges
let odd = createList([1, 2, 3, 4, 5])
reorderList(odd)
traverseList(odd)                         // 1 -> 5 -> 2 -> 4 -> 3 -> nil

let even = createList([1, 2, 3, 4])
reorderList(even)
traverseList(even)                        // 1 -> 4 -> 2 -> 3 -> nil

let two = createList([1, 2])
reorderList(two)
traverseList(two)                         // 1 -> 2 -> nil

let one = createList([1])
reorderList(one)
traverseList(one)                         // 1 -> nil
