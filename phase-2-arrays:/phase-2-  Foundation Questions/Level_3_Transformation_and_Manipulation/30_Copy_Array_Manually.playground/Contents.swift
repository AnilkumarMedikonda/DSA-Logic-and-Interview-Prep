import UIKit

// MARK: - 30_Copy_Array_Manually

/*
 Problem:
 - Copy all elements from one array into another manually

 Input:
 array = [1,2,3,4,5]

 Output:
 [1,2,3,4,5]
*/


// MARK: - Approach: Manual Traversal Copy

/*
 Approach:
 - Create empty array
 - Traverse original array
 - Append each element into new array

 Time: O(n)
 Space: O(n)
*/

var array = [1,2,3,4,5]

var newArray = [Int]()

for number in array {
    
    newArray.append(number)
}

print(newArray)
