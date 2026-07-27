// 198. Top K Frequent Elements (LeetCode #347) ⭐Blind75
//
// Problem:
// Given an integer array nums and an integer k, return the k most
// frequent elements. You may return the answer in ANY order.
//
// Example 1: nums = [1,1,1,2,2,3], k = 2   → [1,2]
// Example 2: nums = [1], k = 1             → [1]
//
// Constraints:
// 1 <= nums.count <= 10^5
// k is always valid (1 <= k <= number of unique elements)
// Answer is guaranteed unique

// MARK: - Solution 1: Brute Force — Dictionary + Sort
// Step 1: Count frequency of each number
// Step 2: Sort dictionary entries by frequency descending
// Step 3: Take the first k keys
// Time: O(n log n) | Space: O(n)
func topKFrequentBrute(_ nums: [Int], _ k: Int) -> [Int] {
    var frequency = [Int: Int]()

    for num in nums {
        if let value = frequency[num] {
            frequency[num] = value + 1
        } else {
            frequency[num] = 1
        }
    }

    let sorted = frequency.sorted { $0.value > $1.value }
    return Array(sorted.prefix(k).map { $0.key })
}

// MARK: - Solution 2: MinHeap of size k — O(n log k)
// Same pattern as 197, but heap elements are (number, frequency) pairs
// and heapify compares on frequency.

struct HeapNode {
    let number: Int
    let frequency: Int
}

struct MinHeap {

    private var heap = [HeapNode]()

    var count: Int {
        heap.count
    }

    // Insert:
    // Step 1: Append at end (new leaf)
    // Step 2: Bubble UP until parent.frequency <= child.frequency
    mutating func insert(_ node: HeapNode) {
        heap.append(node)
        heapifyUp(heap.count - 1)
    }

    // Remove (min frequency):
    // Step 1: Guard empty → nil
    // Step 2: Single element → removeLast
    // Step 3: Swap root with last, remove last (that's the min)
    // Step 4: Bubble new root DOWN
    mutating func remove() -> HeapNode? {
        guard !heap.isEmpty else { return nil }

        if heap.count == 1 {
            return heap.removeLast()
        }

        heap.swapAt(0, heap.count - 1)
        let node = heap.removeLast()
        heapifyDown(0)

        return node
    }

    // Heapify Up:
    // Recompute parent from CURRENT child position each iteration
    private mutating func heapifyUp(_ index: Int) {
        var child = index

        while child > 0 {
            let parent = getParentIndex(child)

            if heap[parent].frequency <= heap[child].frequency {
                break
            }

            heap.swapAt(parent, child)
            child = parent
        }
    }

    // Heapify Down:
    // Step 1: Find smallest frequency among parent, left, right (strict <)
    // Step 2: If parent already smallest → done
    // Step 3: Else swap with smallest and continue from there
    private mutating func heapifyDown(_ index: Int) {
        var parent = index

        while true {
            let left = getLeftIndex(parent)
            let right = getRightIndex(parent)
            var smallest = parent

            if left < heap.count && heap[left].frequency < heap[smallest].frequency {
                smallest = left
            }

            if right < heap.count && heap[right].frequency < heap[smallest].frequency {
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
    private func getParentIndex(_ index: Int) -> Int {
        return (index - 1) / 2
    }

    private func getLeftIndex(_ index: Int) -> Int {
        return 2 * index + 1
    }

    private func getRightIndex(_ index: Int) -> Int {
        return 2 * index + 2
    }

    // Extract all numbers currently in the heap
    func values() -> [Int] {
        return heap.map { $0.number }
    }
}

// Top K using MinHeap:
// Step 1: Count frequencies (dictionary)
// Step 2: Insert each (number, frequency) pair into min-heap
// Step 3: If heap grows beyond k → remove root (drops least frequent)
// Step 4: Whatever remains = the k most frequent
// Time: O(n log k) | Space: O(n)
func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
    var frequency = [Int: Int]()

    for num in nums {
        if let value = frequency[num] {
            frequency[num] = value + 1
        } else {
            frequency[num] = 1
        }
    }

    var heap = MinHeap()

    for (number, count) in frequency {
        heap.insert(HeapNode(number: number, frequency: count))

        if heap.count > k {
            heap.remove()
        }
    }

    return heap.values()
}

// MARK: - Solution 3: Bucket Sort — O(n)
// Key insight: frequency can never exceed nums.count.
// Step 1: Count frequencies
// Step 2: bucket[f] = all numbers appearing exactly f times
// Step 3: Walk buckets from highest frequency down, collect k numbers
// Time: O(n) | Space: O(n)
func topKFrequentBucket(_ nums: [Int], _ k: Int) -> [Int] {
    var frequency = [Int: Int]()

    for num in nums {
        if let value = frequency[num] {
            frequency[num] = value + 1
        } else {
            frequency[num] = 1
        }
    }

    var buckets = [[Int]](repeating: [], count: nums.count + 1)
    for (number, count) in frequency {
        buckets[count].append(number)
    }

    var result = [Int]()
    for freq in stride(from: buckets.count - 1, through: 1, by: -1) {
        for number in buckets[freq] {
            result.append(number)
            if result.count == k { return result }
        }
    }
    return result
}

// MARK: - Test
print(topKFrequentBrute([1, 1, 1, 2, 2, 3], 2))   // [1, 2]
print(topKFrequent([1, 1, 1, 2, 2, 3], 2))        // [1, 2] (any order)
print(topKFrequentBucket([1, 1, 1, 2, 2, 3], 2))  // [1, 2]
print(topKFrequent([1], 1))                        // [1]
