import Foundation

// 231_Non_Overlapping_Intervals

/*
====================================================
        231_Non_Overlapping_Intervals.swift
====================================================

Problem:
Return the MINIMUM number of intervals to REMOVE
so the rest don't overlap.

Input:
[[1,2],[2,3],[3,4],[1,3]] → 1   (remove [1,3])
[[1,2],[1,2],[1,2]]       → 2   (remove two copies)
[[1,2],[2,3]]             → 0   (touching is FINE!)

Key Idea:
Sort by END + greedy keep-earliest-ending
(Phase 16 activity selection on real intervals).
Min removals = total − max keepable.

The condition flip vs Merge (229):
Merge:    next[0] <= end  → overlap (touchers combine)
Here:     next[0] <  end  → overlap (touchers coexist!)

When overlap found:
- remove CURRENT (sorted by end → it ends later-or-equal,
  keeping the earlier end can never block more)
- lastEnd does NOT advance on a removal

====================================================
Time Complexity : O(n log n)
====================================================
- Sort dominates; the pass is O(n)

====================================================
Space Complexity : O(1)
====================================================
- Two variables beyond the sorted copy
====================================================
*/

final class Solution {
    
    func eraseOverlapIntervals(_ intervals: [[Int]]) -> Int {
        
        // Edge case: 0 or 1 interval → nothing can overlap
        if intervals.count <= 1 {
            return 0
        }
        
        // ------------------------
        // STEP 1 : Sort by END — the greedy strategy
        // ------------------------
        let sorted = intervals.sorted { $0[1] < $1[1] }
        
        print("Sorted by END -> \(sorted)")
        print()
        
        var removals = 0
        var lastEnd = sorted[0][1]
        
        print("Keep \(sorted[0]) — boundary \(lastEnd)")
        
        var i = 1
        
        while i < sorted.count {
            
            let current = sorted[i]
            
            if current[0] < lastEnd {
                
                // ------------------------
                // STEP 2a : OVERLAP → remove current
                // lastEnd does NOT move — we keep the
                // earlier-ending interval
                // ------------------------
                removals += 1
                print("👉 Remove \(current) — starts \(current[0]) < boundary \(lastEnd)")
                
            } else {
                
                // ------------------------
                // STEP 2b : No overlap → keep, advance boundary
                // ------------------------
                lastEnd = current[1]
                print("⊘ Keep \(current) — new boundary \(lastEnd)")
            }
            
            i += 1
        }
        
        print()
        print("✅ Minimum removals -> \(removals)")
        return removals
    }
}

// MARK: - Run
let solution = Solution()

print("========== Test 1 ==========")
print()
print(solution.eraseOverlapIntervals([[1, 2], [2, 3], [3, 4], [1, 3]]))
// 1
print()

print("========== Test 2: duplicates ==========")
print()
print(solution.eraseOverlapIntervals([[1, 2], [1, 2], [1, 2]]))
// 2
print()

print("========== Test 3: touching ==========")
print()
print(solution.eraseOverlapIntervals([[1, 2], [2, 3]]))
// 0
