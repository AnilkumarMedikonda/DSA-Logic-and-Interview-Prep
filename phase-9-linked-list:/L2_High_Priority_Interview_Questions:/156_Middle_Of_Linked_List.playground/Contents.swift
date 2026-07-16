// 156_Middle_Of_Linked_List — LC 876
// NOTE: this is the same problem as 151. Likely a misfile — see numbering
// check at the bottom before committing.

/*
 Return the middle. Even length → SECOND middle (LC 876 convention).
 Convention knob (the trap): the loop condition decides which middle.
   while let f = fast, let fNext = f.next   → requires fast.next  → SECOND middle ✓
   while fast.next != nil && fast.next.next → requires fast.next.next → FIRST middle ✗
 One extra .next in the condition flips the answer. LC wants the single-.next form.
*/

final class ListNode {
    let val: Int
    var next: ListNode?
    
    init(_ val: Int) {
        self.val = val
    }
}

// Reviewed createList — head from arr[0], empty guard, non-optional walker
func createList(_ arr: [Int]) -> ListNode? {
    guard !arr.isEmpty else { return nil }
    
    let head = ListNode(arr[0])       // from the data, NOT ListNode(0)
    var current = head
    
    for i in 1..<arr.count {
        let node = ListNode(arr[i])
        current.next = node
        current = node
    }
    return head
}

func traverse(_ head: ListNode?) {
    var current = head
    while let node = current {
        print(node.val, terminator: " -> ")
        current = node.next
    }
    print("nil")
}

// Brute force — count, then walk count/2
func middleNode(_ head: ListNode?) -> ListNode? {
    var count = 0
    var current = head
    while let node = current {
        count += 1
        current = node.next
    }
    
    var walker = head
    for _ in 0..<(count / 2) {
        walker = walker?.next
    }
    return walker
}

// Optimal — slow/fast, single .next condition → SECOND middle
func middleNodeOptimal(_ head: ListNode?) -> ListNode? {
    var slow = head
    var fast = head
    
    while let f = fast, let fNext = f.next {
        slow = slow?.next
        fast = fNext.next
    }
    return slow
}

// Tests — odd AND even (even is where the convention bug hides)
if let m = middleNodeOptimal(createList([1, 2, 3, 4, 5])) { print(m.val) }  // 3 (odd)
if let m = middleNodeOptimal(createList([1, 2, 3, 4]))    { print(m.val) }  // 3 (even ← the tell)
if let m = middleNode(createList([1, 2, 3, 4, 5]))        { print(m.val) }  // 3
if let m = middleNode(createList([1, 2, 3, 4]))           { print(m.val) }  // 3
if let m = middleNodeOptimal(createList([1]))             { print(m.val) }  // 1 (single)
print(middleNodeOptimal(nil) == nil)                                        // true (empty)
