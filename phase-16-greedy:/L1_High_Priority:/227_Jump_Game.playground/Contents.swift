import Foundation

// 227_Jump_Game

/*
====================================================
                227_Jump_Game.swift
====================================================

Problem:
Array where nums[i] = MAX jump length from index i.
Start at index 0. Return true if the LAST index is reachable.

Input:
[2, 3, 1, 1, 4] → true   (0 → 1 → 4)
[3, 2, 1, 0, 4] → false  (every path lands on index 3, the 0)

Key Idea:
Don't ask "which jump do I take?" (backtracking → exponential)
Ask "what's the FARTHEST index reachable so far?" (one variable)

Greedy Choice:
At each index i:
- if i > farthest → i is unreachable → false
- else farthest = max(farthest, i + nums[i])
- if farthest >= last index → true (early exit)

====================================================
Time Complexity : O(n)
====================================================
- Single pass, each index visited once

====================================================
Space Complexity : O(1)
====================================================
- One variable (farthest) — no recursion, no extra array
====================================================
*/

final class Solution {
    
    func canJump(_ nums: [Int]) -> Bool {
        
        var farthest = 0
        let lastIndex = nums.count - 1
        
        for i in 0..<nums.count {
            
            // Am I standing on an unreachable index?
            if i > farthest {
                print("❌ Index \(i) unreachable (farthest = \(farthest))")
                return false
            }
            
            // Greedy Choice: extend the farthest reach
            let reach = i + nums[i]
            
            if reach > farthest {
                print("👉 At \(i) (jump \(nums[i])) → farthest \(farthest) → \(reach)")
                farthest = reach
            } else {
                print("⊘ At \(i) (jump \(nums[i])) → reach \(reach), no improvement")
            }
            
            // Early exit: last index already reachable
            if farthest >= lastIndex {
                print("✅ Farthest \(farthest) >= last index \(lastIndex)")
                return true
            }
        }
        
        return true   // covers the single-element case [0]
    }
}

// MARK: - Run
let solution = Solution()

print("========== Test 1: [2,3,1,1,4] ==========")
print()
print(solution.canJump([2, 3, 1, 1, 4]))   // true
print()

print("========== Test 2: [3,2,1,0,4] ==========")
print()
print(solution.canJump([3, 2, 1, 0, 4]))   // false
print()

print("========== Test 3: [0] ==========")
print()
print(solution.canJump([0]))               // true
