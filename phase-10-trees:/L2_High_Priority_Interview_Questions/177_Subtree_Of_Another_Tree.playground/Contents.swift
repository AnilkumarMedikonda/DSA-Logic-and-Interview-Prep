// MARK: - Problem
// 177 — Subtree of Another Tree (LC 572)
// Return true if some node in `root` has a subtree — that node and ALL its
// descendants — identical in structure and values to `subRoot`.
//
//        3                    4
//       / \                  / \
//      4   5      subRoot:  1   2      → true
//     / \
//    1   2
//
// "Subtree" is total: you can't match a node and ignore some of its
// children. That's why 174 (Same Tree) is the building block.

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

// MARK: - Approach 1: Serialisation
// Flatten both trees to strings, then it's a substring problem.
//
// Format: each node emits  ,value,   each nil emits  x
//
// Steps:
// 1. Empty node → emit "x". This marker preserves SHAPE — without it
//    [1,2] and [1,nil,2] serialise identically and you get a false positive.
// 2. Non-empty node → emit "," + value + "," then recurse left, then right.
//    The leading comma anchors matches to node boundaries.
// 3. Serialise both trees.
// 4. subRoot is a subtree iff its string occurs inside root's string.

func isSubtree(_ root: TreeNode?, _ subRoot: TreeNode?) -> Bool {

    func serialize(_ node: TreeNode?) -> String {
        guard let node else { return "x" }                          // 1
        return "," + String(node.value) + ","                       // 2
            + serialize(node.left) + serialize(node.right)
    }

    let rootStr = serialize(root)                                   // 3
    let subRootStr = serialize(subRoot)

    return rootStr.contains(subRootStr)                             // 4
}

// MARK: - Approach 2: isSameTree at every node
// Steps:
// 1. Empty root → nowhere left to look → false.
// 2. Ask whether the tree rooted HERE equals subRoot. Reuse isSameTree.
// 3. Match → done.
// 4. No match → try the left subtree, then the right. || short-circuits,
//    so the first hit stops the search.
//
// isSameTree itself:
//   a. Both nil → this branch agrees → true.
//   b. Exactly one nil → structures diverge → false (the guard catches
//      this, since step a already ruled out both-nil).
//   c. Values differ → false.
//   d. Recurse left-vs-left AND right-vs-right.

func isSubtreeSameCheck(_ root: TreeNode?, _ subRoot: TreeNode?) -> Bool {

    func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {

        if p == nil && q == nil {                                   // a
            return true
        }

        guard let p = p, let q = q else {                           // b
            return false
        }

        if p.value != q.value {                                     // c
            return false
        }

        return isSameTree(p.left, q.left)                           // d
            && isSameTree(p.right, q.right)
    }

    guard let root else { return false }                            // 1

    if isSameTree(root, subRoot) {                                  // 2
        return true                                                 // 3
    }

    return isSubtreeSameCheck(root.left, subRoot)                   // 4
        || isSubtreeSameCheck(root.right, subRoot)
}

// MARK: - Dry Run  (root [3,4,5,1,2], subRoot [4,1,2])
//
//        3              4
//       / \            / \
//      4   5          1   2
//     / \
//    1   2
//
// Serialisation:
//   subRoot → ",4,,1,xx,2,xx"
//   root    → ",3,,4,,1,xx,2,xx,5,xx"
//                  ^-------------^  occurs → true
//
// Counter-case — give node 4 an extra child 0:
//   root's segment becomes ",4,,1,x,0,xxx,2,xx"
//   The pattern no longer occurs. The x markers caught the shape change.
//
// isSameTree walk:
//   isSameTree(3, 4)          → 3 != 4 → false
//   isSubtreeSameCheck(4, …)  → isSameTree(4, 4) → values match
//                               → (1,1) match, (2,2) match → true
//   Returns true without ever visiting node 5.

// MARK: - Complexity
// n = nodes in root, m = nodes in subRoot.
//
// Serialisation:  Time O(n × m) | Space O(n + m)
// isSameTree:     Time O(n × m) | Space O(h)
//
// Both are O(n × m). Swift's String.contains is naive substring search,
// so the serialisation approach does NOT beat the brute force as written —
// swapping in KMP is what brings it to O(n + m).
//
// The O(n × m) bound is loose in practice: isSameTree usually bails on the
// first value mismatch. The worst case is real though — a tree of all
// identical values forces the full comparison at every node.

// MARK: - Traps
// - Dropping the null markers. [1,2] and [1,nil,2] then look the same.
// - Dropping the delimiter comma. [12] appears to contain [2].
// - Claiming O(n + m) while using .contains(). It's O(n × m).
// - Comparing values only and ignoring structure — the 174 mistake.
// - Treating a partial match as success. The subtree must include every
//   descendant, not just the top levels.
// - A dead guard after explicit nil checks — the guard alone does both jobs.

// MARK: - Tests
// isSubtree(createBuildTree([3,4,5,1,2]), createBuildTree([4,1,2]))  → true
// isSubtree(createBuildTree([3,4,5,1,2,nil,nil,nil,nil,0]),
//           createBuildTree([4,1,2]))                                → false
// isSubtree(createBuildTree([12]), createBuildTree([2]))             → false
// isSubtree(createBuildTree([1,1]), createBuildTree([1]))            → true
// isSubtree(createBuildTree([]), createBuildTree([1]))               → false

// MARK: - Interview Q&A
// Q: Which do you write?
// A: isSameTree-at-every-node. O(n × m) is accepted for LC 572 and it shows
//    you saw the link to 174. Mention serialisation + KMP as the O(n + m)
//    follow-up rather than leading with it.
//
// Q: Why the null markers?
// A: They encode shape. Same values in the same order with different
//    structure would otherwise serialise identically.
//
// Q: Why the leading comma?
// A: It anchors matches to node boundaries. The comma after a value is
//    always followed by , or x, so a pattern starting with ,digit can only
//    align where a real node begins.
//
// Q: Is .contains() good enough?
// A: For passing LC, yes. But state honestly that it's naive search — the
//    serialisation only pays off with KMP or Rabin-Karp underneath.
