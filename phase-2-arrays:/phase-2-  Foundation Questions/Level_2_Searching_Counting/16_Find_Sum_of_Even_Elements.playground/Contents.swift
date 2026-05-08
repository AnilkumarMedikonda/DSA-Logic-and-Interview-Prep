import UIKit

// MARK: - 16_Find_Sum_of_Even_Elements

/*
 Problem:
 - Find sum of all even elements in array

 Input:
 array = [1,2,3,4,5,6]

 Output:
 12
*/


// MARK: - Approach: Linear Traversal

/*
 Approach:
 - Traverse array one by one
 - Check number is even using % 2 == 0
 - Add even numbers to sum

 Time: O(n)
 Space: O(1)
*/

var array = [1,2,3,4,5,6]

var evenSum = 0

for number in array {
    
    if number % 2 == 0 {
        evenSum += number
    }
}

print(evenSum)
