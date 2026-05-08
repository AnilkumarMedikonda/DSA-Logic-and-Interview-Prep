import UIKit

// MARK: - 24_Replace_Even_With_1_And_Odd_With_0

/*
 Problem:
 - Replace every even number with 1
 - Replace every odd number with 0

 Input:
 array = [1,2,3,4,5,6]

 Output:
 [0,1,0,1,0,1]
*/


// MARK: - Approach: In-Place Replacement

/*
 Approach:
 - Traverse array one by one
 - Check number is even using % 2 == 0
 - Replace even with 1
 - Replace odd with 0

 Time: O(n)
 Space: O(1)
*/

var array = [1,2,3,4,5,6]

for i in 0..<array.count {
    
    if array[i] % 2 == 0 {
        array[i] = 1
    } else {
        array[i] = 0
    }
}

print(array)
