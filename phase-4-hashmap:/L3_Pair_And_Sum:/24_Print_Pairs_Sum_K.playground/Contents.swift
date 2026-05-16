import UIKit

//: 24_Print_Pairs_Sum_K

import Foundation

// MARK: - Problem Statement
/*
 Given an array of integers
 and a value K,
 print all pairs whose sum equals K.
 */

// MARK: - Example
/*
 Input  :
 [1, 5, 7, -1, 5]

 k = 6

 Output :
 (1,5)
 (7,-1)
 (1,5)
 */

// MARK: - Brute Force Approach (Using Nested Loops)
/*
 1. Traverse array elements one by one.
 2. Pair current element with remaining elements.
 3. Check:
    current + other == k
 4. If yes:
    print pair.
 */

// MARK: - Brute Force Solution

var array = [1, 5, 7, -1, 5]

var k = 6


for i in 0..<array.count {
    
    for j in i + 1..<array.count {
        
        if array[i] + array[j] == k {
            print("Brute Force :", array[i], array[j])
        }
    }
}


// MARK: - Optimized Approach (Using HashMap) (Best For Interview)
/*
 1. Traverse array elements one by one.
 2. Find complement value:
    k - current element
 3. Check whether complement already exists.
 4. If exists:
    print pair.
 5. Store current element in HashMap.
 */

// MARK: - Optimized Solution

var visitedMap = [Int: Bool]()


for number in array {
    
    let complement = k - number
    
    
    if visitedMap[complement] != nil {
        print("Optimized :", complement, number)
    }
    
    
    visitedMap[number] = true
}


// MARK: - Edge Cases
/*
 1. No Valid Pair
    [1,2,3]
    k = 10

 2. Duplicate Elements
    [1,5,5,1]
    k = 6

 3. Negative Numbers
    [-1,7,5,1]
    k = 6

 4. Multiple Valid Pairs
    [2,4,3,5,7]
    k = 9

 5. Empty Array
    []
 */


// MARK: - Complexity
/*
 Brute Force
 Time  : O(n²)
 Space : O(1)

 Optimized (HashMap) (Best For Interview)
 Time  : O(n)
 Space : O(n)
 */
