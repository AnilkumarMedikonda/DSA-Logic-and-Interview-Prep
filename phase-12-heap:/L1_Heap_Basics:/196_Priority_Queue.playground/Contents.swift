// 196_Priority_Queue

// MARK: - PriorityQueue (wrapper over MaxHeap)
final class PriorityQueue {
    private var heap = MaxHeap()

    var isEmpty: Bool {
        return heap.isEmpty
    }

    var count: Int {
        return heap.count
    }

    // Step 1: Enqueue → just insert into heap → O(log n)
    func enqueue(_ value: Int) {
        heap.insert(value)
    }

    // Step 2: Dequeue → remove max (root) → O(log n)
    func dequeue() -> Int? {
        return heap.remove()
    }

    // Step 3: Peek → look at root without removing → O(1)
    func peek() -> Int? {
        return heap.peek()
    }
}

// MARK: - MaxHeap (array-based)
final class MaxHeap {

    private var heap = [Int]()

    var isEmpty: Bool {
        return heap.isEmpty
    }

    var count: Int {
        return heap.count
    }

    func peek() -> Int? {
        return heap.first   // root = max element
    }

    // Insert:
    // Step 1: Append value at the end (last leaf)
    // Step 2: Bubble it UP until parent >= child
    func insert(_ value: Int) {
        heap.append(value)
        heapifyUp(from: heap.count - 1)
    }

    // Remove (max):
    // Step 1: Guard empty → nil
    // Step 2: Single element → removeLast directly
    // Step 3: Save root (max), move last element to root
    // Step 4: Bubble root DOWN to restore heap property
    func remove() -> Int? {
        guard !heap.isEmpty else { return nil }

        if heap.count == 1 {
            return heap.removeLast()
        }

        let maxValue = heap[0]
        heap[0] = heap.removeLast()
        heapifyDown(from: 0)

        return maxValue
    }

    // Heapify Up:
    // While not at root, compare child with parent.
    // If parent >= child → heap property holds → stop.
    // Else swap and continue from parent's position.
    private func heapifyUp(from childIndex: Int) {
        var childIndex = childIndex

        while childIndex > 0 {
            let parentIndex = parent(of: childIndex)

            if heap[parentIndex] >= heap[childIndex] {
                break
            }

            heap.swapAt(parentIndex, childIndex)
            childIndex = parentIndex
        }
    }

    // Heapify Down:
    // Step 1: Find largest among parent, left child, right child
    // Step 2: If parent is already largest → done
    // Step 3: Else swap with largest child and continue from there
    private func heapifyDown(from parentIndex: Int) {
        var parent = parentIndex

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
                break   // heap property restored
            }

            heap.swapAt(parent, largest)
            parent = largest
        }
    }

    // MARK: - Index math (array-based heap)
    private func parent(of childIndex: Int) -> Int {
        return (childIndex - 1) / 2
    }

    private func leftChildIndex(of parentIndex: Int) -> Int {
        return 2 * parentIndex + 1
    }

    private func rightChildIndex(of parentIndex: Int) -> Int {
        return 2 * parentIndex + 2
    }
}

// MARK: - Test
let pq = PriorityQueue()
pq.enqueue(5)
pq.enqueue(1)
pq.enqueue(10)
pq.enqueue(3)

print(pq.peek()!)     // 10
print(pq.dequeue()!)  // 10
print(pq.dequeue()!)  // 5
print(pq.count)       // 2
