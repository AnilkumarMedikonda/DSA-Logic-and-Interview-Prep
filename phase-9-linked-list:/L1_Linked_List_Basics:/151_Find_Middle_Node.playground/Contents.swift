// 151_Find_Middle_Node — full playground

import UIKit

/*
 Return the middle node. Even length → SECOND middle (LC 876).
 
 Brute force: two passes — count nodes, walk count/2 hops.
 Optimised:  slow/fast — one pass. Slow steps 1, fast steps 2;
 when fast can't double-step, slow is at the middle.
 
 Idiom: unwrap ONCE, use the bindings.
   while let f = fast, let fNext = f.next   ← proves the double-step safe
 NOT: while fast != nil && fast?.next != nil + fast?.next?.next chains.
 
 Convention knob: requiring f.next → second middle on even lists.
 Requiring f.next?.next instead → first middle. Interview follow-up.
 
 Complexity: both O(n) time; slow/fast is O(1) space, one pass.
*/

final class ListNode {
    let value: Int
    var next: ListNode?
    
    init(_ value: Int) {
        self.value = value
    }
}

// 145 — reviewed version
func createList(_ values: [Int]) -> ListNode? {
    guard !values.isEmpty else { return nil }
    
    let head = ListNode(values[0])
    var current = head
    
    for i in 1..<values.count {       // index loop — no dropFirst
        let node = ListNode(values[i])
        current.next = node   // attach
        current = node        // advance
    }
    return head
}

// 146
func traverse(_ head: ListNode?) {
    var current: ListNode? = head
    while let node = current {
        print(node.value, terminator: " -> ")
        current = node.next
    }
    print("nil")
}

// 151 — brute force: two passes
func middleNodeTwoPass(_ head: ListNode?) -> ListNode? {
    var count = 0
    var current: ListNode? = head
    
    while let node = current {
        count += 1
        current = node.next
    }
    
    var walker: ListNode? = head      // its own name — no shadowed head
    for _ in 0..<(count / 2) {
        walker = walker?.next         // bounded; count guarantees the hops
    }
    return walker
}

// 151 — optimised: slow/fast, one pass
func findMiddle(_ head: ListNode?) -> ListNode? {
    var slow: ListNode? = head
    var fast: ListNode? = head
    
    while let f = fast, let fNext = f.next {
        slow = slow?.next     // 1 step
        fast = fNext.next     // 2 steps via the binding — no ?.?. chain
    }
    return slow
}

// Verify — both parities, both versions, edges
let odd = createList([1, 2, 3, 4, 5])
let even = createList([1, 2, 3, 4])

traverse(odd)
traverse(even)

if let mid = findMiddle(odd) { print("odd middle: \(mid.value)") }    // 3
if let mid = findMiddle(even) { print("even middle: \(mid.value)") }  // 3

if let mid = middleNodeTwoPass(odd) { print(mid.value) }              // 3
if let mid = middleNodeTwoPass(even) { print(mid.value) }             // 3

print(findMiddle(nil) == nil)                                          // true — empty
if let mid = findMiddle(createList([7])) { print(mid.value) }          // 7 — single
