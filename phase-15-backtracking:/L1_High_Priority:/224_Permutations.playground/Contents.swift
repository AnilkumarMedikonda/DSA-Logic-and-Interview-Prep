import Foundation


/*
====================================================
                224_Permutations.swift
====================================================

Problem:
Given an array of distinct integers, return all possible permutations.

Input:
[1, 2, 3]x

Output:
[1,2,3]
[1,3,2]
[2,1,3]
[2,3,1]
[3,1,2]
[3,2,1]

Key Idea:
Order matters → loop over ALL elements every level
`used` set blocks picking the same element twice
Save ONLY when path is FULL (path.count == nums.count)

====================================================
Time Complexity : O(n · n!)
====================================================
- Total permutations = n!            (3 elements → 6)
- Copying each full path into result = O(n)
- n! permutations × O(n) copy = O(n · n!)

====================================================
Space Complexity : O(n)
====================================================
- Recursion depth   = n  (one level per chosen element)
- path array        = n
- used set          = n
- (result output array not counted)
====================================================
*/

final class Solution {
    
    var result = [[Int]]()
    var path = [Int]()
    var used = Set<Int>()
    
    func permute(_ nums: [Int]) -> [[Int]] {
        backTracking(nums)
        return result
    }
    
    func backTracking(_ nums: [Int]) {
        
        print("Current Path -> \(path), Used -> \(used)")
        print()
        
        // Base Case : path has ALL elements
        if path.count == nums.count {
            print("✅ Save \(path)")
            print()
            result.append(path)
            return
        }
        
        // Try ALL elements (no start index!)
        for num in nums {
            
            // Skip if already in path
            if used.contains(num) {
                print("⊘ Skip \(num)")
                continue
            }

            print("👉 Choose \(num)")
            // ------------------------
            // STEP 1 : Choose
            // ------------------------
            print("👉 Choose \(num)")
            path.append(num)
            used.insert(num)
            
            // ------------------------
            // STEP 2 : Explore
            // ------------------------
            backTracking(nums)
            
            // ------------------------
            // STEP 3 : Undo
            // ------------------------
            let removed = path.removeLast()
            used.remove(removed)
            print("⬅️ Undo \(removed)")
            print()
        }
    }
}

// MARK: - Run
let solution = Solution()
let answer = solution.permute([1, 2, 3])

print("========== Result ==========")
print()

for permutation in answer {
    print(permutation)
}
