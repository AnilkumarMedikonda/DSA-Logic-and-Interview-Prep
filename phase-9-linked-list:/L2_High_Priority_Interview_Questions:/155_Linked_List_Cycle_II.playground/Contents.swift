// 155_Linked_List_Cycle_II — LC 142

/*
 Find WHERE the cycle begins, or nil.
 Phase 1: Floyd's collision (= LC 141). Phase 2: reset p1 to head,
 keep p2 at collision, advance both by 1 — they meet at the entrance.
 Why: L = nC - k, so L steps from head and from collision both land there.
 
 Node comparison is ALWAYS ===/!== (identity). != needs Equatable,
 which ListNode neither has nor should.
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
    
    let head = ListNode(arr[0])       // let — never reassigned
    var current = head
    
    for i in 1..<arr.count {
        let node = ListNode(arr[i])
        current.next = node
        current = node
    }
    return head
}

func traverse(_ head: ListNode?) {
    var current = head                // honest name, not shadowed head
    while let node = current {
        print(node.val, terminator: " -> ")
        current = node.next
    }
    print("nil")
}

// LC 141 — Phase 1 only. Identical to detectCycle's loop.
func hasCycle(_ head: ListNode?) -> Bool {
    var slow = head
    var fast = head
    
    while let f = fast, let fNext = f.next {
        slow = slow?.next
        fast = fNext.next
        if slow === fast { return true }
    }
    return false
}

// Test harness — tail → node at cycleIndex. >= 0 allows cycle-to-head.
func createCycle(_ head: ListNode?, _ cycleIndex: Int) -> ListNode? {
    guard cycleIndex >= 0 else { return nil }
    
    var current = head
    var cycleNode: ListNode?
    var lastNode: ListNode?
    var index = 0
    
    while let node = current {
        if index == cycleIndex {
            cycleNode = node
        }
        lastNode = node
        current = node.next
        index += 1
    }
    lastNode?.next = cycleNode
    return cycleNode
}

// LC 142
func detectCycle(_ head: ListNode?) -> ListNode? {
    var slow = head
    var fast = head
    
    while let f = fast, let fNext = f.next {
        slow = slow?.next
        fast = fNext.next
        
        if slow === fast {              // collision
            var p1 = head
            var p2 = slow
            while p1 !== p2 {           // !== not != — identity
                p1 = p1?.next
                p2 = p2?.next
            }
            return p1                   // entrance
        }
    }
    return nil
}

// Tests — fresh list per case (can't traverse a cyclic list)
if let head = createList([1, 2, 3, 4, 5]) {
    traverse(head)                                  // 1 -> 2 -> 3 -> 4 -> 5 -> nil
}

let straight = createList([1, 2, 3, 4, 5])
print(hasCycle(straight))                           // false
print(detectCycle(straight) == nil)                 // true — no entrance

let cyclic = createList([1, 2, 3, 4, 5])
let expected = createCycle(cyclic, 1)               // entrance = value 2
print(hasCycle(cyclic))                             // true
if let entrance = detectCycle(cyclic) {
    print(entrance.val)                             // 2
    print(entrance === expected)                    // true — exact node
}
