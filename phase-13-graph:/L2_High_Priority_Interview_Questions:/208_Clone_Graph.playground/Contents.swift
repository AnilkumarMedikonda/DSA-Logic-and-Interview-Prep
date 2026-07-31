import Foundation

// 208_Clone_Graph


//======================================================
// MARK: - Graph Node
//======================================================

class Node {

    var value: Int
    var neighbors: [Node]

    init(_ value: Int) {
        self.value = value
        self.neighbors = []
    }

    init(_ value: Int, _ neighbors: [Node]) {
        self.value = value
        self.neighbors = neighbors
    }
}

//======================================================
// MARK: - Clone Graph Solution
//======================================================

class Solution {

    // Original Node -> Clone Node
    var visited = [ObjectIdentifier: Node]()

    func cloneGraph(_ node: Node?) -> Node? {

        //==================================================
        // STEP 1
        // Empty Graph
        //==================================================

        guard let node = node else {
            print("Graph is Empty")
            return nil
        }

        //==================================================
        // STEP 2
        // Unique Identity
        //==================================================

        let id = ObjectIdentifier(node)

        //==================================================
        // STEP 3
        // Already Cloned?
        //==================================================

        if let clone = visited[id] {

            print("Already Cloned Node \(node.value)")

            return clone
        }

        //==================================================
        // STEP 4
        // Create Clone
        //==================================================

        print("Creating Clone of Node \(node.value)")

        let clone = Node(node.value)

        //==================================================
        // STEP 5
        // Save Mapping
        //==================================================

        visited[id] = clone

        print("Saved Node \(node.value) -> Clone \(clone.value)")

        //==================================================
        // STEP 6
        // Visit Every Neighbor
        //==================================================

        for neighbor in node.neighbors {

            print("Visiting Neighbor \(neighbor.value) of Node \(node.value)")

            if let cloneNeighbor = cloneGraph(neighbor) {

                clone.neighbors.append(cloneNeighbor)

                print("Connected Clone \(cloneNeighbor.value) to Clone \(clone.value)")
            }
        }

        print("Returning Clone \(clone.value)\n")

        return clone
    }
}

//======================================================
// MARK: - Print Graph
//======================================================

func printGraph(_ node: Node?) {

    guard let node = node else {
        print("Empty Graph")
        return
    }

    var visited = Set<ObjectIdentifier>()

    func dfs(_ node: Node) {

        let id = ObjectIdentifier(node)

        if visited.contains(id) {
            return
        }

        visited.insert(id)

        let neighbors = node.neighbors.map { String($0.value) }

        print("Node \(node.value) -> \(neighbors)")

        for neighbor in node.neighbors {
            dfs(neighbor)
        }
    }

    dfs(node)
}

//======================================================
// MARK: - Create Sample Graph
//======================================================

/*

      1
     / \
    2---4
     \ /
      3

*/

let node1 = Node(1)
let node2 = Node(2)
let node3 = Node(3)
let node4 = Node(4)

node1.neighbors = [node2, node4]
node2.neighbors = [node1, node3]
node3.neighbors = [node2, node4]
node4.neighbors = [node1, node3]

//======================================================
// MARK: - Original Graph
//======================================================

print("=================================")
print("Original Graph")
print("=================================\n")

printGraph(node1)

//======================================================
// MARK: - Clone Graph
//======================================================

print("\n=================================")
print("Cloning Graph")
print("=================================\n")

let solution = Solution()

let clonedGraph = solution.cloneGraph(node1)

//======================================================
// MARK: - Cloned Graph
//======================================================

print("\n=================================")
print("Cloned Graph")
print("=================================\n")

printGraph(clonedGraph)
