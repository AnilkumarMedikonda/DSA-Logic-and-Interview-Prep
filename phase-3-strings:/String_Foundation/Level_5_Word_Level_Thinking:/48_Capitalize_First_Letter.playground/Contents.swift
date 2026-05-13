import UIKit

// 48_Capitalize_First_Letter

/*
=====================================================
Method 1: Using uppercased()
=====================================================
*/

var str1 = "hello swift world"
var word1 = ""
var result1 = ""
var isUppercased1 = true

// Traverse string
for char in str1 {
    
    // Space found
    if char == " " {
        result1 += "\(word1) "
        word1 = ""
        isUppercased1 = true
    }
    
    
    // Build word
    else {
        // First character
        if isUppercased1 {
            word1 += String(char).uppercased()
        }
        // Remaining characters
        else { word1 += String(char) }
        isUppercased1 = false
    }
}
// Last word
result1 += word1
print(result1)

// Output:
// Hello Swift World

/*
=====================================================
Time Complexity
=====================================================

O(n)

=====================================================
Space Complexity
=====================================================

O(n)

=====================================================
Interview Note
=====================================================

✅ Easy to understand
✅ Short solution

❌ Uses predefined method
*/



/*
=====================================================
Method 2: ASCII Conversion
(Best For DSA Interview)
=====================================================
*/

var str2 = "hello swift world"
var word2 = ""
var result2 = ""
var isUppercased2 = true

// Traverse string
for char in str2 {
    
    // Space found
    if char == " " {
        result2 += "\(word2) "
        word2 = ""
        isUppercased2 = true
    }
    
    
    // Build word
    else {
        // First character
        if isUppercased2 {
            let asciiValue = char.asciiValue!
            // Lowercase -> Uppercase
            if asciiValue >= 97 &&
                asciiValue <= 122 {
                let upperAscii =
                asciiValue - 32
                
                word2 += String(
                    Character(
                        UnicodeScalar(upperAscii)
                    )
                )
            }
            else { word2 += String(char) }
        }
        // Remaining characters
        else {
            word2 += String(char)
        }
        
        isUppercased2 = false
    }
}


// Last word
result2 += word2

print(result2)

// Output:
// Hello Swift World

/*
=====================================================
Time Complexity
=====================================================

O(n)

=====================================================
Space Complexity
=====================================================

O(n)

=====================================================
Why This Is Best
=====================================================

✅ Manual ASCII manipulation
✅ Better DSA practice
✅ No predefined conversion methods
*/
