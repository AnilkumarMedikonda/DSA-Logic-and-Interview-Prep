import Foundation

//: 29_First_Unique_Element

// MARK: - Problem Statement
/*
 Given an array of integers,
 find the first non-repeating element.
 */

// MARK: - Important Note
/*
 Unique element means:
 element appearing only once.
 */

// MARK: - Example
/*
 Input  :
 [4, 5, 1, 2, 0, 4]

 Output :
 5
 */


// MARK: - Brute Force Approach
/*
 1. Traverse every element.
 2. Count occurrences manually.
 3. If count == 1:
    first unique element found.
 */

// MARK: - Brute Force Solution

var array = [4, 5, 1, 2, 0, 4]

var firstUniqueBruteForce = -1

for i in 0..<array.count {

    var count = 0

    for j in 0..<array.count {

        if array[i] == array[j] {
            count += 1
        }
    }

    if count == 1 {

        firstUniqueBruteForce = array[i]
        break
    }
}

print("Brute Force :", firstUniqueBruteForce)


// MARK: - Optimized Approach (Using HashMap)
/*
 1. Store frequency of every element.
 2. Traverse original array again.
 3. First element whose frequency == 1
    is answer.
 */

// MARK: - Optimized Solution

var frequencyMap: [Int: Int] = [:]

for num in array {
    frequencyMap[num, default: 0] += 1
}

var firstUniqueOptimized = -1

for num in array {

    if let count = frequencyMap[num],
       count == 1 {

        firstUniqueOptimized = num
        break
    }
}

print("Optimized :", firstUniqueOptimized)


// MARK: - Edge Cases
/*
 1. No Unique Element
    [1,1,2,2]

 2. First Element Unique
    [5,1,1,2,2]

 3. Last Element Unique
    [1,1,2,2,5]

 4. All Elements Unique
    [1,2,3]

 5. Single Element
    [10]
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
