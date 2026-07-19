// 159_Palindrome_Linked_List — LC 234

import UIKit

/*
 Is the list a palindrome? Compose: find middle (156) + reverse
 second half (152) + walk both halves comparing values.
 
 while second != nil is the right terminator — second half is ≤ first
 half, so it exhausts first and the middle node (odd length) is skipped
 naturally (it has no pair to match).
 
 Check NODES, not .value: "can fast double-step" is about next
 existence, never about the value. Empty list = true (vacuously).
 
 Caveat: this MUTATES the input (second half left reversed). Interview
 follow-up is often "restore it after" — worth mentioning.
 
 Complexity: Time O(n). Space O(1).
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
    
    let head = ListNode(values[0])       // peel-first, non-optional walker
    var current = head
    
    for i in 1..<values.count {
        let node = ListNode(values[i])
        current.next = node              // no ?.
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

func middleNode(_ head: ListNode?) -> ListNode? {
    var slow = head
    var fast = head
    while fast?.next != nil && fast?.next?.next != nil {   // NODE check
        slow = slow?.next
        fast = fast?.next?.next
    }
    return slow
}

func isPalindrome(_ head: ListNode?) -> Bool {
    guard head != nil else { return true }   // empty = vacuously palindrome
    
    let mid = middleNode(head)               // no dead slow/fast vars
    var first = head
    var second = reverseList(mid?.next)
    
    while second != nil {                    // second is the shorter half
        if first?.value != second?.value {
            return false
        }
        first = first?.next
        second = second?.next
    }
    return true
}

// Tests — true, false, both parities, edges
let sample = createList([1, 2, 2, 1])
traverseList(sample)                                 // 1 -> 2 -> 2 -> 1 -> nil
print(isPalindrome(sample))                          // true

print(isPalindrome(createList([1, 2, 3, 2, 1])))     // true  — odd palindrome
print(isPalindrome(createList([1, 2, 3])))           // false — the critical case
print(isPalindrome(createList([1])))                 // true  — single
print(isPalindrome(createList([])))                  // true  — empty
