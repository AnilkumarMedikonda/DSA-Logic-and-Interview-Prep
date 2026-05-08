import UIKit

// MARK: - 26_Reverse_Array_Without_BuiltIn

/*
 Problem:
 - Reverse array without using built-in reverse methods

 Input:
 array = [1,2,3,4,5]

 Output:
 [5,4,3,2,1]
*/

// MARK: - Approach: Two Pointer Swapping

/*
 Approach:
 - Traverse only half of array
 - Swap first element with last element
 - Move inward from both sides

 Time: O(n)
 Space: O(1)
*/

var array = [1,2,3,4,5]

for i in 0..<array.count / 2 {
    
    array.swapAt(i, array.count - 1 - i)
}

print(array)
