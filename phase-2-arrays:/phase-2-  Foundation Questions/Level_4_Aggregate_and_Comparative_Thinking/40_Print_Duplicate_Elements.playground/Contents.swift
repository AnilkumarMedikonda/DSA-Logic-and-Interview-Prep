import UIKit

// MARK: - 40_Print_Duplicate_Elements

/*
 Problem:
 - Print all duplicate elements
 - Duplicate means frequency > 1

 Input:
 array = [1,2,2,3,1,4]

 Output:
 1 2
*/


// MARK: - Approach: Frequency Map

/*
 Approach:
 - Create frequency map
 - Traverse dictionary
 - Print elements whose frequency > 1

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

for (key, value) in dict {
    if value > 1 {
        print(key, terminator: " ")
    }
}
