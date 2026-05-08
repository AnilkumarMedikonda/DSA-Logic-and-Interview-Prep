import UIKit

// MARK: - 44_Find_Second_Smallest_Element

/*
 Problem:
 - Find second smallest element in array
 - Second smallest must be distinct

 Input:
 array = [45,20,40,30,50]

 Output:
 30
*/


// MARK: - Approach: Single Traversal

/*
 Approach:
 - Maintain:
      1. smallest
      2. secondSmallest
 - If current number < smallest
      → Move smallest to secondSmallest
      → Update smallest
 - Else if current number < secondSmallest
      → Update secondSmallest

 Time: O(n)
 Space: O(1)

 Interview:
 - Best optimized solution without sorting
*/

var array = [45, 20, 40, 30, 50]

var min = Int.max
var secondMin = Int.max

for number in array {
    
    if number < min {
        
        secondMin = min
        min = number
        
    } else if number < secondMin, number != min {
        
        secondMin = number
    }
}

print(secondMin)
print(min)


// T - O(n)
// S - O(1)
