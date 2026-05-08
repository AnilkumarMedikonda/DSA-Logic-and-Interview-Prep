import UIKit

var greeting = "Hello, playground"

// MARK: - 23_Replace_Negative_Numbers_With_Zero

/*
 Problem:
 - Replace every negative number with 0

 Input:
 array = [1,-2,3,-4,5]

 Output:
 [1,0,3,0,5]
*/


// MARK: - Approach: In-Place Replacement

/*
 Approach:
 - Traverse array one by one
 - Check element is negative
 - Replace negative value with 0

 Time: O(n)
 Space: O(1)
*/

var array = [1,-2,3,-4,5]

for i in 0..<array.count {
    
    if array[i] < 0 {
        array[i] = 0
    }
}

print(array)
