import UIKit

// 34_Replace_Spaces_With_Underscore

var str = "Hello Swift World"

var newStr = ""

// Traverse string
for ch in str {
    
    // Replace space
    if ch == " " {
        newStr += "_"
    }
    
    // Add character
    else {
        newStr += String(ch)
    }
}

print(newStr)

// Output:
// Hello_Swift_World

/*
=====================================================
Dry Run
=====================================================

Hello Swift World

space -> _

Final Output:
Hello_Swift_World

=====================================================
Time Complexity
=====================================================

O(n)

=====================================================
Space Complexity
=====================================================

O(n)

Because new string created

=====================================================
Approach
=====================================================

Traverse string.

If character is space:
append "_"

Otherwise:
append character.
*/
