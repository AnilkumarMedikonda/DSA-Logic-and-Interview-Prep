// 161_Add_Two_Numbers — LC 2

import UIKit

/*
 Two numbers as reversed-digit lists (ones place first). Add, return
 the sum as a reversed-digit list. Reverse order is a gift — you add
 from the ones place, carry flows left, exactly like on paper.
 
 Dummy head + carry. Loop while EITHER list has nodes OR carry != 0
 — that last clause is what appends the final carry ([5]+[5] → 0→1).
 Dropping it is THE classic bug for this problem.
 
 Missing digit = 0 is a real mathematical value (not a sentinel), but
 still written explicit if-let per house style — the explicit form
 forces you to confirm 0 is correct, not a fallback for an error.
 
 Complexity: Time O(max(m, n)). Space O(max(m, n)) for the result.
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

func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    var first = l1
    var second = l2
    
    let dummy = ListNode(0)
    var current = dummy
    var carry = 0
    
    while first != nil || second != nil || carry != 0 {
        // missing digit = 0 (real value), explicit if-let
        let value1: Int
        if let node = first { value1 = node.value } else { value1 = 0 }
        
        let value2: Int
        if let node = second { value2 = node.value } else { value2 = 0 }
        
        let sum = value1 + value2 + carry
        carry = sum / 10
        
        let node = ListNode(sum % 10)   // bind once — no force unwrap
        current.next = node
        current = node
        
        first = first?.next
        second = second?.next
    }
    return dummy.next
}

// Tests — the carry-past-end and different-length cases are what matter
traverseList(addTwoNumbers(createList([2, 4, 3]), createList([5, 6, 4])))  // 7 -> 0 -> 8 (342+465=807)
traverseList(addTwoNumbers(createList([9, 9]),    createList([1])))         // 0 -> 0 -> 1 (99+1=100)
traverseList(addTwoNumbers(createList([2, 4]),    createList([5, 6, 4])))   // 7 -> 0 -> 4 (42+465=507)
traverseList(addTwoNumbers(createList([0]),       createList([0])))         // 0
traverseList(addTwoNumbers(createList([5]),       createList([5])))         // 0 -> 1 (5+5=10)
