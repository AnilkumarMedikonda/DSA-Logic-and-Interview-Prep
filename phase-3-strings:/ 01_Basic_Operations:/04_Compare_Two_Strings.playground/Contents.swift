import UIKit

var greeting = "Hello, playground"

// 04_Compare_Two_Strings.


// MARK: - 04_Compare_Two_Strings

/*
 Problem:
 - Compare two strings manually

 Input:
 str1 = "Swift"
 str2 = "swift"

 Output:
 false
*/


// MARK: - Approach: Character Comparison

/*
 Approach:
 - First compare lengths
 - Traverse both strings
 - Compare character by character
 - If mismatch found
      → Strings are not equal

 Time: O(n)
 Space: O(1)

 Interview:
 - Good practice for string indexing & traversal
*/

var str1 = "Swift"
var str2 = "swift"

var isEqual = true

if str1.count != str2.count {
    
    print("Not Equal")
    isEqual = false
}

for i in 0..<str1.count {
    
    let index1 = str1.index(str1.startIndex, offsetBy: i)
    
    let index2 = str2.index(str2.startIndex, offsetBy: i)
    
    if str1[index1] != str2[index2] {
        
        isEqual = false
        break
    }
}

print(isEqual)


// T - O(n)
// S - O(1)
