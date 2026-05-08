import UIKit


// MARK: - 33_Merge_Two_Arrays_Into_Third_Array

/*
 Problem:
 - Merge two arrays into a third array

 Input:
 array1 = [10,20]
 array2 = [30]

 Output:
 [10,20,30]
*/


// MARK: - Approach: Manual Merge

/*
 Approach:
 - Create empty third array
 - Traverse first array and append elements
 - Traverse second array and append elements

 Time: O(n + m)
 Space: O(n + m)
*/

var array1 = [10,20]
var array2 = [30]

var newArray = [Int]()


for number in array1 {
    newArray.append(number)
}

for number in array2 {
    newArray.append(number)
}

print(newArray)
