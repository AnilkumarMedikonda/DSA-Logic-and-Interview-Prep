import UIKit

var greeting = "Hello, playground"


// MARK: - 17_Find_Sum_of_Odd_Elements

/*
 Problem:
 - Find sum of all odd elements in array

 Input:
 array = [1,2,3,4,5,6]

 Output:
 9
*/


// MARK: - Approach: Linear Traversal

/*
 Approach:
 - Traverse array one by one
 - Check number is odd using % 2 != 0
 - Add odd numbers to sum

 Time: O(n)
 Space: O(1)
*/

var oddSum = 0
var array = [1,2,3,4,5,6]

for number in array {
    
    if number % 2 != 0 {
        oddSum += number
    }
}

print(oddSum)
