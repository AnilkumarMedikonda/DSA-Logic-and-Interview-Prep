import UIKit

//==================================================
// 203. Graph Representation
//==================================================

/*
High Level Notes

Graph = Vertices (Nodes) + Edges (Connections)

Vertex   = Node
Edge     = Connection
Neighbor = Connected Node

Graph Types
1. Undirected Graph (u ↔ v)
2. Directed Graph (u → v)

Graph Representation
1. Adjacency List ✅ (Most Used)
2. Adjacency Matrix

Interview Rules

Edges = Count(edges)

Vertices =
    If n is given
        vertices = n
    Else
        Highest Node + 1

Undirected Graph
u → v
v → u

graph[u].append(v)
graph[v].append(u)

Directed Graph
u → v

graph[u].append(v)

Time Complexity  : O(E)
Space Complexity : O(V + E)

Use Cases

Undirected
- Facebook Friends
- Two-way Road
- Network Connection

Directed
- Instagram Follow
- One-way Road
- Course Prerequisites
*/

//==================================================
// Input
//==================================================

let vertices = 4

let edges = [
    [0,1],
    [0,2],
    [1,2],
    [2,3]
]

//==================================================
// Undirected Graph (u ↔ v)
//==================================================

var undirectedGraph = [[Int]]()

for _ in 0..<vertices {
    undirectedGraph.append([])
}

for edge in edges {

    let u = edge[0]
    let v = edge[1]

    undirectedGraph[u].append(v)
    undirectedGraph[v].append(u)
}

print("Undirected Graph")

for i in 0..<vertices {
    print("\(i) -> \(undirectedGraph[i])")
}

//==================================================
// Directed Graph (u → v)
//==================================================

var directedGraph = [[Int]]()

for _ in 0..<vertices {
    directedGraph.append([])
}

for edge in edges {

    let u = edge[0]
    let v = edge[1]

    directedGraph[u].append(v)
}

print("\nDirected Graph")

for i in 0..<vertices {
    print("\(i) -> \(directedGraph[i])")
}

/*
==================================================
Output

Undirected Graph

0 -> [1, 2]
1 -> [0, 2]
2 -> [0, 1, 3]
3 -> [2]

Directed Graph

0 -> [1, 2]
1 -> [2]
2 -> [3]
3 -> []

==================================================
*/
