import UIKit

// — 50_Print_Elements_Occurring_Exactly_Once


// MARK: - 50_Print_Elements_Occurring_Exactly_Once

/*
 Problem:
 - Print elements occurring exactly once

 Input:
 array = [1,2,2,3,1,4]

 Output:
 3
 4
*/


// MARK: - Approach: Dictionary / HashMap

/*
 Approach:
 - Store frequency of each element
 - Traverse dictionary
 - Print elements whose frequency == 1

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

for (key, value) in dict {
    if value == 1 {
        print(key)
    }
}


// T - O(n)
// S - O(n)
