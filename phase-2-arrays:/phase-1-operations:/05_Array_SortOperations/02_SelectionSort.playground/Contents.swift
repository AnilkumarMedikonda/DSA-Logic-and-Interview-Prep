import UIKit

// MARK: - 02. Selection Sort

/*
Approach:
- Divide array into sorted and unsorted parts
- Find minimum element from unsorted part
- Swap it with the current index
- Repeat for all elements

Steps:
1. Start from index i = 0
2. Assume current index as minimum (minIndex = i)
3. Loop from i+1 to end of array
4. Find the smallest element in remaining array
5. Swap it with index i
6. Move to next index and repeat

Time Complexity:
- Best Case:    O(n²)
- Average Case: O(n²)
- Worst Case:   O(n²)

Space Complexity:
- O(1) → In-place sorting

Pattern:
- Brute Force
- Selection based sorting

Key Insight:
- Always selects minimum element and places it correctly
- Only 1 swap per pass
- Does not depend on initial order of array
*/

// MARK: - Implementation

var array = [5, 3, 8, 4, 2]

for i in 0..<array.count {
    
    var minIndex = i
    
    for j in i+1..<array.count {
        if array[j] < array[minIndex] {
            minIndex = j
        }
    }
    
    if i != minIndex {
        let temp = array[i]
        array[i] = array[minIndex]
        array[minIndex] = temp
    }
}

print("Sorted Array:", array)
