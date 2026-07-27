// 197. Kth Largest Element in an Array (LeetCode #215) ⭐NeetCode
//
// Problem:
// Given an integer array nums and an integer k, return the kth largest
// element in the array. Note: it is the kth largest in SORTED order,
// not the kth distinct element.
// Can you solve it without fully sorting?
//
// Example 1: nums = [3,2,1,5,6,4], k = 2          → 5
// Example 2: nums = [3,2,3,1,2,4,5,5,6], k = 4    → 4
//
// Constraints: 1 <= k <= nums.count <= 10^5

// MARK: - Solution 1: Brute Force — Sort
// Step 1: Sort descending
// Step 2: kth largest sits at index k-1
// Time: O(n log n) | Space: O(n) (or O(log n) in-place)
func findKthLargestBrute(_ nums: [Int], _ k: Int) -> Int {
    let sorted = nums.sorted(by: >)
    return sorted[k - 1]
}

// MARK: - Solution 2: Optimized — MinHeap of size k
// Idea: keep only the k largest elements in a min-heap.
// The root (minimum of those k) is the kth largest overall.
// Time: O(n log k) | Space: O(k)

struct MinHeap {

    private var heap = [Int]()

    var count: Int {
        heap.count
    }

    var peek: Int? {
        heap.first   // root = minimum
    }

    // Insert:
    // Step 1: Append at end
    // Step 2: Bubble UP until parent <= child (min-heap rule)
    mutating func insert(_ value: Int) {
        heap.append(value)
        heapifyUp(heap.count - 1)
    }

    // Remove (min):
    // Step 1: Guard empty → nil
    // Step 2: Single element → removeLast
    // Step 3: Swap root with last, remove last (that's the min)
    // Step 4: Bubble new root DOWN to restore heap property
    mutating func remove() -> Int? {
        guard !heap.isEmpty else { return nil }

        if heap.count == 1 {
            return heap.removeLast()
        }

        heap.swapAt(0, heap.count - 1)
        let value = heap.removeLast()
        heapifyDown(0)          // restore heap property

        return value
    }

    // Heapify Up:
    // Recompute parent from the CURRENT child position every iteration
    private mutating func heapifyUp(_ index: Int) {
        var childIndex = index

        while childIndex > 0 {
            let parentIndex = parentIndex(of: childIndex)

            if heap[parentIndex] <= heap[childIndex] {
                break
            }

            heap.swapAt(parentIndex, childIndex)
            childIndex = parentIndex
        }
    }

    // Heapify Down:
    // Step 1: Find smallest among parent, left, right
    // Step 2: If parent already smallest → done
    // Step 3: Else swap with smallest child, continue from there
    private mutating func heapifyDown(_ index: Int) {
        var parent = index

        while true {
            let left = leftIndex(of: parent)
            let right = rightIndex(of: parent)
            var smallest = parent

            if left < heap.count && heap[left] < heap[smallest] {
                smallest = left
            }

            if right < heap.count && heap[right] < heap[smallest] {
                smallest = right
            }

            if smallest == parent {
                break
            }

            heap.swapAt(parent, smallest)
            parent = smallest
        }
    }

    // MARK: - Helper functions (index math)
    private func parentIndex(of index: Int) -> Int {
        return (index - 1) / 2
    }

    private func leftIndex(of index: Int) -> Int {
        return 2 * index + 1
    }

    private func rightIndex(of index: Int) -> Int {
        return 2 * index + 2
    }
}

// Kth Largest using MinHeap:
// Step 1: Insert each number
// Step 2: If heap grows beyond k → remove root (drops the smallest)
// Step 3: After the loop, root = kth largest
func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
    var heap = MinHeap()

    for num in nums {
        heap.insert(num)

        if heap.count > k {
            heap.remove()
        }
    }

    return heap.peek!   // safe: k >= 1 guarantees heap is non-empty
}

// MARK: - Test
print(findKthLargestBrute([3, 2, 1, 5, 6, 4], 2))      // 5
print(findKthLargest([3, 2, 1, 5, 6, 4], 2))           // 5
print(findKthLargest([3, 2, 3, 1, 2, 4, 5, 5, 6], 4))  // 4
