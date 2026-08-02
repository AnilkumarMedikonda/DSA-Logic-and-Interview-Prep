import Foundation

/*
====================================================
            01_Intervals_Basics.swift
====================================================

An interval = [start, end] — a range on a number line.

In Swift/LeetCode, intervals arrive as [[Int]]:
    [[1, 3], [2, 6], [8, 10]]
    interval[0] = start, interval[1] = end

Core skills this file covers:
1. Reading start/end from [[Int]]
2. Visualizing intervals on a number line
3. Checking a point against an interval
4. Comparing two intervals (before / after / touching)
*/

final class IntervalsBasics {
    
    func start() {
        
        let intervals = [[1, 3], [2, 6], [8, 10], [15, 18]]
        
        print("========== Intervals Basics ==========")
        print()
        print("Intervals -> \(intervals)")
        print()
        
        readIntervals(intervals)
        print()
        visualize(intervals)
        print()
        pointCheck(intervals[0], point: 2)
        pointCheck(intervals[0], point: 5)
        print()
        compare(intervals[0], intervals[2])   // [1,3] vs [8,10]
        compare(intervals[0], intervals[1])   // [1,3] vs [2,6]
    }
    
    // ------------------------------------------------
    // 1. Reading start / end
    // ------------------------------------------------
    func readIntervals(_ intervals: [[Int]]) {
        
        for interval in intervals {
            
            let start = interval[0]
            let end = interval[1]
            
            print("Interval [\(start), \(end)] → length \(end - start)")
        }
    }
    
    // ------------------------------------------------
    // 2. Number line visualization
    // ------------------------------------------------
    func visualize(_ intervals: [[Int]]) {
        
        print("Number line (0–20):")
        
        for interval in intervals {
            
            let start = interval[0]
            let end = interval[1]
            
            var line = ""
            var position = 0
            
            while position <= 20 {
                if position >= start && position <= end {
                    line += "■"
                } else {
                    line += "·"
                }
                position += 1
            }
            
            print("\(line)  [\(start), \(end)]")
        }
    }
    
    // ------------------------------------------------
    // 3. Is a point inside an interval?
    // ------------------------------------------------
    func pointCheck(_ interval: [Int], point: Int) {
        
        let start = interval[0]
        let end = interval[1]
        
        if point >= start && point <= end {
            print("👉 Point \(point) is INSIDE [\(start), \(end)]")
        } else {
            print("⊘ Point \(point) is OUTSIDE [\(start), \(end)]")
        }
    }
    
    // ------------------------------------------------
    // 4. Comparing two intervals
    // (overlap logic comes in 04_Overlap_Pattern)
    // ------------------------------------------------
    func compare(_ a: [Int], _ b: [Int]) {
        
        if a[1] < b[0] {
            print("[\(a[0]), \(a[1])] ends BEFORE [\(b[0]), \(b[1])] starts — gap")
        } else if b[1] < a[0] {
            print("[\(a[0]), \(a[1])] starts AFTER [\(b[0]), \(b[1])] ends — gap")
        } else {
            print("[\(a[0]), \(a[1])] and [\(b[0]), \(b[1])] TOUCH or OVERLAP")
        }
    }
}

// MARK: - Run
let demo = IntervalsBasics()
demo.start()

/*
====================================================
Output (visualization section):

·■■■·················  [1, 3]
··■■■■■··············  [2, 6]
········■■■··········  [8, 10]
···············■■■■··  [15, 18]

Rows 1 and 2 — [1,3] and [2,6] share columns 2 and 3.
THAT is overlap. Detecting it with one condition is
file 04; sorting so overlaps sit next to each other
is file 02.

====================================================
KEY POINTS
====================================================
1. interval[0] = start, interval[1] = end — always
   pull them into named lets first; a[0]/b[1] soup
   is where interval bugs breed
2. Inclusive ends: [1,3] contains 3 — most LC
   interval problems treat [1,3] and [3,5] as
   OVERLAPPING (they share point 3)
3. The number line drawing is your dry-run tool —
   draw it in interviews, every time
4. Two intervals have exactly 3 relationships:
   gap-before, gap-after, or touching/overlapping
====================================================
*/
