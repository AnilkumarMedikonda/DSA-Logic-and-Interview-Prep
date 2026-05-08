import UIKit

// MARK: - 39_Create_Frequency_Array

/*
 Problem:
 - Create frequency map for array elements
 - Store how many times each element appears

 Input:
 array = [1,2,2,3,1,1]

 Output:
 [
   1: 3,
   2: 2,
   3: 1
 ]
*/


// MARK: - Approach: Frequency Map

/*
 Approach:
 - Create empty dictionary
 - Traverse array
 - If element exists
   increment frequency
 - Otherwise insert with value 1

 Time: O(n)
 Space: O(n)

 Interview:
 - Very important hashmap pattern
*/

var array = [1,2,2,3,1,1]
var dict = [Int: Int]()


for number in array {
    
    if let value = dict[number] {
        dict[number] = value + 1
    } else {
        dict[number] = 1
    }
}

print(dict)
