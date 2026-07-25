// MARK: - 180. Binary Tree Right Side View (LC 199)

/*
 Given the root of a binary tree, imagine yourself standing on the RIGHT side of it.
 Return the values of the nodes you can see, ordered top to bottom.

 Input : [1,2,3,null,5,null,4]
 Output: [1,3,4]

          1          <- you see 1
        /   \
       2     3       <- you see 3 (2 is hidden behind it)
        \     \
         5     4     <- you see 4 (5 is hidden behind it)

 Key point: it is NOT "all right children". It is the LAST node of every level.
 If a level's rightmost node has no right child, the visible node can come from a
 left subtree (e.g. node 5 would be visible if 4 didn't exist).
*/


// MARK: - Node

final class TreeNode {
    
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
    
    init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}


// MARK: - Build tree (LeetCode array format)

func buildTree(_ nums: [Int?]) -> TreeNode? {
    
    guard !nums.isEmpty, let root = nums[0] else {
        return nil
    }
    
    let rootNode = TreeNode(root)
    var index = 1
    var queue = [rootNode]
    var head = 0
    
    while head < queue.count && index < nums.count {
        let current = queue[head]
        head += 1
        
        if index < nums.count, let left = nums[index] {
            let leftNode = TreeNode(left)
            current.left = leftNode
            queue.append(leftNode)
        }
        index += 1
        
        if index < nums.count, let right = nums[index] {
            let rightNode = TreeNode(right)
            current.right = rightNode
            queue.append(rightNode)
        }
        index += 1
    }
    
    return rootNode
}


// MARK: - Approach 1: BFS

/*
 Steps:
 1. Guard nil root -> return [].
 2. Push root into queue, head = 0 (head pointer instead of removeFirst()).
 3. While head < queue.count:
      a. levelSize = queue.count - head   // snapshot BEFORE appending children
      b. Loop i in 0..<levelSize:
           - pop node (queue[head], head += 1)
           - if i == levelSize - 1  -> this is the last node of the level, append val
           - push left child if present
           - push right child if present
 4. Return result.
*/

func rightSideView(_ root: TreeNode?) -> [Int] {
    
    guard let root else {
        return []
    }
    
    var queue = [root]
    var head = 0
    var result = [Int]()
    
    while head < queue.count {
        let levelSize = queue.count - head
        
        for i in 0..<levelSize {
            let node = queue[head]
            head += 1
            
            if i == levelSize - 1 {
                result.append(node.val)
            }
            
            if let left = node.left {
                queue.append(left)
            }
            
            if let right = node.right {
                queue.append(right)
            }
        }
    }
    
    return result
}


// MARK: - Approach 2: DFS

/*
 Steps:
 1. result = [], where result.count doubles as "how many levels are already filled".
 2. dfs(node, depth):
      a. guard node != nil.
      b. if depth == result.count -> first node ever reached at this depth, append val.
      c. recurse RIGHT first, then LEFT.
 3. Because right is visited first, the first node reached at any depth is the
    rightmost node of that level.
 4. Call dfs(root, 0), return result.
*/

func rightSideView2(_ root: TreeNode?) -> [Int] {
    
    var result = [Int]()
    
    func dfs(_ node: TreeNode?, _ depth: Int) {
        guard let node else {
            return
        }
        
        if depth == result.count {
            result.append(node.val)
        }
        
        dfs(node.right, depth + 1)
        dfs(node.left, depth + 1)
    }
    
    dfs(root, 0)
    
    return result
}


// MARK: - Dry run (DFS, [1,2,3,null,5,null,4])

/*
 dfs(1, 0)  depth 0 == count 0 -> result [1]
   dfs(3, 1)  depth 1 == count 1 -> result [1,3]
     dfs(4, 2)  depth 2 == count 2 -> result [1,3,4]
     dfs(nil,2) return
   dfs(2, 1)  depth 1 != count 3 -> skip
     dfs(5, 2)  depth 2 != count 3 -> skip      // hidden behind 4
     dfs(nil,2) return
 Result: [1,3,4]
*/


// MARK: - Complexity

/*
 BFS: Time O(n) | Space O(n)   -- queue holds up to one full level (and the array
                                  retains the consumed prefix since head only moves)
 DFS: Time O(n) | Space O(h)   -- recursion stack; O(log n) balanced, O(n) skewed
*/


// MARK: - Traps

/*
 1. Flipping DFS to left-then-right gives the LEFT side view. Order IS the algorithm.
 2. Taking levelSize AFTER appending children breaks level boundaries — snapshot first.
 3. "Rightmost node" != "right child". A left child can be visible.
 4. Using removeFirst() on a Swift Array is O(n) per pop -> O(n^2) overall. Use head.
 5. Empty tree must return [], not crash.
*/


// MARK: - Tests

/*
 buildTree([1,2,3,nil,5,nil,4])  -> [1,3,4]
 buildTree([1,nil,3])            -> [1,3]
 buildTree([1,2])                -> [1,2]      // left child visible
 buildTree([1])                  -> [1]
 buildTree([])                   -> []
*/


// MARK: - Interview Q&A

/*
 Q: BFS or DFS here?
 A: BFS reads more naturally ("last of each level") and is O(h) cheaper only when the
    tree is skewed; DFS is O(h) space and shorter. Either is accepted — state the
    depth == result.count invariant clearly and DFS impresses more.

 Q: How would you get the left side view?
 A: BFS: take i == 0 instead of i == levelSize - 1. DFS: recurse left before right.

 Q: Why does depth == result.count work?
 A: result is filled strictly level by level, so its count equals the number of levels
    already recorded. Hitting a depth equal to that count means it's the first — and,
    with right-first traversal, the rightmost — node at that level.
*/
