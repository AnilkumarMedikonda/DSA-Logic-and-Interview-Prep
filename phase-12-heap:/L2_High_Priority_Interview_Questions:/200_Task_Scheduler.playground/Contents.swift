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
// MARK: - LeetCode 621: Task Scheduler
// Solution 1 — Formula (Greedy)
// Time: O(n)   Space: O(1)
//==============================================================

func leastInterval(_ tasks: [Character], _ n: Int) -> Int {

    // Step 1: Count frequency of each task (A–Z → index 0–25)
    var frequency = Array(repeating: 0, count: 26)

    for task in tasks {
        if let ascii = task.asciiValue,
           let base = Character("A").asciiValue {
            frequency[Int(ascii - base)] += 1
        }
    }

    // Step 2: Find max frequency AND how many tasks are tied at max
    //         (single manual pass — no sort, no .max())
    var maxFrequency = 0
    var countOfMax = 0

    for value in frequency {
        if value > maxFrequency {
            maxFrequency = value      // new leader
            countOfMax = 1            // reset tie count
        } else if value == maxFrequency && value > 0 {
            countOfMax += 1           // another task tied at max
        }
    }

    // Step 3: Frame layout — (maxFrequency - 1) frames of width (n + 1),
    //         plus one final slot per task tied at max.
    //         AAABBB, n=2 → A B _ | A B _ | A B → (3-1)*(2+1) + 2 = 8
    let framed = (maxFrequency - 1) * (n + 1) + countOfMax

    // Step 4: Enough distinct tasks to fill every idle → no idles at all
    if tasks.count > framed {
        return tasks.count
    }

    return framed
}

//==============================================================
// MARK: - LeetCode 621: Task Scheduler
// Solution 2 — Heap + Cooldown Queue Simulation
// Time: O(n log 26)   Space: O(26)
// Use this variant when asked to reconstruct the actual schedule
//==============================================================

func leastIntervalHeap(_ tasks: [Character], _ n: Int) -> Int {

    // Step 1: Count frequencies (identity doesn't matter, only counts)
    var frequency = Array(repeating: 0, count: 26)

    for task in tasks {
        if let ascii = task.asciiValue,
           let base = Character("A").asciiValue {
            frequency[Int(ascii - base)] += 1
        }
    }

    // Step 2: Push all non-zero counts into a max heap —
    //         greedy: always run the most frequent remaining task
    let maxHeap = MaxHeap()

    for value in frequency {
        if value > 0 {
            maxHeap.insert(value)
        }
    }

    // Step 3: Cooldown queue of (remainingCount, readyTime) pairs;
    //         head index gives O(1) dequeue without removeFirst()
    var cooldown = [(remaining: Int, readyTime: Int)]()
    var head = 0

    var time = 0

    // Step 4: Simulate one time unit per iteration
    while !maxHeap.isEmpty || head < cooldown.count {

        time += 1

        // Step 5: Run the most frequent available task;
        //         empty heap here = an idle tick
        if let taskCount = maxHeap.remove() {
            if taskCount - 1 > 0 {
                cooldown.append((taskCount - 1, time + n))
            }
        }

        // Step 6: Release tasks whose cooldown just expired
        if head < cooldown.count && cooldown[head].readyTime == time {
            maxHeap.insert(cooldown[head].remaining)
            head += 1
        }
    }

    // Step 7: time = total intervals including idles
    return time
}

//==============================================================
// MARK: - Test Cases
//==============================================================

print(leastInterval(["A","A","A","B","B","B"], 2))              // 8
print(leastInterval(["A","A","A","B","B","B"], 0))              // 6
print(leastInterval(["A","A","A","B","B","B","C","C"], 2))      // 8
print(leastInterval(["A","A","A","A","B","C","D"], 2))          // 10

print(leastIntervalHeap(["A","A","A","B","B","B"], 2))          // 8
print(leastIntervalHeap(["A","A","A","B","B","B"], 0))          // 6
print(leastIntervalHeap(["A","A","A","B","B","B","C","C"], 2))  // 8
print(leastIntervalHeap(["A","A","A","A","B","C","D"], 2))      // 10
