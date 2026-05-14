import UIKit
//: 02_Count_Character_Frequency

import Foundation

// MARK: - Problem Statement
/*
 Given a string,
 count how many times each character appears.
 */

// MARK: - Example
/*
 Input  : "banana"

 Output :
 b -> 1
 a -> 3
 n -> 2
 */

// MARK: - Approach
/*
 1. Create an empty Dictionary.
 2. Traverse each character in string.
 3. If character already exists:
    increase frequency count.
 4. Else:
    insert character with value 1.
 */

// MARK: - Edge Cases
/*
 1. Empty String
    ""

 2. All Unique Characters
    "abc"

 3. All Same Characters
    "aaaa"

 4. Uppercase / Lowercase
    "Aa"

 5. Special Characters
    "a@a#"
 */

// MARK: - Input

let str = "banana"

// MARK: - Solution

var frequencyMap = [Character: Int]()

for ch in str {
    if let count = frequencyMap[ch] {
        frequencyMap[ch] = count + 1
    } else {
        frequencyMap[ch] = 1
    }
}

// MARK: - Output

print(frequencyMap)

// MARK: - Complexity
/*
 Time  : O(n)
 Space : O(n)
 */
