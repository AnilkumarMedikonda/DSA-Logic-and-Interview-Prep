import UIKit

// MARK: - 22_Create_Array_With_Only_Even_Elements

/*
 Problem:
 - Create a new array containing only even elements

 Input:
 array = [1,2,3,4,5,6]

 Output:
 [2,4,6]
*/


// MARK: - Approach: Linear Traversal

/*
 Approach:
 - Traverse array one by one
 - Check number is even using % 2 == 0
 - Store even numbers in new array

 Time: O(n)
 Space: O(n)
*/

var array = [1,2,3,4,5,6]

var evenArray = [Int]()

for number in array {
    
    if number % 2 == 0 {
        evenArray.append(number)
    }
}

print(evenArray)
