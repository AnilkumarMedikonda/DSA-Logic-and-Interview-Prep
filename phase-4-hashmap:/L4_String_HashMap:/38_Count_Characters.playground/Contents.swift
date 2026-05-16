import Foundation

//: 38_Count_Characters

// MARK: - Problem Statement
/*
 Given a string,
 count total number
 of characters.
 */

// MARK: - Example
/*
 Input  :
 "swift"

 Output :
 5
 */


// MARK: - Brute Force Approach
/*
 1. Traverse every character.
 2. Increase count manually.
 */

// MARK: - Brute Force Solution

var str = "swift"

var countBruteForce = 0

for ch in str {
    countBruteForce += 1
}

print("Brute Force :", countBruteForce)


// MARK: - Optimized Approach
/*
 Swift provides:
 .count
 property for strings.
 */

// MARK: - Optimized Solution

let countOptimized = str.count

print("Optimized :", countOptimized)


// MARK: - Edge Cases
/*
 1. Empty String
    ""

 2. Single Character
    "a"

 3. Multiple Characters
    "swift"

 4. Spaces Included
    "hello world"

 5. Special Characters
    "@#$%"
 */


// MARK: - Complexity
/*
 Brute Force
 Time  : O(n)
 Space : O(1)

 Optimized
 Time  : O(1)
 Space : O(1)
 */
