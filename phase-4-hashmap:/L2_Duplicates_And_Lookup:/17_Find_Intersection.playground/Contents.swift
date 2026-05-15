import UIKit

//: 17_Find_Intersection_Of_Arrays

import Foundation

// MARK: - Problem Statement
/*
 Given two arrays,
 find intersection of both arrays.
 */

// MARK: - Example
/*
 Input  :
 [1, 3, 5, 7, 9]
 [3, 4, 5, 6]

 Output :
 [3, 5]
 */

// MARK: - Brute Force Approach (Using Nested Loops)
/*
 1. Traverse first array elements one by one.
 2. Compare with all elements in second array.
 3. If match found:
    add into result array.
 4. Break loop to avoid duplicate reuse.
 */

// MARK: - Brute Force Solution

var arr1 = [1, 3, 5, 7, 9]
var arr2 = [3, 4, 5, 6]

var resultBruteForce = [Int]()
var visited = Array(repeating: false, count: arr2.count)


for number in arr1 {
    
    for i in 0..<arr2.count {
        
        if number == arr2[i],
           !visited[i] {
            
            resultBruteForce.append(number)
            visited[i] = true
            break
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

for number in arr1 {
    
    if let count = frequencyMap[number] {
        frequencyMap[number] = count + 1
    } else {
        frequencyMap[number] = 1
    }
}


// Find Intersection

for number in arr2 {
    
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
    [1,2]
    [3,4]

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
 Space : O(m)
 Optimized (HashMap) (Best For Interview)
 Time  : O(n + m)
 Space : O(n)
 */
