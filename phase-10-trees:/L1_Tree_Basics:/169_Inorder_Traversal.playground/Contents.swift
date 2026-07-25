import Foundation

// MARK: - TreeNode
// LeetCode names: val, left, right. Match them exactly.

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

// MARK: - buildTree
// Every node dequeued claims the NEXT TWO slots of `values`.

func buildTree(_ values: [Int?]) -> TreeNode? {

    guard !values.isEmpty, let rootValue = values[0] else { return nil }

    let rootNode = TreeNode(rootValue)
    var queue: [TreeNode] = [rootNode]
    var head = 0          // dequeue index — never removeFirst(), that is O(n)
    var index = 1         // root already consumed slot 0

    while head < queue.count && index < values.count {

        let current = queue[head]
        head += 1

        // ---- LEFT ----
        if index < values.count {
            if let value = values[index] {
                let node = TreeNode(value)
                current.left = node
                queue.append(node)        // only REAL nodes queued
            }
            index += 1                    // outside the if let —
        }                                 // a nil slot is still consumed

        // ---- RIGHT ----
        if index < values.count {
            if let value = values[index] {
                let node = TreeNode(value)
                current.right = node
                queue.append(node)
            }
            index += 1
        }
    }

    return rootNode
}

// MARK: - Inorder, recursive
// Order: LEFT -> NODE -> RIGHT
// Only difference from preorder: the append sits BETWEEN the two calls.

func inorderTraversal(_ root: TreeNode?) -> [Int] {

    var result: [Int] = []

    func dfs(_ node: TreeNode?) {
        guard let node = node else { return }   // base case = backtrack
        dfs(node.left)            // LEFT
        result.append(node.val)   // NODE
        dfs(node.right)           // RIGHT
    }

    dfs(root)
    return result
}

// MARK: - Inorder, iterative
// The preorder pattern does NOT work here. In preorder you record a
// node the moment you pop it. In inorder you cannot — its left
// subtree is not done yet. So: dive left while stacking, record on
// the way back up, then pivot right.

func inorderTraversalIterative(_ root: TreeNode?) -> [Int] {

    var result: [Int] = []
    var stack: [TreeNode] = []
    var current = root          // walker, separate from the stack

    // TWO conditions. Only checking the stack exits immediately,
    // because the stack starts empty.
    while current != nil || !stack.isEmpty {

        // Phase 1 — go as far left as possible, pushing everything
        while let node = current {
            stack.append(node)
            current = node.left
        }

        // Phase 2 — pop the leftmost unvisited node and record it.
        // Safe: if current is nil the stack is non-empty, and
        // otherwise phase 1 pushed at least once.
        let node = stack.removeLast()
        result.append(node.val)

        // Phase 3 — pivot right. The right subtree gets the same
        // treatment from scratch on the next outer iteration.
        current = node.right
    }

    return result
}

// MARK: - Tests

//        1
//       / \
//      2   3
//     / \   \
//    4   5   6

let t1 = buildTree([1, 2, 3, 4, 5, nil, 6])
print(inorderTraversal(t1))            // [4, 2, 5, 1, 3, 6]
print(inorderTraversalIterative(t1))   // [4, 2, 5, 1, 3, 6]

// BST — inorder gives SORTED output. This is the whole basis of
// LC 98 Validate BST and LC 230 Kth Smallest.
//
//        4
//       / \
//      2   6
//     / \ / \
//    1  3 5  7

let bst = buildTree([4, 2, 6, 1, 3, 5, 7])
print(inorderTraversal(bst))           // [1, 2, 3, 4, 5, 6, 7]
print(inorderTraversalIterative(bst))  // [1, 2, 3, 4, 5, 6, 7]

// Edge cases
print(inorderTraversal(nil))                    // []
print(inorderTraversal(buildTree([])))          // []
print(inorderTraversal(buildTree([1])))         // [1]

// MARK: - Complexity
//
// Time   O(n)  — every node visited exactly once.
// Space  O(h)  — balanced O(log n), fully skewed O(n).
//                Iterative worst case: phase 1 pushes the entire
//                left spine before a single pop happens.

// MARK: - Traps
//
// 1. Outer while checking only !stack.isEmpty -> exits before it starts.
// 2. Forgetting `current = node.right` -> infinite loop.
// 3. Reusing the preorder push-both-children pattern -> wrong order.
// 4. Pushing nil onto the stack.

// MARK: - Interview Notes
//
// Q. What is special about inorder?
//    On a BST it produces sorted output.
//
// Q. Why is iterative inorder harder than preorder?
//    Preorder records a node on pop. Inorder must record it only
//    after its left subtree completes, so you need a separate
//    `current` walker plus the stack.
//
// Q. Why is removeLast() safe without a check?
//    The outer condition guarantees a non-empty stack whenever
//    current is nil, and phase 1 pushes at least one node otherwise.
