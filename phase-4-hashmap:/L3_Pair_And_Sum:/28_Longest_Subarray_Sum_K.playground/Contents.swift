import UIKit

//: 28_Longest_Subarray_Sum_K

import Foundation

// MARK: - Problem Statement
/*
 Given an array of integers
 and a value K,
 find the length of the
 longest continuous subarray
 whose sum equals K.
 */

// MARK: - Example
/*
 Input  :
 [10, 5, 2, 7, 1, 9]

 k = 15

 Output :
 4

 Longest Subarray :
 [5, 2, 7, 1]
 */


// MARK: - Brute Force Approach
/*
 1. Traverse every starting index.
 2. Continuously add next elements.
 3. If sum equals K:
    calculate subarray length.
 4. Store maximum length.
 */

// MARK: - Brute Force Solution

var array = [10, 5, 2, 7, 1, 9]
var k = 15

var longestLengthBruteForce = 0

for i in 0..<array.count {

    var sum = 0

    for j in i..<array.count {

        sum += array[j]

        if sum == k {

            let currentLength = j - i + 1

            if currentLength > longestLengthBruteForce {
                longestLengthBruteForce = currentLength
            }
        }
    }
}

print("Brute Force :", longestLengthBruteForce)


// MARK: - Optimized Approach (Prefix Sum + HashMap)
/*
 1. Maintain running prefix sum.
 2. Store prefixSum : index in HashMap.
 3. Check:
    currentPrefixSum - k
    exists or not.
 4. If exists:
    subarray sum K found.
 5. Calculate subarray length.
 6. Store maximum length.
 */

// MARK: - Optimized Solution

var prefixSum = 0

var prefixMap: [Int: Int] = [:]

prefixMap[0] = -1

var longestLengthOptimized = 0


for i in 0..<array.count {

    prefixSum += array[i]


    let valueToFind = prefixSum - k


    if let previousIndex = prefixMap[valueToFind] {

        let currentLength = i - previousIndex

        if currentLength > longestLengthOptimized {
            longestLengthOptimized = currentLength
        }
    }


    // Store First Occurrence Only

    if prefixMap[prefixSum] == nil {
        prefixMap[prefixSum] = i
    }
}

print("Optimized :", longestLengthOptimized)


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
 Space : O(1)

 Optimized (Best For Interview)
 Time  : O(n)
 Space : O(n)
 */
