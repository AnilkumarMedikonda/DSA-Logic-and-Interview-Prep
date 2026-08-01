import Foundation

/*
====================================================
        04_Duplicate_Handling.swift
====================================================

Goal:
Learn how to skip duplicate branches.

Rule:

1. Sort the array
2. Skip duplicates
*/


class DuplicateHandling {
    
    var path = [Int]()
    var results = [[Int]]()
    
    func start() {
        
        var nums = [2, 1, 2]
        
        nums.sort()
        
        print("Sorted -> \(nums)")
        print()
        
        backTree(nums, 0)
        
        print()
        print("========== Unique Results ==========")
        print()
        
        for result in results {
            print(result)
        }
    }
    
    func backTree(_ nums: [Int], _ index: Int) {
        
        print("Current Path -> \(path)")
        print()
        
        if index == nums.count {
            print("✅ Save \(path)")
            print()
            results.append(path)
            return
        }
        
        for i in index..<nums.count {
            
            if i > index && nums[i] == nums[i - 1] {
                print("⊘ Skip \(nums[i]) (duplicate at this level)")
                print()
                continue
            }
            
            print("👉 Choose \(nums[i])")
            path.append(nums[i])
            print("Path After Choose -> \(path)")
            print()
            
            backTree(nums, i + 1)
            
            let removed = path.removeLast()
            print("⬅️ Undo \(removed)")
            print("Path After Undo -> \(path)")
            print()
        }
    }
}

let demo = DuplicateHandling()
demo.start()
