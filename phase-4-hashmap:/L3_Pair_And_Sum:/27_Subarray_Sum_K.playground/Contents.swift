import UIKit

//: 27_Subarray_Sum_K

import Foundation

// MARK: - Problem Statement
/*
 Given an array of integers
 and a value K,
 find continuous subarray
 whose sum equals K.
 */

// MARK: - Example
/*
 Input  :
 [1, 4, 20, 3, 10, 5]

 k = 33

 Output :
 [20, 3, 10]
 */

// MARK: - Brute Force Approach
/*
 1. Traverse every starting index.
 2. Continuously add next elements.
 3. Check whether running sum equals K.
 4. If yes:
    store subarray elements.
 */

// MARK: - Brute Force Solution

var array = [1, 4, 20, 3, 10, 5]
var k = 33

var subArrayBruteForce: [Int] = []
var isSubArrayFound = false

for i in 0..<array.count {

    var sum = 0

    for j in i..<array.count {

        sum += array[j]

        if sum == k {

            subArrayBruteForce = Array(array[i...j])
            isSubArrayFound = true
            break
        }
    }

    if isSubArrayFound {
        break
    }
}

print("Brute Force :", subArrayBruteForce)


// MARK: - Optimized Approach (Prefix Sum + HashMap)
/*
 1. Maintain running prefix sum.
 2. Store prefixSum : index in HashMap.
 3. Check:
    currentPrefixSum - k
    exists or not.
 4. If exists:
    subarray found.
 */

// MARK: - Optimized Solution

var subArrayOptimized: [Int] = []

var prefixMap: [Int: Int] = [:]
prefixMap[0] = -1

var prefixSum = 0

for i in 0..<array.count {

    prefixSum += array[i]

    let valueToFind = prefixSum - k

    if let startIndex = prefixMap[valueToFind] {

        subArrayOptimized = Array(array[startIndex + 1...i])
        break
    }

    prefixMap[prefixSum] = i
}

print("Optimized :", subArrayOptimized)


// MARK: - Edge Cases
/*
 1. Single Element Equals K
    [5]
    k = 5

 2. Full Array Sum Equals K
    [1,2,3]
    k = 6

 3. Negative Numbers
    [10,2,-2,-20,10]
    k = -10

 4. Zero Values
    [0,0,0]
    k = 0

 5. No Valid Subarray
    [1,2,3]
    k = 10
 */


// MARK: - Complexity
/*
 Brute Force
 Time  : O(n²)
 Space : O(n)

 Optimized (Best For Interview)
 Time  : O(n)
 Space : O(n)
 */
