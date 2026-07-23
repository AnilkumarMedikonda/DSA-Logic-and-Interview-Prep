import Foundation

// MARK: - TreeNode

final class TreeNode {

    var val: Int
    var left: TreeNode?
    var right: TreeNode?

    init(_ val: Int) {
        self.val = val
    }
}

// MARK: - buildTree
// Every node dequeued claims the NEXT TWO slots of `values`.

func buildTree(_ values: [Int?]) -> TreeNode? {

    guard !values.isEmpty, let rootValue = values[0] else { return nil }

    let rootNode = TreeNode(rootValue)
    var queue = [rootNode]
    var head = 0          // dequeue index — never removeFirst(), that is O(n)
    var index = 1         // root already consumed slot 0

    while head < queue.count && index < values.count {

        let current = queue[head]
        head += 1

        // Left child
        if index < values.count {
            if let leftValue = values[index] {
                let left = TreeNode(leftValue)
                current.left = left
                queue.append(left)
            }
            index += 1        // outside the if let — a nil slot is still consumed
        }

        // Right child
        if index < values.count {
            if let rightValue = values[index] {
                let right = TreeNode(rightValue)
                current.right = right
                queue.append(right)
            }
            index += 1
        }
    }

    return rootNode
}

// MARK: - Level Order, BFS (the standard answer)
//
// DFS cannot do this. Preorder/inorder/postorder all dive down one
// branch; level order must finish an entire level first. That needs
// a QUEUE, not a stack.
//
// THE ONE IDEA: freeze queue.count - head BEFORE the inner loop.
// That number is exactly how many nodes sit on the current level.
// Children appended during the inner loop land behind them and
// belong to the next level.

func levelOrder(_ root: TreeNode?) -> [[Int]] {

    // Empty tree returns [], NOT [[]]
    guard let rootNode = root else { return [] }

    var result: [[Int]] = []
    var queue = [rootNode]        // [TreeNode], not [TreeNode?] —
    var head = 0                  // that is what removes every ?? 0

    while head < queue.count {

        // MUST be `let`, and MUST be read before the inner loop.
        // Read it inside and it grows as children are pushed —
        // the level never ends and everything merges into one array.
        let levelSize = queue.count - head

        // Fresh array per level. Declared outside the outer loop,
        // all levels would merge.
        var currentLevel: [Int] = []

        for _ in 0..<levelSize {

            let current = queue[head]   // READ first
            head += 1                   // THEN advance

            currentLevel.append(current.val)

            // Only real nodes are enqueued — never nil
            if let left  = current.left  { queue.append(left)  }
            if let right = current.right { queue.append(right) }
        }

        result.append(currentLevel)
    }

    return result
}

// MARK: - Level Order, DFS alternative
//
// Works because `depth` says which inner array a value belongs to.
// Nodes arrive out of order but land in the right bucket.
// Ask for BFS in an interview unless told otherwise — this version
// uses O(h) stack instead of O(w) queue, which occasionally matters.

func levelOrderDFS(_ root: TreeNode?) -> [[Int]] {

    var result: [[Int]] = []

    func dfs(_ node: TreeNode?, _ depth: Int) {

        guard let node else { return }

        // First node ever seen at this depth creates its row
        if depth == result.count {
            result.append([])
        }

        result[depth].append(node.val)

        dfs(node.left,  depth + 1)
        dfs(node.right, depth + 1)
    }

    dfs(root, 0)
    return result
}

// MARK: - Tests

//        10
//       /  \
//     15    20
//     / \   /
//   20  40 50

let tree = buildTree([10, 15, 20, 20, 40, 50])
print(levelOrder(tree))       // [[10], [15, 20], [20, 40, 50]]
print(levelOrderDFS(tree))    // [[10], [15, 20], [20, 40, 50]]

//        1
//       / \
//      2   3
//     / \   \
//    4   5   6

let tree2 = buildTree([1, 2, 3, 4, 5, nil, 6])
print(levelOrder(tree2))      // [[1], [2, 3], [4, 5, 6]]

// Edge cases
print(levelOrder(nil))                  // []   not [[]]
print(levelOrder(buildTree([])))        // []
print(levelOrder(buildTree([1])))       // [[1]]
print(levelOrder(buildTree([1, 2, nil, 3])))   // [[1], [2], [3]]

// MARK: - Complexity
//
//                  Time    Space
// buildTree        O(n)    O(n)
// levelOrder BFS   O(n)    O(w)  <- w = WIDEST level
// levelOrderDFS    O(n)    O(h)  <- h = height
//
// BFS space is NOT O(h). That is the DFS answer. A queue holds a
// whole level at once, and the bottom level of a perfect tree is
// about n/2 nodes — so worst case O(n).
//
// This contrast is the standard follow-up question:
//   DFS -> O(h) stack, bad on a SKEWED tree
//   BFS -> O(w) queue, bad on a WIDE tree

// MARK: - Traps
//
// 1. head += 1 BEFORE reading queue[head] -> index out of range on
//    the very first iteration.
// 2. Reading queue.count inside the inner loop instead of freezing
//    levelSize -> all levels merge into one array.
// 3. currentLevel declared outside the outer loop -> same merge.
// 4. Returning [[]] for a nil root instead of [].
// 5. queue typed [TreeNode?] -> forces current?.val and ?? 0.
//    Enqueue the UNWRAPPED root; the optionality disappears.
// 6. removeFirst() as dequeue -> O(n) shift, O(n²) overall.

// MARK: - Why 171 matters
//
// The level-boundary pattern is the base for four L2 problems:
//   178 Level Order II      same code, reverse the result
//   179 Zigzag              same code, reverse alternate levels
//   180 Right Side View     same code, take the LAST of each level
//   plus level-based variants elsewhere
//
// Get levelSize solid now and those become small variations.
