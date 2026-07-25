import Foundation

// ============================================================
// 183 - Construct Binary Tree from Preorder and Inorder (LC 105)
// ============================================================
//
// INTERVIEW SOLUTION -> dictionary + global preorder pointer +
// index-range recursion. O(n) time, O(n) space. Memorize this.
//
// KEY IDEA
//   preorder[i] hands out ROOTS in exactly the order the
//   recursion needs (root, then all of left, then all of right)
//   -- as long as we build LEFT BEFORE RIGHT.
//   inorder tells us the SPLIT: everything left of the root's
//   inorder position is the left subtree, everything right of
//   it is the right subtree.
//
// EXAMPLE
//   preorder = [3, 9, 20, 15, 7]
//   inorder  = [9, 3, 15, 20, 7]
//
//              3
//             / \
//            9   20
//               /  \
//              15   7

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

func buildTree(_ preOrder: [Int], _ inOrder: [Int]) -> TreeNode? {

    // Step 1: map value -> inorder index, once.
    //         kills the repeated O(n) scan -> O(1) lookups.
    var inOrderIndex = [Int: Int]()
    for (index, value) in inOrder.enumerated() {
        inOrderIndex[value] = index
    }

    // Step 2: global pointer into preorder. consumed strictly
    //         left to right; each consumption is the root of
    //         the subtree currently being built.
    var preOrderIndex = 0

    // dfs builds the subtree whose inorder values live in
    // inOrder[left...right]. index ranges, no array slicing.
    func dfs(_ left: Int, _ right: Int) -> TreeNode? {

        // Step 3: empty range -> no subtree here.
        if left > right {
            return nil
        }

        // Step 4: next unconsumed preorder value is this
        //         subtree's root. look up its split point
        //         BEFORE consuming, so a failed lookup cannot
        //         corrupt preOrderIndex.
        let rootValue = preOrder[preOrderIndex]

        guard let middle = inOrderIndex[rootValue] else {
            return nil
        }

        preOrderIndex += 1
        let root = TreeNode(rootValue)

        // Step 5: LEFT BEFORE RIGHT - load-bearing order.
        //         preorder lists the entire left subtree before
        //         the right one, so the pointer must finish the
        //         left side first. swapping these lines breaks
        //         the build silently.
        root.left = dfs(left, middle - 1)
        root.right = dfs(middle + 1, right)

        return root
    }

    return dfs(0, inOrder.count - 1)
}

// MARK: - Verification helpers (re-traverse the built tree)

func preorderTraversal(_ root: TreeNode?, _ result: inout [Int]) {
    guard let root = root else { return }
    result.append(root.value)
    preorderTraversal(root.left, &result)
    preorderTraversal(root.right, &result)
}

func inorderTraversal(_ root: TreeNode?, _ result: inout [Int]) {
    guard let root = root else { return }
    inorderTraversal(root.left, &result)
    result.append(root.value)
    inorderTraversal(root.right, &result)
}

func verify(_ preOrder: [Int], _ inOrder: [Int]) {
    let root = buildTree(preOrder, inOrder)

    var preCheck = [Int]()
    var inCheck = [Int]()
    preorderTraversal(root, &preCheck)
    inorderTraversal(root, &inCheck)

    let ok = preCheck == preOrder && inCheck == inOrder
    print(ok ? "PASS" : "FAIL", "-> pre:", preCheck, "in:", inCheck)
}

// MARK: - Tests

verify([3, 9, 20, 15, 7], [9, 3, 15, 20, 7])   // example tree
verify([1, 2, 3], [3, 2, 1])                   // left-skewed (off-by-one exposer)
verify([1, 2, 3], [1, 2, 3])                   // right-skewed
verify([1], [1])                               // single node
verify([1, 2, 4, 5, 3, 6, 7], [4, 2, 5, 1, 6, 3, 7])  // full balanced tree
