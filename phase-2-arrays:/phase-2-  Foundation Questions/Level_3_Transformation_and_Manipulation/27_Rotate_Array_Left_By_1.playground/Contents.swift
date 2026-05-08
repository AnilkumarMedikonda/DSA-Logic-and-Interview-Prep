import UIKit

// MARK: - 27_Rotate_Array_Left_By_1

/*
 Problem:
 - Rotate array left by 1 position

 Input:
 array = [1,2,3,4,5]

 Output:
 [2,3,4,5,1]
*/


// MARK: - Approach: Shift Elements Left

/*
 Approach:
 - Store first element
 - Shift remaining elements left
 - Place stored element at end

 Time: O(n)
 Space: O(1)
*/

var array = [1,2,3,4,5]

let firstElement = array[0]

for i in 0..<array.count - 1 {
    array[i] = array[i + 1]
}

array[array.count - 1] = firstElement

print(array)
