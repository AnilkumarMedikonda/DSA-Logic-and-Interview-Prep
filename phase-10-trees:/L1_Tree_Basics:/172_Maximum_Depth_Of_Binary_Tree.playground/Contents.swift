import Foundation

// MARK: - TreeNode

final class TreeNode {

    var val: Int
    var left: TreeNode?
    var right: TreeNode?

    init(_ val: Int) {
        self.val = val
    }
}

// MARK: - buildTree
//
// Every node dequeued claims the NEXT TWO slots of `values`.
//
// Two lines make the queue work, and they work as a PAIR:
//   queue.append(...)  puts a node IN LINE to receive children
//   head += 1          moves the line FORWARD
// Drop either one and the queue is decoration.

func buildTree(_ values: [Int?]) -> TreeNode? {

    guard !values.isEmpty, let rootValue = values[0] else { return nil }

    let rootNode = TreeNode(rootValue)
    var queue = [rootNode]
    var head = 0          // dequeue index
    var index = 1         // root already consumed slot 0

    while head < queue.count && index < values.count {

        let current = queue[head]   // READ first
        head += 1                   // THEN advance the line

        // ---- LEFT child ----
        if index < values.count {
            if let value = values[index] {
                let leftNode = TreeNode(value)
                current.left = leftNode
                queue.append(leftNode)   // now in line for its own children
            }
            index += 1                   // outside the if let —
        }                                // a nil slot is still consumed

        // ---- RIGHT child ----
        if index < values.count {
            if let value = values[index] {
                let rightNode = TreeNode(value)
                current.right = rightNode
                queue.append(rightNode)
            }
            index += 1
        }
    }

    return rootNode
}

// Time  O(n)   Space  O(n)

// MARK: - Maximum Depth, recursive  (the interview answer)
//
// LeetCode counts NODES: nil -> 0, leaf -> 1 + max(0, 0) = 1.
// For EDGES, the only change is the base returning -1.
// This is POSTORDER — both children resolve before the parent acts.

func maxDepth(_ root: TreeNode?) -> Int {

    guard let node = root else { return 0 }      // base case

    let leftDepth  = maxDepth(node.left)         // trust it works
    let rightDepth = maxDepth(node.right)        // trust it works

    return 1 + max(leftDepth, rightDepth)        // combine
}

// Time  O(n)
// Space O(h) — call stack. Balanced O(log n), fully skewed O(n).

// MARK: - Maximum Depth, iterative BFS
//
// The levelSize freeze from 171, minus the per-level array —
// nothing is collected, only counted. Number of levels IS the depth.

func maxDepthIterative(_ root: TreeNode?) -> Int {

    guard let node = root else { return 0 }

    var queue = [node]
    var head = 0
    var depth = 0

    while head < queue.count {

        // Frozen BEFORE the inner loop — children pushed below
        // belong to the NEXT level, not this one.
        let levelSize = queue.count - head

        for _ in 0..<levelSize {

            let current = queue[head]
            head += 1

            if let left  = current.left  { queue.append(left)  }
            if let right = current.right { queue.append(right) }
        }

        depth += 1        // one full level survived
    }

    return depth
}

// Time  O(n)
// Space O(w) — w = WIDEST level, up to n/2. NOT O(h).

// MARK: - Tests

//        1
//       / \
//      2   3
//     / \   \
//    4   5   6

let tree = buildTree([1, 2, 3, 4, 5, nil, 6])
print(maxDepth(tree))            // 3
print(maxDepthIterative(tree))   // 3

// Fully skewed: 1 -> 2 -> 3 -> 4, all left children.
// This is where recursive space becomes O(n).

let skewed = buildTree([1, 2, nil, 3, nil, 4])
print(maxDepth(skewed))          // 4
print(maxDepthIterative(skewed)) // 4

// Edge cases
print(maxDepth(buildTree([1])))  // 1
print(maxDepth(nil))             // 0
print(maxDepth(buildTree([])))   // 0

// MARK: - Complexity summary
//
//                   Time   Space
// buildTree         O(n)   O(n)
// recursive         O(n)   O(h)   bad on a SKEWED tree
// iterative BFS     O(n)   O(w)   bad on a WIDE tree

// MARK: - Interview line
//
// Write the recursive version, then say:
// "O(n) time, O(h) space for the call stack — O(n) if the tree is
//  skewed. I can do it iteratively with BFS if you want to avoid
//  the recursion depth."

// MARK: - What this carries into L2
//
// 175 Balanced      = this, plus checking |left - right| <= 1
// 176 Diameter      = this, plus tracking left + right at each node
// 182 Max Path Sum  = this, plus summing values and clamping negatives
//
// All three extend the RECURSIVE version. BFS does not extend to
// any of them — that is the real reason recursive is the default.
