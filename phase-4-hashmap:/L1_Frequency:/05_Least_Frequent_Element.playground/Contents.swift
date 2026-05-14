import UIKit

//: 05_Least_Frequent_Element

import Foundation

// MARK: - Problem Statement
/*
 Given an array of integers,
 find the element with lowest frequency.
 */

// MARK: - Example
/*
 Input  : [1, 2, 1, 3, 2, 1]

 Output :
 Element -> 3
 Count   -> 1
 */

// MARK: - Approach
/*
 1. Create frequency map using Dictionary.
 2. Traverse array elements one by one.
 3. Store frequency count for each element.
 4. Traverse frequency map.
 5. Track:
    - minimum frequency
    - corresponding element
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

 5. Multiple Minimum Frequencies
    [1,2,1,2,3,4]
 */

// MARK: - Input

var array = [1, 2, 1, 3, 2, 1]

// MARK: - Solution

var frequencyMap = [Int: Int]()

var minimumCount = Int.max
var leastFrequentElement = 0


// Create Frequency Map

for number in array {
    
    if let count = frequencyMap[number] {
        frequencyMap[number] = count + 1
    } else {
        frequencyMap[number] = 1
    }
}


// Find Minimum Frequency

for (key, value) in frequencyMap {
    
    if value < minimumCount {
        minimumCount = value
        leastFrequentElement = key
    }
}

// MARK: - Output

print("Element : \(leastFrequentElement)")
print("Count   : \(minimumCount)")

// MARK: - Complexity
/*
 Time  : O(n)
 Space : O(n)
 */
