//
// 165_Reverse_Nodes_In_K_Group — LC 25
//
// Reverse the list in groups of k. If fewer than k nodes remain,
// leave them as-is.
//
// [1,2,3,4,5], k=2 → 2 -> 1 -> 4 -> 3 -> 5 -> nil
// [1,2,3,4,5], k=3 → 3 -> 2 -> 1 -> 4 -> 5 -> nil
//
// Iterative + dummy head.
// Time: O(n)   Space: O(1)   (recursive version costs O(n/k) stack)
//

import Foundation

//======================================================
// MARK: - ListNode
//======================================================

final class ListNode {

    let val: Int
    var next: ListNode?

    init(_ val: Int, _ next: ListNode? = nil) {
        self.val = val
        self.next = next
    }
}

//======================================================
// MARK: - Create Linked List
//======================================================

func createList(_ values: [Int]) -> ListNode? {

    guard !values.isEmpty else {
        return nil
    }

    let head = ListNode(values[0])
    var current = head

    for i in 1..<values.count {
        let node = ListNode(values[i])
        current.next = node
        current = node
    }

    return head
}

//======================================================
// MARK: - Print Linked List
//======================================================

func printList(_ head: ListNode?) {

    var current = head

    while let node = current {
        print(node.val, terminator: " -> ")
        current = node.next
    }

    print("nil")
}

//======================================================
// MARK: - Reverse K Group
//======================================================

func reverseKGroup(_ head: ListNode?, _ k: Int) -> ListNode? {

    // k <= 1 or empty list — nothing to reverse
    guard let head = head, k > 1 else {
        return head
    }

    let dummy = ListNode(0)
    dummy.next = head

    // Tail of the previously-reversed group
    var groupPrev: ListNode? = dummy

    while true {

        //--------------------------------------------------
        // Step 1: find the kth node — CHECK BEFORE REVERSING
        //--------------------------------------------------

        var kth = groupPrev

        for _ in 0..<k {
            kth = kth?.next

            if kth == nil {
                return dummy.next     // fewer than k left — leave as-is
            }
        }

        //--------------------------------------------------
        // Step 2: save where the next group starts
        //--------------------------------------------------

        let groupNext = kth?.next

        //--------------------------------------------------
        // Step 3: reverse this group
        // Seeding prev with groupNext pre-links the group's tail
        // to the next group, so Step 4 has only one stitch left.
        //--------------------------------------------------

        var prev = groupNext
        var current = groupPrev?.next

        while current !== groupNext {
            let next = current?.next
            current?.next = prev
            prev = current
            current = next
        }

        //--------------------------------------------------
        // Step 4/5: stitch, then advance
        // temp is the old group head = the new group TAIL.
        // Save it BEFORE overwriting groupPrev.next.
        //--------------------------------------------------

        let temp = groupPrev?.next
        groupPrev?.next = kth      // previous group → new head
        groupPrev = temp           // tail becomes next group's prev
    }
}

//======================================================
// MARK: - Tests
//======================================================

print("========== Test Case 1 ==========")
let list1 = createList([1, 2, 3, 4, 5])
print("Original")
printList(list1)
print("\nReverse k = 2")
printList(reverseKGroup(list1, 2))
// 2 -> 1 -> 4 -> 3 -> 5 -> nil

print("\n========== Test Case 2 ==========")
printList(reverseKGroup(createList([1, 2, 3, 4, 5]), 3))
// 3 -> 2 -> 1 -> 4 -> 5 -> nil

print("\n========== Test Case 3 ==========")
printList(reverseKGroup(createList([1, 2, 3, 4, 5, 6]), 3))
// 3 -> 2 -> 1 -> 6 -> 5 -> 4 -> nil

print("\n========== Test Case 4 ==========")
printList(reverseKGroup(createList([1, 2]), 3))
// 1 -> 2 -> nil

print("\n========== Test Case 5 ==========")
printList(reverseKGroup(createList([1, 2, 3]), 1))
// 1 -> 2 -> 3 -> nil

print("\n========== Test Case 6 ==========")
printList(reverseKGroup(nil, 2))
// nil
