import Foundation

// ============================================================
// 187 - Insert into a Binary Search Tree (LC 701)
// ============================================================
//
// INTERVIEW SOLUTION -> [P1] iterative parent-tracking walk.
// O(h) time, O(1) space. Same three-way walk as 186 + one
// extra variable.
//
// KEY IDEA
//   The value is guaranteed absent, so the search for it MUST
//   fail -- and the exact nil slot where the walk falls off IS
//   a valid leaf position, correct by construction. Insert is
//   always insert-as-leaf; no restructuring, ever.
//
// EXAMPLE  insert 5 into [4,2,7,1,3]
//
//        4                 4
//       / \               / \
//      2   7      ->     2   7
//     / \               / \  /
//    1   3             1  3 5     (5 = left child of 7)
//
// PRIORITY
//   [P1] Iterative parent-tracking  O(h)/O(1)  <- write this
//   [P2] Recursive reattachment     O(h)/O(h)  <- if asked
//
// TRAPS (both hit and fixed during this solve)
//   - Base case must RETURN TreeNode(val) -- returning a
//     recursive call on nil is infinite recursion
//   - Recursive results must be REATTACHED: root.left = ...
//     An unused-result warning on a tree function = orphaned
//     node. The tree comes back unchanged, silently.

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

// MARK: - [P1] Iterative parent-tracking. O(h) time, O(1) space
//
// Steps:
// 1. empty tree -> the new node IS the root
// 2. walk down with `current`, saving `parent` BEFORE each step
// 3. when current falls off, parent is the last real node --
//    the attach point is directly below it
// 4. the SAME comparison that drove the walk picks the side

func insertIntoBST(_ root: TreeNode?, _ val: Int) -> TreeNode? {
    let newNode = TreeNode(val)

    // Step 1: empty tree
    guard let root else { return newNode }

    var parent = root
    var current: TreeNode? = root

    // Step 2: the 186 walk + parent memory
    while let node = current {
        parent = node
        if val < node.value {
            current = node.left
        } else {
            current = node.right
        }
    }

    // Steps 3+4: attach below parent, side from the comparison
    if val < parent.value {
        parent.left = newNode
    } else {
        parent.right = newNode
    }

    return root
}

// MARK: - [P2] Recursive reattachment. O(h) time, O(h) stack
//
// Steps:
// 1. nil -> the fall-off spot -> return the new leaf
// 2. compare, recurse into ONE side
// 3. REATTACH the result -- root.left = insert(...) is what
//    wires the new leaf to its parent. For existing nodes the
//    assignment is a harmless no-op; at exactly one spot it
//    attaches the new node. One uniform line, no special cases.
// 4. return root unchanged so the tree above is untouched

func insertIntoBSTRecursive(_ root: TreeNode?, _ val: Int) -> TreeNode? {
    guard let root else { return TreeNode(val) } // Step 1

    if val < root.value {
        root.left = insertIntoBSTRecursive(root.left, val)    // Steps 2+3
    } else {
        root.right = insertIntoBSTRecursive(root.right, val)
    }

    return root                                           // Step 4
}

// MARK: - Verification (inorder of a BST must stay sorted)

func inorder(_ root: TreeNode?, _ result: inout [Int]) {
    guard let root = root else { return }
    inorder(root.left, &result)
    result.append(root.value)
    inorder(root.right, &result)
}

func check(_ root: TreeNode?, _ label: String) {
    var values = [Int]()
    inorder(root, &values)

    var sorted = true
    var i = 1
    while i < values.count {
        if values[i - 1] > values[i] {
            sorted = false
        }
        i += 1
    }
    print(sorted ? "PASS" : "FAIL", "-", label, "->", values)
}

// MARK: - Tests

// insertion IS the BST builder -- loop inserts from empty
var root: TreeNode? = nil
for value in [4, 2, 7, 1, 3] {
    root = insertIntoBST(root, value)
}
check(root, "built by insertion")            // [1, 2, 3, 4, 7]

root = insertIntoBST(root, 5)
check(root, "iterative: insert 5")           // [1, 2, 3, 4, 5, 7]

root = insertIntoBSTRecursive(root, 0)
check(root, "recursive: insert 0 (new min)") // [0, 1, 2, 3, 4, 5, 7]

root = insertIntoBSTRecursive(root, 8)
check(root, "recursive: insert 8 (new max)") // [..., 7, 8]

check(insertIntoBST(nil, 42), "empty tree -> new root")   // [42]

// skew demo: sorted inserts build a right-leaning line -> O(n) height
var skewed: TreeNode? = nil
for value in [1, 2, 3, 4, 5] {
    skewed = insertIntoBST(skewed, value)
}
check(skewed, "sorted inserts -> skewed (still valid)")
