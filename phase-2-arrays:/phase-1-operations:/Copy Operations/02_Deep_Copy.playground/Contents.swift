import UIKit

// MARK: - 02_Deep_Copy

/*
 Problem:
 - Create a deep copy of an array

 Input:
 arr = [1,2,3]

 Operation:
 Modify original array

 Expected Output:
 Original → [100,2,3]
 Copy     → [1,2,3]

 Constraints:
 - Ensure copy is independent
 - Do NOT rely on assumption — demonstrate clearly

 Expected:
 - Time: O(n)
 - Space: O(n)
*/

/*
 Approach:
 - Assign array to another variable
 - Modify original array
 - Print both to verify independence

 Time: O(n)
 Space: O(n)
*/

var array = [1,2,3]
var arryTwo = array
array[0] = 100
print(array)
print(arryTwo)
