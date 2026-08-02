import Foundation

// 230_Insert_Interval

/*
====================================================
            230_Insert_Interval.swift
====================================================

Problem:
Given non-overlapping intervals SORTED by start,
insert a new interval and merge if necessary.

Input:
intervals = [[1,2],[3,5],[6,7],[8,10],[12,16]]
newInterval = [4,8]

Output:
[[1,2],[3,10],[12,16]]   ← [4,8] swallowed [3,5],[6,7],[8,10]

Key Idea — THREE ZONES, walked in order:
ZONE 1: interval ends BEFORE new starts → copy as-is
ZONE 2: interval OVERLAPS new → absorb (min start, max end)
ZONE 3: interval starts AFTER new ends → push new ONCE, copy rest

No sort needed — input is already sorted!

====================================================
Time Complexity : O(n)
====================================================
- One pass, each interval visited exactly once
- No sort — this is why it beats "append + call LC 56"

====================================================
Space Complexity : O(n)
====================================================
- Result array only
====================================================
*/

final class Solution {
    
    func insert(_ intervals: [[Int]], _ newInterval: [Int]) -> [[Int]] {
        
        var result = [[Int]]()
        
        var newStart = newInterval[0]
        var newEnd = newInterval[1]
        
        var i = 0
        let count = intervals.count
        
        // ------------------------
        // ZONE 1 : entirely BEFORE the new interval
        // interval ends before new starts → untouched
        // ------------------------
        while i < count && intervals[i][1] < newStart {
            print("⏩ Zone 1: copy \(intervals[i]) (ends \(intervals[i][1]) < newStart \(newStart))")
            result.append(intervals[i])
            i += 1
        }
        
        // ------------------------
        // ZONE 2 : OVERLAPPING → absorb into new
        // while the interval starts before/at new's end
        // ------------------------
        while i < count && intervals[i][0] <= newEnd {
            print("👉 Zone 2: absorb \(intervals[i]) (start \(intervals[i][0]) <= newEnd \(newEnd))")
            newStart = min(newStart, intervals[i][0])
            newEnd = max(newEnd, intervals[i][1])
            print("   New interval grows -> [\(newStart), \(newEnd)]")
            i += 1
        }
        
        // Push the (possibly grown) new interval — exactly ONCE
        print("✅ Push new interval [\(newStart), \(newEnd)]")
        result.append([newStart, newEnd])
        
        // ------------------------
        // ZONE 3 : entirely AFTER → copy the rest
        // ------------------------
        while i < count {
            print("⏩ Zone 3: copy \(intervals[i]) (starts after newEnd)")
            result.append(intervals[i])
            i += 1
        }
        
        print()
        print("✅ Result -> \(result)")
        return result
    }
}

// MARK: - Run
let solution = Solution()

print("========== Test 1 ==========")
print()
print(solution.insert([[1, 3], [6, 9]], [2, 5]))
// [[1,5],[6,9]]
print()

print("========== Test 2: swallows three ==========")
print()
print(solution.insert([[1, 2], [3, 5], [6, 7], [8, 10], [12, 16]], [4, 8]))
// [[1,2],[3,10],[12,16]]
print()

print("========== Test 3: empty intervals ==========")
print()
print(solution.insert([], [5, 7]))
// [[5,7]]
print()

print("========== Test 4: entirely after everything ==========")
print()
print(solution.insert([[1, 5]], [6, 8]))
// [[1,5],[6,8]]
