import Foundation

print("=" + String(repeating: "=", count: 60))
print("           BFS vs DFS - Step by Step")
print("=" + String(repeating: "=", count: 60))

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
// BFS
//==============================================================

func bfs(start: String, graph: [String: [String]]) {

    print("\n")
    print("====================================================")
    print("                 BFS (QUEUE)")
    print("====================================================")

    var queue = [start]
    var visited: Set<String> = [start]
    var step = 1

    while !queue.isEmpty {

        print("\n---------------- STEP \(step) ----------------")

        print("Queue Before Remove : \(queue)")

        let node = queue.removeFirst()

        print("removeFirst() -> \(node)")
        print("Visit Node    -> \(node)")

        guard let neighbours = graph[node] else {
            continue
        }

        print("Neighbours    -> \(neighbours)")

        for neighbour in neighbours {

            if !visited.contains(neighbour) {

                print("visited.insert(\(neighbour))")
                visited.insert(neighbour)

                print("queue.append(\(neighbour))")
                queue.append(neighbour)

                print("Queue         -> \(queue)")
            }
        }

        print("Visited       -> \(visited)")
        step += 1
    }

    print("\nBFS Traversal Finished")
}

//==============================================================
// DFS
//==============================================================

func dfs(start: String, graph: [String: [String]]) {

    print("\n")
    print("====================================================")
    print("                 DFS (STACK)")
    print("====================================================")

    var stack = [start]
    var visited: Set<String> = [start]
    var step = 1

    while !stack.isEmpty {

        print("\n---------------- STEP \(step) ----------------")

        print("Stack Before Remove : \(stack)")

        let node = stack.removeLast()

        print("removeLast() -> \(node)")
        print("Visit Node   -> \(node)")

        guard let neighbours = graph[node] else {
            continue
        }

        print("Neighbours        -> \(neighbours)")
        print("Neighbours Reverse-> \(Array(neighbours.reversed()))")

        for neighbour in neighbours.reversed() {

            if !visited.contains(neighbour) {

                print("visited.insert(\(neighbour))")
                visited.insert(neighbour)

                print("stack.append(\(neighbour))")
                stack.append(neighbour)

                print("Stack         -> \(stack)")
            }
        }

        print("Visited       -> \(visited)")
        step += 1
    }

    print("\nDFS Traversal Finished")
}

//==============================================================
// Run
//==============================================================

bfs(start: "A", graph: graph)

print("\n")
print(String(repeating: "-", count: 60))

dfs(start: "A", graph: graph)
