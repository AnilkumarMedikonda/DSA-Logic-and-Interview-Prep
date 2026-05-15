import UIKit

//: 18_Find_Missing_Number

// MARK: - Problem Statement
/*
 Given an array containing numbers
 from 1 to n,
 find the missing number.
 */

// MARK: - Example
/*
 Input  :
 [1, 2, 4, 5]

 Output :
 3
 */

// MARK: - Brute Force Approach (Using Nested Loops)
/*
 1. Traverse numbers from 1 to n.
 2. Check whether current number exists
    in array.
 3. If not exists:
    current number is missing.
 */

// MARK: - Brute Force Solution

var array = [1, 2, 4, 5]

let n = array.count + 1

var missingNumberBruteForce = -1


for number in 1...n {
    
    var isFound = false
    
    
    for element in array {
        
        if number == element {
            isFound = true
            break
        }
    }
    
    
    if !isFound {
        missingNumberBruteForce = number
        break
    }
}

print("Brute Force :", missingNumberBruteForce)


// MARK: - Optimized Approach (Using Math Formula) (Best For Interview)
/*
 1. Find expected sum from 1 to n.
 2. Find actual array sum.
 3. Difference is missing number.
 */

// MARK: - Optimized Solution

var actualSum = 0


for number in array {
    actualSum += number
}


let expectedSum = n * (n + 1) / 2

let missingNumberOptimized = expectedSum - actualSum

print("Optimized :", missingNumberOptimized)


// MARK: - HashMap Approach
/*
 1. Store all array elements in HashMap.
 2. Traverse numbers from 1 to n.
 3. If number not exists in HashMap:
    missing number found.
 */

// MARK: - HashMap Solution

var frequencyMap = [Int: Bool]()

var missingNumberHashMap = -1


// Store Array Elements

for number in array {
    frequencyMap[number] = true
}


// Find Missing Number

for number in 1...n {
    
    if frequencyMap[number] == nil {
        missingNumberHashMap = number
        break
    }
}

print("HashMap :", missingNumberHashMap)


// MARK: - Edge Cases
/*
 1. Missing First Number
    [2,3,4,5]

 2. Missing Last Number
    [1,2,3,4]

 3. Single Element
    [1]

 4. Unsorted Array
    [4,2,1,5]

 5. Large Numbers
    [1...10000]
 */


// MARK: - Complexity
/*
 Brute Force
 Time  : O(n²)
 Space : O(1)

 Optimized (Math Formula) (Best For Interview)
 Time  : O(n)
 Space : O(1)

 HashMap
 Time  : O(n)
 Space : O(n)
 */
