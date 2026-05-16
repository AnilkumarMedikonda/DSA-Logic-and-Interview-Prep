import Foundation

//: 39_Common_Characters

// MARK: - Problem Statement
/*
 Given two strings,
 find common characters
 present in both strings.
 */

// MARK: - Example
/*
 Input  :
 str1 = "swift"
 str2 = "wish"

 Output :
 w
 i
 s
 */


// MARK: - Brute Force Approach
/*
 1. Traverse every character in str1.
 2. Compare with every character in str2.
 3. Avoid duplicate outputs.
 */

// MARK: - Brute Force Solution

var str1 = "swift"
var str2 = "wish"

var commonCharactersBruteForce: [Character] = []


for ch1 in str1 {

    var isAlreadyAdded = false


    for addedCharacter in commonCharactersBruteForce {

        if ch1 == addedCharacter {

            isAlreadyAdded = true
            break
        }
    }


    if isAlreadyAdded {
        continue
    }


    for ch2 in str2 {

        if ch1 == ch2 {

            commonCharactersBruteForce.append(ch1)
            break
        }
    }
}

print("Brute Force :", commonCharactersBruteForce)


// MARK: - Optimized Approach (Using HashMap)
/*
 1. Store characters of first string.
 2. Traverse second string.
 3. If character exists:
    common character found.
 4. Remove character to avoid duplicates.
 */

// MARK: - Optimized Solution

var frequencyMap: [Character: Int] = [:]

var commonCharactersOptimized: [Character] = []


for ch in str1 {

    if let count = frequencyMap[ch] {

        frequencyMap[ch] = count + 1

    } else {

        frequencyMap[ch] = 1
    }
}


for ch in str2 {

    if frequencyMap[ch] != nil {

        commonCharactersOptimized.append(ch)

        frequencyMap[ch] = nil
    }
}

print("Optimized :", commonCharactersOptimized)


// MARK: - Edge Cases
/*
 1. No Common Characters
    "abc"
    "xyz"

 2. All Common Characters
    "abc"
    "abc"

 3. Duplicate Characters
    "apple"
    "plane"

 4. Empty Strings
    ""

 5. Mixed Characters
    "swift"
    "wish"
 */


// MARK: - Complexity
/*
 Brute Force
 Time  : O(n * m)
 Space : O(n)

 Optimized (Best For Interview)
 Time  : O(n + m)
 Space : O(n)
 */


