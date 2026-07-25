import UIKit

// MARK: - Problem
// 174 — Same Tree (LC 100)
// Given roots p and q of two binary trees, return true if they are
// identical: same structure AND same node values at every position.
//
//   1        1              1        1
//  / \      / \            / \        \
// 2   3    2   3   true   2   3        2   false  (structure differs)
//
//   1        1
//  / \      / \
// 2   1    1   2   false  (values differ)

final class TreeNode {

    var value: Int
    var left: TreeNode?
    var right: TreeNode?

    init(value: Int, left: TreeNode? = nil, right: TreeNode? = nil) {
        self.value = value
        self.left = left
        self.right = right
    }
}

// MARK: - Helper: build tree from level-order array

func buildTree(_ values: [Int?]) -> TreeNode? {

    guard !values.isEmpty, let root = values[0] else { return nil }

    let rootNode = TreeNode(value: root)
    var queue = [rootNode]
    var index = 1
    var head = 0

    while index < values.count && head < queue.count {

        let current = queue[head]
        head += 1

        if index < values.count {
            if let value = values[index] {
                let leftNode = TreeNode(value: value)
                current.left = leftNode
                queue.append(leftNode)
            }
            index += 1
        }

        if index < values.count {
            if let value = values[index] {
                let rightNode = TreeNode(value: value)
                current.right = rightNode
                queue.append(rightNode)
            }
            index += 1
        }
    }

    return rootNode
}

// MARK: - Approach 1: Recursive (DFS)
// Steps:
// 1. Both nil → nothing left to compare on this branch → true.
// 2. Exactly one nil → structures diverge → false.
//    (guard let handles this: it only fires if at least one is nil,
//     and step 1 already ruled out "both nil")
// 3. Values differ → false.
// 4. Recurse: left vs left AND right vs right.
//    && short-circuits, so the first false stops the traversal.

func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {

    if p == nil && q == nil {                                    // 1
        return true
    }

    guard let pNode = p, let qNode = q else {                    // 2
        return false
    }

    if pNode.value != qNode.value {                              // 3
        return false
    }

    return isSameTree(pNode.left, qNode.left)                    // 4
        && isSameTree(pNode.right, qNode.right)
}

// MARK: - Approach 2: Iterative (BFS)
// Steps:
// 1. Seed the queue with the pair (p, q). head is the read cursor.
// 2. Pop a pair.
// 3. Both nil → this branch matches, skip to the next pair.
// 4. Exactly one nil → structures diverge → false.
// 5. Values differ → false.
// 6. Enqueue the two child pairs: (left, left) and (right, right).
// 7. Queue drained with no mismatch found → true.

func isSameTreeBFS(_ p: TreeNode?, _ q: TreeNode?) -> Bool {

    var queue: [(TreeNode?, TreeNode?)] = [(p, q)]               // 1
    var head = 0

    while head < queue.count {

        let (first, second) = queue[head]                        // 2
        head += 1

        if first == nil && second == nil {                       // 3
            continue
        }

        guard let firstNode = first, let secondNode = second else { // 4
            return false
        }

        if firstNode.value != secondNode.value {                 // 5
            return false
        }

        queue.append((firstNode.left, secondNode.left))          // 6
        queue.append((firstNode.right, secondNode.right))
    }

    return true                                                  // 7
}

// MARK: - Dry Run  (p = [1,2,3], q = [1,2,1], BFS)
// queue [(1,1)]
// head=0  pair (1,1)      values match  → append (2,2), (3,1)
// head=1  pair (2,2)      values match  → append (nil,nil) x2
// head=2  pair (3,1)      3 != 1        → return false
//
// Recursive on the same input:
// isSameTree(1,1) → values match
//   isSameTree(2,2) → match → both child pairs nil → true
//   isSameTree(3,1) → 3 != 1 → false
//   true && false → false

// MARK: - Complexity
// Both: Time O(min(m, n)) — stop at the first mismatch, never visit
//       more nodes than the smaller tree has.
// Recursive: Space O(h) — call stack, O(n) on a skewed tree.
// BFS:       Space O(n) — pair queue, widest level.

// MARK: - Traps
// - Returning false when both are nil. Two empty trees ARE the same.
//   This is the single most common bug in this problem.
// - Checking values before checking nil → crash or wrong result.
// - Comparing only values and forgetting structure — [1,2] vs [1,nil,2]
//   have identical value sets but are different trees.
// - Pairing children as (left, right) instead of (left, left).
// - A guard whose bound names go unused → dead code + compiler warning.
// - removeFirst() on the queue → O(n) dequeue; keep the head cursor.

// MARK: - Tests
// isSameTree(buildTree([1,2,3]),     buildTree([1,2,3]))     → true
// isSameTree(buildTree([1,2]),       buildTree([1,nil,2]))   → false
// isSameTree(buildTree([1,2,1]),     buildTree([1,1,2]))     → false
// isSameTree(buildTree([]),          buildTree([]))          → true
// isSameTree(buildTree([1]),         buildTree([]))          → false

// MARK: - Interview Q&A
// Q: Why O(min(m,n)) and not O(n)?
// A: The first structural or value mismatch returns immediately, so you
//    can never recurse deeper than the shallower tree allows.
//
// Q: Recursive or iterative in an interview?
// A: Recursive — it mirrors the definition and is 6 lines. Mention the
//    O(h) stack risk on skewed trees and offer BFS as the alternative.
//
// Q: How does this relate to 175 (Subtree of Another Tree)?
// A: 175 calls isSameTree at every node of the main tree.
