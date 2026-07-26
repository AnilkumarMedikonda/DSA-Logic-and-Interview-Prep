// 193_Convert_Sorted_Array_To_BST (LC 108, Easy)
//
// PROBLEM:
// Given an integer array nums sorted in ASCENDING order, convert it into a
// HEIGHT-BALANCED BST (depths of the two subtrees of every node differ by
// at most 1). Any valid answer is accepted.
//
// Example 1: nums = [-10,-3,0,5,9] → [0,-3,9,-10,null,null,5] (others valid)
// Example 2: nums = [1,3]          → [3,1] or [1,null,3]
//
// KEY INSIGHT — 189 in reverse: inorder of a BST is a sorted array, so
// rebuilding from a sorted array means: pick a root, left half becomes the
// left subtree, right half the right subtree. Height-balance forces the
// choice — the MIDDLE element splits the array into equal halves.

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

// MARK: - Solution: middle-as-root, index-range recursion — O(n) time, O(log n) stack

func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {

    // Step 1: recurse on INCLUSIVE index ranges [left, right] over the same
    // array — no subarray slicing (slicing copies → O(n log n))
    func build(_ left: Int, _ right: Int) -> TreeNode? {

        // Step 2: base case — inclusive range is EMPTY when the pointers cross
        // (trap: `left < right` is the VALID condition — inverting it nils the tree)
        if left > right {
            return nil
        }

        // Step 3: overflow-safe middle (Phase 6 binary search form);
        // even-length ranges take the lower middle — either is valid
        let mid = left + (right - left) / 2

        // Step 4: middle element becomes the root of this subtree
        let root = TreeNode(nums[mid])

        // Step 5: recurse and REATTACH — left half and right half,
        // both bounds consistent with the inclusive convention
        root.left = build(left, mid - 1)
        root.right = build(mid + 1, right)

        return root
    }

    return build(0, nums.count - 1)
}

// MARK: - Test Helpers

// Inorder must reproduce the input array — proves valid BST + all elements present
func inorder(_ node: TreeNode?, _ result: inout [Int]) {
    guard let root = node else { return }
    inorder(root.left, &result)
    result.append(root.value)
    inorder(root.right, &result)
}

// Height-balance check (175 pattern: -1 sentinel for "unbalanced below")
func checkHeight(_ node: TreeNode?) -> Int {
    guard let root = node else { return 0 }
    let leftHeight = checkHeight(root.left)
    if leftHeight == -1 { return -1 }
    let rightHeight = checkHeight(root.right)
    if rightHeight == -1 { return -1 }
    let diff = leftHeight - rightHeight
    if diff < -1 || diff > 1 { return -1 }
    if leftHeight > rightHeight {
        return leftHeight + 1
    } else {
        return rightHeight + 1
    }
}

func verify(_ label: String, _ nums: [Int]) {
    let root = sortedArrayToBST(nums)
    var result = [Int]()
    inorder(root, &result)
    let sortedOK = result == nums
    let balancedOK = checkHeight(root) != -1
    print(label, "inorder:", result, "| valid:", sortedOK, "| balanced:", balancedOK)
}

// MARK: - Tests

verify("Test 1 (odd length):", [-10, -3, 0, 5, 9])
// inorder: [-10, -3, 0, 5, 9] | valid: true | balanced: true

verify("Test 2 (even length):", [1, 3])
// inorder: [1, 3] | valid: true | balanced: true

verify("Test 3 (single):", [7])
// inorder: [7] | valid: true | balanced: true

verify("Test 4 (empty):", [])
// inorder: [] | valid: true | balanced: true

verify("Test 5 (larger, 8 elements):", [1, 2, 3, 4, 5, 6, 7, 8])
// inorder: [1...8] | valid: true | balanced: true

// Spot-check structure of Test 1
if let root = sortedArrayToBST([-10, -3, 0, 5, 9]) {
    print(root.value)                       // 0
    if let left = root.left { print(left.value) }    // -10 (lower-middle convention)
    if let right = root.right { print(right.value) } // 5
}
