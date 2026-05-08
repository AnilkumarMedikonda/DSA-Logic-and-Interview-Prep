import UIKit


// MARK: - 08_Find_Index_of_Maximum

/*
 Approach:
 - Traverse array using enumerated()
 - Track:
   maximum value
   maximum index
 - Update when larger element found

 Time: O(n)
 Space: O(1)
*/

var array = [8,3,5,1,9]

var maxIndex = 0
var max = Int.min

for (index, element) in array.enumerated() {
    
    if element > max {
        max = element
        maxIndex = index
    }
}

print(maxIndex)
