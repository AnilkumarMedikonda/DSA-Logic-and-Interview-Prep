import UIKit

//: 10_Check_All_Elements_Unique

import Foundation

// MARK: - Problem Statement
/*
 Given an array of integers,
 check whether all elements are unique.
 */

// MARK: - Example
/*
 Input  : [1, 2, 3, 4]

 Output :
 true
 */

// MARK: - Brute Force Approach (Using Nested Loops)
/*
 1. Traverse array elements one by one.
 2. Compare current element with remaining elements.
 3. If duplicate found:
    mark as false.
 4. Else:
    all elements are unique.
 */

// MARK: - Brute Force Solution

var array = [1, 2, 3, 2, 1]

var allUniqueBruteForce = true

for i in 0..<array.count {
    
    for j in i + 1..<array.count {
        
        if array[i] == array[j] {
            allUniqueBruteForce = false
            break
        }
    }
}

print("Brute Force :", allUniqueBruteForce)


// MARK: - Optimized Approach (Using HashMap) (Best For Interview)
/*
 1. Create frequency map using Dictionary.
 2. Traverse array elements one by one.
 3. Store frequency count for each element.
 4. Traverse frequency map.
 5. If frequency > 1:
    duplicate exists.
 */

// MARK: - Optimized Solution

var frequencyMap = [Int: Int]()
var allUniqueOptimized = true


// Create Frequency Map

for number in array {
    
    if let count = frequencyMap[number] {
        frequencyMap[number] = count + 1
    } else {
        frequencyMap[number] = 1
    }
}


// Check Unique Elements

for (_, value) in frequencyMap {
    
    if value > 1 {
        allUniqueOptimized = false
        break
    }
}
// MARK: - Output
print("Optimized :", allUniqueOptimized)


// MARK: - Edge Cases
/*
 1. Empty Array
    []

 2. Single Element
    [10]

 3. All Unique Elements
    [1,2,3,4]

 4. Duplicate Elements
    [1,2,3,1]

 5. Negative Numbers
    [-1,2,-1]
 */


// MARK: - Complexity
/*
 Brute Force (Nested Loops)
 Time  : O(n²)
 Space : O(1)

 Optimized (HashMap) (Best For Interview)
 Time  : O(n)
 Space : O(n)
 */
