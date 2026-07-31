import Foundation

//==============================================================
// 218. Network Delay Time
// Pattern : Dijkstra's Algorithm (Shortest Path)
// Time    : O((N + E) * log N) with min-heap
// Space   : O(N + E)
//==============================================================
// PROBLEM:
// Given N nodes, weighted edges (time), signal starts at node K
// Find minimum time for all nodes to receive the signal
// Return time when last node receives signal, or -1 if unreachable
//==============================================================

class Solution {
    
    func networkDelayTime(_ times: [[Int]], _ n: Int, _ k: Int) -> Int {
        
        print("====================================")
        print("STEP 1: Build Weighted Graph")
        print("====================================")
        
        var graph = [Int: [(node: Int, time: Int)]]()
        
        for time in times {
            let from = time[0]
            let to = time[1]
            let delay = time[2]
            
            if graph[from] == nil {
                graph[from] = []
            }
            graph[from]!.append((to, delay))
        }
        
        print("Graph nodes: \(n)")
        print("Signal source: node \(k)")
        print("Edges: \(times.count)")
        
        print()
        print("====================================")
        print("STEP 2: Dijkstra's Algorithm")
        print("====================================")
        
        var distances = Array(repeating: Int.max, count: n + 1)
        distances[k] = 0
        
        var visited = Set<Int>()
        var pq = [(node: Int, dist: Int)]()
        pq.append((k, 0))
        
        while !pq.isEmpty {
            // Get node with minimum distance
            pq.sort { $0.dist < $1.dist }
            let (currentNode, currentDist) = pq.removeFirst()
            
            if visited.contains(currentNode) { continue }
            visited.insert(currentNode)
            
            print("Process node \(currentNode) (distance: \(currentDist))")
            
            // Relax edges
            if let neighbors = graph[currentNode] {
                for (neighbor, delay) in neighbors {
                    let newDist = currentDist + delay
                    
                    if newDist < distances[neighbor] {
                        distances[neighbor] = newDist
                        pq.append((neighbor, newDist))
                        print("  Update node \(neighbor): \(newDist)")
                    }
                }
            }
        }
        
        print()
        print("====================================")
        print("STEP 3: Find Maximum Distance")
        print("====================================")
        
        var maxTime = 0
        for i in 1...n {
            if distances[i] == Int.max {
                print("❌ Node \(i) unreachable")
                return -1
            }
            maxTime = max(maxTime, distances[i])
        }
        
        print("Distances: \(Array(distances[1...n]))")
        print("Maximum delay: \(maxTime)")
        
        return maxTime
    }
}

//==============================================================
// MARK: Test Case 1 — Simple Network
//==============================================================
print("\n\nTEST CASE 1: Simple Network")
print("=========================\n")

let solution1 = Solution()
let result1 = solution1.networkDelayTime(
    [[1, 2, 1], [2, 3, 2], [1, 3, 4]],
    3,
    1
)

print()
print("=========================")
print("Output: \(result1)")
print("Expected: 4 (1→2→3 takes 1+2=3, 1→3 takes 4)")
print("=========================")

//==============================================================
// MARK: Test Case 2 — All Nodes Directly Connected
//==============================================================
print("\n\nTEST CASE 2: All Directly Connected")
print("=========================\n")

let solution2 = Solution()
let result2 = solution2.networkDelayTime(
    [[1, 2, 1], [1, 3, 1], [1, 4, 1]],
    4,
    1
)

print()
print("=========================")
print("Output: \(result2)")
print("Expected: 1 (all nodes 1 hop away)")
print("=========================")

//==============================================================
// MARK: Test Case 3 — Unreachable Node
//==============================================================
print("\n\nTEST CASE 3: Unreachable Node")
print("=========================\n")

let solution3 = Solution()
let result3 = solution3.networkDelayTime(
    [[1, 2, 1], [2, 3, 2]],
    4,
    1
)

print()
print("=========================")
print("Output: \(result3)")
print("Expected: -1 (node 4 unreachable)")
print("=========================")

//==============================================================
// MARK: Test Case 4 — Linear Chain
//==============================================================
print("\n\nTEST CASE 4: Linear Chain")
print("=========================\n")

let solution4 = Solution()
let result4 = solution4.networkDelayTime(
    [[1, 2, 5], [2, 3, 5], [3, 4, 5]],
    4,
    1
)

print()
print("=========================")
print("Output: \(result4)")
print("Expected: 15 (1→2→3→4 = 5+5+5)")
print("=========================")

//==============================================================
// MARK: Test Case 5 — Multiple Paths
//==============================================================
print("\n\nTEST CASE 5: Multiple Paths")
print("=========================\n")

let solution5 = Solution()
let result5 = solution5.networkDelayTime(
    [[1, 2, 1], [1, 3, 4], [2, 3, 2], [2, 4, 5], [3, 4, 1]],
    4,
    1
)

print()
print("=========================")
print("Output: \(result5)")
print("Expected: 6 (1→2→3→4 = 1+2+1=4, but direct 1→2→4 = 1+5=6)")
print("=========================")
