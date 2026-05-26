import Foundation

// ──────────────────────────────────────────
// LeetCode 283 — Move Zeroes
// Difficulty: Easy  |  Pattern: Two Pointers
// ──────────────────────────────────────────

// MARK: - Problem

/*
 Move all 0s to the end while keeping relative order of non-zeros.
 Must be done in-place.

 Input:  [0, 1, 0, 3, 12]
 Output: [1, 3, 12, 0, 0]

 Input:  [0, 0, 1]
 Output: [1, 0, 0]
*/

// MARK: - Interview Q&A

/*
 Q: What does insertPos represent?
 A: Next slot where a non-zero should go

 Q: Why swapAt(i, insertPos) not swapAt(nums[i], nums[insertPos])?
 A: swapAt takes index positions not values

 Q: Why != 0 not == 0?
 A: We trigger on non-zero — swap it forward, zeros fall behind naturally

 Q: Why insertPos++ after swap not before?
 A: Increment after swap — slot is now filled, move to next empty slot

 Q: Why O(n) not O(n²)?
 A: Each element visited exactly once — single pass
*/

// MARK: - Brute Force  O(n) time  O(n) space

/*
 Strategy:
 - Take new array
 - Loop nums → if num != 0 append to result
 - zeros count = nums.count - result.count
 - append zeros for that count
 - assign result back to nums

 INTERVIEW: Start here, explain before coding
*/

func bruteForce(_ nums: inout [Int]) {

    var result = [Int]()

    for num in nums {
        if num != 0 {
            result.append(num)
        }
    }

    let zerosCount = nums.count - result.count
    for _ in 0..<zerosCount {
        result.append(0)
    }

    nums = result
}

// MARK: - Optimal ⭐️  O(n) time  O(1) space

/*
 Strategy:
 - insertPos = 0
 - loop i through nums
 - if nums[i] != 0 → swapAt(i, insertPos) → insertPos++
 - zeros fall behind naturally

 INTERVIEW: swapAt takes indices not values
 INTERVIEW: != 0 triggers the swap — non-zero moves forward
 INTERVIEW: insertPos++ comes after swap — slot filled, move to next
*/

func optimised(_ nums: inout [Int]) {

    var insertPos = 0

    for i in 0..<nums.count {

        if nums[i] != 0 {
            nums.swapAt(i, insertPos)
            insertPos += 1
        }
    }
}

// MARK: - Tests

let tests: [([Int], [Int])] = [
    ([0, 1, 0, 3, 12],  [1, 3, 12, 0, 0]),
    ([0],               [0]),
    ([0, 0, 1],         [1, 0, 0]),
    ([1, 2, 3],         [1, 2, 3]),
    ([0, 0, 0, 1],      [1, 0, 0, 0])
]

print("--- Brute Force ---")
for (i, t) in tests.enumerated() {
    var input = t.0
    bruteForce(&input)
    print("Test \(i+1): \(input == t.1 ? "✅" : "❌") | Got: \(input) | Expected: \(t.1)")
}

print("\n--- Optimal ⭐️ ---")
for (i, t) in tests.enumerated() {
    var input = t.0
    optimised(&input)
    print("Test \(i+1): \(input == t.1 ? "✅" : "❌") | Got: \(input) | Expected: \(t.1)")
}
