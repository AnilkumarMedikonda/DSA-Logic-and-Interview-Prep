// 194_Implement_Min_Heap
//
// PROBLEM:
// Build a MinHeap class from scratch — array-backed, no Foundation helpers:
//   - insert(_ value: Int)       O(log n)
//   - remove() -> Int?           O(log n)  — extract the minimum
//   - peek() -> Int?             O(1)
//   - count / isEmpty            O(1)
//
// KEY CONCEPT — the one idea of the whole Heap phase:
// A heap is a COMPLETE binary tree stored in a plain array — no TreeNode,
// no pointers. Completeness (every level full except the last, filled left
// to right) is what makes pure index math work:
//   parent(i) = (i - 1) / 2   |   left(i) = 2i + 1   |   right(i) = 2i + 2
//
// HEAP PROPERTY (min-heap): every parent <= its children. The array is NOT
// sorted — only the root is guaranteed: it is the minimum.

final class MinHeap {

    private var heap = [Int]()

    var isEmpty: Bool {
        return heap.isEmpty
    }

    var count: Int {
        return heap.count
    }

    // Step 1: the root IS the minimum — O(1), optional, no force unwrap
    func peek() -> Int? {
        return heap.first
    }

    // Step 2: insert = append + sift UP
    // Appending at the end keeps the tree complete; the new value then
    // bubbles up past every parent larger than it — at most O(log n) swaps
    func insert(_ value: Int) {
        heap.append(value)
        heapifyUp(from: heap.count - 1)
    }

    // Step 3: remove = take root, fill the hole with the LAST element,
    // sift DOWN. Removing the last slot keeps completeness — popping the
    // root directly would shift the whole array (O(n)) and break the math
    func remove() -> Int? {
        guard !heap.isEmpty else {
            return nil
        }

        // Single element — nothing to restore
        if heap.count == 1 {
            return heap.removeLast()
        }

        let minValue = heap[0]

        // Move last element to root (removeLast is safe behind the guard)
        heap[0] = heap.removeLast()

        // Restore the heap property
        heapifyDown(from: 0)

        return minValue
    }

    // Step 4: sift UP — swap with the parent while the child is smaller;
    // stop at the root (child > 0) or when the parent is already <=
    private func heapifyUp(from index: Int) {
        var child = index

        while child > 0 {
            let parent = parentIndex(of: child)
            if heap[parent] <= heap[child] { break }
            heap.swapAt(parent, child)
            child = parent
        }
    }

    // Step 5: sift DOWN — find the smallest of {parent, left, right},
    // swap toward it, repeat. Bounds-check BOTH children: a node may have
    // only a left child, or none
    private func heapifyDown(from index: Int) {
        var parent = index

        while true {
            let left = leftChildIndex(of: parent)
            let right = rightChildIndex(of: parent)

            var smallest = parent

            if left < heap.count && heap[left] < heap[smallest] {
                smallest = left
            }
            if right < heap.count && heap[right] < heap[smallest] {
                smallest = right
            }

            // Neither child is smaller — the property holds, stop
            if smallest == parent {
                break
            }

            heap.swapAt(parent, smallest)
            parent = smallest
        }
    }

    // Step 6: the index math — completeness makes these exact
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

let heap = MinHeap()

// Empty heap
print(heap.remove() == nil)       // true
print(heap.peek() == nil)         // true

// Insert and verify the root tracks the minimum
for v in [5, 3, 8, 1, 9, 2] {
    heap.insert(v)
}
print(heap.count)                 // 6
if let top = heap.peek() {
    print(top)                    // 1
}

// Extract-all must come out SORTED — heap sort falling out for free
while let min = heap.remove() {
    print(min, terminator: " ")   // 1 2 3 5 8 9
}
print()
print(heap.isEmpty)               // true

// Duplicates behave
for v in [4, 4, 2, 2] {
    heap.insert(v)
}
while let min = heap.remove() {
    print(min, terminator: " ")   // 2 2 4 4
}
print()
