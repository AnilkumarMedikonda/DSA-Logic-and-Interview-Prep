import Foundation

// ============================================================
// 181 - Lowest Common Ancestor  (Blind 75)
// LC 235 - LCA of a Binary Search Tree
// LC 236 - LCA of a Binary Tree
// ============================================================
//
// INTERVIEW SOLUTION -> [P1] DFS recursion (works on ANY tree).
// Memorize this one. It is optimal and expected for LC 236, and
// it reuses the post-order return-value pattern you already know
// from Diameter, LCA, and Max Path Sum. The BST walk [P2] is a
// one-line upgrade you NAME only when the input is stated to be
// a BST -- do not memorize it as a separate solution.
//
// PROBLEM
// Given the root of a tree and two nodes p and q (both are
// guaranteed to exist in the tree), return their lowest common
// ancestor: the deepest node that has both p and q as
// descendants. A node is allowed to be a descendant of itself.
//
// EXAMPLE 1 - BST  [6,2,8,0,4,7,9,nil,nil,3,5]
//
//              6
//            /   \
//           2     8
//          / \   / \
//         0   4 7   9
//            / \
//           3   5
//
//   p = 2, q = 8  -> 6   (targets split at the root)
//   p = 2, q = 4  -> 2   (2 is an ancestor of itself)
//   p = 3, q = 5  -> 4
//
// EXAMPLE 2 - general binary tree  [3,5,1,6,2,0,8,nil,nil,7,4]
//
//              3
//            /   \
//           5     1
//          / \   / \
//         6   2 0   8
//            / \
//           7   4
//
//   p = 5, q = 1  -> 3
//   p = 5, q = 4  -> 5   (self-ancestor)
//   p = 7, q = 8  -> 3
//
// CONSTRAINTS
//   2 <= nodes <= 10^5, all values unique, p != q,
//   both p and q exist in the tree.
//
// SOLUTIONS IN THIS FILE - PRIORITY ORDER FOR INTERVIEWS
//
//   [P1] Solution 1 - DFS recursion, ANY binary tree (LC 236)
//        O(n) time, O(h) space                        *****
//        MEMORIZE. Lead with this. Reusable post-order tree
//        pattern (diameter, path sum, balanced all reuse it).
//
//   [P2] Solution 2a - BST walk, iterative (LC 235)
//        O(h) time, O(1) space                        ****
//        Name as the optimisation once P1 is stated. If the
//        question explicitly says BST and there is time for
//        only one, write this.
//
//   [P3] Solution 2b - BST walk, recursive (LC 235)
//        O(h) time, O(h) stack                        ***
//        Same logic as 2a, extra stack for no gain.
//        Mention only if asked for the recursive form.
//
//   [P4] Path-comparison brute force (not coded here)
//        Store root-to-p and root-to-q paths, compare from the
//        front, last match is the LCA. O(n) time, O(n) space.
//        Say it as the naive baseline, do not code it.
//
// INTERVIEW SEQUENCE
//   1. State P4 in one line as the baseline.
//   2. Code P1 and walk the return-value meaning.
//   3. Say "since it is a BST I can drop to O(h)/O(1)" -> P2.
// ============================================================

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

// MARK: - Level-order builder

func buildTree(_ values: [Int?]) -> TreeNode? {
    guard !values.isEmpty, let rootValue = values[0] else { return nil }

    let rootNode = TreeNode(rootValue)
    var queue = [rootNode]
    var head = 0
    var index = 1

    while index < values.count && head < queue.count {
        let current = queue[head]
        head += 1

        if index < values.count {
            if let leftValue = values[index] {
                let leftNode = TreeNode(leftValue)
                current.left = leftNode
                queue.append(leftNode)
            }
        }
        index += 1

        if index < values.count {
            if let rightValue = values[index] {
                let rightNode = TreeNode(rightValue)
                current.right = rightNode
                queue.append(rightNode)
            }
        }
        index += 1
    }

    return rootNode
}

// MARK: - Helper to fetch p and q by value for testing

func findNode(_ root: TreeNode?, _ value: Int) -> TreeNode? {
    guard let root = root else { return nil }
    if root.value == value { return root }

    if let found = findNode(root.left, value) {
        return found
    }
    return findNode(root.right, value)
}

// MARK: - [P1] Solution 1: DFS recursion (LC 236). O(n) time, O(h) stack. INTERVIEW SOLUTION - MEMORIZE
//
// Return value means: the LCA if found in this subtree, else
// whichever of p/q was found here, else nil. The parent uses that
// to decide whether it is the split point.
//
// Steps:
// 1. nil node -> nil
// 2. node is p or q -> return node (self-ancestor case)
// 3. recurse left, recurse right
// 4. both sides non-nil -> targets split -> this node is the LCA
//    one side non-nil   -> bubble that side up
//    both nil           -> nil

func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode, _ q: TreeNode) -> TreeNode? {
    guard let root = root else { return nil }

    if root === p || root === q { return root }

    let left = lowestCommonAncestor(root.left, p, q)
    let right = lowestCommonAncestor(root.right, p, q)

    if left != nil && right != nil { return root }
    if left != nil { return left }
    return right
}

// MARK: - [P2] Solution 2a: BST iterative (LC 235). O(h) time, O(1) space. UPGRADE WHEN INPUT IS A BST
//
// Steps:
// 1. current = root
// 2. loop while current is not nil
// 3. both targets < current.value  -> move left
//    both targets > current.value  -> move right
//    otherwise (split, or one equals current) -> current is the LCA
// 4. loop exits -> no LCA -> nil

func lowestCommonAncestorBST(_ root: TreeNode?, _ p: TreeNode, _ q: TreeNode) -> TreeNode? {
    var current = root

    while let node = current {
        if p.value < node.value && q.value < node.value {
            current = node.left
        } else if p.value > node.value && q.value > node.value {
            current = node.right
        } else {
            return node
        }
    }

    return nil
}

// MARK: - [P3] Solution 2b: BST recursive (LC 235). O(h) time, O(h) stack. ONLY IF ASKED

func lowestCommonAncestorBSTRecursive(_ root: TreeNode?, _ p: TreeNode, _ q: TreeNode) -> TreeNode? {
    guard let root = root else { return nil }

    if p.value < root.value && q.value < root.value {
        return lowestCommonAncestorBSTRecursive(root.left, p, q)
    }
    if p.value > root.value && q.value > root.value {
        return lowestCommonAncestorBSTRecursive(root.right, p, q)
    }
    return root
}

// MARK: - Tests

let bst = buildTree([6, 2, 8, 0, 4, 7, 9, nil, nil, 3, 5])

if let p = findNode(bst, 2), let q = findNode(bst, 8) {
    print("BST iterative p=2 q=8 ->", lowestCommonAncestorBST(bst, p, q)?.value ?? -1)          // 6
    print("BST recursive p=2 q=8 ->", lowestCommonAncestorBSTRecursive(bst, p, q)?.value ?? -1) // 6
}

if let p = findNode(bst, 2), let q = findNode(bst, 4) {
    print("BST iterative p=2 q=4 ->", lowestCommonAncestorBST(bst, p, q)?.value ?? -1)          // 2
}

if let p = findNode(bst, 3), let q = findNode(bst, 5) {
    print("BST iterative p=3 q=5 ->", lowestCommonAncestorBST(bst, p, q)?.value ?? -1)          // 4
}

let tree = buildTree([3, 5, 1, 6, 2, 0, 8, nil, nil, 7, 4])

if let p = findNode(tree, 5), let q = findNode(tree, 1) {
    print("Tree p=5 q=1 ->", lowestCommonAncestor(tree, p, q)?.value ?? -1)                     // 3
}

if let p = findNode(tree, 5), let q = findNode(tree, 4) {
    print("Tree p=5 q=4 ->", lowestCommonAncestor(tree, p, q)?.value ?? -1)                     // 5
}

if let p = findNode(tree, 7), let q = findNode(tree, 8) {
    print("Tree p=7 q=8 ->", lowestCommonAncestor(tree, p, q)?.value ?? -1)                     // 3
}
