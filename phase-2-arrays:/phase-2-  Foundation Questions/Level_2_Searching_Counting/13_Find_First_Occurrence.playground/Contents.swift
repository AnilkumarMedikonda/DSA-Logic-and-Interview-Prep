import UIKit

// MARK: - 13_Find_First_Occurrence

/*
 Problem:
 - Find the index of first occurrence of target in array
 - Return -1 if target not found

 Input:
 array = [1,2,3,2,4,2,5]
 target = 2

 Output:
 1
*/


// MARK: - Approach: Linear Traversal

/*
 Approach:
 - Traverse array from left to right
 - Compare each element with target
 - Store index when first match found
 - Break loop immediately

 Time: O(n)
 Space: O(1)
*/

var array = [1,2,3,2,4,2,5]
let target = 2

var firstOccurrence: Int? = nil

for (index, element) in array.enumerated() {
    
    if element == target {
        firstOccurrence = index
        break
    }
}

print(firstOccurrence ?? -1)
