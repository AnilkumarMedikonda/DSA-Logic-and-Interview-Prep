import UIKit

// MARK: - 10_Print_Elements_Greater_Than_K

/*
 Approach:
 - Traverse array once
 - Compare each element with k
 - Print element if greater than k

 Time: O(n)
 Space: O(1)
*/

var array = [1,5,8,2,10]
let k = 5

for number in array {
    if number > k {
        print(number, terminator: " ")
    }
}
