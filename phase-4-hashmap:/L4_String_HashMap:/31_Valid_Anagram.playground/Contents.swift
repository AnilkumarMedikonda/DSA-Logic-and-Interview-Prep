import UIKit

//: 31_Valid_Anagram

import Foundation

// MARK: - Problem Statement
/*
 Given two strings,
 check whether both strings
 are anagrams or not.
 */

// MARK: - Important Note
/*
 Two strings are anagrams if:
 1. Both contain same characters.
 2. Character frequencies are same.
 3. Order can be different.
 */

// MARK: - Example
/*
 Input  :
 str1 = "triangle"
 str2 = "integral"

 Output :
 true
 */


// MARK: - Brute Force Approach
/*
 1. Check string lengths.
 2. Count frequency of every character
    manually in both strings.
 3. Compare frequencies.
 */

// MARK: - Brute Force Solution

var str1 = "triangle"
var str2 = "integral"

var isAnagramBruteForce = true


if str1.count != str2.count {
    isAnagramBruteForce = false
}


for ch in str1 {

    var count1 = 0
    var count2 = 0


    for otherCharacter in str1 {

        if ch == otherCharacter {
            count1 += 1
        }
    }


    for otherCharacter in str2 {

        if ch == otherCharacter {
            count2 += 1
        }
    }


    if count1 != count2 {
        isAnagramBruteForce = false
        break
    }
}

print("Brute Force :", isAnagramBruteForce)


// MARK: - Optimized Approach (Using HashMap)
/*
 1. Check string lengths.
 2. Store frequency of first string.
 3. Decrease frequency using second string.
 4. If all frequencies become zero:
    valid anagram.
 */

// MARK: - Optimized Solution

var isAnagramOptimized = true

var frequencyMap: [Character: Int] = [:]


if str1.count != str2.count {
    isAnagramOptimized = false
}


for ch in str1 {
    frequencyMap[ch, default: 0] += 1
}


for ch in str2 {

    if let count = frequencyMap[ch] {
        frequencyMap[ch] = count - 1
    } else {
        isAnagramOptimized = false
        break
    }
}


for (_, value) in frequencyMap {

    if value != 0 {
        isAnagramOptimized = false
        break
    }
}

print("Optimized :", isAnagramOptimized)


// MARK: - Edge Cases
/*
 1. Different Lengths
    "abc"
    "ab"

 2. Same Characters Different Order
    "listen"
    "silent"

 3. Same Strings
    "swift"
    "swift"

 4. Different Frequencies
    "apple"
    "appla"

 5. Empty Strings
    ""
    ""
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
