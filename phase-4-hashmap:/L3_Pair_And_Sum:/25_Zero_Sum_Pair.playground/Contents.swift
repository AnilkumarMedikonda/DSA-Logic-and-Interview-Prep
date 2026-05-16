import Foundation

//: 25_Zero_Sum_Pair

// MARK: - Problem Statement
/*
 Given an array of integers,
 check whether there exists a pair
 whose sum equals zero.
 */

// MARK: - Example
/*
 Input  :
 [5, -5, 3, 1]

 Output :
 true
 */

// MARK: - Brute Force Approach (Using Nested Loops)
/*
 1. Traverse array elements one by one.
 2. Pair current element with remaining elements.
 3. Check:
    current + other == 0
 4. If yes:
    zero sum pair found.
 */

// MARK: - Brute Force Solution

var array = [5, -5, 3, 1]

var isZeroSumPairBruteForce = false


for i in 0..<array.count {
    
    for j in i + 1..<array.count {
        
        if array[i] + array[j] == 0 {
            
            print("Brute Force :", array[i], array[j])
            isZeroSumPairBruteForce = true
            break
        }
    }
    
    
    if isZeroSumPairBruteForce {
        break
    }
}


// MARK: - Optimized Approach (Using HashMap) (Best For Interview)
/*
 1. Traverse array elements one by one.
 2. Find complement value:
    -current element
 3. Check whether complement already exists.
 4. If exists:
    zero sum pair found.
 5. Store current element in HashMap.
 */

// MARK: - Optimized Solution

var frequencyMap = [Int: Int]()

var isZeroSumPairOptimized = false


for number in array {
    
    let complement = -number
    
    
    if frequencyMap[complement] != nil {
        
        print("Optimized :", complement, number)
        isZeroSumPairOptimized = true
        break
    }
    
    
    frequencyMap[number] = 1
}


// MARK: - Edge Cases
/*
 1. No Valid Pair
    [1,2,3]

 2. Positive & Negative Pair
    [5,-5]

 3. Duplicate Zero
    [0,0]

 4. Multiple Valid Pairs
    [1,-1,2,-2]

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
