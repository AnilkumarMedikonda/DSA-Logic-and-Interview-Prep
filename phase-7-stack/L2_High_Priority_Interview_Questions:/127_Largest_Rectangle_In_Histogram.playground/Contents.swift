import UIKit

// MARK: - Problem
// 127. Largest Rectangle in Histogram (LC 84) — Hard
// heights[i] = bar height, width 1 each. Return largest rectangle area.
// For each bar as the limiting height: stretch left/right until a SHORTER bar.
// → nearest-smaller-to-left + nearest-smaller-to-right = monotonic stack.
// [2,1,5,6,2,3] → 10   [2,4] → 4   [2,1,2] → 3

// MARK: - Brute Force
// Fix left endpoint i, extend j rightward tracking running min height.
// T: O(n²)  S: O(1)


func largestRectangleAreaBrute(_ heights: [Int]) -> Int {
    var maxArea = 0

    for i in 0..<heights.count {
        var minHeight = heights[i]

        for j in i..<heights.count {
            if heights[j] < minHeight {
                minHeight = heights[j]
            }

            let width = j - i + 1
            let area = minHeight * width
            if area > maxArea {
                maxArea = area
            }
        }
    }

    return maxArea
}

// MARK: - Optimised (Monotonic Increasing Stack)
// Stack holds INDICES of bars in increasing height order. When an incoming
// bar is shorter than the top, the top's rectangle is finalised:
// right boundary = i, left boundary = new stack top after pop.
// Sentinel 0 appended so every bar flushes by end of loop.
// T: O(n)  S: O(n)


func largestRectangleAreaOptimised(_ heights: [Int]) -> Int {
    var maxArea = 0
    var stack = [Int]()

    var bars = heights
    bars.append(0)                       // sentinel — flushes the stack

    for i in 0..<bars.count {
        while let top = stack.last, bars[i] < bars[top] {
            let height = bars[stack.removeLast()]

            let width: Int
            if let last = stack.last {
                width = i - last - 1     // between new top and i, exclusive
            } else {
                width = i                // popped bar stretched from index 0
            }

            let area = height * width
            if area > maxArea {
                maxArea = area
            }
        }

        stack.append(i)
    }

    return maxArea
}

// MARK: - Dry Run
// [2,1,5,6,2,3] + sentinel 0
// i=0: push 0                      stack [0]
// i=1: 1<2 → pop 0, h=2, empty → w=1, area 2. push 1   [1]
// i=2: push 2                      [1,2]
// i=3: push 3                      [1,2,3]
// i=4: 2<6 → pop 3, h=6, w=4-2-1=1, area 6
//      2<5 → pop 2, h=5, w=4-1-1=2, area 10 ← max
//      push 4                      [1,4]
// i=5: push 5                      [1,4,5]
// i=6 (sentinel 0): pop 5 (area 3), pop 4 (w=6-1-1=4, area 8),
//      pop 1 (empty → w=6, area 6)
// Result: 10

// MARK: - Complexity
// Brute: O(n²) time, O(1) space.
// Stack: O(n) time (each index pushed/popped once), O(n) space.

// MARK: - Traps
// 1. Push INDICES, not heights — width math needs positions.
// 2. Empty-stack width = i (bar spanned from 0). [2,1,2] needs this for
//    the 1 to span width 3 → area 3.
// 3. Non-empty width = i - stack.last - 1, NOT i - stack.last.
// 4. Bars left on stack at the end never met a smaller bar — sentinel 0
//    appended to bars flushes them without a separate cleanup loop.
// 5. No min()/max() — explicit if comparisons. No force unwraps —
//    `if let last = stack.last` covers both branches.

// MARK: - Tests
let tests: [[Int]] = [
    [2, 1, 5, 6, 2, 3],   // 10
    [2, 4],               // 4
    [5, 5, 5],            // 15
    [2, 1, 2],            // 3
    [6],                  // 6
    [4, 3, 2, 1]          // 6 (height 2 × width 3... check: 3×2=6, 2×3=6)
]

for test in tests {
    print("input:", test)
    print("brute:    ", largestRectangleAreaBrute(test))
    print("optimised:", largestRectangleAreaOptimised(test))
    print("---")
}

// MARK: - Interview Q&A
// Q: Why a monotonic increasing stack?
// A: A bar's rectangle ends only when a shorter bar appears. Keeping indices
//    in increasing height order means the incoming shorter bar is the right
//    boundary, and the element below the popped one is the left boundary.
//
// Q: Why is it O(n) with a nested while?
// A: Amortised — each index is pushed once and popped at most once.
//
// Q: Why append a sentinel 0?
// A: 0 is shorter than every bar, so it forces all remaining stack entries
//    to pop and finalise — replaces a duplicate cleanup loop.
//
// Q: Follow-up this unlocks?
// A: LC 85 Maximal Rectangle — run this per row over a binary matrix.
