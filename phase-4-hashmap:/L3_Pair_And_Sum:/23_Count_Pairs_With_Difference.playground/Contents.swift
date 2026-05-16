import Foundation

//: 23_Count_Pairs_With_Difference

// MARK: - Problem Statement
/*
 Given an array of integers
 and a target difference,
 count how many pairs have
 absolute difference equal to target.
 */

// MARK: - Example
/*
 Input  :
 [1, 5, 3, 4, 2]

 target = 2

 Output :
 3
 */

// MARK: - Brute Force Approach (Using Nested Loops)
/*
 1. Traverse array elements one by one.
 2. Pair current element with remaining elements.
 3. Find absolute difference manually.
 4. If difference equals target:
    increase pair count.
 */

// MARK: - Brute Force Solution

var array = [1, 5, 3, 4, 2]

var target = 2

var countBruteForce = 0


for i in 0..<array.count {
    
    for j in i + 1..<array.count {
        
        let difference: Int
        
        
        if array[i] > array[j] {
            difference = array[i] - array[j]
        } else {
            difference = array[j] - array[i]
        }
        
        
        if difference == target {
            countBruteForce += 1
        }
    }
}

print("Brute Force :", countBruteForce)


// MARK: - Optimized Approach (Using HashMap) (Best For Interview)
/*
 1. Store array elements in HashMap.
 2. Traverse array elements one by one.
 3. Check whether:
    current + target
    exists in HashMap.
 4. If exists:
    pair found.
 */

// MARK: - Optimized Solution

var frequencyMap = [Int: Bool]()

var countOptimized = 0


// Store Elements

for number in array {
    frequencyMap[number] = true
}


// Find Valid Pairs

for number in array {
    
    let valueToFind = number + target
    
    
    if frequencyMap[valueToFind] != nil {
        countOptimized += 1
    }
}

print("Optimized :", countOptimized)


// MARK: - Edge Cases
/*
 1. No Valid Pair
    [1,2,3]
    target = 10

 2. Duplicate Elements
    [1,1,1]
    target = 0

 3. Negative Numbers
    [-1,1,3,5]
    target = 2

 4. Multiple Valid Pairs
    [1,5,3,4,2]
    target = 2

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
