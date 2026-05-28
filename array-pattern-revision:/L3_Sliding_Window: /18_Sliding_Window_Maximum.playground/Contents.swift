import Foundation

// ──────────────────────────────────────────
// LeetCode 239 — Sliding Window Maximum
// Difficulty: Hard  |  Pattern: Sliding Window + Deque
// ──────────────────────────────────────────

// MARK: - Problem

/*
 Given array and window size k, return maximum of each sliding window.

 Input:  nums = [1,3,-1,-3,5,3,6,7],  k = 3
 Output: [3,3,5,5,6,7]

 Input:  nums = [1],  k = 1
 Output: [1]

 Key insight:
 Deque stores indices — front always holds index of current max
*/

// MARK: - Interview Q&A

/*
 Q: Why store indices not values in deque?
 A: Need to check if element is still inside window — value alone can't tell position

 Q: Why remove from front?
 A: Front index is outside window — front < right - k + 1

 Q: Why remove from back?
 A: Back values are smaller than current — they can never be max, useless

 Q: Why if for front but while for back?
 A: Only one index can be out of window at front | multiple smaller values at back

 Q: Why right >= k - 1 to record max?
 A: First full window is complete when right reaches k-1

 Q: Time and space?
 A: O(n) time — each index added and removed once | O(k) space — deque holds at most k indices
*/

// MARK: - Brute Force  O(n×k) time  O(1) space

/*
 Strategy:
 - Outer loop i → start of each window  (0 to n-k)
 - Inner loop j → i to i+k → find max
 - Append max to result

 INTERVIEW: Start here, explain before coding
*/

func bruteForce(_ nums: [Int], _ k: Int) -> [Int] {

    var result = [Int]()

    for i in 0...nums.count - k {

        var windowMax = Int.min

        for j in i..<i+k {
            windowMax = max(windowMax, nums[j])
        }

        result.append(windowMax)
    }

    return result
}

// MARK: - Optimal ⭐️  O(n) time  O(k) space

/*
 Strategy:
 Step 1 — remove front  → if front < right - k + 1 (outside window)
 Step 2 — remove back   → while nums[back] <= nums[right] (smaller, useless)
 Step 3 — append right  → add current index to back
 Step 4 — record max    → when right >= k-1, front = max index

 INTERVIEW: Deque is monotonically decreasing — front always max
 INTERVIEW: if for front (one old), while for back (many smaller)
 INTERVIEW: right - k + 1 = left boundary of current window
*/

func optimised(_ nums: [Int], _ k: Int) -> [Int] {

    var deque  = [Int]()
    var result = [Int]()

    for right in 0..<nums.count {

        // step 1 — remove front if outside window
        if let front = deque.first, front < right - k + 1 {
            deque.removeFirst()
        }

        // step 2 — remove back while smaller than current
        while let back = deque.last, nums[back] <= nums[right] {
            deque.removeLast()
        }

        // step 3 — add current index
        deque.append(right)

        // step 4 — record max when window is full
        if right >= k - 1, let front = deque.first {
            result.append(nums[front])
        }
    }

    return result
}

// MARK: - Tests

let tests: [(nums: [Int], k: Int, expected: [Int])] = [
    ([1,3,-1,-3,5,3,6,7], 3, [3,3,5,5,6,7]),
    ([1],                 1, [1]),
    ([1,3,1,2,0,5],       3, [3,3,2,5]),
    ([9,11],              2, [11]),
    ([4,3,2,1],           2, [4,3,2])
]

print("--- Brute Force ---")
for (i, t) in tests.enumerated() {
    let r = bruteForce(t.nums, t.k)
    print("Test \(i+1): \(r == t.expected ? "✅" : "❌") | Got: \(r) | Expected: \(t.expected)")
}

print("\n--- Optimal ⭐️ ---")
for (i, t) in tests.enumerated() {
    let r = optimised(t.nums, t.k)
    print("Test \(i+1): \(r == t.expected ? "✅" : "❌") | Got: \(r) | Expected: \(t.expected)")
}
