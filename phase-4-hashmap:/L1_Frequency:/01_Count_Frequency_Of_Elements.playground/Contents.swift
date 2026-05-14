import UIKit

//: 01_Count_Frequency_Of_Elements

// MARK: - Problem Statement
/*
 Given an array of integers,
 count how many times each element appears.
 */

// MARK: - Example
/*
 Input  : [1, 2, 1, 3, 2, 1]

 Output :
 1 -> 3
 2 -> 2
 3 -> 1
 */

// MARK: - Approach
/*
 1. Create an empty Dictionary.
 2. Traverse array elements one by one.
 3. If element already exists:
    increase frequency count.
 4. Else:
    insert element with value 1.
 */

// MARK: - Edge Cases
/*
 1. Empty Array
    []

 2. All Unique Elements
    [1,2,3]

 3. All Same Elements
    [4,4,4]

 4. Negative Numbers
    [-1,-1,2]
 */

// MARK: - Input

let array = [1, 2, 1, 3, 2, 1]

// MARK: - Solution

var frequencyMap = [Int: Int]()

for number in array {
    if let value = frequencyMap[number] {
        frequencyMap[number] = value + 1
    } else {
        frequencyMap[number] = 1
    }
}

// MARK: - Output
print(frequencyMap)

// MARK: - Complexity
/*
 Time  : O(n)
 Space : O(n)
 */
