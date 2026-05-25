import Foundation

// LeetCode 167 — Two Sum II | Easy | Two Pointers
// NOTE: Array is sorted — use two pointers
// NOTE: Return 1-indexed indices

// MARK: - Brute Force
// check every pair
// Time: O(n²) | Space: O(1)
// INTERVIEW: Start here, explain before coding
func twoSum(_ numbers: [Int], _ target: Int) -> [Int] {

    for i in 0..<numbers.count {
        for j in i+1..<numbers.count {
            if numbers[i] + numbers[j] == target {
                return [i + 1, j + 1]
            }
        }
    }
    return []
}

// MARK: - Optimal ⭐️ BEST
// two pointers, sum < target → left++, sum > target → right--
// Time: O(n) | Space: O(1)
// INTERVIEW: Sorted array → always think two pointers
// INTERVIEW: left < right not left <= right
func twoSumOptimised(_ numbers: [Int], _ target: Int) -> [Int] {

    var left = 0
    var right = numbers.count - 1

    while left < right {

        let sum = numbers[left] + numbers[right]

        if sum < target {
            left += 1
        } else if sum > target {
            right -= 1
        } else {
            return [left + 1, right + 1]
        }
    }
    return []
}

// MARK: - Tests
let testCases: [([Int], Int, [Int])] = [
    ([2, 7, 11, 15], 9,  [1, 2]),
    ([2, 3, 4],      6,  [1, 3]),
    ([-1, 0],        -1, [1, 2])
]

print("--- Brute Force ---")
for (i, t) in testCases.enumerated() {
    let r = twoSum(t.0, t.1)
    print("Test \(i+1): \(r == t.2 ? "✅" : "❌") | Got: \(r)")
}

print("\n--- Optimal ⭐️ ---")
for (i, t) in testCases.enumerated() {
    let r = twoSumOptimised(t.0, t.1)
    print("Test \(i+1): \(r == t.2 ? "✅" : "❌") | Got: \(r)")
}
