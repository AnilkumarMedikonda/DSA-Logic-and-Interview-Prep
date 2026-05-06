import UIKit

// MARK: - 01_Shallow_Copy

/*
 Problem:
 - Create a copy of an array
 - Modify original array and observe effect on copy

 Input:
 arr = [1,2,3]

 Operation:
 arr[0] = 100

 Question:
 - Does copied array change or not?

 Expected:
 - Understand shallow copy behavior

 Time: O(n)
 Space: O(n)
*/


/*
 Approach:
 - Assign array to another variable
 - Modify original
 - Check if copy changes

 Time: O(n)
 Space: O(n)
*/

var arr = [1,2,3]
var copyArr = arr   // copy created

arr[0] = 100

print("Original:", arr)     // [100,2,3]
print("Copy:", copyArr)     // [1,2,3]
