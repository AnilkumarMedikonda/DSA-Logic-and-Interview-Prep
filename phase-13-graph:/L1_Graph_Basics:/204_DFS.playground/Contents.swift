import Foundation

//==============================================================
// Graph
//==============================================================
//
//        A
//       / \
//      B   C
//     / \   \
//    D   E   F
//

let graph: [String: [String]] = [
    "A": ["B", "C"],
    "B": ["D", "E"],
    "C": ["F"],
    "D": [],
    "E": [],
    "F": []
]

//==============================================================
// DFS  —  Recursive
//==============================================================
// Goes DEEP: follow one branch to its end, then backtrack.
// visited marked on ENTER (before looping neighbours).
// Trap: mark AFTER the loop and a cycle re-enters the node before
// it's flagged → infinite recursion.

func dfsRecursive(node: String, graph: [String: [String]], visited: inout Set<String>, depth: Int) {

    let indent = String(repeating: "    ", count: depth)   // visual depth

    print("\(indent)enter ---> \(node)")
    visited.insert(node)
    print("\(indent)visited.insert(\(node))   visited = \(visited.sorted())")

    guard let neighbours = graph[node] else {
        print("\(indent)no neighbours ---> backtrack")
        return
    }

    print("\(indent)neighbours ---> \(neighbours)")

    for neighbour in neighbours {
        if !visited.contains(neighbour) {
            print("\(indent)go deeper: \(node) → \(neighbour)")
            dfsRecursive(node: neighbour, graph: graph, visited: &visited, depth: depth + 1)
        } else {
            print("\(indent)skip \(neighbour) (already visited)")
        }
    }

    print("\(indent)done \(node) ---> backtrack")
}

//==============================================================
// DFS  —  Iterative (explicit stack)
//==============================================================
// Same DEEP behaviour, stack instead of recursion.
// Trap: check visited at POP time, not push time — a node can be
// pushed twice before it's ever popped.
// neighbours pushed .reversed() so pop order matches the recursive walk.

func dfsIterative(start: String, graph: [String: [String]]) {

    var visited: Set<String> = []
    var stack = [start]
    var step = 1

    print("========== DFS Iterative ==========")

    while !stack.isEmpty {

        print("\n---------------- STEP \(step) ----------------")
        print("Stack Before Pop : \(stack)")
        print("Visited          : \(visited.sorted())")

        let node = stack.removeLast()          // pop
        print("removeLast() ---> \(node)")

        if visited.contains(node) {            // check at POP time
            print("already visited ---> skip")
            step += 1
            continue
        }

        visited.insert(node)
        print("Visit Node   ---> \(node)")

        guard let neighbours = graph[node] else {
            step += 1
            continue
        }

        print("Neighbours   ---> \(neighbours)")

        for neighbour in neighbours.reversed() {   // reversed → matches recursive order
            if !visited.contains(neighbour) {
                print("stack.append(\(neighbour))")
                stack.append(neighbour)
            }
        }
        print("Stack Now    ---> \(stack)")

        step += 1
    }

    print("\n========== DFS Iterative Finished ==========")
}

//==============================================================
// Run
//==============================================================

print("========== DFS Recursive ==========\n")
var visited: Set<String> = []
dfsRecursive(node: "A", graph: graph, visited: &visited, depth: 0)
print("\n========== DFS Recursive Finished ==========\n\n")

dfsIterative(start: "A", graph: graph)
