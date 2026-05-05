import UIKit

// 01_MergeTwoSortedArrays

/*
 Approach:
 - Use two pointers (i, j)
 - Compare elements
 - Append smaller element
 - Add remaining elements

 Time: O(n + m)
 Space: O(n + m)   // ❗ because new array is used
*/

var arr1 = [1,3,5]
var arr2 = [2,4,6,7]

var arry = [Int]()
var i = 0
var j = 0

while i < arr1.count && j < arr2.count {
    if arr1[i] <= arr2[j] {   // 🔥 use <=
        arry.append(arr1[i])
        i += 1
    } else {
        arry.append(arr2[j])
        j += 1
    }
}

while i < arr1.count {
    arry.append(arr1[i])
    i += 1
}

while j < arr2.count {
    arry.append(arr2[j])
    j += 1
}

print("Merge Sorted:", arry)

// Merge Unsorted Arrays

/*
 Approach:
 - Direct append
 - No comparison

 Time: O(n + m)
 Space: O(n + m)
*/

var arr3 = [1,3,5]
var arr4 = [2,4,6,7]

arr3 += arr4

print("Merge Unsorted:", arr3)

