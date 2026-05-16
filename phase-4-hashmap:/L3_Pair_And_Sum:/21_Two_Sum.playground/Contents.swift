import UIKit

//: 21_Two_Sum

import Foundation

// MARK: - Problem Statement
/*
 Given an array of integers
 and a target value,
 find two elements whose sum
 equals target.
 */

// MARK: - Example
/*
 Input  :
 [2, 7, 11, 15]
 target = 9

 Output :
 [2, 7]
 */

// MARK: - Brute Force Approach (Using Nested Loops)
/*
 1. Traverse array elements one by one.
 2. Pair current element with remaining elements.
 3. Check:
    current + other == target
 4. If yes:
    pair found.
 */

// MARK: - Brute Force Solution

var array = [2, 7, 11, 15]

var target = 9

var pairFoundBruteForce = false


for i in 0..<array.count {
    
    for j in i + 1..<array.count {
        
        if array[i] + array[j] == target {
            
            print("Brute Force :", array[i], array[j])
            pairFoundBruteForce = true
            break
        }
    }
    
    
    if pairFoundBruteForce {
        break
    }
}


// MARK: - Optimized Approach (Using HashMap) (Best For Interview)
/*
 1. Traverse array elements one by one.
 2. Find complement value:
    target - current element
 3. Check whether complement already exists.
 4. If exists:
    pair found.
 5. Else:
    store current element in HashMap.
 */

// MARK: - Optimized Solution

var visitedMap = [Int: Bool]()

var pairFoundOptimized = false


for number in array {
    
    let complement = target - number
    
    
    if visitedMap[complement] != nil {
        
        print("Optimized :", complement, number)
        pairFoundOptimized = true
        break
    }
    
    
    visitedMap[number] = true
}


// MARK: - Edge Cases
/*
 1. No Valid Pair
    [1,2,3]
    target = 10

 2. Duplicate Elements
    [3,3]
    target = 6

 3. Negative Numbers
    [-1,4,2]
    target = 3

 4. Multiple Valid Pairs
    [1,2,3,4]
    target = 5

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

