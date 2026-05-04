import UIKit

// MARK: - 01. Bubble Sort

/*
Approach:
- Compare adjacent elements
- Swap if they are in wrong order
- After each pass, largest element moves to the end
- Reduce comparison range after every pass

Steps:
1. Run outer loop (number of passes)
2. Run inner loop (compare adjacent elements)
3. Swap if left element > right element
4. Repeat until array is sorted

Time Complexity:
- Worst Case: O(n²)  → Reverse sorted array
- Average Case: O(n²)
- Best Case: O(n)    → Already sorted (with optimization)

Space Complexity:
- O(1) → In-place sorting (no extra memory)

Pattern:
- Brute Force
- Comparison-based sorting

Key Insight:
- After each pass, one element is fixed at correct position
- Largest element "bubbles up" to the end

*/

// MARK: - Implementation

var array = [5, 3, 8, 4, 2]

for i in 0..<array.count {
    
    for j in 0..<array.count - i - 1 {
        if array[j] > array[j + 1] {
            let temp = array[j]
            array[j] = array[j + 1]
            array[j + 1] = temp
        }
    }
}

print("Sorted Array:", array)
