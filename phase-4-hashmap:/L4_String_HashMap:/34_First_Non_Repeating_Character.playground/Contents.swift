import Foundation

//: 34_First_Non_Repeating_Character

// MARK: - Problem Statement
/*
 Given a string,
 find the first
 non-repeating character.
 */

// MARK: - Important Note
/*
 Non-repeating character means:
 character appearing only once.
 */

// MARK: - Example
/*
 Input  :
 "swiss"

 Output :
 w
 */


// MARK: - Brute Force Approach
/*
 1. Traverse every character.
 2. Count occurrences manually.
 3. If count == 1:
    first non-repeating character found.
 */

// MARK: - Brute Force Solution

var str = "swiss"

var firstNonRepeatingBruteForce: Character? = nil

for currentCharacter in str {

    var count = 0

    for otherCharacter in str {

        if currentCharacter == otherCharacter {
            count += 1
        }
    }

    if count == 1 {

        firstNonRepeatingBruteForce = currentCharacter
        break
    }
}

print("Brute Force :", firstNonRepeatingBruteForce as Any)


// MARK: - Optimized Approach (Using HashMap)
/*
 1. Store frequency of characters.
 2. Traverse original string again.
 3. First character whose frequency == 1
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

var firstNonRepeatingOptimized: Character? = nil

for ch in str {

    if let count = frequencyMap[ch],
       count == 1 {

        firstNonRepeatingOptimized = ch
        break
    }
}

print("Optimized :", firstNonRepeatingOptimized as Any)


// MARK: - Edge Cases
/*
 1. Empty String
    ""

 2. All Repeating Characters
    "aabbcc"

 3. First Character Unique
    "swift"

 4. Last Character Unique
    "aabbc"

 5. Mixed Characters
    "swiss"
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
