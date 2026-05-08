import UIKit

// MARK: - 46_Find_Sum_Except_Largest_And_Smallest

/*
 Problem:
 - Find sum of all elements
 - Excluding:
      1. Largest element
      2. Smallest element

 Input:
 array = [10,5,20,8]

 Output:
 18

 Explanation:
 10 + 8 = 18
*/


// MARK: - Approach: Find Min/Max Index

/*
 Approach:
 - Find:
      1. minimum element index
      2. maximum element index
 - Traverse array again
 - Skip min & max indexes
 - Add remaining elements

 Time: O(n)
 Space: O(1)

 Interview:
 - Easy and clean approach
*/

var array = [10, 5, 20, 8]

var min = Int.max
var max = Int.min

var minIndex = -1
var maxIndex = -1


for (index, number) in array.enumerated() {
    
    if number > max {
        max = number
        maxIndex = index
    }
    
    if number < min {
        min = number
        minIndex = index
    }
}

var sum = 0

for i in 0..<array.count {
    
    if i != minIndex, i != maxIndex {
        sum += array[i]
    }
}

print(sum)


// T : O(n)
// S : O(1)
