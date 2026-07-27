import Foundation

// LeetCode 1046 - Last Stone Weight
// Max heap smash simulation
// Time: O(n log n)   Space: O(n)

// MARK: - Max Heap

struct MaxHeap {

    private var heap = [Int]()

    var count: Int {
        heap.count
    }

    mutating func insert(_ value: Int) {
        heap.append(value)
        siftUp(heap.count - 1)
    }

    mutating func remove() -> Int? {

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

            if heap[parent] >= heap[child] {
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
                heap[left] > heap[largest] {
                largest = left
            }

            if right < heap.count &&
                heap[right] > heap[largest] {
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

func lastStoneWeight(_ stones: [Int]) -> Int {

    var heap = MaxHeap()

    // Insert all stones into the max heap
    for stone in stones {
        heap.insert(stone)
    }

    // Smash the two largest stones each round
    // Fix 1: if-let pair instead of remove()! force unwraps
    while heap.count > 1 {

        if let first = heap.remove(),
           let second = heap.remove() {

            // Equal stones destroy each other — insert nothing
            if first != second {
                heap.insert(first - second)
            }
        }
    }

    // Fix 2: explicit if let/else instead of ?? 0
    // Zero or one stone remains at this point
    if let last = heap.remove() {
        return last
    }

    return 0
}

// MARK: - Test

print(lastStoneWeight([2,7,4,1,8,1]))   // 1
print(lastStoneWeight([1]))             // 1
print(lastStoneWeight([2,2]))           // 0  — full cancel
print(lastStoneWeight([10,4,2,10]))     // 2  — equal pair cancels first
