import UIKit


// 40_Shift_Character_By_One

var str = "abcd"

var newStr = ""

// Traverse string
for ch in str {
    let asciiValue = ch.asciiValue!
    
    // z -> a
    if asciiValue == 122 {
        newStr += "a"
    }
    // Z -> A
    else if asciiValue == 90 {
        newStr += "A"
    }
    
    // Shift character
    else {
        let unicodeCharacter =
        UnicodeScalar(asciiValue + 1)
        newStr += String(unicodeCharacter)
    }
}

print(newStr)

// Output:
// bcde

/*
=====================================================
Dry Run
=====================================================

abcd

a -> b
b -> c
c -> d
d -> e

Final Output:
bcde

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

Get ASCII value.

Increase by 1.

Handle wrap-around:
z -> a
Z -> A
*/
