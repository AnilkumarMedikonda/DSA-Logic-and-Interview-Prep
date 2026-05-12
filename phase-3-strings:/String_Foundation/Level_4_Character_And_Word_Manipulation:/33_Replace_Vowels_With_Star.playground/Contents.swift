import UIKit

// 33_Replace_Vowels_With_Star

var str = "Swift"

var newStr = ""

// Traverse string
for ch in str {
    
    // Check vowels
    if ch != "a" && ch != "e" &&
        ch != "i" && ch != "o" &&
        ch != "u" && ch != "A" &&
        ch != "E" && ch != "I" &&
        ch != "O" && ch != "U" {
        
        newStr += String(ch)
    }
    
    // Replace vowel
    else {
        newStr += "*"
    }
}

print(newStr)

// Output:
// Sw*ft

/*
=====================================================
Dry Run
=====================================================

Swift

S -> add
w -> add
i -> *
f -> add
t -> add

Final Output:
Sw*ft

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

If character is vowel:
append *

Otherwise:
append character.
*/
