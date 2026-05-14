import UIKit

//: 09_First_Repeating_Element

import Foundation

// MARK: - Problem Statement
/*
 Given an array of integers,
 find the first repeating element.
 */

// MARK: - Example
/*
 Input  : [1, 2, 3, 2, 1]

 Output :
 1
 */

// MARK: - Brute Force Approach
/*
 1. Traverse array elements one by one.
 2. Compare current element with remaining elements.
 3. If duplicate found:
    return current element.
 */

// MARK: - Brute Force Solution

var array = [1, 2, 3, 2, 1]

for i in 0..<array.count {
    
    var isRepeating = false
    
    for j in i + 1..<array.count {
        
        if array[i] == array[j] {
            isRepeating = true
        }
    }
    
    if isRepeating {
        print("Brute Force :", array[i])
        break
    }
}

// MARK: - Optimized Approach (Best For Interview)
/*
 1. Create frequency map using Dictionary.
 2. Traverse array elements one by one.
 3. Store frequency count for each element.
 4. Traverse original array again.
 5. Find first element where frequency > 1.
 */

// MARK: - Optimized Solution

var frequencyMap = [Int: Int]()


// Create Frequency Map

for number in array {
    
    if let count = frequencyMap[number] {
        frequencyMap[number] = count + 1
    } else {
        frequencyMap[number] = 1
    }
}


// Find First Repeating Element

for number in array {
    
    if let count = frequencyMap[number],
       count > 1 {
        
        print("Optimized :", number)
        break
    }
}

// MARK: - Edge Cases
/*
 1. Empty Array
    []

 2. All Unique Elements
    [1,2,3]

 3. All Duplicate Elements
    [1,1,1]

 4. Negative Numbers
    [-1,2,-1,3]

 5. Mixed Elements
    [1,2,3,2,1]
 */

// MARK: - Complexity
/*
 Brute Force
 Time  : O(n²)
 Space : O(1)

 Optimized (Best For Interview)
 Time  : O(n)
 Space : O(n)
 */
