import UIKit

/*
 Backtracking is an algorithmic technique where we try one possible choice, explore further using recursion, and if it doesn't lead to a solution, we undo the choice and try another one.
 
 */

/*
====================================================
            01_Backtracking_Basics.swift
====================================================
Backtracking =
    Choose
        ↓
    Explore (Recursive Call)
        ↓
    Undo (Backtrack)
        ↓
    Try Next Choice
*/

class BackTrackingBasics {
    
    // Current path
    var path: [Int] = []
    
    func start() {
        let nums = [1, 2, 3]
        print("========== Backtracking Basics ==========\n")
        backTrack(nums, 0)
    }
    
    func backTrack(_ nums: [Int], _ index: Int) {
        
        print("Current Path -> \(path)")
        
        // Base Case
        if index == nums.count {
            print("✅ Reached End\n")
            return
        }
        
        // Try all possible choices
        for i in index..<nums.count {
            
            // ------------------------
            // STEP 1 : Choose
            // ------------------------
            print("👉 Choose \(nums[i])")
            path.append(nums[i])
            print("Path After Choose -> \(path)\n")
            
            // ------------------------
            // STEP 2 : Explore
            // ------------------------
            backTrack(nums, i + 1)
            
            // ------------------------
            // STEP 3 : Undo
            // ------------------------
            let removed = path.removeLast()
            print("⬅️ Undo \(removed)")
            print("Path After Undo -> \(path)\n")
        }
    }
}

// MARK: - Run
let demo = BackTrackingBasics()
demo.start()
