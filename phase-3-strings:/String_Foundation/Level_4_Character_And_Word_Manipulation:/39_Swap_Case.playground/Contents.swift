import UIKit


// 39_Swap_Case

var str = "SwIfT"

var newStr = ""

// Traverse string
for ch in str {
    
    let asciiValue = ch.asciiValue!
    
    
    // Uppercase -> Lowercase
    if asciiValue >= 65 && asciiValue <= 90 {
        let lowerAscii = asciiValue + 32
        newStr += String(
            Character(
                UnicodeScalar(lowerAscii)
            )
        )
    }
    // Lowercase -> Uppercase
    else if asciiValue >= 97 && asciiValue <= 122 {
        let upperAscii = asciiValue - 32
        
        newStr += String(
            Character(
                UnicodeScalar(upperAscii)
            )
        )
    }
}

print(newStr)

// Output:
// sWiFt

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
Approach
=====================================================

Check ASCII range.

Uppercase:
65 -> 90

Lowercase:
97 -> 122

Convert using ASCII difference:
32
*/
