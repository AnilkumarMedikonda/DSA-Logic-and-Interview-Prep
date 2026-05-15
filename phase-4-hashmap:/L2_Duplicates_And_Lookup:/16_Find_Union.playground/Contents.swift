import UIKit

//: 16_Find_Union_Of_Arrays

import Foundation

// MARK: - Problem Statement
/*
 Given two arrays,
 find union of both arrays.
 */

// MARK: - Example
/*
 Input  :
 [1, 2, 3]
 [3, 4, 5]

 Output :
 [1, 2, 3, 4, 5]
 */

// MARK: - Brute Force Approach (Using Nested Loops)
/*
 1. Add all elements from first array.
 2. Traverse second array elements one by one.
 3. Check whether element already exists
    in result array.
 4. If not exists:
    append into result array.
 */

// MARK: - Brute Force Solution

var arr1 = [1, 2, 3]
var arr2 = [3, 4, 5]

var resultBruteForce = [Int]()


// Add First Array Elements

for number in arr1 {
    resultBruteForce.append(number)
}


// Traverse Second Array

for number in arr2 {
    
    var alreadyExists = false
    
    
    for existingNumber in resultBruteForce {
        
        if number == existingNumber {
            alreadyExists = true
            break
        }
    }
    
    
    if !alreadyExists {
        resultBruteForce.append(number)
    }
}

print("Brute Force :", resultBruteForce)


// MARK: - Optimized Approach (Using HashMap) (Best For Interview)
/*
 1. Create HashMap to track visited elements.
 2. Traverse first array.
 3. If element appears first time:
    - add into result array
    - store in HashMap
 4. Traverse second array.
 5. Repeat same process.
 */

// MARK: - Optimized Solution

var frequencyMap = [Int: Bool]()
var resultOptimized = [Int]()


// Traverse First Array

for number in arr1 {
    
    if frequencyMap[number] == nil {
        
        frequencyMap[number] = true
        resultOptimized.append(number)
    }
}


// Traverse Second Array

for number in arr2 {
    
    if frequencyMap[number] == nil {
        
        frequencyMap[number] = true
        resultOptimized.append(number)
    }
}

print("Optimized :", resultOptimized)


// MARK: - Edge Cases
/*
 1. Empty Arrays
    []
    []

 2. All Duplicate Elements
    [1,1,1]
    [1,1]

 3. No Common Elements
    [1,2]
    [3,4]

 4. Negative Numbers
    [-1,2]
    [2,3]

 5. Mixed Elements
    [1,2,3]
    [3,4,5]
 */


// MARK: - Complexity
/*
 Brute Force (Nested Loops)
 Time  : O(n × m)
 Space : O(n + m)

 Optimized (HashMap) (Best For Interview)
 Time  : O(n + m)
 Space : O(n + m)
 */
