import UIKit

//: 22_Count_Pairs_With_Sum

import Foundation

// MARK: - Problem Statement
/*
 Given an array of integers
 and a target value,
 count how many pairs
 have sum equal to target.
 */

// MARK: - Example
/*
 Input  :
 [1, 5, 7, -1]

 target = 6

 Output :
 2
 */

// MARK: - Brute Force Approach (Using Nested Loops)
/*
 1. Traverse array elements one by one.
 2. Pair current element with remaining elements.
 3. Check:
    current + other == target
 4. If yes:
    increase pair count.
 */

// MARK: - Brute Force Solution

var array = [1, 5, 7, -1]

var target = 6

var countBruteForce = 0


for i in 0..<array.count {
    
    for j in i + 1..<array.count {
        
        if array[i] + array[j] == target {
            countBruteForce += 1
        }
    }
}

print("Brute Force :", countBruteForce)


// MARK: - Optimized Approach (Using HashMap) (Best For Interview)
/*
 1. Traverse array elements one by one.
 2. Find complement value:
    target - current element
 3. If complement already exists:
    add its frequency to count.
 4. Store/update current element frequency.
 */

// MARK: - Optimized Solution

var frequencyMap = [Int: Int]()

var countOptimized = 0


for number in array {
    
    let complement = target - number
    
    
    if let value = frequencyMap[complement] {
        countOptimized += value
    }
    
    
    if let value = frequencyMap[number] {
        frequencyMap[number] = value + 1
    } else {
        frequencyMap[number] = 1
    }
}

print("Optimized :", countOptimized)


// MARK: - Edge Cases
/*
 1. No Valid Pair
    [1,2,3]
    target = 10

 2. Duplicate Elements
    [1,1,1,1]
    target = 2

 3. Negative Numbers
    [-1,7,5,1]
    target = 6

 4. Multiple Valid Pairs
    [2,4,3,5]
    target = 7

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
