import UIKit

// MARK: - 41_Check_Array_Sorted_Ascending

/*
 Problem:
 - Check whether array is sorted in ascending order
 - Ascending means current element <= next element

 Input:
 array = [1,2,3,4,5]

 Output:
 true
*/


// MARK: - Approach: Compare Adjacent Elements

/*
 Approach:
 - Traverse array
 - Compare current element with next element
 - If current > next
      → Array is NOT ascending
 - Break immediately for optimization

 Time: O(n)
 Space: O(1)

 Interview:
 - Most common and optimized approach
*/

var array = [1,2,3,4,5]

var isAscending = true

for i in 0..<array.count - 1 {
    
    if array[i] > array[i + 1] {
        isAscending = false
        break
    }
}

print(isAscending)
