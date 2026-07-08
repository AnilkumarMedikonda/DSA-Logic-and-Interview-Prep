import UIKit

// MARK: - Problem
// 130. Next Greater Element II (LC 503) — Medium
// ⚠️ FILED READ-NOT-DERIVED (interview-frequency triage, per Phase 6 precedent).
// Circular array: answer[i] = first element STRICTLY greater than nums[i]
// scanning forward, wrapping to the start. None → -1.
// [1,2,1] → [2,-1,2]   [5,4,3,2,1] → [-1,5,5,5,5]   [3,3,3] → [-1,-1,-1]
//
// Key: linear NGE (owned) + one trick — loop 2n times with i % n to
// simulate the wrap. Push indices only in pass one.

// MARK: - Brute Force
// Per element, scan forward up to n-1 steps with modulo.
// T: O(n²)  S: O(1) extra
func nextGreaterElementsBrute(_ nums: [Int]) -> [Int] {
    let n = nums.count
    var answer = [Int](repeating: -1, count: n)

    for i in 0..<n {
        var step = 1
        while step < n {
            let j = (i + step) % n
            if nums[j] > nums[i] {
                answer[i] = nums[j]
                break
            }
            step += 1
        }
    }

    return answer
}

// MARK: - Optimised (Monotonic Decreasing Stack, 2n Loop)
// Stack holds INDICES of elements still waiting for their next greater.
// Loop i in 0..<2n, index = i % n:
//   - while incoming value > value at top → pop, incoming resolves it
//   - push index ONLY when i < n (second-pass pushes are dead duplicates)
// T: O(n) — each index pushed/popped ≤ once despite the 2n loop  S: O(n)
func nextGreaterElements(_ nums: [Int]) -> [Int] {
    let n = nums.count
    var answer = [Int](repeating: -1, count: n)
    var stack = [Int]()

    var i = 0
    while i < 2 * n {
        let index = i % n

        while let top = stack.last, nums[index] > nums[top] {
            answer[top] = nums[index]
            stack.removeLast()
        }

        if i < n {
            stack.append(index)
        }

        i += 1
    }

    return answer
}

// MARK: - Dry Run
// [1,2,1], n=3, loop i 0..5
// i=0 idx 0 (1): push 0                 [0]        ans [-1,-1,-1]
// i=1 idx 1 (2): 2>1 → pop 0, ans[0]=2; push 1     ans [2,-1,-1]  [1]
// i=2 idx 2 (1): 1>2? no → push 2       [1,2]
// i=3 idx 0 (1): 1>1? no (strict) — no push (pass 2)
// i=4 idx 1 (2): 2>1 → pop 2, ans[2]=2; 2>2? no    ans [2,-1,2]   [1]
// i=5 idx 2 (1): no pop, no push
// Result: [2,-1,2] ✓  (index 1 stays -1 — nothing greater than the max)

// MARK: - Complexity
// Brute O(n²). Stack O(n) time — the 2n loop doesn't change the amortised
// bound: each index enters and leaves the stack at most once. O(n) space.

// MARK: - Traps
// 1. Loop 2n with index = i % n — simulates the wrap without rotating.
// 2. Push ONLY when i < n. Second-pass pushes can never be resolved by
//    anything new — they just churn the stack.
// 3. STRICTLY greater: pop on >, not >=. [3,3,3] must be [-1,-1,-1].
// 4. [5,4,3,2,1]: the max (index 0) must stay -1 despite being visited
//    twice — if it shows 5, you popped on >= or pushed in pass two.
// 5. Prefill answer with -1 — unresolved indices need no cleanup pass.
// 6. Stack holds indices, not values — you're writing into answer[top].

// MARK: - Tests
let cases: [([Int], [Int])] = [
    ([1, 2, 1], [2, -1, 2]),
    ([1, 2, 3, 4, 3], [2, 3, 4, -1, 4]),
    ([5, 4, 3, 2, 1], [-1, 5, 5, 5, 5]),
    ([3, 3, 3], [-1, -1, -1]),
    ([1], [-1])
]

for (input, expected) in cases {
    print("input:", input)
    print("brute:    ", nextGreaterElementsBrute(input))
    print("optimised:", nextGreaterElements(input))
    print("expected: ", expected)
    print("---")
}

// MARK: - Interview Q&A
// Q: Why is it O(n) when the loop runs 2n times?
// A: Amortised over pushes/pops — only n pushes happen (pass one), so at
//    most n pops. The loop count doesn't add stack work.
//
// Q: Why not just duplicate the array (nums + nums)?
// A: Works, but costs O(n) extra copy; i % n gets the same effect free.
//
// Q: Relation to linear NGE (LC 496)?
// A: Identical core — decreasing stack of unresolved indices. The only
//    additions are the 2n loop and the pass-one push guard.
