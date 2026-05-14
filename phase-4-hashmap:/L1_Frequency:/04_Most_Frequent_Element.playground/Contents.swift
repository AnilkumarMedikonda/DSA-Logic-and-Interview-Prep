import UIKit

//: 04_Most_Frequent_Element

import Foundation

// MARK: - Problem Statement
/*
 Given an array of integers,
 find the element with highest frequency.
 */

// MARK: - Example
/*
 Input  : [4, 4, 2, 2, 2, 1]

 Output :
 Element -> 2
 Count   -> 3
 */

// MARK: - Approach
/*
 1. Create frequency map using Dictionary.
 2. Traverse array elements one by one.
 3. Store frequency count for each element.
 4. Traverse frequency map.
 5. Track:
    - maximum frequency
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

 5. Multiple Maximum Frequencies
    [1,2,1,2]
 */

// MARK: - Input

var array = [4, 4, 2, 2, 2, 1]

// MARK: - Solution

var frequencyMap = [Int: Int]()

var maximumCount = Int.min
var mostFrequentElement = 0


// Create Frequency Map

for number in array {
    
    if let count = frequencyMap[number] {
        frequencyMap[number] = count + 1
    } else {
        frequencyMap[number] = 1
    }
}


// Find Maximum Frequency

for (key, value) in frequencyMap {
    
    if value > maximumCount {
        maximumCount = value
        mostFrequentElement = key
    }
}

// MARK: - Output

print("Element : \(mostFrequentElement)")
print("Count   : \(maximumCount)")

// MARK: - Complexity
/*
 Time  : O(n)
 Space : O(n)
 */
