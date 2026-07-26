// 191_Lowest_Common_Ancestor_Of_BST (LC 235, Medium)
//
// PROBLEM:
// Given a BST and two nodes p and q (both guaranteed to exist in the tree),
// return their lowest common ancestor — the deepest node that has both
// p and q as descendants. A node counts as a descendant of itself.
//
// Example 1: root = [6,2,8,0,4,7,9,null,null,3,5], p = 2, q = 8 → 6
//            (2 goes left, 8 goes right — they SPLIT at 6)
// Example 2: same tree, p = 2, q = 4 → 2
//            (4 lives inside 2's subtree — ancestor-of-itself case)
//
// KEY INSIGHT: in a BST, values tell you where p and q live —
// no need to search both subtrees (that's LC 236's general-tree problem).
// Walk down from the root:
//   both smaller → go left | both larger → go right | otherwise → THIS is the LCA
//
// Why is the split node the LOWEST? It's the first node where p and q are
// no longer on the same side — every deeper node contains at most one of them.

final class TreeNode {
    var value: Int
    var left: TreeNode?
    var right: TreeNode?

    init(_ value: Int, _ left: TreeNode? = nil, _ right: TreeNode? = nil) {
        self.value = value
        self.right = right
        self.left = left
    }
}

// MARK: - Approach 1: Iterative walk — O(h) time, O(1) space — PRIMARY

func lcaIterative(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
    guard let p, let q else { return nil }

    // Step 1: single moving pointer — no stack, no recursion → O(1) space
    var current = root

    while let node = current {
        if p.value < node.value && q.value < node.value {
            // Step 2: both in the left subtree — LCA is deeper left
            current = node.left
        } else if p.value > node.value && q.value > node.value {
            // Step 3: both in the right subtree — LCA is deeper right
            current = node.right
        } else {
            // Step 4: split point, or node equals p or q — this is the LCA
            // (no explicit == check needed: failing both conditions above implies it)
            return node
        }
    }

    // Step 5: unreachable when p and q are guaranteed present —
    // the walk always ends at the split node or at p/q itself
    return nil
}

// MARK: - Approach 2: Recursive — O(h) time, O(h) stack — alternate

func lcaRecursive(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
    guard let root, let p, let q else { return nil }

    // Same three-way logic, recursion instead of a pointer
    if p.value < root.value && q.value < root.value {
        return lcaRecursive(root.left, p, q)
    }
    if p.value > root.value && q.value > root.value {
        return lcaRecursive(root.right, p, q)
    }
    return root
}

// MARK: - Tests

// [6,2,8,0,4,7,9,null,null,3,5]
let n3 = TreeNode(3)
let n5 = TreeNode(5)
let n2 = TreeNode(2, TreeNode(0), TreeNode(4, n3, n5))
let n8 = TreeNode(8, TreeNode(7), TreeNode(9))
let root = TreeNode(6, n2, n8)

// Split case: p = 2, q = 8 → 6
if let lca = lcaIterative(root, n2, n8) { print(lca.value) }   // 6

// Ancestor-of-itself: p = 2, q = 4 → 2
if let lca = lcaIterative(root, n2, n5) { print(lca.value) }   // 2

// Deep pair on the same side: p = 3, q = 5 → 4
if let lca = lcaIterative(root, n3, n5) { print(lca.value) }   // 4

// Recursive alternate — same answers
if let lca = lcaRecursive(root, n2, n8) {
    print(lca.value)
}
// 6
if let lca = lcaRecursive(root, n3, n5) {
    print(lca.value)
}   // 4
