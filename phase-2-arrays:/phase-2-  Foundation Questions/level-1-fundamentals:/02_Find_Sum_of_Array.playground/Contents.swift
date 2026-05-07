import UIKit

// MARK: - 02_Find_Sum_of_Array

/*
 Approach:
 - Traverse array once
 - Add each element into sum variable

 Time: O(n)
 Space: O(1)
*/

var array = [1,2,3,4,5]

var sum = 0

for num in array {
    sum += num
}

print(sum)
