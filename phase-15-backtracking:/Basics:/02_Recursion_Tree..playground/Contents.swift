import UIKit

/*
====================================================
            02_Recursion_Tree.swift
====================================================
Same Choose → Explore → Undo pattern,
but with DEPTH tracking + indentation
so the recursion tree shape is visible.
*/

class RecursionTree {
    
    var path = [Int]()
    var depth = 0
    
    func start() {
        let nums = [1, 2, 3, 4]
        print("========== Recursion Tree ==========\n")
        backTrack(nums, 0)
    }
    
    func backTrack(_ nums: [Int], _ index: Int) {
        
        let indent = String(repeating: "    ", count: depth)
        
        print("\(indent)📍 Level \(depth) -> path: \(path), index: \(index)")
        
        // Base Case
        if index == nums.count {
            print("\(indent)✅ Leaf Reached\n")
            return
        }
        
        for i in index..<nums.count {
            
            // STEP 1 : Choose
            print("\(indent)👉 Choose \(nums[i])")
            path.append(nums[i])
            
            // STEP 2 : Explore (go one level deeper)
            depth += 1
            backTrack(nums, i + 1)
            depth -= 1
            
            // STEP 3 : Undo
            let removed = path.removeLast()
            print("\(indent)⬅️ Return & Undo \(removed)")
        }
        
        print("\(indent)🔙 Exit -> index: \(index), path: \(path)\n")
    }
}

// MARK: - Run
let demo = RecursionTree()
demo.start()
