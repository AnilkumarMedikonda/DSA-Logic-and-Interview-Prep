import UIKit

// MARK: - 04_Copy_Array_Manual

/*
 Approach:
 - Traverse original array
 - Append each element into new array manually

 Time: O(n)
 Space: O(n)
*/

var arr1 = [1,2,3,4]
var arr2 = [Int]()

var i = 0

while i < arr1.count {
    arr2.append(arr1[i])
    i += 1
}

print(arr2)
