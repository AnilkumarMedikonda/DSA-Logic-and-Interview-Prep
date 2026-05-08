import UIKit

// MARK: - 25_Swap_First_And_Last_Element

/*
 Problem:
 - Swap first and last element in array

 Input:
 array = [1,2,3,4,5]

 Output:
 [5,2,3,4,1]
*/


// MARK: - Approach 1: Using swapAt()

/*
 Approach:
 - Access first index and last index
 - Swap both elements using swapAt()

 Time: O(1)
 Space: O(1)
*/

var array1 = [1,2,3,4,5]

array1.swapAt(0, array1.count - 1)

print(array1)


// MARK: - Approach 2: Manual Swapping

/*
 Approach:
 - Store first element temporarily
 - Replace first element with last element
 - Replace last element with stored value

 Time: O(1)
 Space: O(1)
*/

var array2 = [1,2,3,4,5]

let first = array2[0]

array2[0] = array2[array2.count - 1]

array2[array2.count - 1] = first

print(array2)
