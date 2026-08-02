import Foundation

// 233_Meeting_Rooms_II

/*
====================================================
            233_Meeting_Rooms_II.swift
====================================================
(LC 253 Premium / LintCode 919)

Problem:
Return the MINIMUM number of conference rooms
needed to host all meetings.

Input:
[[0,30],[5,10],[15,20]] → 2
[[7,10],[2,4]]          → 1

Reframe:
min rooms = MAX meetings running at the same moment

Key Idea — Min-Heap of END times (Phase 12 returns!):
- Sort meetings by START
- Heap holds end times of OCCUPIED rooms
- Root = the room that frees up EARLIEST
- New meeting:
    start >= root → that room is free → REUSE (pop)
    start <  root → even the earliest room is busy → NEW room
  Either way, push this meeting's end time
- Answer = heap size at the end
  (reuse = pop+push → size unchanged; new room → size grows;
   size never shrinks → final size IS the max concurrent)

====================================================
Time Complexity : O(n log n)
====================================================
- Sort O(n log n) + n heap operations at O(log n) each

====================================================
Space Complexity : O(n)
====================================================
- Heap holds up to n end times (all meetings concurrent)
====================================================
*/

// ------------------------
// Phase 12 MinHeap (reviewed version)
// ------------------------
final class MinHeap {
    
    private var items = [Int]()
    
    var count: Int {
        return items.count
    }
    
    func peek() -> Int? {
        return items.first
    }
    
    func insert(_ value: Int) {
        items.append(value)
        siftUp(items.count - 1)
    }
    
    @discardableResult
    func remove() -> Int? {
        
        if items.isEmpty {
            return nil
        }
        
        if items.count == 1 {
            return items.removeLast()
        }
        
        let root = items[0]
        items.swapAt(0, items.count - 1)
        items.removeLast()
        siftDown(0)
        return root
    }
    
    private func siftUp(_ index: Int) {
        
        var child = index
        var parent = (child - 1) / 2
        
        while child > 0 && items[child] < items[parent] {
            items.swapAt(child, parent)
            child = parent
            parent = (child - 1) / 2
        }
    }
    
    private func siftDown(_ index: Int) {
        
        var parent = index
        
        while true {
            
            let left = 2 * parent + 1
            let right = 2 * parent + 2
            var smallest = parent
            
            if left < items.count && items[left] < items[smallest] {
                smallest = left
            }
            
            if right < items.count && items[right] < items[smallest] {
                smallest = right
            }
            
            if smallest == parent {
                return
            }
            
            items.swapAt(parent, smallest)
            parent = smallest
        }
    }
}

// ------------------------
// Solution
// ------------------------
final class Solution {
    
    func minMeetingRooms(_ intervals: [[Int]]) -> Int {
        
        // Edge case: 0 or 1 meeting
        if intervals.count <= 1 {
            return intervals.count
        }
        
        // ------------------------
        // STEP 1 : Sort by START
        // ------------------------
        let sorted = intervals.sorted { $0[0] < $1[0] }
        
        print("Sorted -> \(sorted)")
        print()
        
        // Heap of end times = occupied rooms
        let rooms = MinHeap()
        
        for meeting in sorted {
            
            let start = meeting[0]
            let end = meeting[1]
            
            // ------------------------
            // STEP 2 : Is the earliest-freeing room free?
            // ------------------------
            if let earliestEnd = rooms.peek(), start >= earliestEnd {
                
                // REUSE — that meeting has ended
                rooms.remove()
                print("👉 [\(start), \(end)] reuses room (freed at \(earliestEnd))")
                
            } else {
                
                // NEW room needed
                print("🏠 [\(start), \(end)] needs a NEW room (earliest busy)")
            }
            
            // ------------------------
            // STEP 3 : This meeting now occupies a room
            // ------------------------
            rooms.insert(end)
            print("   Rooms in use -> \(rooms.count)")
            print()
        }
        
        print("✅ Minimum rooms -> \(rooms.count)")
        return rooms.count
    }
}

// MARK: - Run
let solution = Solution()

print("========== Test 1 ==========")
print()
print(solution.minMeetingRooms([[0, 30], [5, 10], [15, 20]]))
// 2
print()

print("========== Test 2 ==========")
print()
print(solution.minMeetingRooms([[7, 10], [2, 4]]))
// 1
print()

print("========== Test 3: all concurrent ==========")
print()
print(solution.minMeetingRooms([[1, 10], [2, 10], [3, 10]]))
// 3
