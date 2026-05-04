import UIKit

// ======================================================
// MARK: - HEAP (FULL NOTES + IMPLEMENTATION)
// ======================================================

/*
 A Heap is a Complete Binary Tree that follows a rule.

 TYPES:
 1. Max Heap → Parent ≥ Children
 2. Min Heap → Parent ≤ Children

 ------------------------------------------------------

 ARRAY REPRESENTATION (IMPORTANT):

 Index:   0   1   2   3   4
 Value:  [10, 5, 3, 4, 1]

 FORMULAS:
 left child  = 2*i + 1
 right child = 2*i + 2
 parent      = (i - 1) / 2

 ------------------------------------------------------

 TIME COMPLEXITY:

 Insert  → O(log n)
 Delete  → O(log n)
 Heapify → O(log n)
 Build Heap → O(n)

 ------------------------------------------------------

 INTERVIEW LINE:
 "Heap is used to efficiently get max/min element
 in O(1) time and update in O(log n)."
*/

// ======================================================
// MARK: - HEAPIFY (Max Heap)
// ======================================================

/*
 Fix heap property from index i
*/

func heapify(_ arr: inout [Int], _ n: Int, _ i: Int) {
    
    var largest = i
    
    let left = 2 * i + 1
    let right = 2 * i + 2
    
    // Check left child
    if left < n && arr[left] > arr[largest] {
        largest = left
    }
    
    // Check right child
    if right < n && arr[right] > arr[largest] {
        largest = right
    }
    
    // If root is not largest → swap and continue
    if largest != i {
        let temp = arr[i]
        arr[i] = arr[largest]
        arr[largest] = temp
        
        heapify(&arr, n, largest)
    }
}


// ======================================================
// MARK: - BUILD MAX HEAP
// ======================================================

/*
 Convert array into Max Heap
*/

func buildMaxHeap(_ arr: inout [Int]) {
    
    let n = arr.count
    
    var i = n / 2 - 1
    while i >= 0 {
        heapify(&arr, n, i)
        i -= 1
    }
}


// ======================================================
// MARK: - INSERT INTO HEAP
// ======================================================

/*
 Insert element and fix heap (heapify up)
*/

func insert(_ arr: inout [Int], _ value: Int) {
    
    arr.append(value)
    
    var i = arr.count - 1
    
    // Move up
    while i > 0 {
        let parent = (i - 1) / 2
        
        if arr[parent] < arr[i] {
            let temp = arr[parent]
            arr[parent] = arr[i]
            arr[i] = temp
            
            i = parent
        } else {
            break
        }
    }
}


// ======================================================
// MARK: - DELETE ROOT (MAX ELEMENT)
// ======================================================

/*
 Remove root and fix heap
*/

func deleteRoot(_ arr: inout [Int]) {
    
    let n = arr.count
    
    if n == 0 { return }
    
    // Replace root with last element
    arr[0] = arr[n - 1]
    arr.removeLast()
    
    // Fix heap
    heapify(&arr, arr.count, 0)
}


// ======================================================
// MARK: - TEST CASES
// ======================================================

var heap = [4, 10, 3, 5, 1]

print("Original:", heap)

// Build heap
buildMaxHeap(&heap)
print("Max Heap:", heap)

// Insert
insert(&heap, 15)
print("After Insert 15:", heap)

// Delete root
deleteRoot(&heap)
print("After Delete Root:", heap)


// ======================================================
// MARK: - FINAL SUMMARY
// ======================================================

/*
 KEY POINTS:

 ✔ Heap gives fast access to max/min
 ✔ Used in Priority Queue
 ✔ Important for Top K problems

 ------------------------------------------------------

 USE CASES:

 ✔ Kth Largest Element
 ✔ Top K Frequent
 ✔ Priority Queue
 ✔ Dijkstra Algorithm

 ------------------------------------------------------

 FINAL VERDICT:

 Heap Sort → Optional ❌
 Heap Concept → VERY IMPORTANT 🔥
*/

