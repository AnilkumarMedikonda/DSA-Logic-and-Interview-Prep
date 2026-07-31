import Foundation

// 206. Connected Components
// Phase 13 · L1_Graph_Basics

// MARK: - Problem
// Count how many separate "pieces" a graph has. Two nodes are in the same
// component if a path connects them. This is DFS from problem 204, wrapped in
// an outer loop over EVERY node — the number of times you kick off a fresh DFS
// is the number of components.
//
// Component 1:  0 --- 1
// Component 2:  2 --- 3 --- 4
// Component 3:  5            (isolated)
// Answer = 3

let vertices = 6
let edges = [[0, 1], [2, 3], [3, 4]]   // node 5 has no edges → its own component

// MARK: - Build Graph (Adjacency List)

var graph = Array(repeating: [Int](), count: vertices)

for edge in edges {
    let u = edge[0]
    let v = edge[1]
    graph[u].append(v)      // undirected → both directions
    graph[v].append(u)
}

print("Adjacency List:", graph)
// [[1], [0], [3], [2, 4], [3], []]
//                                 ^^ node 5 = empty bucket, still exists

// MARK: - DFS (floods one whole component)

// Steps:
//   1. mark node visited
//   2. for each neighbour: recurse if not yet visited
// One dfs(start) call visits EVERY node reachable from start — i.e. the
// entire component — so the outer loop then skips all of them.

func dfs(_ node: Int, _ graph: [[Int]], _ visited: inout [Bool]) {
    visited[node] = true                    // step 1

    for neighbour in graph[node] {          // step 2
        if !visited[neighbour] {
            dfs(neighbour, graph, &visited)
        }
    }
}

// MARK: - Connected Components (the outer loop)

// Steps:
//   1. visited[] all false, count = 0
//   2. walk nodes 0..<n
//   3. if a node is unvisited → it's a NEW component:
//         count += 1  (BEFORE the dfs — the kickoff IS the component)
//         dfs floods the rest of that component
//   4. already-visited nodes are skipped (some earlier dfs reached them)

func connectedComponents(_ graph: [[Int]]) -> Int {
    var visited = Array(repeating: false, count: graph.count)   // step 1
    var count = 0

    for node in 0..<graph.count {                              // step 2
        if !visited[node] {                                    // step 3
            count += 1
            dfs(node, graph, &visited)
        }
        // step 4: else skip — already part of a counted component
    }

    return count
}

// MARK: - Run

let answer = connectedComponents(graph)
print("Connected Components:", answer)   // 3

// MARK: - Dry Run
// visited = [F,F,F,F,F,F], count = 0
// node 0: unvisited → count=1 → dfs(0) marks 0,1        visited=[T,T,F,F,F,F]
// node 1: visited   → skip
// node 2: unvisited → count=2 → dfs(2) marks 2,3,4      visited=[T,T,T,T,T,F]
// node 3: visited   → skip
// node 4: visited   → skip
// node 5: unvisited → count=3 → dfs(5) marks 5          visited=[T,T,T,T,T,T]
// → 3

// MARK: - Complexity
// Time:  O(V + E) — each node visited once across ALL dfs calls, each edge once
// Space: O(V) visited + O(V) recursion stack (worst case: one long chain)

// MARK: - Traps
// 1. count += 1 goes BEFORE the dfs, in the outer loop — not inside dfs.
//    Inside dfs it would count every NODE, not every component.
// 2. Isolated node (5): with an array-backed graph it "just works" — the empty
//    bucket exists, dfs(5) marks it, count goes up. With a DICTIONARY-backed
//    graph, node 5 never got a key, so a `for node in graph.keys` loop would
//    MISS it entirely. Watch for this at 213 (same problem, may hand you a dict).
// 3. Undirected build needs both directions. One-directional append splits a
//    single component into two → wrong count.

// MARK: - Interview Q&A
// Q: BFS instead of DFS here — does the count change?
// A: No. Any full traversal floods a whole component; only visit-order differs.
// Q: What if nodes aren't 0..<n (strings, sparse ids)?
// A: visited becomes a Set, outer loop iterates the node list/keys. Same logic.
// Q: Union-Find alternative?
// A: Yes — union every edge, then count distinct roots. Near-O(V+E) with
//    path compression. That's the tool introduced at 213/214/216.
