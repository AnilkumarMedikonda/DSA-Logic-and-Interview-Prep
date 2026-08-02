import Foundation

// 228_Jump_Game_II

/*
====================================================
                228_Jump_Game_II.swift
====================================================

Problem:
nums[i] = MAX jump length from index i.
Return the MINIMUM number of jumps to reach the last index.
(Reachability is guaranteed — no false case.)

Input:
[2, 3, 1, 1, 4] → 2   (0 → 1 → 4)

Key Idea:
BFS levels WITHOUT a queue:
- farthest   → max reach collected while walking this level
- currentEnd → where the current jump's range ends
- i == currentEnd → level exhausted → MUST jump:
      jumps += 1, currentEnd = farthest

Loop bound trap:
Iterate 0..<count-1 — including the last index
counts one extra jump when landing exactly on it.

====================================================
Time Complexity : O(n)
====================================================
- Single pass, each index visited once

====================================================
Space Complexity : O(1)
====================================================
- Three variables — no recursion, no extra array
====================================================
*/

final class Solution {
    
    func jump(_ nums: [Int]) -> Int {
        
        // Single element → already at the end
        if nums.count <= 1 {
            print("✅ Single element, 0 jumps needed")
            return 0
        }
        
        var jumps = 0
        var currentEnd = 0
        var farthest = 0
        
        // Stop BEFORE the last index
        for i in 0..<nums.count - 1 {
            
            let reach = i + nums[i]
            
            if reach > farthest {
                print("👉 At \(i) (jump \(nums[i])) → farthest \(farthest) → \(reach)")
                farthest = reach
            } else {
                print("⊘ At \(i) (jump \(nums[i])) → reach \(reach), no improvement")
            }
            
            // Reached the edge of the current jump's range
            if i == currentEnd {
                jumps += 1
                currentEnd = farthest
                print("🚀 Level exhausted at \(i) → JUMP #\(jumps), new range ends at \(currentEnd)")
                print()
            }
        }
        
        print("✅ Minimum jumps -> \(jumps)")
        return jumps
    }
}

// MARK: - Run
let solution = Solution()

print("========== Test 1: [2,3,1,1,4] ==========")
print()
print(solution.jump([2, 3, 1, 1, 4]))   // 2
print()

print("========== Test 2: [2,3,0,1,4] ==========")
print()
print(solution.jump([2, 3, 0, 1, 4]))   // 2
print()

print("========== Test 3: [0] ==========")
print()
print(solution.jump([0]))               // 0

/*
====================================================
Debug trace — Test 1: [2,3,1,1,4]
====================================================
👉 At 0 (jump 2) → farthest 0 → 2
🚀 Level exhausted at 0 → JUMP #1, new range ends at 2

👉 At 1 (jump 3) → farthest 2 → 4
⊘ At 2 (jump 1) → reach 3, no improvement
🚀 Level exhausted at 2 → JUMP #2, new range ends at 4

✅ Minimum jumps -> 2
====================================================
*/
