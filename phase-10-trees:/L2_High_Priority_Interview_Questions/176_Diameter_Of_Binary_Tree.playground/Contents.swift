// MARK: - Problem
// 176 — Diameter of Binary Tree (LC 543)
// Return the length of the longest path between any two nodes in the tree.
// Length is measured in EDGES. The path may or may not pass through the root.
//
//        1
//       / \
//      2   3
//     / \
//    4   5
//
// Longest path: 4 → 2 → 1 → 3  (or 5 → 2 → 1 → 3) = 3 edges. Answer 3.
//
// Key insight: for any node, the longest path *through* that node is
// leftHeight + rightHeight. The answer is the maximum of that value
// taken over every node in the tree.

final class TreeNode {
    var value: Int
    var left: TreeNode?
    var right: TreeNode?

    init(_ value: Int, _ left: TreeNode? = nil, _ right: TreeNode? = nil) {
        self.value = value
        self.left = left
        self.right = right
    }
}

// MARK: - Brute Force
// Steps:
// 1. height(node) = 1 + max(child heights); empty = 0.
// 2. At the current node, the path through it = leftHeight + rightHeight.
// 3. Recurse to get the best diameter inside the left subtree, then the right.
// 4. Answer at this node = max of those three candidates.
//
// The waste: height() re-walks an entire subtree, and diameter() calls it
// again at every single node. Same traversal repeated per level.

func diameterOfBinaryTreeBruteForce(_ node: TreeNode?) -> Int {

    func height(_ node: TreeNode?) -> Int {
        guard let node else { return 0 }                           // 1
        let leftHeight = height(node.left)
        let rightHeight = height(node.right)
        return 1 + max(leftHeight, rightHeight)
    }

    func diameter(_ node: TreeNode?) -> Int {

        guard let node else { return 0 }

        let leftHeight = height(node.left)                         // 2
        let rightHeight = height(node.right)
        let pathThroughNode = leftHeight + rightHeight

        let leftDiameter = diameter(node.left)                     // 3
        let rightDiameter = diameter(node.right)

        return max(pathThroughNode, leftDiameter, rightDiameter)   // 4
    }

    return diameter(node)
}

// MARK: - Optimised
// Idea: the same post-order traversal already computes both child heights.
// Update a running maximum while you are there — no second traversal needed.
//
// Steps:
// 1. Capture maxDiameter in the enclosing scope (starts at 0).
// 2. Empty node → height 0.
// 3. Get both child heights.
// 4. Before returning, record the path through this node:
//    maxDiameter = max(maxDiameter, leftHeight + rightHeight).
// 5. Return the node's own height so the parent can use it.
// 6. Run once from the root, then read maxDiameter.
//
// The height helper does two jobs: it returns the height upward, and it
// leaves the best answer it has seen in the captured variable.

func diameterOfBinaryTreeOptimized(_ node: TreeNode?) -> Int {

    var maxDiameter = 0                                            // 1

    func height(_ node: TreeNode?) -> Int {

        guard let node else { return 0 }                           // 2

        let leftHeight = height(node.left)                         // 3
        let rightHeight = height(node.right)

        maxDiameter = max(maxDiameter, leftHeight + rightHeight)   // 4

        return 1 + max(leftHeight, rightHeight)                    // 5
    }

    _ = height(node)                                               // 6

    return maxDiameter
}

// MARK: - Dry Run  (optimised, tree [1,2,3,4,5])
//
//        1
//       / \
//      2   3
//     / \
//    4   5
//
// height(4)  left 0, right 0 → maxDia = max(0, 0+0) = 0 → returns 1
// height(5)  left 0, right 0 → maxDia = max(0, 0+0) = 0 → returns 1
// height(2)  left 1, right 1 → maxDia = max(0, 1+1) = 2 → returns 2
// height(3)  left 0, right 0 → maxDia = max(2, 0+0) = 2 → returns 1
// height(1)  left 2, right 1 → maxDia = max(2, 2+1) = 3 → returns 3
// answer: 3
//
// Off-root case, tree [1,2,nil,3,4,5,6]:
//          1
//         /
//        2
//       / \
//      3   4
//     /     \
//    5       6
// Best path is 5 → 3 → 2 → 4 → 6 = 4 edges, and it never touches node 1.
// The code finds it because maxDiameter is updated at node 2, not only at
// the root — every node gets its turn as the peak of a path.

// MARK: - Complexity
// Brute force: Time O(n²) — height() is O(n) and runs at each of n nodes
//              (O(n log n) on a well-balanced tree) | Space O(h)
// Optimised:   Time O(n) — one visit per node       | Space O(h)
//
// h is tree height: O(log n) balanced, O(n) skewed. Space is the call stack.

// MARK: - Traps
// - Returning maxDiameter from the helper instead of the height. The helper
//   must return height upward; the answer lives in the captured variable.
// - Adding 1 to leftHeight + rightHeight. Heights count nodes, the answer
//   counts edges, and the two off-by-ones cancel exactly. See Q&A.
// - Assuming the path passes through the root. It often does not.
// - Forgetting `_ =` on the top-level call → unused-result warning.
// - Initialising maxDiameter to something other than 0. A single-node tree
//   has diameter 0, and an empty tree also 0.

// MARK: - Tests
// diameterOfBinaryTreeOptimized(createBuildTree([1,2,3,4,5]))          → 3
// diameterOfBinaryTreeOptimized(createBuildTree([1,2]))                → 1
// diameterOfBinaryTreeOptimized(createBuildTree([1]))                  → 0
// diameterOfBinaryTreeOptimized(createBuildTree([]))                   → 0
// diameterOfBinaryTreeOptimized(createBuildTree([1,nil,2,nil,3]))      → 2
// diameterOfBinaryTreeOptimized(createBuildTree([1,2,nil,3,4,5,6]))    → 4

// MARK: - Interview Q&A
// Q: Why leftHeight + rightHeight and not 1 + leftHeight + rightHeight?
// A: Your heights count NODES (empty = 0, leaf = 1). A node with two leaf
//    children: leftHeight 1 + rightHeight 1 = 2, and the real path
//    leaf → node → leaf is 2 edges. Correct. Each height overcounts by one
//    node relative to its edge count, and the current node is shared by both
//    sides — the two overcounts pay for the current node exactly. If your
//    height returned edges instead (empty = -1), you would need the +1.
//
// Q: Where is "the path need not pass through the root" handled?
// A: maxDiameter is updated inside height(), which runs at every node. Each
//    node gets evaluated as the peak of its own path, so the maximum is taken
//    across all n candidates, not just the root's.
//
// Q: Why is the brute force O(n²)?
// A: height() walks a whole subtree, and diameter() calls it once per node.
//    On a skewed tree that is n + (n-1) + (n-2) + … = O(n²).
//
// Q: Can this be done without a captured variable?
// A: Yes — have the helper return a tuple (height, bestDiameter). Same O(n),
//    slightly more verbose. The captured variable is the common idiom; know
//    both so you can answer if they push on purity or thread safety.
//
// Q: How does this connect to other tree problems?
// A: Same post-order skeleton as 175 (Balanced) — a height helper doing extra
//    work on the way back up. 175 encodes the answer in the return value via
//    a sentinel; 176 accumulates it in a captured variable. 181 (Max Path Sum)
//    reuses this exact shape with one twist: negative contributions get
//    clamped to 0 before being passed upward.
