//
//  167_Create_Binary_Tree.playground
//
//  Phase 10 - Trees / L1_Tree_Basics
//
//  Objective:
//  1. Define a TreeNode.
//  2. Create a Binary Tree manually.
//  3. Create a Binary Tree from a level-order array.
//  4. Understand Root, Parent, Child, Leaf, Depth, Height.
//

import Foundation

//==============================================================
// MARK: - TreeNode
//==============================================================

// Reference type: a struct cannot hold a stored property of its
// own type — the compiler cannot compute a size that recurses
// forever. `TreeNode?` inside a struct will not compile.

final class TreeNode {

    var val: Int
    var left: TreeNode?
    var right: TreeNode?

    init(_ val: Int, _ left: TreeNode? = nil, _ right: TreeNode? = nil) {
        self.val = val
        self.left = left
        self.right = right
    }
}

//==============================================================
// MARK: - Manual Construction
//==============================================================

// `let` freezes the reference, not the object.
// manualRoot = otherNode  -> error
// manualRoot.left = node  -> allowed

let manualRoot = TreeNode(10)

manualRoot.left = TreeNode(5)
manualRoot.right = TreeNode(15)

manualRoot.left?.left = TreeNode(2)
manualRoot.left?.right = TreeNode(7)

//          10
//         /  \
//        5    15
//       / \
//      2   7
//
// Root         : 10
// Parents      : 10, 5
// Children     : 5, 15, 2, 7
// Leaves       : 2, 7, 15

if let left = manualRoot.left {
    print("Left child:", left.val)
} else {
    print("Left child: none")
}

//==============================================================
// MARK: - Build From Level-Order Array
//==============================================================

// Rule: every node dequeued claims the next TWO slots of `values`
// — one for left, one for right. Nodes enter the queue in level
// order, so they claim slots in exactly the right order.

func buildTree(_ values: [Int?]) -> TreeNode? {

    // Empty array, or the root slot itself is nil
    guard values.count > 0, let rootValue = values[0] else {
        return nil
    }

    let root = TreeNode(rootValue)

    // Nodes waiting to receive children.
    // `head` is the read position — no removeFirst(), that is O(n).
    var queue: [TreeNode] = [root]
    var head = 0

    // Read position in `values`. Starts at 1 — the root consumed 0.
    var i = 1

    while head < queue.count && i < values.count {

        let node = queue[head]
        head += 1

        // ---- LEFT child ----
        if i < values.count {
            if let leftValue = values[i] {
                let leftNode = TreeNode(leftValue)
                node.left = leftNode
                queue.append(leftNode)
            }
            // Advances even when the slot was nil — a nil slot is
            // still a consumed slot.
            i += 1
        }

        // ---- RIGHT child ----
        if i < values.count {
            if let rightValue = values[i] {
                let rightNode = TreeNode(rightValue)
                node.right = rightNode
                queue.append(rightNode)
            }
            i += 1
        }
    }

    return root
}

//==============================================================
// MARK: - Dry Run
//==============================================================

// values = [1, 2, 3, 4, 5, nil, 6]
//
// start:            queue = [1]        head = 0   i = 1
//
// dequeue 1:  values[1] = 2   -> 1.left  = 2, enqueue
//             values[2] = 3   -> 1.right = 3, enqueue
//                               queue = [1,2,3]  head = 1  i = 3
//
// dequeue 2:  values[3] = 4   -> 2.left  = 4, enqueue
//             values[4] = 5   -> 2.right = 5, enqueue
//                               queue = [1,2,3,4,5]  head = 2  i = 5
//
// dequeue 3:  values[5] = nil -> no left, nothing enqueued
//             values[6] = 6   -> 3.right = 6, enqueue
//                               queue = [1,2,3,4,5,6]  head = 3  i = 7
//
// i = 7 = values.count -> loop ends. Nodes 4, 5, 6 keep nil children.
//
//          1
//         / \
//        2   3
//       / \   \
//      4   5   6

//==============================================================
// MARK: - Depth and Height
//==============================================================

//          10
//         /
//        5
//       /
//      2
//
// Depth  = edges from Root down to a node.
//          10 -> 0,  5 -> 1,  2 -> 2
//
// Height = edges from a node down to its deepest leaf.
//          2 -> 0,   5 -> 1,  10 -> 2
//
// WARNING — two conventions exist:
//   Counting edges -> leaf height 0, empty tree -1
//   Counting nodes -> leaf height 1, empty tree  0   <- LeetCode uses this
//
// LC 104 on this tree expects 3, not 2.

//==============================================================
// MARK: - Complexity
//==============================================================

// buildTree
// Time  O(n) — each slot of `values` is read exactly once
// Space O(n) — queue holds at most one level, plus n nodes created
//
// Creating a single node: O(1)

//==============================================================
// MARK: - Traps
//==============================================================

// 1. Advancing `i` once per dequeued node instead of twice.
//    Bug: children shift left, tree silently wrong.
//    Fix: `i += 1` sits outside the `if let`, in both blocks.
//
// 2. Enqueuing a nil child.
//    Bug: the nil claims two slots that belong to a real node.
//    Fix: only `queue.append` inside the `if let`.
//
// 3. Assuming `values` is complete.
//    Bug: index out of range on ragged input like [1,2,3,4].
//    Fix: `if i < values.count` before every read.
//
// 4. Using removeFirst() as the dequeue.
//    Bug: O(n) shift per call, turns the build into O(n^2).
//    Fix: `head` index, never mutate the front.

//==============================================================
// MARK: - Tests
//==============================================================

// No traversal helper yet — that arrives in 171 Level Order.
// For now, verify by walking to specific nodes by hand.

let t1 = buildTree([1, 2, 3, 4, 5, nil, 6])

if let node = t1 {
    print("root:", node.val)                      // 1
}
if let node = t1?.left {
    print("root.left:", node.val)                 // 2
}
if let node = t1?.right {
    print("root.right:", node.val)                // 3
}
if let node = t1?.left?.left {
    print("root.left.left:", node.val)            // 4
}
if let node = t1?.left?.right {
    print("root.left.right:", node.val)           // 5
}
if t1?.right?.left == nil {
    print("root.right.left: none")                // nil slot honoured
}
if let node = t1?.right?.right {
    print("root.right.right:", node.val)          // 6
}

// Edge cases

if buildTree([]) == nil {
    print("empty array -> nil")
}
if buildTree([nil]) == nil {
    print("nil root -> nil")
}

// Ragged input — node 2 gets a left child, then the array runs out

let t2 = buildTree([1, 2, 3, 4])

if let node = t2?.left?.left {
    print("ragged left.left:", node.val)          // 4
}
if t2?.left?.right == nil {
    print("ragged left.right: none")
}

// Nil in the middle — 3 must land as 2's RIGHT child, not left

let t3 = buildTree([1, 2, nil, 3])

if t3?.left?.left == nil {
    print("t3 left.left: none")
}
if let node = t3?.left?.right {
    print("t3 left.right:", node.val)             // 3
}

//==============================================================
// MARK: - Interview Q&A
//==============================================================

// Q. Why is TreeNode a class, not a struct?
// A struct cannot contain a stored property of its own type —
// infinite size. Classes are references, so size is fixed.

// Q. Why are left and right optional?
// A node may have zero, one, or two children. nil is the absence
// of a child, and also the base case for every tree recursion.

// Q. Why `head` instead of removeFirst()?
// removeFirst() shifts the whole array — O(n) per dequeue.
// An index makes dequeue O(1), at the cost of not reclaiming memory.

// Q. Depth vs height?
// Depth: root down to a node. Height: a node down to its deepest leaf.
// Counting edges -> leaf height 0, empty tree -1.
// Counting nodes -> leaf height 1, empty tree  0.  <- LeetCode uses this.

//==============================================================
// MARK: - Assignment
//==============================================================

// Build this tree with buildTree, then verify by walking to nodes.
//
//              50
//            /    \
//          25      75
//         /  \    /  \
//       10   30  60   90
//             \
//             40
//
// Answers to check against:
//   Root          : 50
//   Leaves        : 10, 40, 60, 90
//   Depth of 40   : 3  (50 -> 25 -> 30 -> 40)
//   Height of 50  : 3
