import UIKit

// MARK: - Problem
// 175 — Balanced Binary Tree (LC 110)
// Return true if the tree is height-balanced: for EVERY node, the heights
// of its left and right subtrees differ by at most 1.
//
//      3                1
//     / \                \
//    9  20                2
//      /  \                \
//     15   7                3
//
//   balanced (true)    not balanced (false)
//
// Note: "every node", not just the root. A tree can have a balanced root
// and still fail deeper down.

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

// MARK: - Helper: build tree from level-order array

func createBuildTree(_ values: [Int?]) -> TreeNode? {

    guard !values.isEmpty, let root = values[0] else { return nil }

    let rootNode = TreeNode(root)
    var index = 1
    var head = 0
    var queue = [rootNode]

    while head < queue.count && index < values.count {

        let current = queue[head]
        head += 1

        if index < values.count {
            if let leftValue = values[index] {
                let leftNode = TreeNode(leftValue)
                current.left = leftNode
                queue.append(leftNode)
            }
            index += 1
        }

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

// MARK: - Brute Force
// Steps:
// 1. height(node) = 1 + max(height of children); empty node = 0.
// 2. At the current node, compute both child heights and compare.
// 3. Differ by more than 1 → not balanced.
// 4. Recurse — the same check must hold at every descendant.
//
// The waste: height() re-walks an entire subtree, and it is called again
// at every ancestor of that subtree. Same work, repeated per level.

func isBalancedTree(_ node: TreeNode?) -> Bool {

    func height(_ node: TreeNode?) -> Int {
        guard let node else { return 0 }                          // 1
        let leftHeight = height(node.left)
        let rightHeight = height(node.right)
        return 1 + max(leftHeight, rightHeight)
    }

    guard let rootNode = node else { return true }

    let leftHeight = height(rootNode.left)                        // 2
    let rightHeight = height(rootNode.right)

    if abs(leftHeight - rightHeight) > 1 {                        // 3
        return false
    }

    return isBalancedTree(rootNode.left)                          // 4
        && isBalancedTree(rootNode.right)
}

// MARK: - Optimised
// Idea: one traversal that returns BOTH pieces of information at once —
// the height, or -1 meaning "an imbalance exists somewhere below me".
//
// Steps:
// 1. Empty node → height 0.
// 2. Compute left height; if it is -1, an imbalance is already known —
//    propagate -1 immediately, skip the right subtree entirely.
// 3. Compute right height; same early bail.
// 4. Both real heights in hand → check the difference at THIS node.
//    Off by more than 1 → return -1.
// 5. Otherwise return the genuine height so the parent can use it.
// 6. Top level: the tree is balanced iff the root did not return -1.
//
// The check happens on the way back UP (post-order). You cannot decide
// balance at a node until both subtrees have reported their heights.

func isBalancedTreeOptimized(_ node: TreeNode?) -> Bool {

    func height(_ node: TreeNode?) -> Int {

        guard let node else { return 0 }                          // 1

        let leftHeight = height(node.left)                        // 2
        if leftHeight == -1 {
            return -1
        }

        let rightHeight = height(node.right)                      // 3
        if rightHeight == -1 {
            return -1
        }

        if abs(leftHeight - rightHeight) > 1 {                    // 4
            return -1
        }

        return 1 + max(leftHeight, rightHeight)                   // 5
    }

    return height(node) != -1                                     // 6
}

// MARK: - Dry Run  (optimised, input [1,2,2,3,3,nil,nil,4,4])
//
//            1
//          /   \
//         2     2
//        / \
//       3   3
//      / \
//     4   4
//
// height(4)  → left 0, right 0, diff 0 → returns 1   (both leaves)
// height(3L) → left 1, right 1, diff 0 → returns 2
// height(3R) → left 0, right 0, diff 0 → returns 1
// height(2L) → left 2, right 1, diff 1 → returns 3
// height(2R) → left 0, right 0, diff 0 → returns 1
// height(1)  → left 3, right 1, diff 2 → returns -1
// result: -1 != -1 is false → NOT balanced
//
// Note the root looked fine by value but failed on subtree heights —
// this is exactly the case a root-only check would miss.

// MARK: - Complexity
// Brute force: Time O(n log n) balanced, O(n²) skewed | Space O(h)
// Optimised:   Time O(n)                              | Space O(h)
//
// Brute force is quadratic on a skewed tree because height() walks
// the remaining n-k nodes at each of the n levels.
// Optimised visits every node exactly once. Space is the call stack:
// O(log n) balanced, O(n) skewed.

// MARK: - Traps
// - Checking balance only at the root. The condition is every node.
// - Computing both heights unconditionally in the optimised version —
//   still correct, but does wasted work under an already-failed subtree.
// - Recursing into node.left twice instead of node.left / node.right.
//   Silent bug: right-side imbalances go undetected.
// - Wrong base height. Empty = 0 makes a leaf height 1. If you return
//   -1 for empty (edge-count convention), the sentinel collides — pick
//   one convention and keep it.
// - Confusing height (downward from a node) with depth (from the root).

// MARK: - Tests
// isBalancedTreeOptimized(createBuildTree([3,9,20,nil,nil,15,7]))   → true
// isBalancedTreeOptimized(createBuildTree([1,2,2,3,3,nil,nil,4,4])) → false
// isBalancedTreeOptimized(createBuildTree([1,nil,2,nil,3]))         → false
// isBalancedTreeOptimized(createBuildTree([1,2,3]))                 → true
// isBalancedTreeOptimized(createBuildTree([1]))                     → true
// isBalancedTreeOptimized(createBuildTree([]))                      → true

// MARK: - Interview Q&A
// Q: Why is -1 a safe sentinel?
// A: A real height is always >= 0 — empty is 0, and every other node is
//    1 + max(children), so the value can only grow. No legitimate height
//    can ever be negative, so -1 is unambiguously "unbalanced".
//
// Q: Why not return a tuple (isBalanced: Bool, height: Int)?
// A: It works and is arguably more readable. The sentinel avoids
//    allocating a tuple per call and keeps the recursion a single Int.
//    Say this out loud in an interview — knowing the tradeoff matters
//    more than which one you pick.
//
// Q: Why post-order and not pre-order?
// A: A node's balance depends on results from below. You must have both
//    child heights before you can decide, so the work happens on the way
//    back up. Contrast 226 (Invert), where the swap is independent of
//    the children's results and can happen on the way down.
//
// Q: Which do you write in an interview?
// A: The optimised one directly, but mention the naive O(n²) version
//    first in one sentence so they see you know why the sentinel exists.
