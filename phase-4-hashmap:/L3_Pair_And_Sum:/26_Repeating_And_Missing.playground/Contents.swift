import Foundation

//: 26_Repeating_And_Missing_Number

// MARK: - Problem Statement
/*
 Given an array containing numbers
 from 1 to n.

 One number is repeating
 and one number is missing.

 Find both numbers.
 */

// MARK: - Example
/*
 Input  :
 [4, 3, 6, 2, 1, 1]

 Output :
 Repeating : 1
 Missing   : 5
 */

// MARK: - Brute Force Approach (Using Nested Loops)
/*
 1. Traverse numbers from 1 to n.
 2. Count occurrences manually.
 3. If count == 0:
    missing number found.
 4. If count > 1:
    repeating number found.
 */

// MARK: - Brute Force Solution

var array = [4, 3, 6, 2, 1, 1]

let n = array.count

var repeatingNumberBruteForce = -1
var missingNumberBruteForce = -1


for number in 1...n {
    
    var count = 0
    
    
    for element in array {
        
        if number == element {
            count += 1
        }
    }
    
    
    if count == 0 {
        missingNumberBruteForce = number
    }
    
    
    if count > 1 {
        repeatingNumberBruteForce = number
    }
}

print("Brute Force Repeating :", repeatingNumberBruteForce)
print("Brute Force Missing :", missingNumberBruteForce)


// MARK: - Optimized Approach (Using HashMap) (Best For Interview)
/*
 1. Create frequency map using array elements.
 2. Store frequency count for each number.
 3. Traverse numbers from 1 to n.
 4. If frequency:
    nil -> missing number
    >1  -> repeating number
 */

// MARK: - Optimized Solution

var frequencyMap = [Int: Int]()

var repeatingNumberOptimized = -1
var missingNumberOptimized = -1


// Create Frequency Map

for number in array {
    
    if let count = frequencyMap[number] {
        frequencyMap[number] = count + 1
    } else {
        frequencyMap[number] = 1
    }
}


// Find Repeating & Missing

for number in 1...n {
    
    if let count = frequencyMap[number],
       count > 1 {
        
        repeatingNumberOptimized = number
    }
    
    
    if frequencyMap[number] == nil {
        missingNumberOptimized = number
    }
}

print("Optimized Repeating :", repeatingNumberOptimized)
print("Optimized Missing :", missingNumberOptimized)


// MARK: - Edge Cases
/*
 1. Repeating Number At Beginning
    [1,1,2,3]

 2. Repeating Number At End
    [1,2,3,3]

 3. Small Arrays
    [2,2]

 4. Unordered Arrays
    [4,3,6,2,1,1]

 5. Missing First Number
    [2,2,3,4]
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
