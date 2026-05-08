import UIKit

// MARK: - 12_Count_Occurrences

/*
 Problem:
 - Count how many times target appears in array

 Input:
 array = [1,2,3,2,4,2,5]
 target = 2

 Output:
 3
*/


// MARK: - Approach: Linear Traversal

/*
 Approach:
 - Traverse array one by one
 - Compare each element with target
 - Increment count when match found

 Time: O(n)
 Space: O(1)
*/

var array = [1,2,3,2,4,2,5]
let target = 2

var count = 0

for number in array {
    if number == target {
        count += 1
    }
}
print(count)
