import Foundation

//: 40_Check_K_Anagrams

// MARK: - Problem Statement
/*
 Given two strings and a value k,
 check whether both strings
 are K-Anagrams or not.
 */

// MARK: - Important Note
/*
 Two strings are K-Anagrams if:
 1. Both strings have same length.
 2. By changing at most k characters,
    both strings can become anagrams.
 */

// MARK: - Example
/*
 Input  :
 str1 = "anagram"
 str2 = "grammar"

 k = 3

 Output :
 true
 */


// MARK: - Brute Force Approach
/*
 1. Compare frequencies manually.
 2. Count unmatched characters.
 3. If changesNeeded <= k:
    valid K-Anagram.
 */

// MARK: - Brute Force Solution

var str1 = "anagram"
var str2 = "grammar"

var k = 3

var isKAnagramBruteForce = true


if str1.count != str2.count {
    isKAnagramBruteForce = false
}


var changesNeededBruteForce = 0


for ch1 in str1 {

    var count1 = 0
    var count2 = 0


    for otherCharacter in str1 {

        if ch1 == otherCharacter {
            count1 += 1
        }
    }


    for otherCharacter in str2 {

        if ch1 == otherCharacter {
            count2 += 1
        }
    }


    if count1 > count2 {

        changesNeededBruteForce += count1 - count2
    }
}


if changesNeededBruteForce > k {
    isKAnagramBruteForce = false
}

print("Brute Force :", isKAnagramBruteForce)


// MARK: - Optimized Approach (Using HashMap)
/*
 1. Store frequency of str1.
 2. Decrease frequency using str2.
 3. Count remaining positive frequencies.
 4. Compare changesNeeded with k.
 */

// MARK: - Optimized Solution

var isKAnagramOptimized = true

var frequencyMap: [Character: Int] = [:]


if str1.count != str2.count {
    isKAnagramOptimized = false
}


for ch in str1 {

    if let count = frequencyMap[ch] {

        frequencyMap[ch] = count + 1

    } else {

        frequencyMap[ch] = 1
    }
}


for ch in str2 {

    if let count = frequencyMap[ch] {

        frequencyMap[ch] = count - 1
    }
}


var changesNeededOptimized = 0


for (_, value) in frequencyMap {

    if value > 0 {

        changesNeededOptimized += value
    }
}


if changesNeededOptimized > k {
    isKAnagramOptimized = false
}

print("Optimized :", isKAnagramOptimized)


// MARK: - Edge Cases
/*
 1. Already Anagrams
    "listen"
    "silent"

 2. Different Length Strings
    "abc"
    "abcd"

 3. Exact K Changes Needed
    "anagram"
    "grammar"

 4. More Than K Changes Needed
    "apple"
    "plane"

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
