import UIKit

// MARK: - 14_Find_Last_Occurrence

/*
 Problem:
 - Find the index of last occurrence of target in array
 - Return -1 if target not found

 Input:
 array = [1,2,3,2,4,2,5]
 target = 2

 Output:
 5
*/


// MARK: - Approach: Linear Traversal

/*
 Approach:
 - Traverse array from left to right
 - Compare each element with target
 - Update index whenever match found
 - Last updated index becomes answer

 Time: O(n)
 Space: O(1)
*/

var array = [1,2,3,2,4,2,5]
let target = 2

var lastOccurrence: Int? = nil

for (index, element) in array.enumerated() {
    
    if element == target {
        lastOccurrence = index
    }
}

print(lastOccurrence ?? -1)
