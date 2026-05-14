//: 08_First_Non_Repeating_Element
import Foundation

// MARK: - Problem Statement
/*
 Given an array of integers,
 find the first non-repeating element.
 */

// MARK: - Example
/*
 Input  : [1, 2, 1, 3, 2, 4]

 Output :
 3
 */

// MARK: - Brute Force Approach
/*
 1. Traverse array elements one by one.
 2. Compare current element with all elements.
 3. If duplicate found:
    mark as duplicate.
 4. First element without duplicate:
    return answer.
 */

// MARK: - Brute Force Solution

var array = [1, 2, 1, 3, 2, 4]

for i in 0..<array.count {
    
    var isDuplicate = false
    
    for j in 0..<array.count {
        
        if i != j, array[i] == array[j] {
            isDuplicate = true
        }
    }
    
    if !isDuplicate {
        print("Brute Force :", array[i])
        break
    }
}

// MARK: - Optimized Approach (Best For Interview)
/*
 1. Create frequency map using Dictionary.
 2. Traverse array elements one by one.
 3. Store frequency count for each element.
 4. Traverse original array again.
 5. Find first element where frequency == 1.
 */

// MARK: - Optimized Solution

var frequencyMap = [Int: Int]()
var firstNonRepeatingElement: Int?


// Create Frequency Map

for number in array {
    
    if let count = frequencyMap[number] {
        frequencyMap[number] = count + 1
    } else {
        frequencyMap[number] = 1
    }
}


// Traverse Original Array

for number in array {
    
    if frequencyMap[number] == 1 {
        firstNonRepeatingElement = number
        break
    }
}

// MARK: - Output

if let element = firstNonRepeatingElement {
    print("Optimized :", element)
} else {
    print("No Non-Repeating Element")
}

// MARK: - Edge Cases
/*
 1. Empty Array
    []

 2. All Duplicate Elements
    [1,1,2,2]

 3. All Unique Elements
    [1,2,3]

 4. Negative Numbers
    [-1,-1,2,3]

 5. Mixed Elements
    [1,2,1,3,2,4]
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
