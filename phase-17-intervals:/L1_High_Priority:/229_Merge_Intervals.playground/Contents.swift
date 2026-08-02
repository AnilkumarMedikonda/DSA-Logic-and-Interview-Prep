import Foundation

// 229_Merge_Intervals

/*
====================================================
            229_Merge_Intervals.swift
====================================================

Problem:
Given an array of intervals, merge all overlapping
intervals and return the non-overlapping result.

Input:
[[1,3],[2,6],[8,10],[15,18]]

Output:
[[1,6],[8,10],[15,18]]

Touching counts as overlapping:
[[1,4],[4,5]] → [[1,5]]

Key Idea:
1. SORT by start → overlappers become neighbors
2. Walk once with a work-in-progress `current`:
   - next[0] <= current[1] → OVERLAP → extend with max()
   - else → GAP → push current, current = next
3. Append the FINAL current after the loop —
   it never meets a gap, the input just ends

====================================================
Time Complexity : O(n log n)
====================================================
- Sort dominates
- Merge pass itself is O(n)

====================================================
Space Complexity : O(n)
====================================================
- Sorted copy + result array
- O(log n) if output isn't counted (sort stack)
====================================================
*/

final class Solution {
    
    func merge(_ intervals: [[Int]]) -> [[Int]] {
        
        // Edge case: nothing to merge
        if intervals.count <= 1 {
            return intervals
        }
        
        // ------------------------
        // STEP 1 : Sort by START
        // ------------------------
        let sorted = intervals.sorted { $0[0] < $1[0] }
        
        print("Sorted -> \(sorted)")
        print()
        
        var result = [[Int]]()
        
        // Work-in-progress interval
        var current = sorted[0]
        
        print("Start with \(current)")
        print()
        
        var i = 1
        
        while i < sorted.count {
            
            let next = sorted[i]
            
            if next[0] <= current[1] {
                
                // ------------------------
                // STEP 2a : OVERLAP → extend end
                // max() — next's end can be SMALLER
                // (contained interval [[1,10],[2,3]])
                // ------------------------
                print("👉 [\(next[0]), \(next[1])] overlaps (start \(next[0]) <= end \(current[1]))")
                current[1] = max(current[1], next[1])
                print("   Current extended -> \(current)")
                
            } else {
                
                // ------------------------
                // STEP 2b : GAP → push current, restart
                // ------------------------
                print("⊘ [\(next[0]), \(next[1])] gap (start \(next[0]) > end \(current[1]))")
                result.append(current)
                current = next
                print("   Pushed. New current -> \(current)")
            }
            
            print()
            i += 1
        }
        
        // ------------------------
        // STEP 3 : Final push
        // The last current never meets a gap —
        // without this line it's silently lost
        // ------------------------
        result.append(current)
        
        print("✅ Result -> \(result)")
        return result
    }
}

// MARK: - Run
let solution = Solution()

print("========== Test 1 ==========")
print()
print(solution.merge([[1, 3], [2, 6], [8, 10], [15, 18]]))
// [[1,6],[8,10],[15,18]]
print()

print("========== Test 2: touching ==========")
print()
print(solution.merge([[1, 4], [4, 5]]))
// [[1,5]]
print()

print("========== Test 3: contained (trap) ==========")
print()
print(solution.merge([[1, 10], [2, 3]]))
// [[1,10]]
