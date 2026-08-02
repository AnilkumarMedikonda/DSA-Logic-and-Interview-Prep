import Foundation

/*
====================================================
            03_Merge_Pattern.swift
====================================================

The MERGE pattern — the core loop of LC 56 and 57.

After sorting by START, walk once:
- OVERLAP  → extend the last merged interval's end
- NO overlap → push current as a new interval

The one condition (from file 02):
    current[0] <= last merged end  →  overlap

The one action:
    end = max(both ends)   ← max, not just current's end!
*/

final class MergePattern {
    
    func start() {
        
        let intervals = [[1, 3], [2, 6], [8, 10], [15, 18]]
        
        print("========== Merge Pattern ==========")
        print()
        print("Input -> \(intervals)  (already sorted by start)")
        print()
        
        merge(intervals)
        
        print()
        print("--- Trap input: contained interval ---")
        print()
        merge([[1, 10], [2, 3], [12, 14]])
    }
    
    func merge(_ intervals: [[Int]]) {
        
        var merged = [[Int]]()
        
        // First interval always starts the result
        merged.append(intervals[0])
        print("Start with \(intervals[0])")
        print()
        
        var i = 1
        while i < intervals.count {
            
            let current = intervals[i]
            let lastIndex = merged.count - 1
            let lastEnd = merged[lastIndex][1]
            
            if current[0] <= lastEnd {
                
                // OVERLAP → extend the end (max of both!)
                let newEnd = max(lastEnd, current[1])
                
                print("👉 [\(current[0]), \(current[1])] overlaps (start \(current[0]) <= end \(lastEnd))")
                print("   Extend end: \(lastEnd) → \(newEnd)")
                
                merged[lastIndex][1] = newEnd
                
            } else {
                
                // GAP → current becomes a new merged interval
                print("⊘ [\(current[0]), \(current[1])] no overlap (start \(current[0]) > end \(lastEnd))")
                print("   Push as new interval")
                
                merged.append(current)
            }
            
            print("   Merged so far -> \(merged)")
            print()
            
            i += 1
        }
        
        print("✅ Result -> \(merged)")
    }
}

// MARK: - Run
let demo = MergePattern()
demo.start()

/*
====================================================
Output — main input:

Start with [1, 3]

👉 [2, 6] overlaps (start 2 <= end 3)
   Extend end: 3 → 6
   Merged so far -> [[1, 6]]

⊘ [8, 10] no overlap (start 8 > end 6)
   Push as new interval
   Merged so far -> [[1, 6], [8, 10]]

⊘ [15, 18] no overlap (start 15 > end 10)
   Push as new interval

✅ Result -> [[1, 6], [8, 10], [15, 18]]

Trap input [[1,10],[2,3],[12,14]]:
[2,3] overlaps [1,10] → newEnd = max(10, 3) = 10 ✓
Without max(): end would SHRINK to 3, and [12,14]
would wrongly... stay separate here, but shrinking
corrupts later comparisons. max() is load-bearing.

====================================================
KEY POINTS
====================================================
1. Compare against the LAST MERGED interval, not
   the previous input interval — after a merge they
   differ, and using the wrong one drops overlaps
2. end = max(lastEnd, current[1]) — the contained
   interval [[1,10],[2,3]] is WHY; current's end
   can be SMALLER than what's already merged
3. Mutate in place: merged[lastIndex][1] = newEnd —
   Swift arrays of arrays allow direct element writes
4. First interval seeds the result — the loop then
   only ever asks: extend or push?
====================================================
*/

