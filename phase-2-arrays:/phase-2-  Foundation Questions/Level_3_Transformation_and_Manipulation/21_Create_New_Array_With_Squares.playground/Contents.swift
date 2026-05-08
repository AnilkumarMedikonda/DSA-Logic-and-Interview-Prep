import UIKit

// MARK: - 21_Create_New_Array_With_Squares

/*
 Problem:
 - Create a new array containing squares of all numbers

 Input:
 array = [1,2,3,4]

 Output:
 [1,4,9,16]
*/


// MARK: - Approach: Linear Traversal

/*
 Approach:
 - Traverse array one by one
 - Square each element
 - Store squared value in new array

 Time: O(n)
 Space: O(n)
*/

var array = [1,2,3,4]

var squareArray = [Int]()

for i in 0..<array.count {
    
    let value = array[i]
    
    squareArray.append(value * value)
}

print(squareArray)
