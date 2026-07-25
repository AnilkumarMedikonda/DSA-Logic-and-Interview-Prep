import Foundation

// ============================================================
// 185 - Path Sum (LC 112)  EASY
// ============================================================
//
// INTERVIEW SOLUTION -> recursive subtract-and-check at leaf.
// O(n) time, O(h) space. This IS the optimal; nothing to
// upgrade to.
//
// PROBLEM
// Given the root of a tree and targetSum, return true if there
// is a ROOT-TO-LEAF path whose values sum to targetSum. The
// path must end at a leaf -- stopping at an internal node does
// not count.
//
// EXAMPLE  [5,4,8,11,nil,13,4,7,2,nil,nil,nil,1], target 22
//
//              5
//            /   \
//           4     8
//          /     / \
//        11    13   4
//        / \         \
//       7   2         1
//
//   5 -> 4 -> 11 -> 2 = 22 -> true
//
// KEY IDEA
//   Subtract the current node from the target and pass the
//   REMAINDER down. At a leaf, ask: does this leaf's value
//   equal what is left?
//
// TRAPS THIS VERSION AVOIDS
//   - Checking "remaining == 0" at a nil node instead of at a
//     leaf: wrongly accepts paths that stop at an internal
//     node with one child. The leaf check must be explicit.
//   - Early exit on targetSum < 0: WRONG, node values can be
//     negative, so a path can dip below zero and recover.

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

func hasPathSum(_ root: TreeNode?, _ targetSum: Int) -> Bool {

    // Step 1: empty tree (or walked past a leaf's missing
    //         sibling) -> no path here.
    guard let root else { return false }

    // Step 2: LEAF check -- the path is only allowed to end
    //         here. true iff this leaf supplies exactly what
    //         is still needed.
    if root.left == nil && root.right == nil {
        return targetSum == root.value
    }

    // Step 3: internal node -> consume this node's value and
    //         pass the remainder down.
    let remaining = targetSum - root.value

    // Step 4: true if EITHER subtree completes the path.
    //         || short-circuits: right is not explored if the
    //         left already found a path.
    return hasPathSum(root.left, remaining) || hasPathSum(root.right, remaining)
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

let tree = buildTree([5, 4, 8, 11, nil, 13, 4, 7, 2, nil, nil, nil, 1])

print(hasPathSum(tree, 22))                          // true  (5-4-11-2)
print(hasPathSum(tree, 26))                          // true  (5-8-13)
print(hasPathSum(tree, 18))                          // false (5-13? not a path)
print(hasPathSum(buildTree([1, 2]), 1))              // false (1 is NOT a leaf)
print(hasPathSum(buildTree([1, 2]), 3))              // true  (1-2)
print(hasPathSum(nil, 0))                            // false (empty tree)
print(hasPathSum(buildTree([-2, nil, -3]), -5))      // true  (negatives work)
