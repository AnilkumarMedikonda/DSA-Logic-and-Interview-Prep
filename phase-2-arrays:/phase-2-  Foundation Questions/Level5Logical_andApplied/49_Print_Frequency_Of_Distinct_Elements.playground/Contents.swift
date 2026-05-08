import UIKit

// MARK: - 49_Print_Frequency_Of_Distinct_Elements

/*
 Problem:
 - Print frequency of distinct elements

 Frequency:
 - Number of times element appears

 Input:
 array = [1,2,2,3,1,4]

 Output:
 1 : 2
 2 : 2
 3 : 1
 4 : 1
*/


// MARK: - Approach: Dictionary / HashMap

/*
 Approach:
 - Create frequency dictionary
 - Traverse array
 - If element exists
      → Increase count
 - Else
      → Insert with count 1

 Time: O(n)
 Space: O(n)

 Interview:
 - Best optimized solution
*/

var array = [1,2,2,3,1,4]

var dict = [Int: Int]()

for number in array {
    
    if let value = dict[number] {
        
        dict[number] = value + 1
        
    } else {
        
        dict[number] = 1
    }
}

print(dict)


// T : O(n)
// S : O(n)
