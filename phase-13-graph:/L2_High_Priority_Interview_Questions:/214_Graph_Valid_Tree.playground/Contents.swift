import UIKit

//==============================================================
// 214. Graph Valid Tree
// Pattern : DFS with Cycle Detection + Connectivity Check
// Time    : O(V + E)
// Space   : O(V + E)
//==============================================================
// PROBLEM:
// A valid tree must satisfy THREE conditions:
// 1. Exactly n-1 edges (no extra edges)
// 2. No cycles (undirected graph)
// 3. All nodes connected (no isolated components)
//==============================================================

class Solution {
    
    func validTree(_ n: Int, edges: [[Int]]) -> Bool {
        
        //----------------------------------------------------
        // STEP 1: Edge Count Check (Tree Property #1)
        //----------------------------------------------------
        // A tree with n nodes must have EXACTLY n-1 edges.
        // More edges → cycle. Fewer edges → disconnected.
        print("====================================")
        print("STEP 1: Edge Count Validation")
        print("====================================")
        
        print("Number of Nodes: \(n)")
        print("Number of Edges: \(edges.count)")
        print("Expected Edges: \(n - 1)")
        
        if edges.count != n - 1 {
            print("❌ INVALID: Edge count mismatch")
            return false
        }
        
        print("✓ Edge count is valid\n")
        
        //----------------------------------------------------
        // STEP 2: Build Adjacency List (Undirected Graph)
        //----------------------------------------------------
        print("====================================")
        print("STEP 2: Build Adjacency List")
        print("====================================")
        
        var graph = Array(repeating: [Int](), count: n)
        
        for edge in edges {
            let node1 = edge[0]
            let node2 = edge[1]
            
            print("Edge: \(node1) -- \(node2)")
            
            graph[node1].append(node2)
            graph[node2].append(node1)
        }
        
        print()
        print("Graph Adjacency List:")
        for (node, neighbors) in graph.enumerated() {
            print("  Node \(node): \(neighbors)")
        }
        
        //----------------------------------------------------
        // STEP 3: Initialize Visited Array
        //----------------------------------------------------
        print()
        print("====================================")
        print("STEP 3: Initialize Tracking")
        print("====================================")
        
        var visited = Array(repeating: false, count: n)
        print("Visited Array: \(visited)")
        
        //----------------------------------------------------
        // STEP 4: Define DFS with Parent Tracking (Guard Statements)
        //----------------------------------------------------
        print()
        print("====================================")
        print("STEP 4: DFS with Cycle Detection")
        print("====================================")
        
        func dfs(_ node: Int, _ parent: Int) -> Bool {
            
            visited[node] = true
            print()
            print("Visit Node \(node) (from parent: \(parent))")
            
            for neighbor in graph[node] {
                // Guard: Skip parent edge
                guard neighbor != parent else {
                    print("  Check Neighbor: \(neighbor)")
                    print("    → Parent edge (skip)")
                    continue
                }
                
                // Guard: Cycle Detection
                guard !visited[neighbor] else {
                    print("  Check Neighbor: \(neighbor)")
                    print("    → Already visited: CYCLE DETECTED!")
                    return false
                }
                
                // Continue DFS to unvisited neighbor
                print("  Check Neighbor: \(neighbor)")
                print("    → Unvisited: continue DFS")
                if !dfs(neighbor, node) { return false }
            }
            
            return true
        }
        
        //----------------------------------------------------
        // STEP 5: Start DFS from Node 0
        //----------------------------------------------------
        print()
        print("====================================")
        print("STEP 5: Run DFS from Node 0")
        print("====================================")
        
        if !dfs(0, -1) {
            print()
            print("Result: ❌ CYCLE DETECTED")
            return false
        }
        
        print()
        print("Result: ✓ No cycles found")
        
        //----------------------------------------------------
        // STEP 6: Connectivity Check (Tree Property #3)
        //----------------------------------------------------
        print()
        print("====================================")
        print("STEP 6: Verify All Nodes Visited")
        print("====================================")
        print("Final Visited: \(visited)")
        
        for node in 0..<n {
            if !visited[node] {
                print("Result: ❌ DISCONNECTED - Node \(node) unreachable")
                return false
            }
        }
        
        print("Result: ✓ All nodes connected")
        
        //----------------------------------------------------
        // STEP 7: Return True (Valid Tree)
        //----------------------------------------------------
        print()
        print("====================================")
        print("STEP 7: Final Result")
        print("====================================")
        print("✅ VALID TREE")
        print("- Exactly n-1 edges")
        print("- No cycles detected")
        print("- All nodes connected")
        
        return true
    }
}

//==============================================================
// MARK: Test Case 1 — Valid Tree
//==============================================================
print("TEST CASE 1: Valid Tree (5 Nodes, 4 Edges)")
print("=========================\n")

let result1 = Solution().validTree(5, edges: [
    [0, 1],
    [0, 2],
    [0, 3],
    [1, 4]
])

print()
print("=========================")
print("Result: \(result1) (Expected: true)")
print("=========================")

//==============================================================
// MARK: Test Case 2 — Cycle Detected
//==============================================================
print("\n\nTEST CASE 2: Cycle Detected (5 Nodes, 5 Edges)")
print("=========================\n")

let result2 = Solution().validTree(5, edges: [
    [0, 1],
    [1, 2],
    [2, 3],
    [1, 3],  // ← Creates cycle: 1-2-3-1
    [0, 2]
])

print()
print("=========================")
print("Result: \(result2) (Expected: false)")
print("=========================")

//==============================================================
// MARK: Test Case 3 — Disconnected Graph
//==============================================================
print("\n\nTEST CASE 3: Disconnected Graph (4 Nodes, 2 Edges)")
print("=========================\n")

let result3 = Solution().validTree(4, edges: [
    [0, 1],
    [2, 3]
    // Node 0,1 connected; Node 2,3 connected; but two separate components
])

print()
print("=========================")
print("Result: \(result3) (Expected: false)")
print("=========================")

//==============================================================
// MARK: Test Case 4 — Single Node
//==============================================================
print("\n\nTEST CASE 4: Single Node (1 Node, 0 Edges)")
print("=========================\n")

let result4 = Solution().validTree(1, edges: [])

print()
print("=========================")
print("Result: \(result4) (Expected: true)")
print("=========================")

//==============================================================
// MARK: Test Case 5 — Incorrect Edge Count
//==============================================================
print("\n\nTEST CASE 5: Wrong Edge Count (3 Nodes, 3 Edges)")
print("=========================\n")

let result5 = Solution().validTree(3, edges: [
    [0, 1],
    [1, 2],
    [0, 2]  // Too many edges for 3 nodes
])

print()
print("=========================")
print("Result: \(result5) (Expected: false)")
print("=========================")
