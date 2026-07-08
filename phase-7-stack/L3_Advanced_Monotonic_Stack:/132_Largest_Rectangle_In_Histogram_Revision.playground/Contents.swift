import UIKit

// MARK: - Problem
// 132. Largest Rectangle in Histogram — REVISION (cold rewrite of 127 / LC 84)
// heights[i] = bar height, width 1. Return largest rectangle area.
// [2,1,5,6,2,3] → 10   [2,1,2] → 3   [4,3,2,1] → 6

// MARK: - Cold Rewrite Result (Jul 8, 2026)
// VERDICT: PASS with one reinforcement note.
// Retained cold (the hard parts):
//   ✓ sentinel 0 append
//   ✓ pop condition bars[top] > bars[i]
//   ✓ BOTH width branches, incl. empty-stack width = i
//   ✓ height captured before pop
// Slipped:
//   ✗ stck.append(i) — the PUSH half of the invariant (took 2 rounds to land)
//   ✗ rule habits on first pass (last!, max())
// → Next spaced revision (start of Trees phase): drill "pop violators,
//   then PUSH — both halves, every index."

// MARK: - Optimised (Monotonic Increasing Stack)
// T: O(n)  S: O(n)


func largestRectangleArea(_ heights: [Int]) -> Int {
    var maxArea = 0
    var stack = [Int]()

    var bars = heights
    bars.append(0)                       // sentinel — flushes the stack

    for i in 0..<bars.count {
        while let top = stack.last, bars[top] > bars[i] {
            let height = bars[top]
            stack.removeLast()

            let width: Int
            if let last = stack.last {
                width = i - last - 1
            } else {
                width = i
            }

            let size = height * width
            if maxArea < size {
                maxArea = size
            }
        }

        stack.append(i)                  // ← the half that slipped: EVERY index pushes
    }

    return maxArea
}

// MARK: - Dry Run
// [2,1,2] + sentinel → [2,1,2,0]
// i=0: push 0                         [0]
// i=1: 2>1 → pop 0, h=2, empty → w=1, size 2. push 1   [1]
// i=2: push 2                         [1,2]
// i=3 (0): 2>0 → pop 2, h=2, w=3-1-1=1, size 2
//          1>0 → pop 1, h=1, empty → w=3, size 3 ← the empty-branch proof
// Result: 3 ✓

// MARK: - Complexity
// O(n) time — each index pushed/popped once. O(n) space.

// MARK: - Traps
// 1. THE INVARIANT HAS TWO HALVES: pop violators, then PUSH the current
//    index. Dropping the push → stack stays empty → returns 0 for everything.
// 2. Empty-stack width = i, non-empty = i - last - 1. [2,1,2] → 3 proves it.
// 3. Sentinel 0 flushes remaining bars — no cleanup loop.
// 4. Run [2,1,2] BEFORE pasting — the missing push prints 0 instantly;
//    re-reading the diff didn't catch it, thirty seconds of running did.

// MARK: - Tests
let tests: [([Int], Int)] = [
    ([2, 1, 2], 3),
    ([2, 1, 5, 6, 2, 3], 10),
    ([4, 3, 2, 1], 6),
    ([5, 5, 5], 15),
    ([6], 6)
]

for (input, expected) in tests {
    print("input:", input, "→", largestRectangleArea(input), " expected:", expected)
}

// MARK: - Interview Q&A
// Q: What does a bar on the stack represent?
// A: A bar whose rectangle hasn't ended yet — no shorter bar seen since.
//    The incoming shorter bar is its right boundary; the element beneath
//    it after popping is its left boundary.
//
// Q: Why did the cold rewrite drop the push and not the width math?
// A: The width formula was studied as the "hard part" so it got encoding
//    effort; the push felt too obvious to rehearse. Revision lesson:
//    invariants need BOTH halves drilled, not just the clever half.
