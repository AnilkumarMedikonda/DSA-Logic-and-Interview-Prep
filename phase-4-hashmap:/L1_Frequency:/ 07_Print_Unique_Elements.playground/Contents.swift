import UIKit

//: 07_Print_Unique_Elements

import Foundation

// MARK: - Problem Statement
/*
 Given an array of integers,
 print all unique elements.
 */

// MARK: - Example
/*
 Input  : [1, 2, 1, 3, 2, 4]

 Output :
 [3, 4]
 */

// MARK: - Approach
/*
 1. Create frequency map using Dictionary.
 2. Traverse array elements one by one.
 3. Store frequency count for each element.
 4. Traverse frequency map.
 5. If frequency == 1:
    add element into unique array.
 */

// MARK: - Edge Cases
/*
 1. Empty Array
    []

 2. All Unique Elements
    [1,2,3]

 3. All Duplicate Elements
    [4,4,4]

 4. Negative Numbers
    [-1,-1,2]

 5. Mixed Elements
    [1,2,1,3,2,4]
 */

// MARK: - Input

var array = [1, 2, 1, 3, 2, 4]

// MARK: - Solution

var frequencyMap = [Int: Int]()
var uniqueElements = [Int]()


// Create Frequency Map

for number in array {
    
    if let count = frequencyMap[number] {
        frequencyMap[number] = count + 1
    } else {
        frequencyMap[number] = 1
    }
}


// Find Unique Elements

for (key, value) in frequencyMap {
    
    if value == 1 {
        uniqueElements.append(key)
    }
}

// MARK: - Output

if uniqueElements.isEmpty {
    print("No Unique Elements")
} else {
    print(uniqueElements)
}

// MARK: - Complexity
/*
 Time  : O(n)
 Space : O(n)
 */
