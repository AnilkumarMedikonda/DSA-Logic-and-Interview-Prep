import UIKit

// 03_Convert_To_Uppercase

var str = "swift"

var result = ""


// Traverse string
for char in str {
    
    // ASCII value
    let asciiValue = char.asciiValue!
    
    
    // Lowercase check
    if asciiValue >= 97 && asciiValue <= 122 {
        
        // Convert to uppercase
        let upperAscii = asciiValue - 32
        
        result += String(Character(UnicodeScalar(upperAscii)))
        
    } else {
        
        result += String(char)
    }
}

print(result)

// Output:
// SWIFT



/*
 =====================================================
 Dry Run
 =====================================================

 s -> 115
 115 - 32 = 83 -> S

 w -> 119
 119 - 32 = 87 -> W

 i -> 105
 105 - 32 = 73 -> I

 f -> 102
 102 - 32 = 70 -> F

 t -> 116
 116 - 32 = 84 -> T


 Final Output:
 SWIFT


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

 If character is lowercase:
 convert using ASCII difference.

 Append converted character
 into result string.
 */
