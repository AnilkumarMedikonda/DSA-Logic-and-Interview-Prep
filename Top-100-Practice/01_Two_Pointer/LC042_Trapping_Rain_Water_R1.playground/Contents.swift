//
//  LC042_Trapping_Rain_Water.playground
//  Two Pointer (Opposite Ends) · Hard · Blind75
//

import Foundation

// MARK: - Problem
/*
 Given n non-negative integers representing an elevation map where the
 width of each bar is 1, compute how much water it can trap after raining.

 [0,1,0,2,1,0,1,3,2,1,2,1] → 6
 [4,2,0,3,2,5]             → 9
*/

// MARK: - Core Idea
/*
 Water above bar i = min(leftMax, rightMax) - heights[i]

 Both maxes INCLUDE bar i, so the result is never negative.
 Water is capped by the SHORTER of the two surrounding walls.
*/

// MARK: - Brute Force · O(n²) / O(1)
// Recomputes leftMax and rightMax from scratch at every index.

func trapBruteForce(_ heights: [Int]) -> Int {

    guard heights.count >= 3 else { return 0 }      // need 2 walls + a dip

    var totalWater = 0

    for i in 0..<heights.count {

        var leftMax = 0
        for left in 0...i {
            leftMax = heights[left] > leftMax ? heights[left] : leftMax
        }

        var rightMax = 0
        for right in i..<heights.count {
            rightMax = heights[right] > rightMax ? heights[right] : rightMax
        }

        let minWall = leftMax < rightMax ? leftMax : rightMax
        totalWater += minWall - heights[i]
    }
    return totalWater
}

// MARK: - Optimised · Two Pointer · O(n) / O(1)
/*
 Track running leftMax/rightMax and process whichever SIDE IS SHORTER.

 Branch split:
   heights[x] >= max  →  this bar IS the new wall, update max, traps nothing
   heights[x] <  max  →  it's a dip below a known wall, collect the water
*/

func trap(_ heights: [Int]) -> Int {

    guard heights.count >= 3 else { return 0 }

    var totalWater = 0
    var leftMax    = 0
    var rightMax   = 0
    var left       = 0
    var right      = heights.count - 1

    while left < right {

        if heights[left] < heights[right] {

            if heights[left] >= leftMax {
                leftMax = heights[left]                  // new wall
            } else {
                totalWater += leftMax - heights[left]    // dip → collect
            }
            left += 1

        } else {

            if heights[right] >= rightMax {
                rightMax = heights[right]
            } else {
                totalWater += rightMax - heights[right]
            }
            right -= 1
        }
    }
    return totalWater
}

// MARK: - Why committing to one side is safe
/*
 At `left`, with heights[left] < heights[right]:

 I don't know the TRUE right max — I haven't scanned the middle.
 But a bar exists at `right`, so trueRightMax >= heights[right].
 And the branch condition keeps leftMax <= heights[right].

    leftMax <= heights[right] <= trueRightMax

 → min(leftMax, trueRightMax) = leftMax

 The left side is the bottleneck, so the water here is already determined.
 Taller bars further right only raise trueRightMax, which never changes
 the minimum.

 SAY THIS: "I don't need the true right max — only that it's at least
 heights[right], which exceeds leftMax. So left is the constraint."
*/

// MARK: - Dry Run  [0,1,0,2,1,0,1,3,2,1,2,1]
/*
 left right h[l] h[r] leftMax rightMax water  action
   0    11    0    1     0       0       0    l<r, 0>=0 → leftMax=0, left++
   1    11    1    1     0       0       0    else, 1>=0 → rightMax=1, right--
   1    10    1    2     0       1       0    l<r, 1>=0 → leftMax=1, left++
   2    10    0    2     1       1       1    l<r, 0<1  → +1, left++
   ...
 → 6
*/

// MARK: - Traps
/*
 1. Both maxes must INCLUDE index i in the brute force, or the
    subtraction goes negative
 2. Process the SHORTER side — processing the taller one breaks the bound
 3. `>=` in the wall check, not `>` — equal height is still a wall
 4. Update max OR collect water, never both in one step
 5. Needs 3 bars minimum to trap anything
*/

// MARK: - Tests

print("---- Brute Force ----")
print(trapBruteForce([0,1,0,2,1,0,1,3,2,1,2,1]))   // 6
print(trapBruteForce([4,2,0,3,2,5]))               // 9

print("---- Optimised ----")
print(trap([0,1,0,2,1,0,1,3,2,1,2,1]))             // 6
print(trap([4,2,0,3,2,5]))                         // 9
print(trap([3,0,3]))                               // 3  — simplest trap
print(trap([2,0,2]))                               // 2
print(trap([1,2,3,4,5]))                           // 0  — monotonic up
print(trap([5,4,3,2,1]))                           // 0  — monotonic down
print(trap([]))                                    // 0
print(trap([4]))                                   // 0

// MARK: - Q&A
/*
 Q: Why process the shorter side?
 A: Its max is provably the binding constraint (see proof above). The
    taller side's true max is still unknown, so you can't commit there.

 Q: Relation to LC 11 (Container With Most Water)?
 A: Same converging two-pointer shape, different question. LC 11 = ONE
    container between two chosen walls, tracks best area. LC 42 = water
    on top of EVERY bar, tracks running leftMax/rightMax.

 Q: Middle solution?
 A: Prefix arrays — precompute leftMax[] and rightMax[] in two passes,
    then sum in a third. O(n) time, O(n) space. Most interviewers accept
    this; two pointers is the O(1)-space upgrade.

 Q: Complexity?
 A: Brute force O(n²)/O(1) · Prefix arrays O(n)/O(n) · Two pointer O(n)/O(1)
*/
