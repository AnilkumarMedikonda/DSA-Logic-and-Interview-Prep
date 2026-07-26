// 192_BST_Iterator (LC 173, Medium)
//
// PROBLEM:
// Implement a class BSTIterator over a BST's INORDER traversal:
//   - init(_ root: TreeNode?)  — initialize with the root
//   - next() -> Int?           — return the next smallest value
//   - hasNext() -> Bool        — true if values remain
//
// Example: root = [7,3,15,null,null,9,20]
//   next() → 3, next() → 7, hasNext() → true,
//   next() → 9, next() → 15, next() → 20, hasNext() → false
//
// CONSTRAINT: next()/hasNext() must average O(1) time using O(h) memory —
// so "flatten everything in init" (O(n) space) is the brute force, not the answer.
//
// KEY INSIGHT: iterative inorder = push left spine, pop, move right.
// The iterator PAUSES that loop between calls — the stack IS the paused state.
// INVARIANT: the stack always holds the path to the next unvisited inorder node,
// with that node on top.

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

// MARK: - Approach 1: Flatten in init — O(n) space (brute force, violates the bound)
final class BSTIteratorBrute {
    private var values = [Int]()
    private var index = 0

    // Step 1: full inorder up front — all the work happens here
    init(_ root: TreeNode?) {
        inOrder(root)
    }

    private func inOrder(_ node: TreeNode?) {
        guard let node else { return }
        inOrder(node.left)
        values.append(node.value)
        inOrder(node.right)
    }

    // Step 2: next = return + advance; true O(1), but O(n) memory
    func next() -> Int? {
        guard index < values.count else { return nil }
        let value = values[index]
        index += 1
        return value
    }

    func hasNext() -> Bool {
        return index < values.count
    }
}

// MARK: - Approach 2: Controlled inorder with a stack — O(h) memory, amortized O(1) — PRIMARY
final class BSTIterator {
    private var stack = [TreeNode]()

    // Step 1: establish the invariant — push root and its whole left spine;
    // the smallest node ends up on top
    init(_ root: TreeNode?) {
        pushLeft(root)
    }

    // Step 2: the reusable spine walk — house idiom: while let
    private func pushLeft(_ node: TreeNode?) {
        var current = node
        while let node = current {
            stack.append(node)
            current = node.left
        }
    }

    // Step 3: pop = the answer; then push the popped node's RIGHT subtree's
    // left spine to restore the invariant for the following call
    func next() -> Int? {
        // popLast + guard — no removeLast crash on empty
        guard let node = stack.popLast() else { return nil }
        pushLeft(node.right)   // pushLeft guards nil internally — no if-let wrapper needed
        return node.value
    }

    // Step 4: values remain ⟺ stack is non-empty
    func hasNext() -> Bool {
        return !stack.isEmpty
    }
}

// MARK: - Tests

// [7,3,15,null,null,9,20] — inorder: 3, 7, 9, 15, 20
let root = TreeNode(7,TreeNode(3),TreeNode(15, TreeNode(9), TreeNode(20)))

let it = BSTIterator(root)
while it.hasNext() {
    if let value = it.next() {
        print(value, terminator: " ")   // 3 7 9 15 20
    }
}
print()

// next() past the end — nil, no crash
print(it.next() == nil)                 // true

// Single node
let single = BSTIterator(TreeNode(42))
print(single.next() == 42)              // true
print(single.hasNext())                 // false

// Empty tree
let empty = BSTIterator(nil)
print(empty.hasNext())                  // false

// Brute-force alternate — same sequence
let brute = BSTIteratorBrute(root)
while brute.hasNext() {
    if let value = brute.next() {
        print(value, terminator: " ")   // 3 7 9 15 20
    }
}
