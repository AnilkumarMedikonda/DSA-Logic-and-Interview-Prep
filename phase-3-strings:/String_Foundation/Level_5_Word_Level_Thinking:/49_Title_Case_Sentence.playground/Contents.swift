import UIKit

// 49_Title_Case_Sentence

var str = "hELLo sWIFt WORld"
var word = ""
var result = ""
var isFirstCharacter = true


// Traverse string
for char in str {
    
    // Word end
    if char == " " {
        result += "\(word) "
        word = ""
        isFirstCharacter = true
    }
    
    // Build word
    else {
        var asciiValue = char.asciiValue!
        
        // First letter -> Uppercase
        if isFirstCharacter {
            if asciiValue >= 97 && asciiValue <= 122 {
                asciiValue -= 32
                let ch = Character(UnicodeScalar(asciiValue))
                word += String(ch)
            }
            else { word += String(char) }
        }
        
        // Remaining letters -> Lowercase
        else {
            if asciiValue >= 65 && asciiValue <= 90 {
                asciiValue += 32
                let ch = Character( UnicodeScalar(asciiValue))
                word += String(ch)
            }
            else { word += String(char) }
        }
        isFirstCharacter = false
    }
}


// Last word
result += word
print(result)

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

Because result string created

=====================================================
Approach
=====================================================

First character:
convert to uppercase.

Remaining characters:
convert to lowercase.
*/
