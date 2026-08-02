import Foundation

// 232_Meeting_Rooms

/*
====================================================
            232_Meeting_Rooms.swift
====================================================
(LC 252 Premium / LintCode 920)

Problem:
Given meeting time intervals, can one person
attend ALL meetings? (true = no two overlap)

Input:
[[0,30],[5,10],[15,20]] → false   ([0,30] clashes with both)
[[7,10],[2,4]]          → true
[[1,2],[2,3]]           → true    (back-to-back is fine!)

Key Idea:
Sort by START → overlap can only be with the
PREVIOUS meeting. One neighbor check per pass.

Strict < again: touching meetings are attendable —
you walk out of one and into the next.

====================================================
Time Complexity : O(n log n)
====================================================
- Sort dominates; the scan is O(n)
- Early exit on first clash

====================================================
Space Complexity : O(1)
====================================================
- Nothing beyond the sorted copy
====================================================
*/

final class Solution {
    
    func canAttendMeetings(_ intervals: [[Int]]) -> Bool {
        
        // Edge case: 0 or 1 meeting → always attendable
        if intervals.count <= 1 {
            return true
        }
        
        // ------------------------
        // STEP 1 : Sort by START
        // ------------------------
        let sorted = intervals.sorted { $0[0] < $1[0] }
        
        print("Sorted -> \(sorted)")
        print()
        
        // ------------------------
        // STEP 2 : Neighbor check
        // ------------------------
        var i = 1
        
        while i < sorted.count {
            
            let previous = sorted[i - 1]
            let current = sorted[i]
            
            if current[0] < previous[1] {
                
                // Overlap → one person can't be in two rooms
                print("👉 CLASH: \(current) starts \(current[0]) < \(previous) ends \(previous[1])")
                return false
            }
            
            print("⊘ OK: \(current) starts at/after \(previous[1])")
            i += 1
        }
        
        print()
        print("✅ All meetings attendable")
        return true
    }
}

// MARK: - Run
let solution = Solution()

print("========== Test 1 ==========")
print()
print(solution.canAttendMeetings([[0, 30], [5, 10], [15, 20]]))
// false
print()

print("========== Test 2 ==========")
print()
print(solution.canAttendMeetings([[7, 10], [2, 4]]))
// true
print()

print("========== Test 3: back-to-back ==========")
print()
print(solution.canAttendMeetings([[1, 2], [2, 3]]))
// true
