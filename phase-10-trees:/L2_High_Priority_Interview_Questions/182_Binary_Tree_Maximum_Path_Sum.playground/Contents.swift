import Foundation

// LeetCode 124. Binary Tree Maximum Path Sum
//
// A path is any sequence of connected nodes; it does not have to
// pass through the root and cannot reuse a node. Return the
// largest sum of any path.
//
// KEY IDEA - two different quantities at each node:
//   - ANSWER candidate = split path = left + right + node
//     (bends through the node, uses BOTH children)
//   - RETURN value     = straight path = node + max(left, right)
//     (goes up to the parent, can use only ONE child, since a
//      parent cannot walk into both of a child's branches)

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

func maxPathSum(_ root: TreeNode?) -> Int {
    var maxiPathSum = Int.min

    func dfs(_ root: TreeNode?) -> Int {
        // Step 1: nil node contributes 0
        guard let root else { return 0 }

        // Step 2: best downward contribution from each child.
        //         clamp at 0 -> a negative branch is dropped
        //         instead of dragging the path down.
        let leftPath = max(0, dfs(root.left))
        let rightPath = max(0, dfs(root.right))

        // Step 3: answer candidate = path that BENDS at this node,
        //         joining both children through it.
        let splitPath = leftPath + rightPath + root.val
        maxiPathSum = max(maxiPathSum, splitPath)

        // Step 4: return the STRAIGHT path for the parent to extend.
        //         only one child may continue upward.
        return root.val + max(leftPath, rightPath)
    }

    _ = dfs(root)
    return maxiPathSum
}

// MARK: - Level-order builder (nil = missing child)

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

// MARK: - Tests

print(maxPathSum(buildTree([1, 2, 3])))                       // 6  (2 + 1 + 3)
print(maxPathSum(buildTree([-10, 9, 20, nil, nil, 15, 7])))   // 42 (15 + 20 + 7)
print(maxPathSum(buildTree([-3])))                            // -3 (single node)
print(maxPathSum(buildTree([2, -1])))                         // 2  (drop the -1 branch)
print(maxPathSum(buildTree([-2, -1])))                        // -1 (best single node)
