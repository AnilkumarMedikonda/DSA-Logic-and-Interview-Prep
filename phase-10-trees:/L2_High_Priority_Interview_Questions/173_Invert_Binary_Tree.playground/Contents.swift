// MARK: - Problem
// LC 226 — Invert Binary Tree
// Given the root of a binary tree, mirror it: swap the left and right
// child of every node, top to bottom. Return the same root.
//
//      4                4
//    /   \            /   \
//   2     7    →     7     2
//  / \   / \        / \   / \
// 1   3 6   9      9   6 3   1
//
// Input:  [4,2,7,1,3,6,9]
// Output: [4,7,2,9,6,3,1]

final class TreeNode {

    var value: Int
    var left: TreeNode?
    var right: TreeNode?

    init(value: Int, left: TreeNode? = nil, right: TreeNode? = nil) {
        self.value = value
        self.left = left
        self.right = right
    }
}

// MARK: - Helper: build tree from level-order array

func buildTree(_ values: [Int?]) -> TreeNode? {

    guard !values.isEmpty, let root = values[0] else { return nil }

    let rootNode = TreeNode(value: root)
    var index = 1
    var head = 0
    var queue = [rootNode]

    while index < values.count && head < queue.count {

        let current = queue[head]
        head += 1

        if index < values.count {
            if let leftValue = values[index] {
                let node = TreeNode(value: leftValue)
                current.left = node
                queue.append(node)
            }
            index += 1
        }

        if index < values.count {
            if let rightValue = values[index] {
                let node = TreeNode(value: rightValue)
                current.right = node
                queue.append(node)
            }
            index += 1
        }
    }

    return rootNode
}

// MARK: - Approach 1: Recursive (DFS)
// Steps:
// 1. Empty node → nothing to invert, return nil.
// 2. Swap the current node's left and right references.
// 3. Recurse into the new left, then the new right.
// 4. Return the same node — the tree is mutated in place.

func invertTreeNode(_ node: TreeNode?) -> TreeNode? {

    guard let node = node else { return nil }          // 1

    let leftNode = node.left                           // 2
    node.left = node.right
    node.right = leftNode

    _ = invertTreeNode(node.left)                      // 3
    _ = invertTreeNode(node.right)

    return node                                        // 4
}

// MARK: - Approach 2: Iterative (BFS)
// Steps:
// 1. Empty root → return nil.
// 2. Seed the queue with root; `head` is the read cursor (O(1) dequeue).
// 3. Pop a node, swap its two children.
// 4. Enqueue whichever children are non-nil.
// 5. Loop until the cursor passes the end. Return the same root.

func invertTreeBFS(_ root: TreeNode?) -> TreeNode? {

    guard let root else { return nil }                 // 1

    var queue = [root]                                 // 2
    var head = 0

    while head < queue.count {

        let current = queue[head]
        head += 1

        let temp = current.left                        // 3
        current.left = current.right
        current.right = temp

        if let left = current.left {                   // 4
            queue.append(left)
        }

        if let right = current.right {
            queue.append(right)
        }
    }

    return root                                        // 5
}

// MARK: - Dry Run  (input [4,2,7,1,3,6,9], BFS)
// head=0  visit 4 → swap(2,7)  → queue [4,7,2]
// head=1  visit 7 → swap(6,9)  → queue [4,7,2,9,6]
// head=2  visit 2 → swap(1,3)  → queue [4,7,2,9,6,3,1]
// head=3..6 leaves, both children nil, nothing appended
// head=7 == count → stop.  Result [4,7,2,9,6,3,1]

// MARK: - Complexity
// Recursive: Time O(n) | Space O(h) — O(log n) balanced, O(n) skewed
// BFS:       Time O(n) | Space O(n) — widest level, up to n/2 nodes

// MARK: - Traps
// - Swapping values instead of node references.
// - Recursing into node.left expecting the *original* left subtree.
// - removeFirst() on the queue → O(n) per dequeue; use a head cursor.
// - Discarding the recursive return without `_ =` → compiler warning.

// MARK: - Tests
// buildTree([4,2,7,1,3,6,9])  → invert → [4,7,2,9,6,3,1]
// buildTree([2,1,3])          → invert → [2,3,1]
// buildTree([1,nil,2])        → invert → [1,2]
// buildTree([1])              → invert → [1]
// buildTree([])               → nil
