import UIKit

// MARK: - Problem
// 178 — Binary Tree Level Order Traversal (LC 102)
// Return node values grouped by level, left to right — one inner array
// per level.
//
//      3
//     / \
//    9  20        →  [[3], [9,20], [15,7]]
//      /  \
//     15   7
//
// This is 171 with one addition: 171 gave a flat list, here you need the
// boundaries between levels. All the difficulty lives in that grouping.

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

// MARK: - Helper: build tree from level-order array

func createBuildTree(_ values: [Int?]) -> TreeNode? {

    guard !values.isEmpty, let root = values[0] else { return nil }

    let rootNode = TreeNode(root)
    var queue = [rootNode]
    var head = 0
    var index = 1

    while index < values.count && head < queue.count {

        let current = queue[head]
        head += 1

        if index < values.count {
            if let leftValue = values[index] {
                let leftNode = TreeNode(leftValue)
                current.left = leftNode
                queue.append(leftNode)
            }
            index += 1
        }

        if index < values.count {
            if let rightValue = values[index] {
                let rightNode = TreeNode(rightValue)
                current.right = rightNode
                queue.append(rightNode)
            }
            index += 1
        }
    }

    return rootNode
}

// MARK: - Approach 1: BFS
// Key idea: at the top of each outer iteration, the unread portion of the
// queue holds EXACTLY one complete level. Snapshot its size before popping.
//
// Steps:
// 1. Empty root → return [] (not [[]]).
// 2. Seed the queue with root; head is the read cursor.
// 3. levelSize = queue.count - head — how many unread nodes remain, which
//    is precisely the current level. Snapshot it into a `let` BEFORE the
//    inner loop; the queue grows as you append children.
// 4. Pop exactly levelSize nodes. Everything appended during those pops
//    belongs to the NEXT level, which is why the boundary holds.
// 5. Collect values into a fresh level array, enqueue non-nil children.
// 6. Append the finished level to the result, repeat until the cursor
//    passes the end.

func levelOrder(_ root: TreeNode?) -> [[Int]] {

    guard let root else { return [] }                              // 1

    var result = [[Int]]()
    var queue = [root]                                             // 2
    var head = 0

    while head < queue.count {

        let levelSize = queue.count - head                         // 3
        var level = [Int]()

        for _ in 0..<levelSize {                                   // 4

            let current = queue[head]
            head += 1

            level.append(current.value)                            // 5

            if let left = current.left {
                queue.append(left)
            }

            if let right = current.right {
                queue.append(right)
            }
        }

        result.append(level)                                       // 6
    }

    return result
}

// MARK: - Approach 2: DFS
// Key idea: level order is about DEPTH, not about queues. Carry the depth
// down as a parameter and index into the result with it.
//
// Steps:
// 1. Empty node → return, nothing to record.
// 2. result.count == level means this depth has never been reached before
//    → append an empty array to make room for it.
// 3. Append the value into result[level].
// 4. Recurse left with level + 1, then right.
//
// Why the output is still left-to-right: you always recurse left before
// right, so the first node to reach any new depth is the leftmost one at
// that depth, and every later node at that depth appends after it. The
// ordering falls out of the traversal order — no queue required.

func levelOrderDFS(_ root: TreeNode?) -> [[Int]] {

    var result = [[Int]]()

    func dfs(_ node: TreeNode?, _ level: Int) {

        guard let node else { return }                             // 1

        if result.count == level {                                 // 2
            result.append([])
        }

        result[level].append(node.value)                           // 3

        dfs(node.left, level + 1)                                  // 4
        dfs(node.right, level + 1)
    }

    dfs(root, 0)

    return result
}

// MARK: - Dry Run  (BFS, input [3,9,20,nil,nil,15,7])
//
//      3
//     / \
//    9  20
//      /  \
//     15   7
//
// queue [3]           head 0
// outer 1: levelSize = 1 - 0 = 1
//   pop 3 → level [3], enqueue 9, 20 → queue [3,9,20], head 1
//   result [[3]]
// outer 2: levelSize = 3 - 1 = 2
//   pop 9  → level [9],    no children
//   pop 20 → level [9,20], enqueue 15, 7 → queue [3,9,20,15,7], head 3
//   result [[3],[9,20]]
// outer 3: levelSize = 5 - 3 = 2
//   pop 15 → level [15]
//   pop 7  → level [15,7], head 5
//   result [[3],[9,20],[15,7]]
// head 5 == count → stop.
//
// DFS on the same tree:
// dfs(3, 0)  → count 0 == 0 → append []   → result [[3]]
//   dfs(9, 1)  → count 1 == 1 → append [] → result [[3],[9]]
//   dfs(20, 1) → count 2 != 1             → result [[3],[9,20]]
//     dfs(15, 2) → count 2 == 2 → append [] → [[3],[9,20],[15]]
//     dfs(7, 2)  → count 3 != 2             → [[3],[9,20],[15,7]]

// MARK: - Complexity
// BFS: Time O(n) | Space O(n) — queue
// DFS: Time O(n) | Space O(h) — call stack, O(log n) balanced, O(n) skewed
//
// Both allocate O(n) for the output, so that part is a wash. The real
// difference is working space: DFS wins on wide shallow trees, loses on
// skewed ones.
//
// Note on the BFS bound: textbooks quote O(w) space where w is the widest
// level, because they use removeFirst(). The head-cursor pattern never
// removes anything, so the array retains every node ever enqueued → O(n).
//
//   head cursor    dequeue O(1)  |  peak space O(n)
//   removeFirst()  dequeue O(n)  |  peak space O(w)
//
// O(1) dequeue is the better trade, but know why yours differs from the
// textbook number.

// MARK: - Traps
// - Reading queue.count live inside the inner loop instead of snapshotting.
//   It grows as children are appended and the level boundary is lost.
// - Forgetting `- head` in levelSize. With a head cursor the array holds
//   every node ever enqueued, not just the unread ones.
// - Returning [[]] for an empty root instead of [].
// - Appending an empty level array to the result.
// - In DFS, using result.count > level or >= level. The correct signal for
//   a brand-new depth is exact equality.
// - In DFS, recursing right before left — output order silently reverses
//   within each level.

// MARK: - Tests
// levelOrder(createBuildTree([3,9,20,nil,nil,15,7]))  → [[3],[9,20],[15,7]]
// levelOrder(createBuildTree([1]))                    → [[1]]
// levelOrder(createBuildTree([]))                     → []
// levelOrder(createBuildTree([1,nil,2,nil,3]))        → [[1],[2],[3]]
// levelOrder(createBuildTree([1,2,3,4,5,6,7]))        → [[1],[2,3],[4,5,6,7]]
// Same six inputs through levelOrderDFS → identical output.

// MARK: - Interview Q&A
// Q: How do you know where a level ends?
// A: Snapshot the queue size before popping. Whatever is in the queue at
//    the start of an iteration IS the current level, complete — children
//    appended during that iteration land in the next one.
//
// Q: Why does DFS still produce left-to-right order?
// A: Left recursion always precedes right, so the leftmost node at any
//    depth is reached first and appends first. Order comes from the
//    traversal, not from a queue.
//
// Q: Which would you write in an interview?
// A: BFS — it matches the problem's shape and the level boundary is
//    explicit. Mention DFS as the O(h)-space alternative, and be ready to
//    write it if they ask.
//
// Q: What changes for Zigzag Level Order (LC 103)?
// A: Same skeleton, reverse the level array on odd levels — or build it
//    back-to-front. Nothing about the traversal changes.
//
// Q: What about Right Side View (LC 199)?
// A: Same skeleton, take the last element of each level. In the DFS
//    version, recurse right first and record only when result.count == level.
