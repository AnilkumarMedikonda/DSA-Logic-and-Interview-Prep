import UIKit

// 223_Subsets

/*
====================================================
                223_Subsets.swift
====================================================

Problem:
Given an array of unique integers, return all possible subsets.

Input:
[1, 2, 3]

Output:
[]
[1]
[1,2]
[1,2,3]
[1,3]
[2]
[2,3]
[3]

Key Idea:
Every path state is a valid subset
→ save on ENTRY, not at base case

Time  : O(n · 2^n)
Space : O(n) recursion depth
*/

final class Solution {
    
    var result = [[Int]]()
    var path = [Int]()
    
    func subsets(_ nums: [Int]) -> [[Int]] {
        backTracking(nums, 0)
        return result
    }
    
    func backTracking(_ nums: [Int], _ start: Int) {
        
        // Every Path is a Valid Subset → save first
        result.append(path)
        
        print("Current Path -> \(path)")
        print()
        
        for i in start..<nums.count {
            
            // ------------------------
            // STEP 1 : Choose
            // ------------------------
            print("👉 Choose \(nums[i])")
            path.append(nums[i])
            
            // ------------------------
            // STEP 2 : Explore
            // ------------------------
            backTracking(nums, i + 1)
            
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
let answer = solution.subsets([1, 2, 3])

print("========== Result ==========")
print()

for subset in answer {
    print(subset)
}
