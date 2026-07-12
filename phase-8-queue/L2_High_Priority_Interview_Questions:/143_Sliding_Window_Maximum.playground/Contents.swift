import Foundation

// MARK: - 1. Problem
/*
 143. Sliding Window Maximum (LC 239, Hard)

 Given nums and window size k, slide the window one step at a time
 and return the maximum of each window.

 nums = [1, 3, -1, -3, 5, 3, 6, 7], k = 3
 [1  3 -1] -3  5  3  6  7   → 3
  1 [3 -1  -3] 5  3  6  7   → 3
  1  3 [-1 -3  5] 3  6  7   → 5
  1  3  -1[-3  5  3] 6  7   → 5
  1  3  -1 -3 [5  3  6] 7   → 6
  1  3  -1 -3  5 [3  6  7]  → 7
 Output: [3, 3, 5, 5, 6, 7]      // length = n - k + 1

 Pattern: MONOTONIC DEQUE — Phase 7 monotonic stack + eviction
 from the front when indices expire out of the window.
 Both ends active → deque.
*/

// MARK: - 2. Brute Force — scan every window
/*
 For each of the n - k + 1 windows, scan its k elements for the max.
 Simple, correct — the oracle for testing the optimised version.
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

// MARK: - 3. Optimised — monotonic deque (indices, decreasing values)
/*
 Invariant: indices in the deque are in DECREASING order of their
 values, all inside the current window → front is always the answer.

 Per step:
 1. Front expired?  front < right - k + 1 → removeFirst
 2. Back useless?   nums[back] <= nums[right] → removeLast (flush)
    A smaller/equal value in front of a newer bigger one can
    NEVER be a window max again — same argument as Phase 7 stack.
 3. Append current index.
 4. Once right >= k - 1, the front is the window max.
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

// MARK: - 4. Dry Run  ([1,3,-1,-3,5,3,6,7], k = 3)
/*
 right=0  v=1                    deque=[0]
 right=1  v=3   evict back 0     deque=[1]
 right=2  v=-1  keep             deque=[1,2]     → nums[1]=3
 right=3  v=-3  keep             deque=[1,2,3]   → nums[1]=3
 right=4  v=5   front 1 expired; evict back 3,2  deque=[4] → 5
 right=5  v=3   keep             deque=[4,5]     → nums[4]=5
 right=6  v=6   evict back 5,4   deque=[6]       → 6
 right=7  v=7   evict back 6     deque=[7]       → 7

 Result: [3, 3, 5, 5, 6, 7] ✅
 right=4 is the money step: one new value flushes two dead ones —
 the amortisation made visible.
*/

// MARK: - 5. Complexity
/*
 Brute Force:  O(n·k) time, O(1) extra space
 Optimised:    O(n) amortised — every index enters the deque once
               and leaves at most once (same argument as the
               Phase 7 sentinel flush). Space O(k).
 Caveat: Array.removeFirst() is O(deque.count) ≤ O(k); a
 head-pointer (advance an index instead of removing) makes step 1
 strictly O(1) — same fix as 142's circular-buffer follow-up.
*/

// MARK: - 6. Traps
/*
 1. Store INDICES, not values — values can't tell you whether the
    front has expired out of the window.
 2. Eviction order matters: expire front FIRST, then flush back,
    then append. Appending first can evict the wrong element.
 3. Back flush uses <= — equal values are evicted so the NEWER
    index survives (it stays in-window longer).
 4. Record only from right >= k - 1 — the first full window.
 5. Front expiry: `if` suffices here because the window slides by
    exactly 1 → at most one expiry per step. In variable-window
    problems, use `while`.
*/

// MARK: - 7. Tests
func check(_ label: String, _ got: [Int], _ expected: [Int]) {
    print(got == expected ? "✅" : "❌", label, got)
}

let n1 = [1, 3, -1, -3, 5, 3, 6, 7]
check("brute standard", bruteForce(n1, 3), [3, 3, 5, 5, 6, 7])
check("opt   standard", optimised(n1, 3),  [3, 3, 5, 5, 6, 7])

// strictly decreasing — back never flushes, expiry does all the work
check("opt   decreasing", optimised([9, 8, 7, 6], 2), [9, 8, 7])

// strictly increasing — every new value flushes the whole deque
check("opt   increasing", optimised([1, 2, 3, 4], 2), [2, 3, 4])

// all equal — exercises the <=
check("opt   all equal", optimised([2, 2, 2], 2), [2, 2])

// k = 1 — every element is its own max
check("opt   k=1", optimised([4, -2, 7], 1), [4, -2, 7])

// k = n — single window
check("opt   k=n", optimised([3, 1, 5, 2], 4), [5])

// negatives
check("opt   negatives", optimised([-7, -3, -9, -1], 2), [-3, -3, -1])

// MARK: - 8. Interview Q&A
/*
 Q: Why indices in the deque, not values?
 A: Expiry check needs position — front < right - k + 1 is only
    answerable if you know WHERE the element is.

 Q: Why can the back be evicted when nums[back] <= nums[right]?
 A: The newer, bigger (or equal) value dominates it: it will be a
    valid candidate for every remaining window the old one is in.
    The old one can never be a max again — dead weight.

 Q: Why `if` for front expiry but `while` for the back?
 A: Fixed window slides by 1 → at most one front expiry per step.
    The back can hold many smaller values → flush needs a loop.

 Q: How is O(n) possible with a while loop inside a for loop?
 A: Amortisation — each index is appended once and removed at most
    once across the WHOLE run, so total deque work is ≤ 2n.

 Q: iOS bridge?
 A: Rolling max/min over live streams — peak memory in the last N
    samples (MetricKit), max frame time in a window for jank
    detection, rate-limit peak detection. Pair with 142's rolling
    average: same window, different aggregate.
*/
