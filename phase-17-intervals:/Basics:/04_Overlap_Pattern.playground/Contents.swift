import Foundation

/*
====================================================
            04_Overlap_Pattern.swift
====================================================

The OVERLAP pattern — core of LC 435, Meeting Rooms I & II.

Different question from merging:
- Merge asks:   "combine the overlappers into one"
- Overlap asks: "do they overlap? count them / remove them"

Sort by END for the greedy version:
keep the interval that ends EARLIEST → leaves the
most room for everything after (Phase 16's activity
selection, now on real intervals!)
*/

final class OverlapPattern {
    
    func start() {
        
        print("========== Overlap Pattern ==========")
        print()
        
        detectOverlap([[1, 3], [2, 6], [8, 10]])
        print()
        countRemovals([[1, 2], [2, 3], [3, 4], [1, 3]])
    }
    
    // ------------------------------------------------
    // 1. Detect ANY overlap (Meeting Rooms I shape)
    // Sorted by START — neighbors only
    // ------------------------------------------------
    func detectOverlap(_ intervals: [[Int]]) {
        
        let sorted = intervals.sorted { a, b in
            a[0] < b[0]
        }
        
        print("--- Detect any overlap ---")
        print("Sorted by start -> \(sorted)")
        print()
        
        var i = 1
        while i < sorted.count {
            
            let previous = sorted[i - 1]
            let current = sorted[i]
            
            if current[0] < previous[1] {
                print("👉 OVERLAP: [\(current[0]), \(current[1])] starts before [\(previous[0]), \(previous[1])] ends")
            } else {
                print("⊘ OK: [\(current[0]), \(current[1])] starts at/after \(previous[1])")
            }
            
            i += 1
        }
    }
    
    // ------------------------------------------------
    // 2. Minimum removals (LC 435 shape)
    // Sort by END — greedy keep earliest-ending
    // ------------------------------------------------
    func countRemovals(_ intervals: [[Int]]) {
        
        let sorted = intervals.sorted { a, b in
            a[1] < b[1]
        }
        
        print("--- Minimum removals for zero overlap ---")
        print("Sorted by END -> \(sorted)")
        print()
        
        var removals = 0
        var lastEnd = sorted[0][1]
        
        print("Keep \(sorted[0]) — first end \(lastEnd)")
        
        var i = 1
        while i < sorted.count {
            
            let current = sorted[i]
            
            if current[0] < lastEnd {
                // Overlaps what we kept → REMOVE current
                // (current ends later or equal — sorted by end —
                //  so removing IT is always the safe greedy choice)
                removals += 1
                print("👉 Remove [\(current[0]), \(current[1])] — starts before \(lastEnd)")
            } else {
                // No overlap → keep it, advance the boundary
                lastEnd = current[1]
                print("⊘ Keep [\(current[0]), \(current[1])] — new boundary \(lastEnd)")
            }
            
            i += 1
        }
        
        print()
        print("✅ Minimum removals -> \(removals)")
    }
}

// MARK: - Run
let demo = OverlapPattern()
demo.start()

/*
====================================================
Output — removals input [[1,2],[2,3],[3,4],[1,3]]:

Sorted by END -> [[1, 2], [2, 3], [1, 3], [3, 4]]

Keep [1, 2] — first end 2
⊘ Keep [2, 3] — new boundary 3
👉 Remove [1, 3] — starts before 3
⊘ Keep [3, 4] — new boundary 4

✅ Minimum removals -> 1

====================================================
KEY POINTS
====================================================
1. STRICT < here: current[0] < lastEnd is overlap.
   [1,2] and [2,3] TOUCH but don't overlap — touching
   is fine for scheduling (LC 435 / Meeting Rooms).
   Compare with MERGE where <= combined touchers!
2. Sort by END + keep earliest-ending = Phase 16's
   exchange argument: the earliest end can never
   block MORE future intervals than a later end
3. When overlap found, remove CURRENT (the one
   sorted later = ends later-or-equal) — and note
   lastEnd does NOT advance on a removal
4. Two questions, two conditions:
   Merge (LC 56):     <=  (touchers combine)
   Schedule (LC 435): <   (touchers coexist)
   Mixing these up is THE off-by-one of this phase
====================================================
*/
