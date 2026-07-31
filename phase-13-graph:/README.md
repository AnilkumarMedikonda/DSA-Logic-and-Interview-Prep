# Phase 13 — Graphs (Problems 203–219)

Swift solutions for the Graph phase of my DSA roadmap. Every problem includes
step-by-step comments, debug logs, traps, and tests. Covers all five core
graph algorithms: DFS/BFS, Topological Sort, Union-Find, Dijkstra's, and
Kruskal's.


## Problems

| # | Problem | LeetCode | Approach | Complexity |
|---|---------|----------|----------|------------|
| 203 | Graph Representation | — | Adjacency list from edge list, undirected | O(V + E) |
| 204 | DFS Traversal | — | Recursive DFS with visited array | O(V + E) |
| 205 | BFS Traversal | — | Iterative BFS with queue + visited | O(V + E) |
| 206 | Connected Components | — | DFS outer loop, count kickoffs | O(V + E) |
| 207 | Number of Islands ⭐ | LC 200 | Grid DFS/BFS flood fill, sink visited cells | O(R × C) |
| 208 | Clone Graph ⭐ | LC 133 | DFS + visited map (old → clone) | O(V + E) |
| 209 | Rotting Oranges ⭐ | LC 994 | Multi-source BFS, level = minutes | O(R × C) |
| 210 | Course Schedule II ⭐ | LC 210 | Topological Sort — Kahn's Algorithm (BFS) | O(V + E) |
| 211 | Pacific Atlantic Water Flow ⭐ | LC 417 | Reverse DFS from ocean edges, intersect | O(R × C) |
| 212 | Course Schedule ⭐ | LC 207 | Topological Sort / Cycle detection | O(V + E) |
| 213 | Connected Components ⭐ | LC 323 | DFS outer loop / Union-Find | O(V + E) |
| 214 | Graph Valid Tree ⭐ | LC 261 | DFS + parent tracking + connectivity check | O(V + E) |
| 215 | Alien Dictionary ⭐ | LC 269 | Build directed graph from word pairs, topological sort | O(N × L + U + E) |
| 216 | Redundant Connection ⭐ | LC 684 | Union-Find with path compression + union by rank | O(N × α(N)) |
| 217 | Word Ladder ⭐ | LC 127 | BFS shortest path, pattern-based neighbor mapping | O(N × L²) |
| 218 | Network Delay Time ⭐ | LC 743 | Dijkstra's Algorithm, return max distance | O((V + E) log V) |
| 219 | Min Cost to Connect Points ⭐ | LC 1584 | Kruskal's MST, Manhattan distance, Union-Find | O(N² log N) |

## Core Patterns

- **DFS/BFS flood fill** — mark visited, explore neighbors, count components
  or measure spread; grid problems (207, 209, 211) treat cells as nodes and
  four-directional adjacency as edges
- **Topological Sort (Kahn's)** — track in-degrees, seed queue with zero-degree
  nodes, peel layer by layer; if result < total nodes → cycle (210, 212, 215)
- **Union-Find (DSU)** — `find()` with path compression, `union()` with rank;
  same-root check = cycle detection; one data structure solves components (213),
  tree validation (214), redundancy (216), and MST (219)
- **Parent tracking in undirected DFS** — skip the edge you came from to avoid
  false cycle detection; `if neighbor == parent { continue }` before the visited
  check (214)
- **Reverse DFS from boundaries** — instead of checking if every cell reaches
  the ocean, start from the ocean and flow uphill; intersect two visited sets (211)
- **BFS = shortest path in unweighted graphs** — level-by-level expansion
  guarantees minimum steps; DFS does NOT (217)
- **Pattern-based neighbor mapping** — replace each character with `*` to group
  words by wildcard; `"h*t"` maps `[hit, hot]` — avoids O(N²) pairwise
  comparison (217)
- **Dijkstra's greedy relaxation** — always process the closest unvisited node;
  update neighbor distances if shorter path found; works only with positive
  weights (218)
- **Kruskal's MST** — sort all edges by cost, greedily add cheapest edge that
  doesn't create a cycle (Union-Find check); stop at N-1 edges (219)
- **Interview ladders** — DFS → BFS → Topological Sort → Union-Find →
  Dijkstra's → Kruskal's; each builds on the previous

## Traps Logged This Phase

- `removeLast()` turns BFS into DFS — use manual head pointer or `removeFirst()`
  for FIFO; shortest path guarantee silently breaks (217)
- Missing `dfs(node)` call in outer loop counts nodes instead of components —
  visited array stays all false, returns N instead of actual count (213)
- Nesting BFS inside the graph-building loop runs the entire search N times
  with an incomplete graph each iteration (217)
- Calling `dfs()` in both branches of `if !visited` / `else` makes the
  condition pointless and risks infinite recursion (213)
- Undirected graph without parent tracking reports a cycle on every single
  edge — the bidirectional edge back to parent is not a real cycle (214)
- `count += 1` goes in the outer loop BEFORE `dfs()`, not inside `dfs()` —
  inside counts every node, not every component (206, 213)
- Isolated nodes in dictionary-backed graphs: `for node in graph.keys` skips
  nodes with no edges; array-backed graphs keep the empty bucket (206)
- String tuple interpolation `\(word, 1)` fails in Swift — interpolate
  elements separately `(\(word), 1)` (217)
- Edge count validation for trees: exactly `n - 1` edges required; more →
  cycle, fewer → disconnected (214)
- Duplicate edges in pattern graph: check `!graph[char].contains(neighbor)`
  before adding to avoid inflated in-degree counts (215)

## House Rules

- No force unwraps; `if let / guard let` everywhere
- No `?? 0` nil-coalescing — explicit `if let / else` for dictionary operations
- Guard statements for early exits and validation
- `while let` for condition-driven walks; `let` over `var` where possible
- Debug prints at key decision points, not every line
- Step-by-step structure with clear section headers

**Status:** ✅ Complete — closed Jul 31, 2026
