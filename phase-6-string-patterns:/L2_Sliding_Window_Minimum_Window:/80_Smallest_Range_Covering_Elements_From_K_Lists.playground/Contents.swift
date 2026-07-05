import Foundation

// MARK: - Problem
/*
 LC 632 — Smallest Range Covering Elements From K Lists (Hard)

 You have k sorted lists of integers. Find the smallest range [a, b] that
 includes AT LEAST ONE number from EACH of the k lists.

 Range [a, b] is smaller than [c, d] if:
   - (b - a) < (d - c), OR
   - (b - a) == (d - c) AND a < c   (tie-break: smaller start wins)

 Example:
   nums = [[4,10,15,24,26], [0,9,12,20], [5,18,22,30]]
   Output: [20, 24]
   → 24 from list 0, 20 from list 1, 22 from list 2

 Constraints:
   - 1 <= k <= 3500
   - 1 <= nums[i].length <= 50
   - Lists are sorted in non-decreasing order

 Pattern link: "cover all k lists" is the same formed/required idea as
 Minimum Window Substring (#78–79), but over list indices instead of
 characters. The sorted lists unlock the k-pointer + min-heap optimisation.
 */

// MARK: - Brute Force (k = 3 only, for intuition)
/*
 Idea: try every combination of one element from each list. Track the
 combination with the smallest (max - min).

 NOTE: This only works for exactly 3 lists — it cannot generalise to k
 lists without recursion over the cartesian product. Kept here purely to
 build intuition about "one element per list defines a candidate range".

 T: O(n1 * n2 * n3)   ≈ O(n³)
 S: O(1)              (temp array is fixed size 3)
 */

func smallestRangeBruteForce(_ nums: [[Int]]) -> [Int] {

    var currentDifference: Int = Int.max
    var left = 0
    var right = 0

    for number in nums[0] {

        for number2 in nums[1] {

            for number3 in nums[2] {

                let array = [number, number2, number3]
                var minNumber: Int = Int.max
                var maxNumber: Int = Int.min

                for num in array {

                    if num < minNumber {
                        minNumber = num
                    }

                    if num > maxNumber {
                        maxNumber = num
                    }
                }

                let difference = maxNumber - minNumber

                if difference < currentDifference ||
                    (difference == currentDifference && minNumber < left) {

                    currentDifference = difference
                    left = minNumber
                    right = maxNumber
                }
            }
        }
    }

    return [left, right]
}

// MARK: - Optimised (k pointers + hand-rolled Min-Heap)
/*
 Idea:
 - Keep one pointer into each of the k lists (all start at index 0).
 - At any moment the candidate range is [min of pointed values, max of pointed values].
 - The ONLY move that can shrink the range is advancing the pointer that
   holds the current MIN:
     * advancing any other pointer keeps the min fixed and can only keep
       or grow the max → gap never shrinks.
 - A min-heap of size k gives the min in O(log k); currentMaximum is
   tracked separately and only ever increases (lists are sorted, so any
   pushed value ≥ the popped min from the same list).
 - Stop when the list holding the min is exhausted: every valid range
   needs an element from that list, and all of them have already been
   the window's min.

 bestGap = Int.max acts as the explicit "no answer recorded yet" flag,
 so the tie-break never compares against sentinel left/right values.

 T: O(N log k)   N = total elements; each element pushed/popped once
 S: O(k)         heap never exceeds k nodes
 */

struct HeapNode {
    let value: Int
    let listIndex: Int
    let elementIndex: Int
}

struct MinHeap {

    private var heap: [HeapNode] = []

    var isEmpty: Bool {
        heap.isEmpty
    }

    mutating func insert(_ node: HeapNode) {
        heap.append(node)
        siftUp(heap.count - 1)
    }

    mutating func remove() -> HeapNode? {

        guard !heap.isEmpty else {
            return nil
        }

        if heap.count == 1 {
            return heap.removeLast()
        }

        let root = heap[0]
        heap[0] = heap.removeLast()
        siftDown(0)

        return root
    }

    private mutating func siftUp(_ index: Int) {

        var child = index

        while child > 0 {

            let parent = (child - 1) / 2

            if heap[child].value < heap[parent].value {
                heap.swapAt(child, parent)
                child = parent
            } else {
                break
            }
        }
    }

    private mutating func siftDown(_ index: Int) {

        var parent = index

        while true {

            let leftChild = parent * 2 + 1
            let rightChild = parent * 2 + 2

            var smallest = parent

            if leftChild < heap.count &&
                heap[leftChild].value < heap[smallest].value {
                smallest = leftChild
            }

            if rightChild < heap.count &&
                heap[rightChild].value < heap[smallest].value {
                smallest = rightChild
            }

            if smallest == parent {
                break
            }

            heap.swapAt(parent, smallest)
            parent = smallest
        }
    }
}

func smallestRange(_ nums: [[Int]]) -> [Int] {

    var heap = MinHeap()
    var currentMaximum = Int.min

    // Seed heap with the first element of every list
    for list in 0..<nums.count {

        let value = nums[list][0]

        heap.insert(
            HeapNode(
                value: value,
                listIndex: list,
                elementIndex: 0
            )
        )

        if value > currentMaximum {
            currentMaximum = value
        }
    }

    var bestGap = Int.max
    var left = 0
    var right = 0

    while !heap.isEmpty {

        guard let node = heap.remove() else {
            break
        }

        let currentMinimum = node.value
        let currentGap = currentMaximum - currentMinimum

        if currentGap < bestGap ||
            (currentGap == bestGap && currentMinimum < left) {

            bestGap = currentGap
            left = currentMinimum
            right = currentMaximum
        }

        let nextIndex = node.elementIndex + 1

        // The list holding the min is exhausted → no further valid window
        if nextIndex == nums[node.listIndex].count {
            break
        }

        let nextValue = nums[node.listIndex][nextIndex]

        heap.insert(
            HeapNode(
                value: nextValue,
                listIndex: node.listIndex,
                elementIndex: nextIndex
            )
        )

        if nextValue > currentMaximum {
            currentMaximum = nextValue
        }
    }

    return [left, right]
}

// MARK: - Dry Run
/*
 nums = [[4,10,15,24,26], [0,9,12,20], [5,18,22,30]]

 Seed: heap = {0(L1), 4(L0), 5(L2)}   currentMaximum = 5

 Step | popped min | max | gap | best so far | pushed next
 -----|------------|-----|-----|-------------|------------
  1   | 0  (L1)    | 5   | 5   | [0, 5]      | 9  (L1) → max 9
  2   | 4  (L0)    | 9   | 5   | [0, 5]*     | 10 (L0) → max 10
  3   | 5  (L2)    | 10  | 5   | [0, 5]*     | 18 (L2) → max 18
  4   | 9  (L1)    | 18  | 9   | [0, 5]      | 12 (L1)
  5   | 10 (L0)    | 18  | 8   | [0, 5]      | 15 (L0)
  6   | 12 (L1)    | 18  | 6   | [0, 5]      | 20 (L1) → max 20
  7   | 15 (L0)    | 20  | 5   | [0, 5]*     | 24 (L0) → max 24
  8   | 18 (L2)    | 24  | 6   | [0, 5]      | 22 (L2)
  9   | 20 (L1)    | 24  | 4   | [20, 24] ✓  | L1 exhausted → break

 * gap ties with best (5) but min (4/5/15) is NOT < left (0) → keep [0, 5]

 Answer: [20, 24]
 */

// MARK: - Complexity
/*
 Brute force : T O(n³)        S O(1)     — and hardcoded to k = 3
 Optimised   : T O(N log k)   S O(k)     — N = total elements across lists

 Each of the N elements enters and leaves the heap at most once; every
 heap op costs O(log k) since the heap size is always exactly k (until
 the final break).
 */

// MARK: - Traps
/*
 1. Tie-break: `gap < best` alone is wrong — equal gap with smaller
    start must win. Compare (gap, start) lexicographically.
 2. Sentinel initial state: left = 0 / right = Int.max entangles the
    tie-break with fake values. Use an explicit bestGap = Int.max flag.
 3. Forgetting to update currentMaximum when pushing the next value —
    the max is NOT in the heap, it's tracked separately.
 4. Advancing the wrong pointer: only the MIN pointer can ever shrink
    the gap. Advancing the max pointer strictly grows or keeps the gap.
 5. Continuing after a list exhausts: once any list runs out, no future
    window can cover all k lists — must break, not skip.
 6. Assuming currentMaximum might need to decrease — it never does,
    because lists are sorted (pushed value ≥ popped value of same list).
 */

// MARK: - Tests

let test1 = [[4, 10, 15, 24, 26], [0, 9, 12, 20], [5, 18, 22, 30]]
print(smallestRangeBruteForce(test1))            // [20, 24]
print(smallestRange(test1))                      // [20, 24]

let test2 = [[1, 2, 3], [1, 2, 3], [1, 2, 3]]
print(smallestRange(test2))                      // [1, 1]

let test3 = [[10], [20], [30]]                   // single element each
print(smallestRange(test3))                      // [10, 30]

let test4 = [[5, 6, 7]]                          // k = 1
print(smallestRange(test4))                      // [5, 5]

let test5 = [[1, 100], [50, 51], [49, 52]]
print(smallestRange(test5))                      // [49, 52]

let test6 = [[-5, -3, 0], [-4, 2], [-6, -2]]     // negatives
print(smallestRange(test6))                      // [-5, -2]

// MARK: - Interview Q&A
/*
 Q1. Why is advancing the min pointer the only correct move?
 A.  The gap is max - min. Advancing any non-min pointer leaves the min
     unchanged and can only increase (or keep) the max → the gap can
     never shrink. Advancing the min is the only move with a chance of
     shrinking the gap.

 Q2. Why stop when one list is exhausted?
 A.  Every valid range needs at least one element from every list. Once
     a list runs out, all of its elements have already served as the
     window's min — no unseen valid window remains.

 Q3. Why does currentMaximum never need to decrease?
 A.  Lists are sorted, so the value pushed always ≥ the value popped
     from the same list. The set's maximum is monotonically
     non-decreasing, so a single running variable suffices — no
     max-heap needed.

 Q4. How does this relate to Minimum Window Substring (#78–79)?
 A.  Same "cover all k categories" requirement. The alternative
     solution flattens all elements to (value, listIndex) pairs, sorts
     them, and runs the exact formed/required sliding window —
     O(N log N). The heap version exploits pre-sorted lists to get
     O(N log k).

 Q5. Why a hand-rolled heap?
 A.  Swift's standard library has no priority queue. In interviews,
     either implement a binary heap (as here) or state you'd use
     swift-collections' Heap if third-party packages are allowed.

 Q6. Could a max-heap + min tracking work instead (advance the max)?
 A.  No — you can't "advance past" the max meaningfully; pointers move
     forward, values grow. Moving the max pointer grows the max further.
     Only the min side is shrinkable.
 */
