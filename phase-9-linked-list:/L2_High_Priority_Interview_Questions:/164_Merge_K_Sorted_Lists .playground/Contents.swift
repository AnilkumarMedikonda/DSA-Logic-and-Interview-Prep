//
// 023_Merge_K_Sorted_Lists.playground
//
// Problem:
// Given an array of K sorted linked lists, merge them into one sorted list.
//
// Approaches:
// 1. Brute Force — collect all values, sort, rebuild
//    Time: O(N log N)   Space: O(N)
//
// 2. Divide & Conquer (Interview Recommended ⭐)
//    Reuse Merge Two Sorted Lists — same idea as Merge Sort
//    Time: O(N log K)   Space: O(log K)
//
// 3. Min Heap (Alternative Optimal)
//    Time: O(N log K)   Space: O(K)
//

import Foundation

// MARK: - ListNode

final class ListNode {
    let val: Int
    var next: ListNode?

    init(val: Int, next: ListNode? = nil) {
        self.val = val
        self.next = next
    }
}

// MARK: - Helpers

func createList(_ values: [Int]) -> ListNode? {
    guard !values.isEmpty else { return nil }

    let head = ListNode(val: values[0])
    var current = head

    for i in 1..<values.count {
        let node = ListNode(val: values[i])
        current.next = node
        current = node
    }

    return head
}

func printList(_ head: ListNode?) {
    var current = head

    while let node = current {
        print(node.val, terminator: " -> ")
        current = node.next
    }

    print("nil")
}

// MARK: - Merge Two Sorted Lists

func mergeTwoLists(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {

    let dummy = ListNode(val: -1)
    var tail: ListNode? = dummy

    var left = list1
    var right = list2

    while let leftNode = left,
          let rightNode = right {

        if leftNode.val <= rightNode.val {   // <= keeps the merge stable
            tail?.next = leftNode
            left = leftNode.next
        } else {
            tail?.next = rightNode
            right = rightNode.next
        }

        tail = tail?.next
    }

    tail?.next = left ?? right   // attach the remaining sorted tail

    return dummy.next
}

// MARK: - Merge K Sorted Lists

func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
    guard !lists.isEmpty else { return nil }

    return divide(lists, 0, lists.count - 1)
}

// MARK: - Divide & Conquer

func divide(_ lists: [ListNode?], _ left: Int, _ right: Int) -> ListNode? {

    // Base case: single list is already sorted
    if left == right {
        return lists[left]
    }

    let mid = left + (right - left) / 2

    let leftList = divide(lists, left, mid)
    let rightList = divide(lists, mid + 1, right)

    return mergeTwoLists(leftList, rightList)
}

// MARK: - Test Cases

print("===== Test Case 1 =====")
let list1 = createList([1, 4, 5])
let list2 = createList([1, 3, 4])
let list3 = createList([2, 6])

printList(mergeKLists([list1, list2, list3]))
// 1 -> 1 -> 2 -> 3 -> 4 -> 4 -> 5 -> 6 -> nil

print("\n===== Test Case 2 =====")
printList(mergeKLists([]))
// nil

print("\n===== Test Case 3 =====")
printList(mergeKLists([
    createList([5]),
    createList([1]),
    createList([3])
]))
// 1 -> 3 -> 5 -> nil

print("\n===== Test Case 4 =====")
printList(mergeKLists([nil, createList([1, 2]), nil]))
// 1 -> 2 -> nil

print("\n===== Test Case 5 =====")
printList(mergeKLists([createList([1, 2, 3])]))
// 1 -> 2 -> 3 -> nil

print("\n===== Interview Notes =====")
print("""
Flow:
1. Explain Brute Force (O(N log N))
2. Observe the lists are already sorted
3. Use Divide & Conquer (Merge Sort idea)
4. Reuse Merge Two Sorted Lists
5. Complexity — Time: O(N log K), Space: O(log K)
""")
