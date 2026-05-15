import UIKit

// 12_Remove_String_Duplicates

//: 12_Remove_Duplicates_From_String

import Foundation

// MARK: - Problem Statement
/*
 Given a string,
 remove duplicate characters.
 */

// MARK: - Example
/*
 Input  : "banana"

 Output :
 "ban"
 */

// MARK: - Brute Force Approach (Using Nested Loops)
/*
 1. Traverse string characters one by one.
 2. Check if character already exists
    in result string.
 3. If not exists:
    append into result string.
 */

// MARK: - Brute Force Solution

var str = "banana"
var uniqueStringBruteForce = ""


for char in str {
    
    var alreadyExists = false
    
    for existingCharacter in uniqueStringBruteForce {
        if char == existingCharacter {
            alreadyExists = true
            break
        }
    }
    
    if !alreadyExists {
        uniqueStringBruteForce += String(char)
    }
}

print("Brute Force :", uniqueStringBruteForce)


// MARK: - Optimized Approach (Using HashMap) (Best For Interview)
/*
 1. Create HashMap to track visited characters.
 2. Traverse string characters one by one.
 3. If character appears first time:
    - append into result string
    - store in HashMap
 4. Else:
    skip duplicate character.
 */

// MARK: - Optimized Solution

var uniqueStringOptimized = ""
var visitedMap = [Character: Bool]()


for char in str {
    
    if visitedMap[char] == nil {
        
        uniqueStringOptimized += String(char)
        visitedMap[char] = true
    }
}

print("Optimized :", uniqueStringOptimized)


// MARK: - Edge Cases
/*
 1. Empty String
    ""

 2. All Duplicate Characters
    "aaaa"

 3. All Unique Characters
    "swift"

 4. Uppercase / Lowercase
    "Aa"

 5. Special Characters
    "a@a#"
 */


// MARK: - Complexity
/*
 Brute Force (Nested Loops)
 Time  : O(n²)
 Space : O(n)

 Optimized (HashMap) (Best For Interview)
 Time  : O(n)
 Space : O(n)
 */
