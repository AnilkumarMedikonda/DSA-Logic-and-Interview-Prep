import Foundation

// MARK: - TreeNode
// A class, not a struct — a struct cannot hold a stored property
// of its own type (the compiler cannot compute its size).
// left/right are optional: a node may have 0, 1, or 2 children.

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

// MARK: - buildTree (level-order array -> tree)
// RULE: every node dequeued claims the NEXT TWO slots of `values`,
// one for left and one for right. Nodes enter the queue in level
// order, so they claim slots in exactly the order stored.

func buildTree(_ values: [Int?]) -> TreeNode? {

    // Empty array, or slot 0 is nil -> no tree
    guard !values.isEmpty, let rootValue = values[0] else { return nil }

    let rootNode = TreeNode(rootValue)

    // Queue holds nodes WAITING for children.
    // `head` is the read index — never removeFirst(), that is O(n).
    var queue: [TreeNode] = [rootNode]
    var head = 0

    // Read index into values. Starts at 1 — root consumed slot 0.
    var index = 1

    while head < queue.count && index < values.count {

        let current = queue[head]
        head += 1

        // ---- LEFT ----
        if index < values.count {                 // array can end mid-node
            if let leftValue = values[index] {    // nil slot = no child
                let leftNode = TreeNode(leftValue)
                current.left = leftNode
                queue.append(leftNode)            // only REAL nodes queued
            }
            index += 1                            // outside the if let:
        }                                         // a nil slot is still consumed

        // ---- RIGHT ----
        if index < values.count {
            if let rightValue = values[index] {
                let rightNode = TreeNode(rightValue)
                current.right = rightNode
                queue.append(rightNode)
            }
            index += 1
        }
    }

    return rootNode
}

// MARK: - Preorder, recursive
// Order: NODE -> LEFT -> RIGHT
// Move the append line to change traversal:
//   between the two dfs calls -> inorder   (169)
//   below both dfs calls      -> postorder (170)

func preorderTraversal(_ root: TreeNode?) -> [Int] {

    // Lives in the outer function so every recursive call shares it.
    // Declared inside dfs, it would reset on each call.
    var result: [Int] = []

    // Nested so it can capture and mutate `result`.
    // dfs = Depth First Search: go as deep as possible, then back up.
    func dfs(_ node: TreeNode?) {

        // Base case. `return` on nil IS the backtrack.
        // No need to check node.left != nil before recursing —
        // this guard already handles it.
        guard let node = node else { return }

        result.append(node.val)   // NODE
        dfs(node.left)            // LEFT
        dfs(node.right)           // RIGHT
    }

    dfs(root)
    return result
}

// MARK: - Preorder, iterative
// Same output, explicit stack instead of the call stack.
// This is the version interviewers ask for as a follow-up.

func preorderTraversalIterative(_ root: TreeNode?) -> [Int] {

    guard let root = root else { return [] }

    var result: [Int] = []
    var stack: [TreeNode] = [root]

    // popLast() returns an optional, so `while let` both pops and
    // tests for empty — no force unwrap needed.
    while let node = stack.popLast() {

        result.append(node.val)

        // A stack is LIFO: the LAST push pops FIRST.
        // Left must be processed first, so push RIGHT first.
        // Swap these two and you get [1,3,6,2,5,4] instead of
        // [1,2,4,5,3,6] — the whole order reverses.
        if let right = node.right { stack.append(right) }
        if let left  = node.left  { stack.append(left)  }
    }

    return result
}

// MARK: - Tests

//        10
//       /  \
//      5    20
//     / \   /
//   30  40 50

let tree = buildTree([10, 5, 20, 30, 40, 50])
print(preorderTraversal(tree))            // [10, 5, 30, 40, 20, 50]
print(preorderTraversalIterative(tree))   // [10, 5, 30, 40, 20, 50]

//        1
//       / \
//      2   3
//     / \   \
//    4   5   6

let t1 = buildTree([1, 2, 3, 4, 5, nil, 6])
print(preorderTraversal(t1))              // [1, 2, 4, 5, 3, 6]
print(preorderTraversalIterative(t1))     // [1, 2, 4, 5, 3, 6]

// Edge cases — both take TreeNode?, so no force unwrap anywhere
print(preorderTraversal(nil))             // []
print(preorderTraversal(buildTree([])))   // []
print(preorderTraversal(buildTree([1])))  // [1]

// MARK: - Complexity
//
// Time   O(n)  — every node visited exactly once.
// Space  O(h)  — h = height.
//                  balanced tree      -> O(log n)
//                  fully skewed tree  -> O(n)   <- the follow-up
//                Recursive: call stack. Iterative: explicit stack.
//                The result array is required output, so excluded.

// MARK: - Traps
//
// 1. Signature must be TreeNode?, not TreeNode.
//    Otherwise the call site needs `!`, which crashes on buildTree([]).
// 2. Missing guard in dfs -> crash on nil.
// 3. `result` declared inside dfs -> resets every call.
// 4. Printing
