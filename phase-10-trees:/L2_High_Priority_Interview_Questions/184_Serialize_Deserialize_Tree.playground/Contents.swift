import Foundation

// ============================================================
// 184 - Serialize and Deserialize Binary Tree (LC 297)  HARD
// ============================================================
//
// INTERVIEW SOLUTION -> preorder DFS with "#" nil sentinels.
// Serialize and deserialize are both O(n). Memorize this.
//
// KEY IDEA
//   Preorder + explicit nil markers is SELF-DESCRIBING: each "#"
//   closes a branch, so deserialize can rebuild the exact shape
//   from the token stream alone. Deserialize is the same
//   "global pointer consuming preorder roots" pattern as LC 105.
//
//   Why not inorder? Inorder with nil markers is ambiguous --
//   you cannot tell the root apart from a subtree. Preorder or
//   postorder work; inorder alone does not.
//
// EXAMPLE
//              1
//             / \
//            2   3
//               / \
//              4   5
//
//   serialize -> "1,2,#,#,3,4,#,#,5,#,#"

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

// MARK: - Serialize. O(n) time, O(n) space

func serialize(_ root: TreeNode?) -> String {
    var result = [String]()

    func dfs(_ node: TreeNode?) {
        // Step 1: nil -> emit the sentinel. this is what makes
        //         the encoding self-describing.
        guard let node else {
            result.append("#")
            return
        }

        // Step 2: root, then left, then right (preorder).
        result.append(String(node.value))
        dfs(node.left)
        dfs(node.right)
    }

    dfs(root)
    return result.joined(separator: ",")
}

// MARK: - Deserialize. O(n) time, O(n) space
//
// Invariant: every dfs() call consumes exactly the tokens of its
// own subtree and leaves index at the next sibling's first token.

func deserialize(_ data: String) -> TreeNode? {
    // Step 1: tokenize once.
    let values = data.split(separator: ",").map(String.init)
    var index = 0

    func dfs() -> TreeNode? {
        // Step 2: bounds guard -- protects against truncated or
        //         malformed input instead of crashing.
        guard index < values.count else { return nil }

        // Step 3: sentinel -> consume it, branch is closed.
        if values[index] == "#" {
            index += 1
            return nil
        }

        // Step 4: parse with if-let, no force unwrap. a bad
        //         token bails cleanly.
        guard let value = Int(values[index]) else { return nil }
        index += 1

        // Step 5: build root, then LEFT BEFORE RIGHT -- same
        //         load-bearing order as LC 105. the pointer must
        //         drain the left subtree's tokens first.
        let node = TreeNode(value)
        node.left = dfs()
        node.right = dfs()

        return node
    }

    return dfs()
}

// MARK: - Tests (round-trip: serialize -> deserialize -> serialize)

func roundTrip(_ root: TreeNode?, _ label: String) {
    let encoded = serialize(root)
    let rebuilt = deserialize(encoded)
    let reEncoded = serialize(rebuilt)
    print(encoded == reEncoded ? "PASS" : "FAIL", "-", label, "->", encoded)
}

// example tree: 1,2,3 with 3 having children 4,5
let tree = TreeNode(1,
                    TreeNode(2),
                    TreeNode(3, TreeNode(4), TreeNode(5)))
roundTrip(tree, "example")

// left-skewed
roundTrip(TreeNode(1, TreeNode(2, TreeNode(3))), "left-skewed")

// right-skewed
roundTrip(TreeNode(1, nil, TreeNode(2, nil, TreeNode(3))), "right-skewed")

// single node
roundTrip(TreeNode(7), "single node")

// empty tree
roundTrip(nil, "empty")                       // "#"

// negative values (token stream handles the minus sign fine)
roundTrip(TreeNode(-1, TreeNode(-2), TreeNode(3)), "negatives")

// malformed input does not crash, returns partial/nil
print(deserialize("1,2") == nil ? "partial input handled" : "built partial tree safely")
