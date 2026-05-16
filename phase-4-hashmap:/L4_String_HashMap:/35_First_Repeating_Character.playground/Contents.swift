import UIKit

//: 35_First_Repeating_Character

import Foundation

// MARK: - Problem Statement
/*
 Given a string,
 find the first
 repeating character.
 */

// MARK: - Important Note
/*
 Repeating character means:
 character appearing
 more than once.
 */

// MARK: - Example
/*
 Input  :
 "swiss"

 Output :
 s
 */


// MARK: - Brute Force Approach
/*
 1. Traverse every character.
 2. Count occurrences manually.
 3. If count > 1:
    first repeating character found.
 */

// MARK: - Brute Force Solution

var str = "swiss"

var firstRepeatingBruteForce: Character? = nil

for currentCharacter in str {

    var count = 0

    for otherCharacter in str {

        if currentCharacter == otherCharacter {
            count += 1
        }
    }

    if count > 1 {

        firstRepeatingBruteForce = currentCharacter
        break
    }
}

print("Brute Force :", firstRepeatingBruteForce as Any)


// MARK: - Optimized Approach (Using HashMap)
/*
 1. Store frequency of characters.
 2. Traverse original string again.
 3. First character whose frequency > 1
    is answer.
 */

// MARK: - Optimized Solution

var frequencyMap: [Character: Int] = [:]

for ch in str {

    if let count = frequencyMap[ch] {

        frequencyMap[ch] = count + 1

    } else {

        frequencyMap[ch] = 1
    }
}

var firstRepeatingOptimized: Character? = nil

for ch in str {

    if let count = frequencyMap[ch],
       count > 1 {

        firstRepeatingOptimized = ch
        break
    }
}

print("Optimized :", firstRepeatingOptimized as Any)


// MARK: - Edge Cases
/*
 1. Empty String
    ""

 2. No Repeating Character
    "swift"

 3. First Character Repeats
    "abca"

 4. Multiple Repeating Characters
    "swiss"

 5. All Same Characters
    "aaaa"
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
