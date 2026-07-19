// 153_Merge_Two_Sorted_Lists — LC 21

/*
 Merge two sorted lists by splicing existing nodes (no new nodes).
 
 Dummy head technique: a throwaway node to attach onto, so there's
 no "is this the first node?" special case. Build off dummy.next,
 return dummy.next.
 
 Walk both while BOTH have nodes: attach the smaller, advance that
 list + tail. When one runs dry, attach the whole remainder in one
 line — it's already sorted and linked.
 
 <= (not <) keeps the merge STABLE: equal values keep l1-before-l2.
 
 tail.next = list1 ?? list2 is the ONE valid coalescing: choosing
 between two node references, not defaulting data to a fake number.
 The house rule bans ?? 0-style sentinels, not all ??.
 
 Complexity: Time O(n + m). Space O(1) — rewiring, no new nodes.
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

// 153
func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    var list1 = l1
    var list2 = l2
    
    let dummy = ListNode(-1)      // sentinel — value never matters
    var tail = dummy
    
    while let node1 = list1, let node2 = list2 {
        if node1.val <= node2.val {   // <= keeps merge stable
            tail.next = node1
            tail = node1
            list1 = node1.next
        } else {
            tail.next = node2
            tail = node2
            list2 = node2.next
        }
    }
    
    tail.next = list1 ?? list2    // attach the (sorted) remainder
    return dummy.next             // real head; dummy discarded
}

// Test
let list1 = createList([1, 2, 4])
let list2 = createList([1, 3, 4])

print("List 1:")
traverseList(list1)
print("List 2:")
traverseList(list2)

let merged = mergeTwoLists(list1, list2)
print("Merged:")
traverseList(merged)                          // 1 -> 1 -> 2 -> 3 -> 4 -> 4 -> nil

// Edge cases
print("One empty:")
traverseList(mergeTwoLists(createList([1, 3, 5]), nil))   // 1 -> 3 -> 5 -> nil
print("Both empty:")
traverseList(mergeTwoLists(nil, nil))                     // nil
