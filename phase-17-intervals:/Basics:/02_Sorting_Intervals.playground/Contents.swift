import Foundation

/*
====================================================
            02_Sorting_Intervals.swift
====================================================

Sorting is STEP 0 of every interval problem.
Why? After sorting, overlapping intervals become
NEIGHBORS — you only ever compare interval[i]
with interval[i-1], never all pairs.

Two sort keys, two problem families:
- Sort by START → merging problems (LC 56, 57)
- Sort by END   → scheduling/removal problems (LC 435)

This file: how to sort [[Int]] in Swift with a
custom comparator, and what each key gives you.
*/

final class SortingIntervals {
    
    func start() {
        
        let intervals = [[8, 10], [1, 3], [15, 18], [2, 6]]
        
        print("========== Sorting Intervals ==========")
        print()
        print("Unsorted -> \(intervals)")
        print()
        
        sortByStart(intervals)
        print()
        sortByEnd(intervals)
        print()
        whyItMatters(intervals)
    }
    
    // ------------------------------------------------
    // 1. Sort by START — for merging problems
    // ------------------------------------------------
    func sortByStart(_ intervals: [[Int]]) {
        
        let sorted = intervals.sorted { a, b in
            a[0] < b[0]
        }
        print("Sorted by START -> \(sorted)")
        print("→ Use for: Merge Intervals, Insert Interval")
    }
    
    // ------------------------------------------------
    // 2. Sort by END — for scheduling problems
    // ------------------------------------------------
    func sortByEnd(_ intervals: [[Int]]) {
        
        let sorted = intervals.sorted { a, b in
            a[1] < b[1]
        }
        print("Sorted by END -> \(sorted)")
        print("→ Use for: Non-Overlapping (max keep / min remove)")
    }
    
    // ------------------------------------------------
    // 3. WHY sorting matters — neighbor comparison
    // ------------------------------------------------
    func whyItMatters(_ intervals: [[Int]]) {
        
        print("--- Why sort? ---")
        print()
        print("Unsorted: is [8,10] overlapping anything?")
        print("→ must check ALL others: O(n²) pairs")
        print()
        
        let sorted = intervals.sorted { a, b in
            a[0] < b[0]
        }
        print("Sorted by start: \(sorted)")
        print("→ overlap can ONLY be with the previous one")
        print("→ single pass, compare i with i-1: O(n)")
        print()
        
        var previous = sorted[0]
        
        var i = 1
        while i < sorted.count {
            
            let current = sorted[i]
            
            if current[0] <= previous[1] {
                print("👉 [\(current[0]), \(current[1])] overlaps previous [\(previous[0]), \(previous[1])]")
            } else {
                print("⊘ [\(current[0]), \(current[1])] no overlap with [\(previous[0]), \(previous[1])] — gap")
            }
            
            previous = current
            i += 1
        }
    }
}

// MARK: - Run
let demo = SortingIntervals()
demo.start()

/*
====================================================
Output:

Sorted by START -> [[1, 3], [2, 6], [8, 10], [15, 18]]
Sorted by END   -> [[1, 3], [2, 6], [8, 10], [15, 18]]
(same here because starts and ends agree — they can
differ: [[1,10],[2,3]] sorts differently per key!)

👉 [2, 6] overlaps previous [1, 3]
⊘ [8, 10] no overlap with [2, 6] — gap
⊘ [15, 18] no overlap with [8, 10] — gap

====================================================
KEY POINTS
====================================================
1. sorted { a, b in a[0] < b[0] } — the closure
   answers "should a come before b?"
2. Sorting turns O(n²) all-pairs checking into an
   O(n) neighbor scan — THE reason step 0 exists
3. After sorting by START:
   current[0] <= previous[1]  →  overlap
   (one condition — this is 03 and 04's foundation)
4. The sort KEY is the strategy (Phase 16 lesson):
   START for merging, END for greedy keep/remove
5. Trap input for dry runs: [[1,10],[2,3]] —
   an interval fully INSIDE another; if your logic
   survives that, it's probably right
====================================================
*/
