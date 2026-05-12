import UIKit

// 13_Count_Uppercase_And_Lowercase

var str = "SwIfT"

var upperCase = 0

var lowerCase = 0


// Traverse string
for char in str {
    
    let asciiValue = char.asciiValue!
    
    
    // Uppercase check
    if asciiValue >= 65 &&
       asciiValue <= 90 {
        
        upperCase += 1
    }
    
    
    // Lowercase check
    if asciiValue >= 97 &&
       asciiValue <= 122 {
        
        lowerCase += 1
    }
}

print("Uppercase:", upperCase)
print("Lowercase:", lowerCase)


// Output:
// Uppercase: 3
// Lowercase: 2



/*
 =====================================================
 Dry Run
 =====================================================

 SwIfT


 S -> Uppercase = 1

 w -> Lowercase = 1

 I -> Uppercase = 2

 f -> Lowercase = 2

 T -> Uppercase = 3


 =====================================================
 Time Complexity
 =====================================================

 O(n)

 n = string length


 =====================================================
 Space Complexity
 =====================================================

 O(1)


 =====================================================
 Approach
 =====================================================

 Traverse string.

 Check ASCII range:
 65-90   -> Uppercase
 97-122  -> Lowercase

 Increase respective counts.
 */
