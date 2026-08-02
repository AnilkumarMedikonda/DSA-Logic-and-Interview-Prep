import UIKit

/*
====================================================
            03_Path_Visited.swift
====================================================
When elements can be picked in ANY order (Permutations),
we track which elements are already USED.

Rule:
- Add to `used` when CHOOSE
- Remove from `used` when UNDO
*/

class PathVisited {
    
    var path = [Int]()
    var used = Set<Int>()
    
    func start() {
        let nums = [1, 2, 3]
        print("========== Path + Visited ==========\n")
        backTrack(nums)
    }
    
    func backTrack(_ nums: [Int]) {
        
        print("Current Path -> \(path), Used -> \(used)")
        
        // Base Case: path has all elements
        if path.count == nums.count {
            print("✅ Complete Permutation: \(path)\n")
            return
        }
        
        // Try ALL elements (no startIndex here!)
        for num in nums {
            
            // Skip if already in path
            if used.contains(num) {
                print("⊘ Skip \(num) (already used)")
                continue
            }
            
            // STEP 1 : Choose
            print("👉 Choose \(num)")
            path.append(num)
            used.insert(num)
            
            // STEP 2 : Explore
            backTrack(nums)
            
            // STEP 3 : Undo
            let removed = path.removeLast()
            used.remove(removed)
            print("⬅️ Undo \(removed)")
        }
    }
}

// MARK: - Run
let demo = PathVisited()
demo.start()
