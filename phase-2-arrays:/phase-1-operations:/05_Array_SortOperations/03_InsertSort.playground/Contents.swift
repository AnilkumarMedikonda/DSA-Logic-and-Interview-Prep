import UIKit


import UIKit

// MARK: - 03. Insertion Sort

/*
Approach:
- Divide array into sorted and unsorted parts
- Take one element (key) from unsorted part
- Compare it with sorted part (left side)
- Shift all larger elements to the right
- Insert key at correct position

Steps:
1. Start from index i = 1 (first element already sorted)
2. Store current element as 'key'
3. Initialize j = i - 1 (last index of sorted part)
4. While j >= 0 AND array[j] > key:
     → Shift array[j] to right (array[j+1] = array[j])
     → Move j left (j--)
5. Insert key at correct position (array[j+1] = key)
6. Repeat for all elements

Time Complexity:
- Best Case:    O(n)    → Already sorted (no shifting)
- Average Case: O(n²)
- Worst Case:   O(n²)   → Reverse sorted (max shifting)

Space Complexity:
- O(1) → In-place sorting

Pattern:
- Incremental / Adaptive Sorting

Key Insight:
- Builds sorted array step-by-step
- Uses shifting instead of swapping
- Efficient for nearly sorted arrays
*/

// MARK: - Implementation

var array = [5, 3, 8, 4, 2]

for i in 1..<array.count {
    
    let key = array[i]
    var j = i - 1
    
    while j >= 0 && array[j] > key {
        array[j + 1] = array[j]
        j -= 1
    }
    
    array[j + 1] = key
}

print("Sorted Array:", array)
