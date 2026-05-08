import UIKit
// MARK: - 48_Count_Elements_Greater_Than_Average

/*
 Problem:
 - Count elements greater than average

 Formula:
 average = totalSum / totalElements

 Input:
 array = [1,2,3,4,5]

 Output:
 2

 Explanation:
 Sum = 15
 Average = 3

 Elements greater than 3:
 4,5

 Count = 2
*/


// MARK: - Approach: Sum + Average

/*
 Approach:
 - Find total sum
 - Calculate average
 - Traverse array again
 - Count elements greater than average

 Time: O(n)
 Space: O(1)

 Interview:
 - Simple and optimized approach
*/

var array = [1,2,3,4,5]

var sum = 0

for number in array {
    sum += number
}

print(sum)

let average = sum / array.count

print(average)

var count = 0

for number in array {
    
    if number > average {
        count += 1
    }
}

print(count)


// T - O(n)
// S - O(1)
