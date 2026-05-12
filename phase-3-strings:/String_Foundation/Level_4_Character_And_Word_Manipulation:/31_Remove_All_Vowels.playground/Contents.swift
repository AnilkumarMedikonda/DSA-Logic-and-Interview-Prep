import UIKit

// 31_Remove_All_Vowels

// 31_Remove_All_Vowels

var str = "Swift"

var newStr = ""

// Traverse string
for ch in str {
    
    // Skip vowels
    if ch != "a" &&
        ch != "e" &&
        ch != "i" &&
        ch != "o" &&
        ch != "u" &&
        ch != "A" &&
        ch != "E" &&
        ch != "I" &&
        ch != "O" &&
        ch != "U" {
        
        newStr += "\(ch)"
    }
}

print(newStr)

// Output:
// Swft

/*
=====================================================
Dry Run
=====================================================

Swift

S -> add
w -> add
i -> skip
f -> add
t -> add

Final Output:
Swft

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
skip it.

Otherwise:
append into result.
*/
