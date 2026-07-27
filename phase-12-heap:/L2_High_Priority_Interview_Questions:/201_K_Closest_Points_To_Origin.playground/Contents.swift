import Foundation

// MARK: - Max Heap

struct HeapNode {
    let distance: Int
    let point: [Int]
}

struct MaxHeap {

    private var heap = [HeapNode]()

    var count: Int {
        heap.count
    }

    var elements: [HeapNode] {
        heap
    }

    mutating func insert(_ node: HeapNode) {
        heap.append(node)
        siftUp(heap.count - 1)
    }

    // Fix 1: @discardableResult — kClosest evicts without using the value
    @discardableResult
    mutating func remove() -> HeapNode? {

        guard !heap.isEmpty else {
            return nil
        }

        if heap.count == 1 {
            return heap.removeLast()
        }

        heap.swapAt(0, heap.count - 1)
        let value = heap.removeLast()
        siftDown(0)
        return value
    }

    private mutating func siftUp(_ index: Int) {

        var child = index

        while child > 0 {

            let parent = (child - 1) / 2

            if heap[parent].distance >= heap[child].distance {
                return
            }

            heap.swapAt(parent, child)
            child = parent
        }
    }

    private mutating func siftDown(_ index: Int) {

        var parent = index

        while true {

            let left = parent * 2 + 1
            let right = parent * 2 + 2

            var largest = parent

            if left < heap.count &&
                heap[left].distance > heap[largest].distance {
                largest = left
            }

            if right < heap.count &&
                heap[right].distance > heap[largest].distance {
                largest = right
            }

            if largest == parent {
                return
            }

            heap.swapAt(parent, largest)
            parent = largest
        }
    }
}

// MARK: - Solution
// LeetCode 973 - K Closest Points to Origin
// Size-k max heap: keep the k closest seen so far, evict the farthest
// Time: O(n log k)   Space: O(k)

func kClosest(_ points: [[Int]], _ k: Int) -> [[Int]] {

    var heap = MaxHeap()

    for point in points {

        let x = point[0]
        let y = point[1]

        // Squared distance — sqrt not needed, ordering is identical
        let distance = x * x + y * y

        heap.insert(
            HeapNode(
                distance: distance,
                point: point
            )
        )

        // More than k points held → evict the farthest (heap root)
        if heap.count > k {
            heap.remove()
        }
    }

    // Heap order, not sorted by distance — LC 973 accepts any order
    return heap.elements.map { $0.point }
}

// MARK: - Test

print(kClosest([[1,3], [-2,2], [5,8]], 1))
// [[-2,2]]

// Fix 2: LC example 2 — exercises eviction with k = 2
print(kClosest([[3,3], [5,-1], [-2,4]], 2))
// [[3,3],[-2,4]] — any order accepted
