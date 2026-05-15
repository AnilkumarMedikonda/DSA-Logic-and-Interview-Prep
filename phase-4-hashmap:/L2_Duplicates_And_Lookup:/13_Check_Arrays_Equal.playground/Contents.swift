import UIKit

//: 13_Check_Two_Arrays_Equal

import Foundation

// MARK: - Problem Statement
/*
 Given two arrays,
 check whether both arrays are equal.
 */

// MARK: - Example
/*
 Input  :
 [1, 2, 3]
 [1, 2, 3]

 Output :
 true
 */

// MARK: - Brute Force Approach (Using Simple Traversal) (Best For Interview)
/*
 1. Check both array sizes.
 2. Traverse arrays index by index.
 3. Compare elements.
 4. If mismatch found:
    arrays are not equal.
 */

// MARK: - Brute Force Solution

var arrayOne = [1, 2, 3]
var arrayTwo = [1, 2, 3]

var isEqualBruteForce = true


if arrayOne.count != arrayTwo.count {
    
    isEqualBruteForce = false
    
} else {
    
    for i in 0..<arrayOne.count {
        
        if arrayOne[i] != arrayTwo[i] {
            isEqualBruteForce = false
            break
        }
    }
}

print("Brute Force :", isEqualBruteForce)


// MARK: - Optimized Approach (Using HashMap)
/*
 1. Create frequency map using first array.
 2. Store frequency count for each element.
 3. Traverse second array.
 4. Reduce frequency count.
 5. If mismatch found:
    arrays are not equal.
 6. Finally:
    all frequencies must become zero.
 */

// MARK: - Optimized Solution

var frequencyMap = [Int: Int]()
var isEqualOptimized = true


// Create Frequency Map

for number in arrayOne {
    
    if let count = frequencyMap[number] {
        frequencyMap[number] = count + 1
    } else {
        frequencyMap[number] = 1
    }
}


// Reduce Frequencies

for number in arrayTwo {
    
    if let count = frequencyMap[number],
       count > 0 {
        
        frequencyMap[number] = count - 1
        
    } else {
        isEqualOptimized = false
        break
    }
}


// Final Verification

for (_, value) in frequencyMap {
    
    if value != 0 {
        isEqualOptimized = false
        break
    }
}

print("Optimized :", isEqualOptimized)


// MARK: - Edge Cases
/*
 1. Empty Arrays
    []
    []

 2. Different Sizes
    [1,2]
    [1,2,3]

 3. Different Order
    [1,2,3]
    [3,2,1]

 4. Duplicate Elements
    [1,2,2]
    [1,2,2]

 5. Negative Numbers
    [-1,2]
    [-1,2]
 */


// MARK: - Complexity
/*
 Brute Force (Simple Traversal) (Best For Interview)
 Time  : O(n)
 Space : O(1)

 Optimized (HashMap)
 Time  : O(n)
 Space : O(n)
 */
