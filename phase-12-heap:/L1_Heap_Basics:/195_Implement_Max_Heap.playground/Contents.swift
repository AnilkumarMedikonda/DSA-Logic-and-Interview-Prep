// 195_Implement_Max_Heap
//
// PROBLEM:
// Build a MaxHeap class from scratch — array-backed, no Foundation helpers:
//   - insert(_ value: Int)       O(log n)
//   - remove() -> Int?           O(log n)  — extract the MAXIMUM
//   - peek() -> Int?             O(1)
//   - count / isEmpty            O(1)
//
// KEY INSIGHT vs 194: a max heap IS the min heap with every comparison
// flipped — nothing else changes. Diff the two classes: the only logic
// differences are four operators. Interview line: "min and max heap are
// one comparator apart — inject (Int, Int) -> Bool and one Heap type
// does both." (That becomes real code in 196.)
//
// HEAP PROPERTY (max-heap): every parent >= its children.
// Only the root is guaranteed: it is the maximum.

final class MaxHeap {

    private var heap = [Int]()

    var isEmpty: Bool {
        return heap.isEmpty
    }

    var count: Int {
        return heap.count
    }

    // Step 1: the root IS the maximum — O(1)
    func peek() -> Int? {
        return heap.first
    }

    // Step 2: insert = append + sift UP (identical shape to 194)
    func insert(_ value: Int) {
        heap.append(value)
        heapifyUp(from: heap.count - 1)
    }

    // Step 3: remove = take root, fill the hole with the LAST element,
    // sift DOWN — last-slot removal is what preserves completeness
    func remove() -> Int? {
        guard !heap.isEmpty else {
            return nil
        }

        if heap.count == 1 {
            return heap.removeLast()
        }

        let maxValue = heap[0]
        heap[0] = heap.removeLast()   // safe behind the guard
        heapifyDown(from: 0)

        return maxValue
    }

    // Step 4: sift UP — FLIP #1: parent >= child means the property
    // already holds, stop (194 had <=)
    private func heapifyUp(from index: Int) {
        var child = index

        while child > 0 {
            let parent = parentIndex(of: child)
            if heap[parent] >= heap[child] {
                break
            }
            heap.swapAt(parent, child)
            child = parent
        }
    }

    // Step 5: sift DOWN — FLIPS #2/#3: chase the LARGEST of the three,
    // with > comparisons (194 chased the smallest with <)
    private func heapifyDown(from index: Int) {
        var parent = index

        while true {
            let left = leftChildIndex(of: parent)
            let right = rightChildIndex(of: parent)

            var largest = parent

            if left < heap.count && heap[left] > heap[largest] {
                largest = left
            }
            if right < heap.count && heap[right] > heap[largest] {
                largest = right
            }

            if largest == parent {
                break
            }

            heap.swapAt(parent, largest)
            parent = largest
        }
    }

    // Step 6: index math — UNCHANGED from 194, and written visually
    // parallel on purpose (see trap below)
    private func parentIndex(of childIndex: Int) -> Int {
        return (childIndex - 1) / 2
    }

    private func leftChildIndex(of parentIndex: Int) -> Int {
        return 2 * parentIndex + 1
    }

    private func rightChildIndex(of parentIndex: Int) -> Int {
        return 2 * parentIndex + 2
    }

    func printHeap() {
        print(heap)
    }
}

// MARK: - Tests

let heap = MaxHeap()

// Empty heap
print(heap.remove() == nil)       // true
print(heap.peek() == nil)         // true

// Insert and verify the root tracks the MAXIMUM
for v in [5, 3, 8, 1, 9, 2] {
    heap.insert(v)
}
print(heap.count)                 // 6
if let top = heap.peek() {
    print(top)                    // 9
}

// Extract-all must come out DESCENDING — reverse heap sort
while let max = heap.remove() {
    print(max, terminator: " ")   // 9 8 5 3 2 1
}
print()
print(heap.isEmpty)               // true

// Duplicates behave
for v in [4, 4, 7, 7] {
    heap.insert(v)
}
while let max = heap.remove() {
    print(max, terminator: " ")   // 7 7 4 4
}
print()
