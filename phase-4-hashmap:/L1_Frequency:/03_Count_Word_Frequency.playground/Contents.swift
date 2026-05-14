import UIKit

//: 03_Count_Word_Frequency

import Foundation

// MARK: - Problem Statement
/*
 Given a sentence,
 count how many times each word appears.
 */

// MARK: - Example
/*
 Input  :
 "apple banana apple mango banana apple"

 Output :
 apple  -> 3
 banana -> 2
 mango  -> 1
 */

// MARK: - Approach
/*
 1. Traverse string character by character.
 2. Build each word manually.
 3. If space found:
    - store word frequency
    - reset current word
 4. Handle last word separately.
 */

// MARK: - Edge Cases
/*
 1. Empty String
    ""

 2. Single Word
    "apple"

 3. Multiple Spaces
    "apple   banana"

 4. Uppercase / Lowercase
    "Apple apple"

 5. Special Characters
    "hello, hello"
 */

// MARK: - Input

var str = "apple banana apple mango banana apple"

// MARK: - Solution

var word = ""
var frequencyMap = [String: Int]()

for ch in str {
    
    if ch == " " {
        if !word.isEmpty {
            if let count = frequencyMap[word] {
                frequencyMap[word] = count + 1
            } else {
                frequencyMap[word] = 1
            }
            word = ""
        }
        
    } else {
        word += String(ch)
    }
}


// Handle Last Word

if !word.isEmpty {
    if let count = frequencyMap[word] {
        frequencyMap[word] = count + 1
    } else {
        frequencyMap[word] = 1
    }
}

// MARK: - Output

print(frequencyMap)

// MARK: - Complexity
/*
 Time  : O(n)
 Space : O(n)
 */
