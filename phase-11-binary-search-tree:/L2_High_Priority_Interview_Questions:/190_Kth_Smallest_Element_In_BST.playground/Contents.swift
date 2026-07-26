// 190_Kth_Smallest_Element_In_BST (LC 230, Medium, ⭐Blind75)
//
// PROBLEM:
// Given the root of a BST and an integer k, return the kth SMALLEST
// value in the tree (1-indexed).
//
// Example 1: root = [3,1,4,null,2], k = 1          → 1
// Example 2: root = [5,3,6,2,4,null,null,1], k = 3 → 3
//
// KEY INSIGHT: inorder traversal of a BST visits values in SORTED order,
// so the kth smallest = the kth node visited in an inorder walk.

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

// MARK: - Approach 1: Brute Force — O(n) time, O(n) space

func kthSmallestBrute(_ root: TreeNode, _ k: Int) -> Int {
    var result = [Int]()

    // Step 1: full inorder — LEFT, visit, RIGHT → ascending order
    // (right-first would give descending = kth LARGEST — the order trap)
    func inOrder(_ root: TreeNode?) {
        guard let root else { return }
        inOrder(root.left)
        result.append(root.value)
        inOrder(root.right)
    }

    inOrder(root)

    // Step 2: k is 1-based, array is 0-based
    return result[k - 1]
}

// MARK: - Approach 2: Counter with early exit — O(h + k) time, O(h) stack — PRIMARY

func kthSmallestOptimal(_ root: TreeNode, _ k: Int) -> Int? {
    var count = 0
    // Step 1: optional answer — no sentinel; 0 is a legal node value,
    // so `answer = 0` can't distinguish "found 0" from "not found"
    var answer: Int?

    func inOrder(_ node: TreeNode?) {
        // Step 2: SHORT-CIRCUIT — once count reaches k, every remaining
        // call bails immediately; without `count < k` the walk continues
        // through all ancestors' right subtrees and O(h + k) is lost
        guard let node, count < k else { return }

        inOrder(node.left)

        // Step 3: the "visit" — this fires in ascending order
        count += 1
        if count == k {
            answer = node.value
            return
        }

        inOrder(node.right)
    }

    inOrder(root)
    // Step 4: caller unwraps — nil only when k > node count
    return answer
}

// MARK: - Tests

// [5,3,6,2,4,null,null,1] — inorder: 1,2,3,4,5,6
let root = TreeNode(5,
                    TreeNode(3,
                             TreeNode(2, TreeNode(1)),
                             TreeNode(4)),
                    TreeNode(6))

print(kthSmallestBrute(root, 1))    // 1
print(kthSmallestBrute(root, 3))    // 3
print(kthSmallestBrute(root, 6))    // 6

if let k1 = kthSmallestOptimal(root, 1) { print(k1) }   // 1
if let k3 = kthSmallestOptimal(root, 3) { print(k3) }   // 3
if let k6 = kthSmallestOptimal(root, 6) { print(k6) }   // 6

// k out of range → nil, handled without crashing
if let bad = kthSmallestOptimal(root, 10) {
    print(bad)
} else {
    print("k out of range")          // k out of range
}
