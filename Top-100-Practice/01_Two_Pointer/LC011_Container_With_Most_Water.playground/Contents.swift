//
//  LC011_Container_With_Most_Water.playground
//  Two Pointer (Opposite Ends) · Medium · O(n) / O(1)
//

import Foundation

// MARK: - Problem
/*
 height[i] = vertical line at x = i. Pick 2 lines that hold the most water.

 [1,8,6,2,5,4,8,3,7] → 49
 [1,1]               → 1
*/

// MARK: - Idea
/*
 area = min(left, right) * width      // min → water spills over the shorter wall

 Start at both ends (widest). Moving in shrinks width, so only a taller
 cap helps → move the shorter wall.
*/

// MARK: - Brute Force · O(n²)

func maxAreaBruteForce(_ heights: [Int]) -> Int {

    guard heights.count >= 2 else { return 0 }

    var best = 0

    for i in 0..<heights.count {
        for j in (i + 1)..<heights.count {
            let l = heights[i]
            let r = heights[j]
            let minHeight = l < r ? l : r
            let area = minHeight * (j - i)
            best = area > best ? area : best
        }
    }
    return best
}

// MARK: - Optimised · O(n)

func maxArea(_ heights: [Int]) -> Int {

    guard heights.count >= 2 else { return 0 }

    var best  = 0
    var left  = 0
    var right = heights.count - 1

    while left < right {

        let leftHeight  = heights[left]
        let rightHeight = heights[right]

        let minHeight = leftHeight < rightHeight ? leftHeight : rightHeight
        let width     = right - left
        let area      = minHeight * width

        best = area > best ? area : best

        if leftHeight < rightHeight {
            left += 1                 // move the shorter wall
        } else {
            right -= 1
        }
    }
    return best
}

// MARK: - Dry Run  [1,8,6,2,5,4,8,3,7]
/*
 left right width minH area best
   0    8     8     1    8    8
   1    8     7     7   49   49   ← answer
   1    7     6     3   18   49
   1    6     5     8   40   49
   1    5     4     4   16   49
   ...
*/

// MARK: - Traps
/*
 1. min not max — capped by the shorter wall
 2. don't name a local `min` (shadows stdlib)
 3. move the shorter pointer, not the taller
 4. `left < right`, not `<=`
*/

// MARK: - Tests

print(maxArea([1,8,6,2,5,4,8,3,7]))   // 49
print(maxArea([1,1]))                 // 1
print(maxArea([4,3,2,1,4]))           // 16
print(maxArea([1,2,1]))               // 2
print(maxArea([0,2]))                 // 0

// MARK: - Q&A
/*
 Q: Why safe to drop the shorter line?
 A: Max cap + max width already used → its best area is computed.

 Q: Why not sort?
 A: Width needs indices; sorting destroys them.
*/
