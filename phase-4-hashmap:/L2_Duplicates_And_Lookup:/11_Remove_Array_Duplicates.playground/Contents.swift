import UIKit

//: 11_Remove_Duplicates_From_Array

import Foundation

// MARK: - Problem Statement
/*
 Given an array of integers,
 remove duplicate elements.
 */

// MARK: - Example
/*
 Input  : [1, 2, 1, 3, 2, 4]

 Output :
 [1, 2, 3, 4]
 */

// MARK: - Brute Force Approach (Using Nested Loops)
/*
 1. Traverse array elements one by one.
 2. Check if current element already exists
    in result array.
 3. If not exists:
    add into result array.
 */

// MARK: - Brute Force Solution

var array = [1, 2, 1, 3, 2, 4]

var uniqueElementsBruteForce = [Int]()


for i in 0..<array.count {
    
    var alreadyExists = false
    
    
    for number in uniqueElementsBruteForce {
        
        if array[i] == number {
            alreadyExists = true
            break
        }
    }
    
    
    if !alreadyExists {
        uniqueElementsBruteForce.append(array[i])
    }
}

print("Brute Force :", uniqueElementsBruteForce)


// MARK: - Optimized Approach (Using HashMap) (Best For Interview)
/*
 1. Create frequency map using Dictionary.
 2. Traverse array elements one by one.
 3. If element appears first time:
    - add into result array
    - store in HashMap
 4. Else:
    skip duplicate element.
 */

// MARK: - Optimized Solution

var frequencyMap = [Int: Int]()
var uniqueElementsOptimized = [Int]()


for number in array {
    
    if let count = frequencyMap[number] {
        frequencyMap[number] = count + 1
    } else {
        frequencyMap[number] = 1
        uniqueElementsOptimized.append(number)
    }
}

print("Optimized :", uniqueElementsOptimized)


// MARK: - Edge Cases
/*
 1. Empty Array
    []

 2. All Duplicate Elements
    [4,4,4]

 3. All Unique Elements
    [1,2,3]

 4. Negative Numbers
    [-1,-1,2,3]

 5. Mixed Elements
    [1,2,1,3,2,4]
 */


// MARK: - Complexity
/*
 Brute Force (Nested Loops)
 Time  : O(n²)
 Space : O(n)

 Optimized (HashMap) (Best For Interview)
 Time  : O(n)
 Space : O(n)
 */
