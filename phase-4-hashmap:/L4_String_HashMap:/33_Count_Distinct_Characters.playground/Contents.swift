import Foundation

//: 33_Count_Distinct_Characters

// MARK: - Problem Statement
/*
 Given a string,
 count number of
 distinct characters.
 */

// MARK: - Important Note
/*
 Distinct character means:
 character appearing
 at least once.
 */

// MARK: - Example
/*
 Input  :
 "aabbcc"

 Output :
 3

 Distinct Characters :
 a, b, c
 */


// MARK: - Brute Force Approach
/*
 1. Traverse every character.
 2. Check whether character
    already appeared earlier.
 3. If not:
    increase distinct count.
 */

// MARK: - Brute Force Solution

var str = "aabbcc"

var distinctCountBruteForce = 0

for i in 0..<str.count {

    let currentCharacter = Array(str)[i]

    var isDuplicate = false

    for j in 0..<i {

        let previousCharacter = Array(str)[j]

        if currentCharacter == previousCharacter {
            isDuplicate = true
            break
        }
    }

    if !isDuplicate {
        distinctCountBruteForce += 1
    }
}

print("Brute Force :", distinctCountBruteForce)


// MARK: - Optimized Approach (Using HashMap)
/*
 1. Store frequency of characters.
 2. Every new character
    increases distinct count.
 */

// MARK: - Optimized Solution

var frequencyMap: [Character: Int] = [:]

var distinctCountOptimized = 0

for ch in str {

    if let count = frequencyMap[ch] {
        frequencyMap[ch] = count + 1
    } else {
        frequencyMap[ch] = 1
        distinctCountOptimized += 1
    }
}

print("Optimized :", distinctCountOptimized)


// MARK: - Edge Cases
/*
 1. Empty String
    ""

 2. All Same Characters
    "aaaa"

 3. All Unique Characters
    "swift"

 4. Mixed Characters
    "programming"

 5. Uppercase & Lowercase
    "Aa"
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
