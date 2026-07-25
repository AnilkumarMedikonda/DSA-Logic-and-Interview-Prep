import UIKit

// MARK: - Problem
// 179 — Binary Tree Zigzag Level Order Traversal (LC 103)
// Same output shape as 178, but the direction alternates per level:
// level 0 left→right, level 1 right→left, level 2 left→right, and so on.
//
//      3
//     / \
//    9  20        →  [[3], [20,9], [15,7]]
//      /  \
//     15   7
//
// The traversal is IDENTICAL to 178. Only how each level array gets
// assembled changes.

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

// MARK: - Approach: BFS with index mirroring
// Key idea: don't change the traversal, change where each value LANDS.
// Pre-size the level array, then write each popped value directly into
// its final slot.
//
// Steps:
// 1. Empty root → return [].
// 2. levelSize = queue.count - head — the unread portion IS the current
//    level. Snapshot it before popping, exactly as in 178.
// 3. Pre-size the level array. Every slot gets overwritten, so the
//    placeholder value never survives.
// 4. Pop in normal left-to-right order — enqueue order NEVER changes.
// 5. Compute the destination slot:
//       forward  → i
//       reversed → levelSize - 1 - i
//    Pop 0 lands last, pop 1 second-to-last, and so on.
// 6. Enqueue non-nil children, unchanged from 178.
// 7. Flip the direction, append the finished level, repeat.

func zigzagLevelOrder(_ root: TreeNode?) -> [[Int]] {

    guard let root else { return [] }                              // 1

    var queue = [root]
    var head = 0
    var result = [[Int]]()
    var isReversed = false

    while head < queue.count {

        let levelSize = queue.count - head                         // 2
        var level = [Int](repeating: 0, count: levelSize)          // 3

        for i in 0..<levelSize {                                   // 4

            let current = queue[head]
            head += 1

            let position = isReversed ? levelSize - 1 - i : i      // 5
            level[position] = current.value

            if let left = current.left {                           // 6
                queue.append(left)
            }

            if let right = current.right {
                queue.append(right)
            }
        }

        isReversed = !isReversed                                   // 7
        result.append(level)
    }

    return result
}

// MARK: - Variant: parity from result.count
// The flag is optional. result.count at the top of the outer loop IS the
// index of the level being built, so the parity is already available.
// Fewer moving parts, one less variable to keep in sync.

func zigzagLevelOrderNoFlag(_ root: TreeNode?) -> [[Int]] {

    guard let root else { return [] }

    var queue = [root]
    var head = 0
    var result = [[Int]]()

    while head < queue.count {

        let levelSize = queue.count - head
        let isReversed = result.count % 2 == 1
        var level = [Int](repeating: 0, count: levelSize)

        for i in 0..<levelSize {

            let current = queue[head]
            head += 1

            level[isReversed ? levelSize - 1 - i : i] = current.value

            if let left = current.left {
                queue.append(left)
            }

            if let right = current.right {
                queue.append(right)
            }
        }

        result.append(level)
    }

    return result
}

// MARK: - Dry Run  (input [1,2,3,4,5,6,7])
//
//        1
//      /   \
//     2     3
//    / \   / \
//   4   5 6   7
//
// queue [1]  head 0  isReversed false
//
// outer 1: levelSize = 1 - 0 = 1, level [0]
//   i=0  pop 1  position = 0        → level [1]
//        enqueue 2, 3 → queue [1,2,3], head 1
//   flip → true, result [[1]]
//
// outer 2: levelSize = 3 - 1 = 2, level [0,0]
//   i=0  pop 2  position = 2-1-0 = 1 → level [0,2]
//        enqueue 4, 5
//   i=1  pop 3  position = 2-1-1 = 0 → level [3,2]
//        enqueue 6, 7 → queue [1,2,3,4,5,6,7], head 3
//   flip → false, result [[1],[3,2]]
//
// outer 3: levelSize = 7 - 3 = 4, level [0,0,0,0]
//   i=0..3 pop 4,5,6,7 at positions 0,1,2,3 → level [4,5,6,7]
//        no children, head 7
//   flip → true, result [[1],[3,2],[4,5,6,7]]
//
// head 7 == count → stop.
//
// Note the pops are ALWAYS 2 then 3, never 3 then 2. The reversal happens
// on write, not on read.

// MARK: - Complexity
// Time  O(n) — each node popped once, each write O(1)
// Space O(n) — queue retains every node (head-cursor pattern), plus
//              O(n) output
//
// Identical to 178. That equality is the tell that you solved it properly:
// the zigzag should cost nothing extra.
//
// Compare the naive assembly:
//   level.insert(value, at: 0)  → O(k) per insert, every element shifts
//                                  right → O(levelSize²) per level
// On a wide tree the bottom level holds ~n/2 nodes, so that degrades the
// whole solution to O(n²) while the traversal stays O(n).

// MARK: - Traps
// - insert(at: 0) in a loop. Correct output, quadratic cost. This is THE
//   mistake in this problem.
// - Alternating the ENQUEUE order (right child first on odd levels).
//   Tempting and wrong — you'd be reordering the next level while still
//   reading the current one, and they interleave incorrectly. Reversal
//   belongs in assembly, not traversal.
// - Reading queue.count live inside the inner loop instead of snapshotting.
// - Flipping the direction inside the inner loop instead of after it.
// - Returning [[Int]]? when nothing ever returns nil — the caller gets
//   Optional(...) for no reason.
// - Off-by-one in the mirror: levelSize - i instead of levelSize - 1 - i
//   → index out of range on the first pop.

// MARK: - Tests
// zigzagLevelOrder(createBuildTree([3,9,20,nil,nil,15,7]))
//   → [[3],[20,9],[15,7]]
// zigzagLevelOrder(createBuildTree([1,2,3,4,5,6,7]))
//   → [[1],[3,2],[4,5,6,7]]
// zigzagLevelOrder(createBuildTree([1]))          → [[1]]
// zigzagLevelOrder(createBuildTree([]))           → []
// zigzagLevelOrder(createBuildTree([1,nil,2,nil,3])) → [[1],[2],[3]]
// zigzagLevelOrder(createBuildTree([1,2]))        → [[1],[2]]

// MARK: - Interview Q&A
// Q: Why not reverse the enqueue order on odd levels?
// A: With one queue you'd be writing the next level in a different order
//    while still reading the current one — the two interleave and the
//    output breaks. The direction is a property of how you READ a level,
//    not how you BUILD the next one.
//
// Q: Is there a traversal-level solution?
// A: Yes — two stacks. Pop from stack A pushing children left-then-right
//    onto B, then pop from B pushing right-then-left onto A, swapping each
//    level. Same O(n), different idea. Worth naming even if you write the
//    BFS version.
//
// Q: Why pre-size instead of appending then reversing?
// A: Reversing is a second O(k) pass and, in Swift, .reversed() returns a
//    lazy view you'd have to materialise anyway. Writing to the mirrored
//    index does it in one pass with no extra allocation.
//
// Q: Where else does levelSize - 1 - i show up?
// A: It's generic index mirroring, not zigzag-specific — in-place array
//    reversal, spiral matrix traversal, palindrome two-pointer checks.
//    Recognising it as "map i to its mirror" is what makes it transfer.
//
// Q: What's the minimal change from 178?
// A: One line — the destination index. That's a good thing to say out loud:
//    it shows you recognised the problem as 178 plus an assembly tweak
//    rather than a new problem.
