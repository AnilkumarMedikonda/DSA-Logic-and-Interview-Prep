import UIKit

// MARK: - 19_Count_Numbers_Divisible_By_3_and_5

/*
 Problem:
 - Count numbers divisible by both 3 and 5

 Input:
 array = [3,5,15,30,10,9,45]

 Output:
 3
*/


// MARK: - Approach: Linear Traversal

/*
 Approach:
 - Traverse array one by one
 - Check number divisible by 3 and 5
 - Increment count when condition matches

 Time: O(n)
 Space: O(1)
*/

var array = [3,5,15,30,10,9,45]

var count = 0

for number in array {
    
    if number % 3 == 0 && number % 5 == 0 {
        count += 1
    }
}

print(count)
