import UIKit

// 04_Convert_To_Lowercase

var str = "SWIFT"

var result = ""


// Traverse string
for char in str {
    
    // ASCII value
    let asciiValue = char.asciiValue!
    
    
    // Uppercase check
    if asciiValue >= 65 && asciiValue <= 90 {
        // Convert to lowercase
        let lowerAscii = asciiValue + 32
        
        result += String(Character(UnicodeScalar(lowerAscii)))
        
    } else {
        result += String(char)
    }
}

print(result)

// Output:
// swift



/*
 =====================================================
 Dry Run
 =====================================================

 S -> 83
 83 + 32 = 115 -> s

 W -> 87
 87 + 32 = 119 -> w

 I -> 73
 73 + 32 = 105 -> i

 F -> 70
 70 + 32 = 102 -> f

 T -> 84
 84 + 32 = 116 -> t


 Final Output:
 swift


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

 Traverse string.

 If character is uppercase:
 convert using ASCII difference.

 Append converted character
 into result string.
 */
