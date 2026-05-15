import UIKit

//: 19_Find_Extra_Element

import Foundation

// MARK: - Problem Statement
/*
 Given two arrays,
 second array contains all elements
 of first array plus one extra element.

 Find the extra element.
 */

// MARK: - Example
/*
 Input  :
 [1, 2, 3, 4]
 [1, 2, 3, 4, 5]

 Output :
 5
 */

// MARK: - Brute Force Approach (Using Nested Loops)
/*
 1. Traverse second array elements one by one.
 2. Check whether current element exists
    in first array.
 3. If not exists:
    extra element found.
 */

// MARK: - Brute Force Solution

var array1 = [1, 2, 3, 4]
var array2 = [1, 2, 3, 4, 5]

var extraElementBruteForce = -1


for number in array2 {
    
    var isFound = false
    
    
    for element in array1 {
        
        if number == element {
            isFound = true
            break
        }
    }
    
    
    if !isFound {
        extraElementBruteForce = number
        break
    }
}

print("Brute Force :", extraElementBruteForce)


// MARK: - Optimized Approach (Using HashMap)
/*
 1. Store first array elements in HashMap.
 2. Traverse second array.
 3. If element not exists in HashMap:
    extra element found.
 */

// MARK: - Optimized Solution

var frequencyMap = [Int: Bool]()

var extraElementOptimized = -1


// Store First Array Elements

for number in array1 {
    frequencyMap[number] = true
}


// Find Extra Element

for number in array2 {
    
    if frequencyMap[number] == nil {
        extraElementOptimized = number
        break
    }
}

print("Optimized :", extraElementOptimized)


// MARK: - Sum Difference Approach (Best For Interview)
/*
 1. Find sum of first array.
 2. Find sum of second array.
 3. Difference is extra element.
 */

// MARK: - Sum Solution

var sumArray1 = 0
var sumArray2 = 0


for number in array1 {
    sumArray1 += number
}


for number in array2 {
    sumArray2 += number
}


let extraElementSum = sumArray2 - sumArray1

print("Sum Approach :", extraElementSum)


// MARK: - Edge Cases
/*
 1. Extra Element At Beginning
    [1,2,3]
    [5,1,2,3]

 2. Extra Element At End
    [1,2,3]
    [1,2,3,5]

 3. Duplicate Elements
    [1,1,2]
    [1,1,2,5]

 4. Negative Numbers
    [-1,2]
    [-1,2,5]

 5. Unsorted Arrays
    [4,1,2]
    [1,2,4,7]
 */


// MARK: - Complexity
/*
 Brute Force
 Time  : O(n²)
 Space : O(1)

 Optimized (HashMap)
 Time  : O(n)
 Space : O(n)

 Sum Difference (Best For Interview)
 Time  : O(n)
 Space : O(1)
 */
