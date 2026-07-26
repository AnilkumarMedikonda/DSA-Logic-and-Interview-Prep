import Foundation

// ============================================================
// 186 - Search in a Binary Search Tree (LC 700)
// ============================================================
//
// INTERVIEW SOLUTION -> three-way compare, walk ONE direction.
// O(h) time; O(1) space iterative. This is array binary search
// transplanted onto pointers.
//
// PROBLEM
// Given the root of a BST and val, return the node whose value
// equals val (the whole subtree rooted there). Not found -> nil.
//
// EXAMPLE  [4,2,7,1,3]
//
//        4
//       / \
//      2   7
//     / \
//    1   3
//
//   val = 2 -> node 2 (subtree [2,1,3])
//   val = 5 -> nil

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

// MARK: - Level-order builder (guard BEFORE the subscript)

func buildTree(_ values: [Int?]) -> TreeNode? {
    guard !values.isEmpty, let root = values[0] else { return nil }

    let rootNode = TreeNode(root)
    var queue = [rootNode]
    var head = 0
    var index = 1

    while head < queue.count && index < values.count {
        let current = queue[head]
        head += 1

        if index < values.count, let left = values[index] {
            let leftNode = TreeNode(left)
            current.left = leftNode
            queue.append(leftNode)
        }
        index += 1

        if index < values.count, let right = values[index] {
            let rightNode = TreeNode(right)
            current.right = rightNode
            queue.append(rightNode)
        }
        index += 1
    }
    return rootNode
}

// MARK: - Brute force: plain DFS, ignores the BST property
//
// Steps:
// 1. nil -> nil
// 2. match -> return the node
// 3. search left; if found, return it
// 4. otherwise return whatever the right side finds
//
// O(n) time, O(h) stack -- works on ANY tree. State it in one
// line as the baseline, then use the ordering.

func searchAnyTree(_ root: TreeNode?, _ val: Int) -> TreeNode? {
    guard let root else { return nil }
    if root.value == val { return root }

    if let found = searchAnyTree(root.left, val) {
        return found
    }
    return searchAnyTree(root.right, val)
}

// MARK: - Optimised recursive: BST three-way compare
//
// Steps:
// 1. nil -> fell off the tree -> not present -> nil
// 2. equal -> found, return the node (equality is its OWN case)
// 3. val < node -> answer can only be LEFT
// 4. else -> answer can only be RIGHT
//
// O(h) time, O(h) stack. Never touches both subtrees.

func searchBST(_ root: TreeNode?, _ val: Int) -> TreeNode? {
    guard let root else { return nil }

    if root.value == val {
        return root
    }

    if val < root.value {
        return searchBST(root.left, val)
    } else {
        return searchBST(root.right, val)
    }
}

// MARK: - Optimised iterative: single walking pointer
//
// Steps:
// 1. current = root
// 2. loop while current is a real node
// 3. equal -> return; smaller -> step left; larger -> step right
// 4. loop exits -> walked off the tree -> nil
//
// O(h) time, O(1) SPACE -- the true optimal. Same while-let
// walking-pointer shape as the LCA-BST walk from 181.

func searchBSTIterative(_ root: TreeNode?, _ val: Int) -> TreeNode? {
    var current = root

    while let node = current {
        if node.value == val {
            return node
        }
        if val < node.value {
            current = node.left
        } else {
            current = node.right
        }
    }

    return nil
}

// MARK: - Tests

let root = buildTree([4, 2, 7, 1, 3])

print(searchBST(root, 2)?.value ?? -1)            // 2
print(searchBSTIterative(root, 2)?.value ?? -1)   // 2
print(searchBST(root, 5) == nil)                  // true (not present)
print(searchBSTIterative(root, 5) == nil)         // true
print(searchBSTIterative(root, 4)?.value ?? -1)   // 4 (root itself)
print(searchBSTIterative(root, 1)?.value ?? -1)   // 1 (leaf, deepest walk)
print(searchBSTIterative(nil, 3) == nil)          // true (empty tree)

// returned value is the SUBTREE, not just the value:
if let subtree = searchBSTIterative(root, 2) {
    print(subtree.left?.value ?? -1, subtree.right?.value ?? -1)  // 1 3
}
