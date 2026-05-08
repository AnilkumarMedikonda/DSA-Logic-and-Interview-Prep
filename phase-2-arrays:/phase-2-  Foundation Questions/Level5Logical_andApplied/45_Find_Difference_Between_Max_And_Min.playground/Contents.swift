import UIKit

// MARK: - 45_Find_Difference_Between_Max_And_Min

/*
 Problem:
 - Find difference between maximum and minimum element

 Formula:
 difference = max - min

 Input:
 array = [10,5,20,8]

 Output:
 15
*/


// MARK: - Approach: Single Traversal

/*
 Approach:
 - Maintain:
      1. maximum
      2. minimum
 - Traverse array once
 - Update max and min simultaneously
 - Find:
      max - min

 Time: O(n)
 Space: O(1)

 Interview:
 - Best optimized solution without sorting
*/

var array = [10, 5, 20, 8]

var min = Int.max
var max = Int.min

for number in array {
    
    if number > max {
        max = number
    }
    
    if number < min {
        min = number
    }
}

var difference = max - min

print(max, min)
print(difference)


// T - O(n)
// S - O(1)
