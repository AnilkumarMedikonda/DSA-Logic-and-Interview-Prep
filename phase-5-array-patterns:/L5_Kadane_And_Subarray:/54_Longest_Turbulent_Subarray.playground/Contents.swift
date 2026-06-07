import UIKit

// ============================================================
// MARK: - Problem: Longest Turbulent Subarray (LC 978)
// ============================================================
// Given an integer array arr, return the length of a maximum
// size turbulent subarray of arr.
//
// A subarray is turbulent if the comparison sign flips
// between every adjacent pair of elements.
//
// Example 1: [9,4,2,10,7,8,8,1,9] → 5  ([4,2,10,7,8])
// Example 2: [4,8,12,16]           → 2
// Example 3: [100]                 → 1
//
// Constraints:
// - 1 <= arr.length <= 4 * 10⁴
// - 0 <= arr[i] <= 10⁹
// ============================================================

// ============================================================
// MARK: - Brute Force — O(n²) Time | O(1) Space
// ============================================================
// Steps:
// 1. Fix start index i
// 2. Extend end index j from i+1
// 3. Check if sign flips between each adjacent pair
// 4. Track maximum length
// 5. Return maximum
// ============================================================

func longestTurbulentBrute(_ arr: [Int]) -> Int {
    let n = arr.count
    var maxLength = 1

    for i in 0..<n {
        var length = 1
        for j in i+1..<n {
            if length == 1 {
                // any two different elements start turbulence
                if arr[j] != arr[j-1] {
                    length += 1
                } else {
                    break
                }
            } else {
                // check sign flip
                let prevSign = arr[j-1] > arr[j-2]
                let currSign = arr[j]   > arr[j-1]
                if arr[j] != arr[j-1] && prevSign != currSign {
                    length += 1
                } else {
                    break
                }
            }
            maxLength = max(maxLength, length)
        }
    }

    return maxLength
}

// ============================================================
// MARK: - Optimised — O(n) Time | O(1) Space
// ============================================================
// Key Insight:
// At each index, check if sign flipped from previous:
// → Flipped   → extend currentLength
// → Same sign → reset to 2
// → Equal     → reset to 1
//
// Steps:
// 1. Handle single element edge case
// 2. Init maxLength and currentLength = 1
// 3. Loop from index 1
// 4. First pair — check if different
// 5. Remaining pairs — check sign flip using prev and curr
// 6. Update maxLength at each step
// 7. Return maxLength
// ============================================================

func longestTurbulentOptimised(_ arr: [Int]) -> Int {
    let n = arr.count

    if n == 1 { return 1 }

    var maxLength     = 1
    var currentLength = 1

    for i in 1..<n {

        if i == 1 {
            // first pair
            if arr[i] != arr[i-1] {
                currentLength = 2
            } else {
                currentLength = 1
            }
        } else {
            // prev comparison sign
            let prev = arr[i-1] > arr[i-2] ? 1 : (arr[i-1] < arr[i-2] ? -1 : 0)
            // curr comparison sign
            let curr = arr[i] > arr[i-1]   ? 1 : (arr[i] < arr[i-1]   ? -1 : 0)

            if curr == 0 {
                currentLength = 1    // equal → full reset
            } else if prev != curr {
                currentLength += 1   // sign flipped → extend
            } else {
                currentLength = 2    // same sign → reset to 2
            }
        }

        maxLength = max(maxLength, currentLength)
    }

    return maxLength
}

// ============================================================
// MARK: - Test Cases — Basic
// ============================================================

print("---- Brute Force ----")
print(longestTurbulentBrute([9, 4, 2, 10, 7, 8, 8, 1, 9])) // 5
print(longestTurbulentBrute([4, 8, 12, 16]))                 // 2
print(longestTurbulentBrute([100]))                          // 1

print("---- Optimised ----")
print(longestTurbulentOptimised([9, 4, 2, 10, 7, 8, 8, 1, 9])) // 5
print(longestTurbulentOptimised([4, 8, 12, 16]))                 // 2
print(longestTurbulentOptimised([100]))                          // 1

// ============================================================
// MARK: - Test Cases — Edge Cases
// ============================================================

print("---- Edge Case 1: Single Element ----")
print(longestTurbulentOptimised([1]))                        // 1
print(longestTurbulentOptimised([100]))                      // 1

print("---- Edge Case 2: All Equal ----")
print(longestTurbulentOptimised([5, 5, 5]))                  // 1
print(longestTurbulentOptimised([3, 3, 3, 3]))               // 1

print("---- Edge Case 3: Two Elements Equal ----")
print(longestTurbulentOptimised([9, 8, 8, 1, 9]))            // 3
print(longestTurbulentOptimised([1, 2, 2, 3]))               // 2

print("---- Edge Case 4: All Increasing ----")
print(longestTurbulentOptimised([1, 2, 3, 4, 5]))            // 2
print(longestTurbulentOptimised([10, 20, 30]))               // 2

print("---- Edge Case 5: All Decreasing ----")
print(longestTurbulentOptimised([5, 4, 3, 2, 1]))            // 2
print(longestTurbulentOptimised([100, 50, 25]))              // 2

print("---- Edge Case 6: Perfect Turbulent ----")
print(longestTurbulentOptimised([9, 4, 7, 2, 10]))           // 5
print(longestTurbulentOptimised([1, 5, 1, 5, 1]))            // 5

print("---- Edge Case 7: Two Elements ----")
print(longestTurbulentOptimised([1, 2]))                     // 2
print(longestTurbulentOptimised([2, 1]))                     // 2
print(longestTurbulentOptimised([1, 1]))                     // 1

print("---- Edge Case 8: Turbulent Then Flat ----")
print(longestTurbulentOptimised([9, 4, 7, 7, 2]))            // 3
print(longestTurbulentOptimised([1, 3, 2, 2, 5]))            // 3

// ============================================================
// MARK: - Complexity Summary
// ============================================================
// Approach       Time      Space
// Brute Force    O(n²)     O(1)
// Optimised      O(n)      O(1)
//
// Key Rules:
// Sign flips     → extend (length + 1)
// Same sign      → reset to 2
// Equal elements → reset to 1
// Single element → return 1
// ============================================================
