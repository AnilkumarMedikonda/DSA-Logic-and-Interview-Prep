import Foundation

//==============================================================
// MARK: - Max Heap
//==============================================================

final class MaxHeap {

    private var heap = [Int]()

    var count: Int {
        heap.count
    }

    var isEmpty: Bool {
        heap.isEmpty
    }

    var peek: Int? {
        heap.first
    }

    func insert(_ value: Int) {
        heap.append(value)
        heapUp(heap.count - 1)
    }

    @discardableResult
    func remove() -> Int? {

        guard !heap.isEmpty else {
            return nil
        }

        if heap.count == 1 {
            return heap.removeLast()
        }

        let root = heap[0]

        heap[0] = heap.removeLast()

        heapDown(0)

        return root
    }

    private func heapUp(_ index: Int) {

        var child = index

        while child > 0 {

            let parent = (child - 1) / 2

            if heap[parent] >= heap[child] {
                break
            }

            heap.swapAt(parent, child)
            child = parent
        }
    }

    private func heapDown(_ index: Int) {

        var parent = index

        while true {

            let left = 2 * parent + 1
            let right = 2 * parent + 2

            var largest = parent

            if left < heap.count &&
                heap[left] > heap[largest] {

                largest = left
            }

            if right < heap.count &&
                heap[right] > heap[largest] {

                largest = right
            }

            if largest == parent {
                break
            }

            heap.swapAt(parent, largest)
            parent = largest
        }
    }
}

//==============================================================
// MARK: - Min Heap
//==============================================================

final class MinHeap {

    private var heap = [Int]()

    var count: Int {
        heap.count
    }

    var isEmpty: Bool {
        heap.isEmpty
    }

    var peek: Int? {
        heap.first
    }

    func insert(_ value: Int) {
        heap.append(value)
        heapUp(heap.count - 1)
    }

    @discardableResult
    func remove() -> Int? {

        guard !heap.isEmpty else {
            return nil
        }

        if heap.count == 1 { return heap.removeLast() }

        let root = heap[0]

        heap[0] = heap.removeLast()

        heapDown(0)

        return root
    }

    private func heapUp(_ index: Int) {

        var child = index

        while child > 0 {

            let parent = (child - 1) / 2

            if heap[parent] <= heap[child] {
                break
            }

            heap.swapAt(parent, child)
            child = parent
        }
    }

    private func heapDown(_ index: Int) {

        var parent = index

        while true {

            let left = 2 * parent + 1
            let right = 2 * parent + 2

            var smallest = parent

            if left < heap.count &&
                heap[left] < heap[smallest] {

                smallest = left
            }

            if right < heap.count &&
                heap[right] < heap[smallest] {

                smallest = right
            }

            if smallest == parent {
                break
            }

            heap.swapAt(parent, smallest)
            parent = smallest
        }
    }
}

//==============================================================
// MARK: - Median Finder (LC 295)
//==============================================================

final class MedianFinder {

    private let maxHeap = MaxHeap()   // lower half
    private let minHeap = MinHeap()   // upper half

    init() {}

    func addNum(_ num: Int) {

        // Fix 2: if-let instead of peek! force unwrap
        if let top = maxHeap.peek {
            if num <= top {
                maxHeap.insert(num)
            } else {
                minHeap.insert(num)
            }
        } else {
            maxHeap.insert(num)
        }

        if maxHeap.count > minHeap.count + 1 {
            if let value = maxHeap.remove() {
                minHeap.insert(value)
            }
        }

        if minHeap.count > maxHeap.count {
            if let value = minHeap.remove() {
                maxHeap.insert(value)
            }
        }
    }

    // Fix 1: findMeadin → findMedian
    func findMedian() -> Double {

        if maxHeap.count > minHeap.count {
            if let top = maxHeap.peek {
                return Double(top)
            }
        }

        if let maxTop = maxHeap.peek,
           let minTop = minHeap.peek {
            return Double(maxTop + minTop) / 2.0
        }

        return 0.0   // empty stream — LC guarantees findMedian isn't called before addNum
    }
}

// Test — Fix 3: corrected expected outputs
let medianFinder = MedianFinder()
medianFinder.addNum(1)
print(medianFinder.findMedian())     // 1.0

medianFinder.addNum(2)
print(medianFinder.findMedian())     // 1.5

medianFinder.addNum(3)
print(medianFinder.findMedian())     // 2.0

medianFinder.addNum(4)
print(medianFinder.findMedian())     // 2.5
