import UIKit

//: 30_Duplicate_Within_K

import Foundation

// MARK: - Problem Statement
/*
 Given an array of integers
 and a value K,
 check whether duplicate elements
 exist within distance K.
 */

// MARK: - Example
/*
 Input  :
 [1, 2, 3, 1]

 k = 3

 Output :
 true
 */


// MARK: - Brute Force Approach
/*
 1. Compare every element
    with remaining elements.
 2. If duplicate found:
    calculate index distance.
 3. If distance <= k:
    duplicate within K found.
 */

// MARK: - Brute Force Solution

var array = [1, 2, 3, 1]

var k = 3

var isDuplicateFoundBruteForce = false


for i in 0..<array.count {

    for j in i + 1..<array.count {

        if array[i] == array[j] {

            let distance = j - i

            if distance <= k {

                isDuplicateFoundBruteForce = true
                break
            }
        }
    }

    if isDuplicateFoundBruteForce {
        break
    }
}

print("Brute Force :", isDuplicateFoundBruteForce)


// MARK: - Optimized Approach (Using HashMap)
/*
 1. Store:
    element : latest index
 2. If duplicate appears:
    calculate distance.
 3. If distance <= k:
    duplicate within K found.
 */

// MARK: - Optimized Solution

var indexMap: [Int: Int] = [:]

var isDuplicateFoundOptimized = false


for i in 0..<array.count {

    let currentNumber = array[i]


    if let previousIndex = indexMap[currentNumber] {

        let distance = i - previousIndex

        if distance <= k {

            isDuplicateFoundOptimized = true
            break
        }
    }


    indexMap[currentNumber] = i
}

print("Optimized :", isDuplicateFoundOptimized)


// MARK: - Edge Cases
/*
 1. Duplicate Exists Within K
    [1,2,3,1]
    k = 3

 2. Duplicate Exists But Distance > K
    [1,2,3,1]
    k = 2

 3. Multiple Duplicates
    [1,0,1,1]
    k = 1

 4. No Duplicate
    [1,2,3,4]

 5. Empty Array
    []
 */


// MARK: - Complexity
/*
 Brute Force
 Time  : O(n²)
 Space : O(1)

 Optimized (Best For Interview)
 Time  : O(n)
 Space : O(n)
 */
