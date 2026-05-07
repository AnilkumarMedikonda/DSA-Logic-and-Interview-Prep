import UIKit

// MARK: - 09_Find_Index_of_Minimum

/*
 Approach:
 - Traverse array using enumerated()
 - Track minimum value and its index
 - Update when smaller element found

 Time: O(n)
 Space: O(1)
*/

var array = [8,3,5,1,9]

var minIndex = 0
var min = Int.max

for (index, element) in array.enumerated() {
    
    if element < min {
        min = element
        minIndex = index
    }
}

print(minIndex)
