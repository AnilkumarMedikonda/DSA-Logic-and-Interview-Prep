import Foundation

//==============================================================
// 219. Min Cost To Connect All Points
// Pattern : Kruskal's Algorithm (Minimum Spanning Tree)
// Time    : O(N^2 * log N)
// Space   : O(N^2)
//==============================================================
// PROBLEM:
// You are given N points on a 2D plane. You need to connect all
// points with minimum total cost. The cost between two points is
// Manhattan Distance: |x1 - x2| + |y1 - y2|
// Find minimum cost to connect all points (MST).
//==============================================================

class Solution {
    
    func minimumCost(_ points: [[Int]]) -> Int {
        
        print("====================================")
        print("STEP 1: Calculate All Distances")
        print("====================================")
        
        let n = points.count
        var edges = [(cost: Int, u: Int, v: Int)]()
        
        for i in 0..<n {
            for j in i + 1..<n {
                let x1 = points[i][0], y1 = points[i][1]
                let x2 = points[j][0], y2 = points[j][1]
                let distance = abs(x1 - x2) + abs(y1 - y2)
                edges.append((distance, i, j))
            }
        }
        
        print("Points: \(n)")
        print("Edges: \(edges.count)")
        
        print()
        print("====================================")
        print("STEP 2: Sort Edges by Cost")
        print("====================================")
        
        edges.sort { $0.cost < $1.cost }
        print("Edges sorted (min cost first)")
        
        print()
        print("====================================")
        print("STEP 3: Union-Find Kruskal's")
        print("====================================")
        
        var parent = Array(0..<n)
        var rank = Array(repeating: 0, count: n)
        var totalCost = 0
        var edgesUsed = 0
        
        func find(_ x: Int) -> Int {
            if parent[x] != x {
                parent[x] = find(parent[x])
            }
            return parent[x]
        }
        
        func union(_ x: Int, _ y: Int) -> Bool {
            let rootX = find(x)
            let rootY = find(y)
            
            if rootX == rootY { return false }
            
            if rank[rootX] < rank[rootY] {
                parent[rootX] = rootY
            } else if rank[rootX] > rank[rootY] {
                parent[rootY] = rootX
            } else {
                parent[rootY] = rootX
                rank[rootX] += 1
            }
            
            return true
        }
        
        for (cost, u, v) in edges {
            if union(u, v) {
                totalCost += cost
                edgesUsed += 1
                print("Add edge (\(u), \(v)): cost \(cost)")
                
                if edgesUsed == n - 1 { break }
            }
        }
        
        print()
        print("====================================")
        print("STEP 4: Result")
        print("====================================")
        print("Total edges used: \(edgesUsed)")
        print("Total cost: \(totalCost)")
        
        return totalCost
    }
}

// Test Case 1
print("\n\nTEST CASE 1: Simple Triangle")
print("=========================\n")

let solution1 = Solution()
let result1 = solution1.minimumCost([[0, 0], [2, 2], [3, 10], [5, 2], [7, 0]])

print()
print("=========================")
print("Output: \(result1)")
print("=========================")

// Test Case 2
print("\n\nTEST CASE 2: Square")
print("=========================\n")

let solution2 = Solution()
let result2 = solution2.minimumCost([[0, 0], [1, 1], [1, 0], [0, 1]])

print()
print("=========================")
print("Output: \(result2)")
print("=========================")

// Test Case 3
print("\n\nTEST CASE 3: Two Points")
print("=========================\n")

let solution3 = Solution()
let result3 = solution3.minimumCost([[0, 0], [1, 1]])

print()
print("=========================")
print("Output: \(result3)")
print("=========================")
