import UIKit
// MARK: - 31_Check_Arrays_Equal_Order_And_Elements

/*
 Problem:
 - Check whether two arrays are equal
 - Elements and order both must match

 Input:
 array1 = [1,2,3]
 array2 = [1,2,3]

 Output:
 true
*/


// MARK: - Approach: Index Comparison

/*
 Approach:
 - First compare array sizes
 - Traverse arrays index by index
 - If any element differs
   arrays are not equal

 Time: O(n)
 Space: O(1)
*/

var array1 = [1,2,3]
var array2 = [1,2,3]


func checkArraysEqual(_ arr1: [Int], arr2: [Int]) -> Bool {
    
    if arr1.count != arr2.count {
        return false
    }
    
    for i in 0..<arr1.count {
        
        if arr1[i] != arr2[i] {
            return false
        }
    }
    
    return true
}

print(checkArraysEqual(array1, arr2: array2))

print(checkArraysEqual(array1, arr2: [3,2,1]))
