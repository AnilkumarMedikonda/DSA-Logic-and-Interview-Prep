import Foundation

// 225_Combination_Sum

/*
====================================================
            225_Combination_Sum.swift
====================================================

Problem:
Given distinct integers and a target, return all unique
combinations that sum to target.
Same number may be reused unlimited times.

Input:
candidates = [2, 3, 6, 7], target = 7

Output:
[2, 2, 3]
[7]

Key Idea:
- Recurse with `i` (not i + 1) → allows REUSE of same element
- Still start from `i` (not 0)  → avoids duplicate orderings
- Pass `remaining` down instead of summing path
- remaining == 0 → save   |   remaining < 0 → dead branch

====================================================
Time Complexity : O(2^target)  (exponential branching)
====================================================
- Each level can branch on every candidate
- Depth limited by target / smallest candidate

====================================================
Space Complexity : O(target / min(candidates))
====================================================
- Recursion depth = longest chain of smallest element
- path array same bound
- (result output array not counted)
====================================================
*/

final class Solution {
    
    var result = [[Int]]()
    var path = [Int]()
    
    func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
        backTracking(candidates, 0, target)
        return result
    }
    
    func backTracking(_ candidates: [Int], _ start: Int, _ remaining: Int) {
        
        print("Current Path -> \(path), Remaining -> \(remaining)")
        print()
        
        // Base Case 1 : exact target hit
        if remaining == 0 {
            print("✅ Save \(path)")
            print()
            result.append(path)
            return
        }
        
        // Base Case 2 : overshot → dead branch
        if remaining < 0 {
            print("❌ Overshot, backtrack")
            print()
            return
        }
        
        for i in start..<candidates.count {
            
            // ------------------------
            // STEP 1 : Choose
            // ------------------------
            print("👉 Choose \(candidates[i])")
            path.append(candidates[i])
            
            // ------------------------
            // STEP 2 : Explore
            // NOTE: `i` not `i + 1` → same element can be reused
            // ------------------------
            backTracking(candidates, i, remaining - candidates[i])
            
            // ------------------------
            // STEP 3 : Undo
            // ------------------------
            let removed = path.removeLast()
            print("⬅️ Undo \(removed)")
            print()
        }
    }
}

// MARK: - Run
let solution = Solution()
let answer = solution.combinationSum([2, 3, 6, 7], 7)

print("========== Result ==========")
print()

for combination in answer {
    print(combination)
}
