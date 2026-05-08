import UIKit

// MARK: - 43_Find_Second_Largest_Element

/*
 Problem:
 - Find second largest element in array
 - Second largest must be distinct

 Input:
 array = [45,20,40,30,50]

 Output:
 45
*/


// MARK: - Approach: Single Traversal

/*
 Approach:
 - Maintain:
      1. largest
      2. secondLargest
 - If current number > largest
      → Move largest to secondLargest
      → Update largest
 - Else if current number > secondLargest
      → Update secondLargest

 Time: O(n)
 Space: O(1)

 Interview:
 - Best optimized solution without sorting
*/

var array = [45, 20, 40, 30, 50]

var max = Int.min
var secondMax = Int.min

for number in array {
    
    if number > max {
        
        secondMax = max
        max = number
        
    } else if number > secondMax, number != max {
        
        secondMax = number
    }
}

print(secondMax)
print(max)


// T - O(n)
// S - O(1)
