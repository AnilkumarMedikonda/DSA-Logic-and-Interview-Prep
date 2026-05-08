import UIKit
/// MARK: - 28_Rotate_Array_Right_By_1

/*
 Problem:
 - Rotate array right by 1 position

 Input:
 array = [1,2,3,4,5]

 Output:
 [5,1,2,3,4]
*/


// MARK: - Approach: Shift Elements Right

/*
 Approach:
 - Store last element
 - Traverse from end towards beginning
 - Shift elements one position right
 - Place stored element at beginning

 Time: O(n)
 Space: O(1)
*/

var array = [1,2,3,4,5]

let lastElement = array[array.count - 1]

var i = array.count - 1

while i > 0 {
    array[i] = array[i - 1]
    i -= 1
}
array[0] = lastElement
print(array)
