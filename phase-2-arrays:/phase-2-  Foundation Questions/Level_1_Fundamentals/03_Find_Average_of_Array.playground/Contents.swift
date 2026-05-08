import UIKit

// MARK: - 03_Find_Average_of_Array

/*
 Approach:
 - Traverse array
 - Find sum and count
 - Divide sum by count

 Time: O(n)
 Space: O(1)
*/

var array = [1,2,3,4,5]

var count = 0
var sum = 0

for number in array {
    count += 1
    sum += number
}

var average = Double(sum) / Double(count)

print(average)
