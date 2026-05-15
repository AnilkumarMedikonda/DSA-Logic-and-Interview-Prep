import UIKit

//: 15_Find_Common_Elements

import Foundation

// MARK: - Problem Statement
/*
 Given two arrays,
 find all common elements.
 */

// MARK: - Example
/*
 Input  :
 [1, 2, 3, 4]
 [3, 4, 5, 6]

 Output :
 [3, 4]
 */

// MARK: - Brute Force Approach (Using Nested Loops)
/*
 1. Traverse first array elements one by one.
 2. Compare with all elements in second array.
 3. If match found:
    add into result array.
 */

// MARK: - Brute Force Solution

var array1 = [1, 2, 3, 4]
var array2 = [3, 4, 5, 6]

var resultBruteForce = [Int]()


for element in array1 {
    
    for otherElement in array2 {
        
        if element == otherElement {
            resultBruteForce.append(element)
        }
    }
}

print("Brute Force :", resultBruteForce)


// MARK: - Optimized Approach (Using HashMap) (Best For Interview)
/*
 1. Create frequency map using first array.
 2. Store frequency count for each element.
 3. Traverse second array.
 4. If frequency exists and > 0:
    - add into result array
    - reduce frequency count
 */

// MARK: - Optimized Solution

var frequencyMap = [Int: Int]()
var resultOptimized = [Int]()


// Create Frequency Map

for number in array1 {
    
    if let count = frequencyMap[number] {
        frequencyMap[number] = count + 1
    } else {
        frequencyMap[number] = 1
    }
}


// Find Common Elements

for number in array2 {
    
    if let count = frequencyMap[number],
       count > 0 {
        
        resultOptimized.append(number)
        frequencyMap[number] = count - 1
    }
}

print("Optimized :", resultOptimized)


// MARK: - Edge Cases
/*
 1. Empty Arrays
    []
    []

 2. No Common Elements
    [1,2,3]
    [4,5,6]

 3. Duplicate Elements
    [1,2,2,3]
    [2,2,4]

 4. Negative Numbers
    [-1,2,3]
    [-1,4]

 5. All Elements Common
    [1,2,3]
    [1,2,3]
 */


// MARK: - Complexity
/*
 Brute Force (Nested Loops)
 Time  : O(n × m)
 Space : O(k)

 Optimized (HashMap) (Best For Interview)
 Time  : O(n + m)
 Space : O(n)
 */
