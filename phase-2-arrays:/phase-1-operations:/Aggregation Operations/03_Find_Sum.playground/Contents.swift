import UIKit

// MARK: - 03_Find_Sum

/*
 Problem:
 - Given an array of integers, find the sum of all elements.

 Input:
 [1, 2, 3, 4, 5]

 Output:
 15

 Constraints:
 - Do not use built-in reduce()
 - Solve using single traversal

 Expected:
 - Time: O(n)
 - Space: O(1)
*/


var arry = [1, 2, 3, 4, 5]
var sum = 0
for number in arry { sum += number }
print("Sum ---", sum)
