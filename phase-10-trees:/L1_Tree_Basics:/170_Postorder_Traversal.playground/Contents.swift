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
// Every node dequeued claims the NEXT TWO slots of `values`.

func buildTree(_ values: [Int?]) -> TreeNode? {

    guard !values.isEmpty, let rootValue = values[0] else { return nil }

    let rootNode = TreeNode(rootValue)
    var queue = [rootNode]
    var head = 0          // dequeue index — never removeFirst(), that is O(n)
    var index = 1         // root already consumed slot 0

    while head < queue.count && index < values.count {

        let current = queue[head]
        head += 1

        // Left child
        if index < values.count {
            if let leftValue = values[index] {
                let left = TreeNode(leftValue)
                current.left = left
                queue.append(left)        // only REAL nodes queued
            }
            index += 1                    // outside the if let —
        }                                 // a nil slot is still consumed

        // Right child
        if index < values.count {
            if let rightValue = values[index] {
                let right = TreeNode(rightValue)
                current.right = right
                queue.append(right)
            }
            index += 1
        }
    }

    return rootNode
}

// Time  O(n) — each slot read once
// Space O(n) — queue holds at most one level, plus n nodes created

// MARK: - Postorder, recursive
// Order: LEFT -> RIGHT -> NODE
// Same dfs as 168/169 — the append just moved below both calls.

func postorderTraversal(_ root: TreeNode?) -> [Int] {

    var result: [Int] = []

    func dfs(_ node: TreeNode?) {
        guard let node else { return }   // base case = backtrack
        dfs(node.left)                   // LEFT
        dfs(node.right)                  // RIGHT
        result.append(node.val)          // NODE
    }

    dfs(root)
    return result
}

// Time  O(n) — every node visited exactly once
// Space O(h) — call stack. Balanced O(log n), fully skewed O(n).

// MARK: - Postorder, iterative (reverse-preorder trick)
//
// Preorder is        root -> left  -> right
// Push LEFT first, so right pops first:
//                    root -> right -> left
// Reverse that:      left -> right -> root   = POSTORDER

func postorderTraversalIterative(_ root: TreeNode?) -> [Int] {

    guard let root else { return [] }

    var result: [Int] = []
    var stack = [root]

    while let node = stack.popLast() {

        result.append(node.val)

        // Push left first so RIGHT pops first
        if let left  = node.left  { stack.append(left)  }
        if let right = node.right { stack.append(right) }
    }

    return Array(result.reversed())
}

// Time  O(n) — each node pushed and popped once; reversed() is O(n)
// Space O(h) for the stack, plus O(n) for result (required output)
//
// NEVER use result.insert(node.val, at: 0) to skip the reverse —
// every insert shifts the whole array, making it O(n²).

// MARK: - Postorder, true single pass (follow-up only)
//
// Answer to "can you do it without reversing at the end?"
// Peek instead of pop: descend into the right child if it exists
// and has not been visited; otherwise pop and record.

func postorderTraversalSinglePass(_ root: TreeNode?) -> [Int] {

    var result: [Int] = []
    var stack: [TreeNode] = []
    var current = root
    var lastVisited: TreeNode?

    while current != nil || !stack.isEmpty {

        // Dive left, stacking everything
        while let node = current {
            stack.append(node)
            current = node.left
        }

        guard let peek = stack.last else { break }

        // Right subtree exists and has not been processed yet
        if let right = peek.right, right !== lastVisited {
            current = right
        } else {
            result.append(peek.val)
            lastVisited = stack.removeLast()
        }
    }

    return result
}

// Time  O(n)   Space O(h)
// `!==` compares object identity, not values — the correct check
// for "is this the same node instance I just finished".

// MARK: - Tests

//        10
//       /  \
//      5    20
//     / \   /
//    2   7 15

let tree = buildTree([10, 5, 20, 2, 7, 15])
print(postorderTraversal(tree))            // [2, 7, 5, 15, 20, 10]
print(postorderTraversalIterative(tree))   // [2, 7, 5, 15, 20, 10]
print(postorderTraversalSinglePass(tree))  // [2, 7, 5, 15, 20, 10]

//        1
//       / \
//      2   3
//     / \   \
//    4   5   6

let tree2 = buildTree([1, 2, 3, 4, 5, nil, 6])
print(postorderTraversal(tree2))           // [4, 5, 2, 6, 3, 1]
print(postorderTraversalIterative(tree2))  // [4, 5, 2, 6, 3, 1]

// Edge cases
print(postorderTraversal(buildTree([])))      // []
print(postorderTraversal(nil))                // []
print(postorderTraversal(buildTree([100])))   // [100]

// MARK: - Complexity summary
//
//                          Time    Space
// buildTree                O(n)    O(n)
// recursive postorder      O(n)    O(h)   call stack
// iterative (reverse)      O(n)    O(h)   explicit stack
// iterative (single pass)  O(n)    O(h)   explicit stack
//
// h = height.  Balanced -> O(log n).  Fully skewed -> O(n).
// The result array is O(n) but excluded, being required output.

// MARK: - Why postorder matters
//
// Children are processed BEFORE the parent, so the parent can
// combine values computed from below. That is the shape of:
//   172 Maximum Depth, 175 Balanced, 176 Diameter, 182 Max Path Sum
// Deleting a tree is also postorder — free the children first.
