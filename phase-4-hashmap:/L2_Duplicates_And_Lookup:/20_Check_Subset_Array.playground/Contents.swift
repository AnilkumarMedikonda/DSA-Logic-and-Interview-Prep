import UIKit

//: 20_Check_Subset_Array

import Foundation

// MARK: - Problem Statement
/*
 Given two arrays,
 check whether second array
 is subset of first array.
 */

// MARK: - Example
/*
 Input  :
 [1, 2, 3, 4, 5]
 [2, 4]

 Output :
 true
 */

// MARK: - Brute Force Approach (Using Nested Loops)
/*
 1. Traverse second array elements one by one.
 2. Search current element in first array.
 3. If element not found:
    not a subset.
 */

// MARK: - Brute Force Solution

var array1 = [1, 2, 3, 4, 5]
var array2 = [2, 4]

var isSubsetBruteForce = true


for number in array2 {
    
    var isFound = false
    
    
    for element in array1 {
        
        if number == element {
            isFound = true
            break
        }
    }
    
    
    if !isFound {
        isSubsetBruteForce = false
        break
    }
}

print("Brute Force :", isSubsetBruteForce)


// MARK: - Optimized Approach (Using HashMap) (Best For Interview)
/*
 1. Create frequency map using first array.
 2. Store frequency count for each element.
 3. Traverse second array.
 4. If frequency exists and > 0:
    reduce frequency.
 5. Else:
    not a subset.
 */

// MARK: - Optimized Solution

var frequencyMap = [Int: Int]()

var isSubsetOptimized = true


// Create Frequency Map

for number in array1 {
    
    if let count = frequencyMap[number] {
        frequencyMap[number] = count + 1
    } else {
        frequencyMap[number] = 1
    }
}


// Check Subset

for number in array2 {
    
    if let count = frequencyMap[number],
       count > 0 {
        
        frequencyMap[number] = count - 1
        
    } else {
        isSubsetOptimized = false
        break
    }
}

print("Optimized :", isSubsetOptimized)


// MARK: - Edge Cases
/*
 1. Empty Arrays
    []
    []

 2. Duplicate Elements
    [1,2,2,3]
    [2,2]

 3. Missing Elements
    [1,2,3]
    [2,4]

 4. Negative Numbers
    [-1,2,3]
    [-1,2]

 5. Second Array Larger
    [1,2]
    [1,2,3]
 */


// MARK: - Complexity
/*
 Brute Force
 Time  : O(n × m)
 Space : O(1)

 Optimized (HashMap) (Best For Interview)
 Time  : O(n + m)
 Space : O(n)
 */
