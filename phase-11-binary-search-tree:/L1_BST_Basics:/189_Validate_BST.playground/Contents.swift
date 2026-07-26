import Foundation

// 189_Validate_BST (LC 98, Medium)
//
// PROBLEM:
// Given the root of a binary tree, determine if it is a valid Binary Search Tree.
// A valid BST is defined as:
//   - ALL nodes in the left subtree have values < node's value
//   - ALL nodes in the right subtree have values > node's value
//   - Both subtrees must themselves be valid BSTs
//   - Strict comparison — duplicate values are NOT allowed
//
// Example 1: [5,3,6,2,4,null,7]        → true
// Example 2: [5,1,4,null,null,3,6]     → false (4 in right subtree, but 4 < 5)
// Example 3: [10,5,15,null,null,6,20]  → false (6 is valid vs parent 15,
//            but 6 sits in 10's RIGHT subtree and 6 < 10 — the trap:
//            parent-child checks alone are NOT enough, whole-subtree bounds are)

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

// MARK: - Approach 1: Inorder — O(n) time, O(n) space

// Inorder of a valid BST must be STRICTLY increasing
func isValidBSTInorder(_ node: TreeNode?) -> Bool {
    // Step 1: empty tree is a VALID BST
    guard let root = node else { return true }

    var result = [Int]()

    // Step 2: standard inorder — left, visit, right
    func inOrder(_ node: TreeNode?) {
        guard let node else { return }
        inOrder(node.left)
        result.append(node.value)
        inOrder(node.right)
    }

    inOrder(root)

    // Step 3: every value must be strictly greater than its predecessor
    // start at 1 (i-1 access), <= catches duplicates
    for i in 1..<result.count {
        if result[i] <= result[i - 1] {
            return false
        }
    }
    return true
}

// MARK: - Approach 2: Range (min, max) — O(n) time, O(h) stack — PRIMARY

func isValidBST(_ root: TreeNode?) -> Bool {
    // Step 1: root starts unbounded on both sides
    return validate(root, min: nil, max: nil)
}

func validate(_ node: TreeNode?, min: Int?, max: Int?) -> Bool {
    // Step 2: empty subtree is valid
    guard let node = node else { return true }

    // Step 3: lower bound — node must be STRICTLY greater than min
    if let min = min {
        if node.value <= min {
            return false
        }
    }

    // Step 4: upper bound — node must be STRICTLY less than max
    if let max = max {
        if node.value >= max {
            return false
        }
    }

    // Step 5: LEFT tightens the UPPER bound, RIGHT tightens the LOWER bound
    return validate(node.left, min: min, max: node.value)
        && validate(node.right, min: node.value, max: max)
}

// MARK: - Tests

// Valid: [5,3,6,2,4,null,7]
let valid = TreeNode(5,
                     TreeNode(3, TreeNode(2), TreeNode(4)),
                     TreeNode(6, nil, TreeNode(7)))
print(isValidBST(valid), isValidBSTInorder(valid))         // true true

// Invalid, direct child: [5,1,4,null,null,3,6]
let invalid1 = TreeNode(5,
                        TreeNode(1),
                        TreeNode(4, TreeNode(3), TreeNode(6)))
print(isValidBST(invalid1), isValidBSTInorder(invalid1))   // false false

// Invalid, DEEP violation (the trap): [10,5,15,null,null,6,20]
let invalid2 = TreeNode(10,
                        TreeNode(5),
                        TreeNode(15, TreeNode(6), TreeNode(20)))
print(isValidBST(invalid2), isValidBSTInorder(invalid2))   // false false

// Duplicate values are invalid: [2,2,2]
let dupes = TreeNode(2, TreeNode(2), TreeNode(2))
print(isValidBST(dupes), isValidBSTInorder(dupes))         // false false

// Empty and single node are valid
print(isValidBST(nil), isValidBSTInorder(nil))             // true true
print(isValidBST(TreeNode(1)), isValidBSTInorder(TreeNode(1))) // true true
