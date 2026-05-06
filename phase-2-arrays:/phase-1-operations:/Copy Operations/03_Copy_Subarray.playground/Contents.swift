import UIKit

/// MARK: - 03_Copy_Subarray

/*
 Approach:
 - Traverse from L to R
 - Append elements into new array

 Time: O(n)        // O(r - l + 1)
 Space: O(n)
*/

var arr = [10,20,30,40,50]
var newArry = [Int]()
var l = 1
var r = 3

if l >= 0 && r < arr.count && l <= r {
    var i = l
    while i <= r {
        newArry.append(arr[i])
        i += 1
    }
    print(newArry)
} else {
    print("Invalid range")
}
