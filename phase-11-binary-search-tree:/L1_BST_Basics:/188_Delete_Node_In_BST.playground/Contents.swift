// 188_Delete_Node_In_BST (LC 450) — O(h) time, O(h) stack

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

// MARK: - Solution

// Step A: smallest node in a subtree = keep walking left
func findMin(_ node: TreeNode?) -> TreeNode? {
    var current = node
    while let left = current?.left {
        current = left
    }
    return current
}

func deleteNode(_ node: TreeNode?, _ key: Int) -> TreeNode? {
    // Step 1: empty subtree — key not found, nothing to delete
    guard let root = node else { return nil }

    if key < root.value {
        // Step 2: key is in the left subtree — recurse and REATTACH the result
        root.left = deleteNode(root.left, key)
    } else if key > root.value {
        // Step 3: key is in the right subtree — recurse and reattach
        root.right = deleteNode(root.right, key)
    } else {
        // Step 4: found the node to delete — three cases

        // Case 1 & 2: zero or one child — return the other side,
        // parent's reattachment (Step 2/3) links it in, node drops out
        if root.left == nil {
            return root.right
        }
        if root.right == nil {
            return root.left
        }

        // Case 3: two children — replace value with inorder successor
        // (min of right subtree = smallest value > root.value, keeps BST valid)
        if let successor = findMin(root.right) {
            root.value = successor.value
            // Step 5: remove the duplicate — successor has no left child,
            // so this recursive delete hits Case 1/2 and terminates
            root.right = deleteNode(root.right, successor.value)
        }
    }

    return root
}

// MARK: - Test Helpers

// Inorder traversal — for a BST this must always print sorted values
func inorder(_ node: TreeNode?, _ result: inout [Int]) {
    guard let root = node else { return }
    inorder(root.left, &result)
    result.append(root.value)
    inorder(root.right, &result)
}

func printInorder(_ label: String, _ root: TreeNode?) {
    var result = [Int]()
    inorder(root, &result)
    print(label, result)
}

// MARK: - Test Cases

// Test 1: two children (successor case)
// [5,3,6,2,4,null,7], key = 3
let root1 = TreeNode(5,
                     TreeNode(3, TreeNode(2), TreeNode(4)),
                     TreeNode(6, nil, TreeNode(7)))
let r1 = deleteNode(root1, 3)
printInorder("Test 1 (delete 3):", r1)      // [2, 4, 5, 6, 7]

// Test 2: leaf node
let root2 = TreeNode(5,
                     TreeNode(3, TreeNode(2), TreeNode(4)),
                     TreeNode(6, nil, TreeNode(7)))
let r2 = deleteNode(root2, 7)
printInorder("Test 2 (delete leaf 7):", r2) // [2, 3, 4, 5, 6]

// Test 3: one child — 7 takes 6's place
let root3 = TreeNode(5,
                     TreeNode(3, TreeNode(2), TreeNode(4)),
                     TreeNode(6, nil, TreeNode(7)))
let r3 = deleteNode(root3, 6)
printInorder("Test 3 (delete one-child 6):", r3) // [2, 3, 4, 5, 7]

// Test 4: delete the root (two children)
let root4 = TreeNode(5,
                     TreeNode(3, TreeNode(2), TreeNode(4)),
                     TreeNode(6, nil, TreeNode(7)))
let r4 = deleteNode(root4, 5)
printInorder("Test 4 (delete root 5):", r4) // [2, 3, 4, 6, 7]

// Test 5: key not in tree — unchanged
let root5 = TreeNode(5, TreeNode(3), TreeNode(6))
let r5 = deleteNode(root5, 10)
printInorder("Test 5 (missing key 10):", r5) // [3, 5, 6]

// Test 6: single-node tree, delete it
let root6 = TreeNode(1)
let r6 = deleteNode(root6, 1)
printInorder("Test 6 (delete only node):", r6) // []
