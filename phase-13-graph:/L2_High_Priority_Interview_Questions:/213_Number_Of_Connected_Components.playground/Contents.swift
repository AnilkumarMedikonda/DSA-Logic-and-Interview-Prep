import UIKit

// 213_Number_Of_Connected_Components

class Solution {
    
    func components(_ n: Int, _ edges: [[Int]]) -> Int {
        
        //----------------------------------------------------
        // STEP 1: Build Graph (Adjacency List)
        //----------------------------------------------------
        var graph = Array(repeating: [Int](), count: n)
        
        print("====================================")
        print("STEP 1: Building Graph")
        print("====================================")
        
        for edge in edges {
            let u = edge[0]
            let v = edge[1]
            
            print("Edge: \(u) -- \(v)")
            
            graph[u].append(v)
            graph[v].append(u)
        }
        
        print()
        print("Graph Adjacency List:")
        for (node, neighbors) in graph.enumerated() {
            print("  Node \(node): \(neighbors)")
        }
        
        //----------------------------------------------------
        // STEP 2: Initialize Visited Array
        //----------------------------------------------------
        var visited = Array(repeating: false, count: n)
        
        print()
        print("====================================")
        print("STEP 2: Initialize Visited Array")
        print("====================================")
        print("Initial Visited: \(visited)")
        
        //----------------------------------------------------
        // STEP 3: Define DFS Function
        //----------------------------------------------------
        func dfs(_ node: Int) {
            
            if visited[node] {
                print("  Node \(node) Already Visited - Return")
                return
            }
            
            visited[node] = true
            print("  Visit Node \(node)")
            
            for neighbor in graph[node] {
                print("   Neighbor: \(neighbor)")
                
                // BUG FIX #2: Only call dfs if NOT visited
                if !visited[neighbor] {
                    print("      Move to Node \(neighbor)")
                    dfs(neighbor)
                } else {
                    print("      Node \(neighbor) already visited")
                }
            }
        }
        
        //----------------------------------------------------
        // STEP 4: Count Components (Outer Loop)
        //----------------------------------------------------
        var componentCount = 0
        
        print()
        print("====================================")
        print("STEP 4: Count Components")
        print("====================================")
        
        for node in 0..<n {
            print()
            print("Checking Node: \(node)")
            
            if visited[node] {
                print("  Already Visited - Skip")
                continue
            }
            
            // BUG FIX #3: Increment BEFORE calling dfs
            componentCount += 1
            print("  New Component Found")
            print("  Component Count: \(componentCount)")
            
            dfs(node)
            
            print("  Component \(componentCount) Complete")
            print("  Current Visited: \(visited)")
        }
        
        //----------------------------------------------------
        // STEP 5: Return Result
        //----------------------------------------------------
        print()
        print("====================================")
        print("STEP 5: Final Result")
        print("====================================")
        print("Total Components: \(componentCount)")
        
        return componentCount
    }
}

//==============================================================
// Test Case 1
//==============================================================
print("TEST CASE 1: 5 Nodes, 2 Components")
print("=========================\n")

let n = 5
let edges = [
    [0, 1],
    [1, 2],
    [3, 4]
]

let result = Solution().components(n, edges)

print()
print("=========================")
print("ANSWER: \(result)")
print("=========================")

//==============================================================
// Test Case 2
//==============================================================
print("\n\nTEST CASE 2: 4 Nodes, 2 Components")
print("=========================\n")

let result2 = Solution().components(4, [[2, 3], [1, 2]])

print()
print("=========================")
print("ANSWER: \(result2)")
print("=========================")

//==============================================================
// Test Case 3
//==============================================================
print("\n\nTEST CASE 3: 3 Nodes, 3 Components (No Edges)")
print("=========================\n")

let result3 = Solution().components(3, [])

print()
print("=========================")
print("ANSWER: \(result3)")
print("=========================")
