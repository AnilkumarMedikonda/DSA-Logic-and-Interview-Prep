import Foundation

//==============================================================
// 216. Redundant Connection
// Pattern : Union-Find (Disjoint Set Union)
// Time    : O(N * α(N)) where α is inverse Ackermann (nearly O(N))
// Space   : O(N)
//==============================================================
// PROBLEM:
// Given edges that form a tree with ONE extra edge (creating cycle)
// Find and return the redundant edge that creates the cycle
//==============================================================

class Solution {
    
    func findRedundantConnection(_ edges: [[Int]]) -> [Int] {
        
        print("====================================")
        print("STEP 1: Initialize Union-Find")
        print("====================================")
        
        let n = edges.count
        var parent = Array(0..<n + 1)
        var rank = Array(repeating: 0, count: n + 1)
        
        print("Edges: \(edges.count)")
        print("Parent initialized: [0, 1, 2, ..., \(n)]")
        
        //----------------------------------------------------
        // STEP 2: Helper Functions
        //----------------------------------------------------
        // Find with path compression
        func find(_ x: Int) -> Int {
            if parent[x] != x {
                parent[x] = find(parent[x])
            }
            return parent[x]
        }
        
        // Union with rank optimization
        func union(_ x: Int, _ y: Int) -> Bool {
            let rootX = find(x)
            let rootY = find(y)
            
            if rootX == rootY {
                return false  // Already in same set → cycle!
            }
            
            // Union by rank
            if rank[rootX] < rank[rootY] {
                parent[rootX] = rootY
            } else if rank[rootX] > rank[rootY] {
                parent[rootY] = rootX
            } else {
                parent[rootY] = rootX
                rank[rootX] += 1
            }
            
            return true  // Successfully united
        }
        
        print()
        print("====================================")
        print("STEP 3: Process Edges")
        print("====================================")
        
        //----------------------------------------------------
        // STEP 3: Process Each Edge
        //----------------------------------------------------
        for (index, edge) in edges.enumerated() {
            let u = edge[0]
            let v = edge[1]
            
            print("Edge \(index + 1): [\(u), \(v)]")
            
            if !union(u, v) {
                print("  ❌ Cycle detected! Both already connected")
                print()
                print("====================================")
                print("STEP 4: Result")
                print("====================================")
                print("Redundant edge: [\(u), \(v)]")
                return [u, v]
            }
            
            print("  ✓ Successfully connected")
        }
        
        return []
    }
}

//==============================================================
// MARK: Test Case 1 — Simple Cycle
//==============================================================
print("\n\nTEST CASE 1: Simple Cycle")
print("=========================\n")

let solution1 = Solution()
let result1 = solution1.findRedundantConnection([[1, 2], [1, 3], [2, 3]])

print()
print("=========================")
print("Output: \(result1)")
print("Expected: [2, 3]")
print("=========================")

//==============================================================
// MARK: Test Case 2 — Linear Then Extra
//==============================================================
print("\n\nTEST CASE 2: Linear Then Extra")
print("=========================\n")

let solution2 = Solution()
let result2 = solution2.findRedundantConnection([[1, 2], [2, 3], [3, 4], [1, 4], [1, 5]])

print()
print("=========================")
print("Output: \(result2)")
print("Expected: [1, 4]")
print("=========================")

//==============================================================
// MARK: Test Case 3 — Back to Start
//==============================================================
print("\n\nTEST CASE 3: Back to Start")
print("=========================\n")

let solution3 = Solution()
let result3 = solution3.findRedundantConnection([[1, 2], [2, 3], [3, 1]])

print()
print("=========================")
print("Output: \(result3)")
print("Expected: [3, 1]")
print("=========================")

//==============================================================
// MARK: Test Case 4 — Large Number
//==============================================================
print("\n\nTEST CASE 4: Large Number")
print("=========================\n")

let solution4 = Solution()
let result4 = solution4.findRedundantConnection([[1, 2], [2, 3], [3, 4], [4, 5], [5, 6], [6, 7], [7, 8], [8, 9], [9, 10], [5, 10]])

print()
print("=========================")
print("Output: \(result4)")
print("Expected: [5, 10]")
print("=========================")

//==============================================================
// MARK: Test Case 5 — Triangle at End
//==============================================================
print("\n\nTEST CASE 5: Triangle at End")
print("=========================\n")

let solution5 = Solution()
let result5 = solution5.findRedundantConnection([[1, 2], [1, 3], [2, 4], [3, 4]])

print()
print("=========================")
print("Output: \(result5)")
print("Expected: [3, 4]")
print("=========================")
