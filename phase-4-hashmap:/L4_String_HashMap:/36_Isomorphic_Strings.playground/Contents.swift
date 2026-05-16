import UIKit

// 36_Isomorphic_Strings


//: 36_Isomorphic_Strings

import Foundation

// MARK: - Problem Statement
/*
 Given two strings,
 check whether both strings
 are isomorphic or not.
 */

// MARK: - Important Note
/*
 Two strings are isomorphic if:
 1. Characters follow same pattern.
 2. One character maps to only one character.
 3. Mapping must be consistent.
 */

// MARK: - Example
/*
 Input  :
 str1 = "egg"
 str2 = "add"

 Output :
 true
 */


// MARK: - Brute Force Approach
/*
 1. Compare character patterns manually.
 2. Validate mapping consistency.
 3. Check one-to-one mapping.
 */

// MARK: - Brute Force Solution

var str1 = "egg"
var str2 = "add"

var isIsomorphicBruteForce = true

if str1.count != str2.count {
    isIsomorphicBruteForce = false
}

let array1 = Array(str1)
let array2 = Array(str2)

for i in 0..<array1.count {

    for j in i + 1..<array1.count {

        let samePatternInFirstString = array1[i] == array1[j]
        let samePatternInSecondString = array2[i] == array2[j]

        if samePatternInFirstString != samePatternInSecondString {
            isIsomorphicBruteForce = false
            break
        }
    }

    if !isIsomorphicBruteForce {
        break
    }
}

print("Brute Force :", isIsomorphicBruteForce)


// MARK: - Optimized Approach (Using HashMap)
/*
 1. Store mapping from:
    str1 -> str2
 2. Store reverse mapping from:
    str2 -> str1
 3. Validate mapping consistency.
 */

// MARK: - Optimized Solution

var isIsomorphicOptimized = true

var map1: [Character: Character] = [:]
var map2: [Character: Character] = [:]

for i in 0..<array1.count {

    let char1 = array1[i]
    let char2 = array2[i]


    // str1 -> str2 Mapping

    if let mappedCharacter = map1[char1] {

        if mappedCharacter != char2 {

            isIsomorphicOptimized = false
            break
        }

    } else {

        map1[char1] = char2
    }


    // str2 -> str1 Mapping

    if let mappedCharacter = map2[char2] {

        if mappedCharacter != char1 {

            isIsomorphicOptimized = false
            break
        }

    } else {

        map2[char2] = char1
    }
}

print("Optimized :", isIsomorphicOptimized)


// MARK: - Edge Cases
/*
 1. Different Length Strings
    "abc"
    "ab"

 2. Valid Isomorphic
    "egg"
    "add"

 3. Invalid Mapping
    "foo"
    "bar"

 4. Multiple Valid Mappings
    "paper"
    "title"

 5. Same Strings
    "swift"
    "swift"
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
