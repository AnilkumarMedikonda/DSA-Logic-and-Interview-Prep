import Foundation

/*
 =========================================================
    121 - NEXT GREATER ELEMENT I  (LC 496)  ⭐ NeetCode
 =========================================================

 Problem
 -------
 nums1 is a subset of nums2. For each element of nums1,
 find the NEXT GREATER element to its right in nums2 —
 the first element after its position that is bigger.
 No such element → -1.

 nums1 = [4,1,2], nums2 = [1,3,4,2]
   4 → after 4 in nums2: [2] → nothing bigger → -1
   1 → after 1: [3,4,2] → first bigger = 3
   2 → after 2: [] → -1
 Output: [-1, 3, -1]

 Interview rate: 🟡 Medium as-is — but it OPENS the
 monotonic stack pattern that carries 122 Daily Temps 🔴,
 123 Stock Span, 126 Asteroids, 127 Histogram 🟠, 130, 131.

 ---------------------------------------------------------

 THE PATTERN — Monotonic Stack (the waiting room)
 ------------------------------------------------
 Walk the array once. Stack = elements still WAITING for
 their answer. Every new arrival does two jobs IN ORDER:

   JOB 1 — ANSWER: while top waiter < me → pop, I am its
           next greater. (while, not if — one arrival can
           answer SEVERAL waiters.)
   JOB 2 — WAIT:   push myself.

 Invariant: stack stays DECREASING bottom→top — not sorted
 by us, but because anything bigger resolves waiters before
 joining. Disorder is impossible by construction.

 Why O(n) despite the nested look: each element is pushed
 once and popped AT MOST once — total pops ≤ n, amortized.

 The three knobs that turn this into 7 problems:
   compare (< vs >) · push (values vs indices) · record
   (value / distance / count / area)

 =========================================================
 */

//==========================================================
// MARK: - Brute Force — find + scan right, O(n·m)
//==========================================================

func indexOf(_ nums: [Int], _ target: Int) -> Int {

    for i in 0..<nums.count {
        if nums[i] == target {
            return i
        }
    }
    return -1                       // -1 convention (#100)
}

func nextGreaterElementBrute(_ nums1: [Int], _ nums2: [Int]) -> [Int] {

    var result: [Int] = []

    for num in nums1 {
        var nextGreater = -1
        let index = indexOf(nums2, num)

        if index != -1 {            // found → scan (NOT == -1 — my flip bug)
            for i in (index + 1)..<nums2.count {
                if nums2[i] > num {
                    nextGreater = nums2[i]
                    break
                }
            }
        }
        result.append(nextGreater)
    }

    return result
}

//==========================================================
// MARK: - Optimised — Monotonic Stack, O(n + m)
//==========================================================

func nextGreaterElement(_ nums1: [Int], _ nums2: [Int]) -> [Int] {

    var answers = [Int: Int]()      // element → its next greater (the notebook)
    var stack = [Int]()             // the waiting room (decreasing bottom→top)

    // ---- Walk nums2 once ----
    for num in nums2 {

        // JOB 1: "is anyone waiting for me?"
        // Guard FIRST — && short-circuits, peek never runs on empty
        while stack.isEmpty == false && stack[stack.count - 1] < num {
            let waiter = stack.removeLast()
            answers[waiter] = num           // waiter's story ends here
        }

        // JOB 2: now I wait
        stack.append(num)
    }
    // Leftovers on the stack = never answered = the -1s
    // (no notebook entry — handled by if let below)

    // ---- Map nums1 through the notebook ----
    var result = [Int]()

    for num in nums1 {
        if let found = answers[num] {
            result.append(found)
        } else {
            result.append(-1)               // dictionary miss = -1 (no ??)
        }
    }

    return result
}

//==========================================================
// MARK: - Dry Run
//==========================================================
/*
 nums2 = [1, 3, 4, 2]

 num=1: room empty → push.                room [1]      notebook {}
 num=3: peek 1, 1<3 → pop, [1]=3.
        empty → push.                     room [3]      notebook {1:3}
 num=4: peek 3, 3<4 → pop, [3]=4. push.   room [4]      notebook {1:3, 3:4}
 num=2: peek 4, 4<2? NO → just push.      room [4,2]    notebook {1:3, 3:4}
 END:   4, 2 still waiting → -1.

 nums1 [4,1,2] → [-1, 3, -1] ✅

 The multi-pop moment (why WHILE): nums2 = [5,4,3,10]
 room builds to [5,4,3]; 10 arrives → pops 3, then 4,
 then 5 — ONE arrival, THREE answers. An `if` would
 answer only 3 and leave 4, 5 wrongly at -1.
 */

//==========================================================
// MARK: - Complexity
//==========================================================
/*
 Brute    : T O(n·m) — per nums1 element: find O(m) + scan O(m)
            S O(n) result
 Optimised: T O(n + m) — each nums2 element pushed once,
            popped ≤ once (amortized); nums1 lookups O(1)
            S O(m) — stack + dictionary
 */

//==========================================================
// MARK: - Traps
//==========================================================
/*
 1. `if` instead of `while` for the pop — one arrival can
    answer several waiters ([5,4,3,10]); `if` leaves wrong -1s.
 2. Guard order: isEmpty check must come BEFORE the peek —
    && short-circuit is the crash protection.
 3. Push AFTER the while, not before — I answer first, wait second.
 4. Brute: inverted guard `if index == -1` scanned only on
    NOT-found → all -1s. (My bug — the ==/!= flip family.)
 5. Brute: scan starts at index+1 — "next" means AFTER me.
 6. Helper returning 0 on not-found lies silently; -1 convention.
 7. `??` on the dictionary lookup — house rules say if let/else.
 */

//==========================================================
// MARK: - Tests
//==========================================================

let testCases: [(nums1: [Int], nums2: [Int], expected: [Int])] = [
    ([4, 1, 2], [1, 3, 4, 2], [-1, 3, -1]),
    ([2, 4], [1, 2, 3, 4], [3, -1]),
    ([1], [1], [-1]),
    ([2, 1, 5], [2, 1, 5, 3, 6], [5, 5, 6]),        // walkthrough array
    ([5, 4, 3], [5, 4, 3, 10], [10, 10, 10]),       // the multi-pop proof
    ([3], [1, 2, 3], [-1])                          // last element waits forever
]

var testIndex = 1
for testCase in testCases {
    let bruteResult = nextGreaterElementBrute(testCase.nums1, testCase.nums2)
    let stackResult = nextGreaterElement(testCase.nums1, testCase.nums2)

    let ok = bruteResult == testCase.expected && stackResult == testCase.expected
    print("Test \(testIndex): expected \(testCase.expected) | brute \(bruteResult) | stack \(stackResult) \(ok ? "✅" : "❌")")
    testIndex += 1
}

//==========================================================
// MARK: - Interview Q&A
//==========================================================
/*
 Q1: Isn't the while-inside-for O(n²)?
 A : No — amortized O(n). Each element is pushed exactly once
     and popped at most once; total pops across the whole walk
     are ≤ n. The while's cost is spread over all iterations.

 Q2: Why does the stack stay decreasing?
 A : The pop rule makes disorder impossible: anything bigger
     than the top resolves waiters BEFORE joining, so only
     smaller-or-equal elements ever pile up. Self-maintaining.

 Q3: What changes for Next SMALLER Element?
 A : One character — top > num instead of top < num. The
     stack flips to increasing. Same two jobs.

 Q4: When do you push indices instead of values?
 A : When the answer involves position or distance — 122
     Daily Temperatures needs i - poppedIndex ("how many
     days"), so values alone are useless. Indices are the
     more general choice.

 Q5: Follow-ups on this exact problem?
 A : LC 503 NGE II (circular — loop the array twice, indices
     mod n), 122 Daily Temperatures (distance), 123 Stock
     Span (counts). All the same skeleton, different knobs.

 =========================================================
 */
