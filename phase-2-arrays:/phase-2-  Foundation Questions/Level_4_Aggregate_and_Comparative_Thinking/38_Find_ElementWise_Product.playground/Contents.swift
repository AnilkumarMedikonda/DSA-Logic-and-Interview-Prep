import UIKit

// MARK: - 38_Find_ElementWise_Product

/*
 Problem:
 - Create a new array containing
   product of elements at same index

 Input:
 array1 = [1,2,3]
 array2 = [4,5,6]

 Output:
 [4,10,18]
*/


// MARK: - Approach: Index Based Multiplication

/*
 Approach:
 - First validate equal array sizes
 - Traverse arrays using same index
 - Multiply corresponding elements
 - Store result in new array

 Time: O(n)
 Space: O(n)
*/

var array1 = [1,2,3]
var array2 = [4,5,6]

if array1.count != array2.count {
    
    print("Not Equal Size")
    
} else {
    
    var newArray = [Int]()
    
    for i in 0..<array1.count {
        newArray.append(array1[i] * array2[i])
    }
    
    print(newArray)
}
