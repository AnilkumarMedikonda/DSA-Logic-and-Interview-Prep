import UIKit

// 23_Trim_Leading_And_Trailing_Spaces

/*
 =====================================================
 Method 1:
 Split + Remove Empty Strings
 =====================================================

 1. Split string using space
 2. Ignore empty strings
 3. Store valid words
 4. Build final sentence
 */


var str1 = "   Hello World   "


// Split using space
var words = str1.components(separatedBy: " ")

print(words)

// ["", "", "", "Hello", "World", "", "", ""]

var newWords = [String]()


// Remove empty strings
for word in words {
    
    if word.count != 0 {
        
        newWords.append(word)
    }
}

print(newWords)

// ["Hello", "World"]


// Build final string
var result1 = ""

for i in 0..<newWords.count {
    
    result1 += newWords[i]
    
    if i != newWords.count - 1 {
        result1 += " "
    }
}

print("Method 1:", result1)

// Output:
// Hello World


/*
 =====================================================
 Time Complexity:
 O(n)

 Space Complexity:
 O(n)

 =====================================================

 Uses predefined split function.

 Easy and beginner friendly.
 */







/*
 =====================================================
 Method 2:
 Two Pointer Traversal
 (Best Interview Approach)
 =====================================================

 1. Find first non-space character
 2. Find last non-space character
 3. Build string between them
 */


var str2 = "   Hello World   "


// Left pointer
var left = 0

// Right pointer
var right = str2.count - 1


// Remove leading spaces
while left < str2.count {
    
    let index = str2.index(str2.startIndex, offsetBy: left)
    
    if str2[index] != " " {
        break
    }
    
    left += 1
}


// Remove trailing spaces
while right >= 0 {
    
    let index = str2.index(str2.startIndex, offsetBy: right)
    
    if str2[index] != " " {
        break
    }
    
    right -= 1
}


// Build trimmed string
var result2 = ""

while left <= right {
    let index = str2.index(str2.startIndex, offsetBy: left)
    result2 += String(str2[index])
    left += 1
}
print("Method 2:", result2)

// Output:
// Hello World


/*
 =====================================================
 Time Complexity:
 O(n)

 Space Complexity:
 O(n)

 =====================================================

 Best interview approach because:

 ✅ Two Pointer Pattern
 ✅ Manual traversal
 ✅ No predefined split functions
 ✅ Strong DSA logic
 */
