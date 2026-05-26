import Foundation

// LeetCode 11 — Container With Most Water | Medium | Two Pointers

// NOTE: water = min(left, right) × (right - left)

// NOTE: always move shorter side inward

// MARK: - Brute Force

// check every pair

// Time: O(n²) | Space: O(1)

// INTERVIEW: Start here, explain before coding

func maxAreaBrute(_ heights: [Int]) -> Int {
    
    var maxArea = 0
    
    for i in 0..<heights.count {
        for j in i+1..<heights.count {
            let width = j - i
            let height = min(heights[i], heights[j])
            let area = width * height
            maxArea = max(area, maxArea)
        }
    }
    
    return maxArea
}

// MARK: - Optimal ⭐️ BEST

// two pointers, move shorter side inward

// Time: O(n) | Space: O(1)

// INTERVIEW: Moving taller side never helps

// INTERVIEW: Moving shorter side gives chance for bigger area

func maxAreaOptimal(_ heights: [Int]) -> Int {
    
    var maxArea = 0
    var left = 0
    var right = heights.count - 1
    
    while left < right {
        
        let width = right - left
        let height = min(heights[left], heights[right])
        let area = width * height
        maxArea = max(area, maxArea)
        
        if heights[left] > heights[right] {
            right -= 1
        } else {
            left += 1
        }
    }
    
    return maxArea
}

// MARK: - Tests
let testCases: [([Int], Int)] = [
    ([1, 8, 6, 2, 5, 4, 8, 3, 7], 49),
    ([1, 1],                        1)
]

print("--- Brute Force ---")

for (i, t) in testCases.enumerated() {
    let r = maxAreaBrute(t.0)
    print("Test \(i+1): \(r == t.1 ? "✅" : "❌") | Expected: \(t.1) | Got: \(r)")
}

print("\n--- Optimal ⭐️ ---")

for (i, t) in testCases.enumerated() {
    let r = maxAreaOptimal(t.0)
    print("Test \(i+1): \(r == t.1 ? "✅" : "❌") | Expected: \(t.1) | Got: \(r)")
}
