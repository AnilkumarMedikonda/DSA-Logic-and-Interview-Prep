import UIKit

// MARK: - 06_Frequency_Map

/*
 Problem:
 - Given an array of integers, build a frequency map
   (count how many times each element appears)

 Input:
 [1,2,2,3,1,4]

 Output:
 [
 1:2,
 2:2,
 3:1,
 4:1
 ]

 Constraints:
 - Use a dictionary (hash map)
 - Solve in single traversal

 Expected:
 - Time: O(n)
 - Space: O(n)
*/

/*
 Approach:
 - Traverse array
 - Use dictionary to store count
 - Increment value if key exists

 Time: O(n)
 Space: O(n)
*/

var arr = [1,2,2,3,1,4]
var dict = [Int: Int]()

for number in arr {
    if let value = dict[number] {
        dict[number] = value + 1
    } else {
        dict[number] = 1
    }
}
print(dict)
