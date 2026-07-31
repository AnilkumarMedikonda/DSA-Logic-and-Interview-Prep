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
// BFS
//==============================================================

func bfs(start: String, graph: [String: [String]]) {

    var queue = [start]
    var visited: Set<String> = [start]

    var step = 1

    print("========== BFS ==========")

    while !queue.isEmpty {

        print("\n---------------- STEP \(step) ----------------")

        print("Queue Before Remove : \(queue)")
        print("Visited             : \(visited)")

        let node = queue.removeFirst()

        print("removeFirst() ---> \(node)")
        print("Visit Node      ---> \(node)")

        guard let neighbours = graph[node] else {
            continue
        }

        print("Neighbours      ---> \(neighbours)")

        for neighbour in neighbours {

            if !visited.contains(neighbour) {

                print("visited.insert(\(neighbour))")
                visited.insert(neighbour)

                print("queue.append(\(neighbour))")
                queue.append(neighbour)

                print("Queue Now       ---> \(queue)")
            }
        }

        step += 1
    }

    print("\n========== BFS Finished ==========")
}

//==============================================================
// Run
//==============================================================

bfs(start: "A", graph: graph)
