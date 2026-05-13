import UIKit

// 41_Print_Each_Word_New_Line

var str = "Hello Swift World"

var newStr = ""

// Traverse string
for char in str {
    
    // Word end
    if char == " " {
        print(newStr)
        newStr = ""
    }
    
    // Build word
    else {
        newStr += String(char)
    }
}

// Print last word
print(newStr)

// Output:
// Hello
// Swift
// World

/*
=====================================================
Dry Run
=====================================================

Hello Swift World

Build:
Hello

space found:
print Hello

Build:
Swift

space found:
print Swift

Build:
World

Final Output:
Hello
Swift
World

=====================================================
Time Complexity
=====================================================

O(n)

=====================================================
Space Complexity
=====================================================

O(n)

Because temporary word string created

=====================================================
Approach
=====================================================

Build word character by character.

When space appears:
print word
reset word.
*/
