import UIKit

// 21_Convert_To_Uppercase

/*
 =====================================================
 Approach:
 ASCII Conversion
 =====================================================

 1. Traverse string
 2. Get ASCII value of character
 3. Check lowercase range
 4. Convert into uppercase
 5. Build result string
 */


var str = "swift"

var result = ""

// Traverse string
for char in str {
    
    // Get ASCII value
    let asciiValue = char.asciiValue!
    
    
    // Check lowercase letters
    if asciiValue >= 97 && asciiValue <= 122 {
        
        // Convert lowercase to uppercase
        let upperAscii = asciiValue - 32
        
        result += String(Character(UnicodeScalar(upperAscii)))
        
    } else {
        
        result += String(char)
    }
}

print(result)

// Output: SWIFT


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


 Final Result:
 SWIFT


 =====================================================
 ASCII Difference
 =====================================================

 a -> 97
 A -> 65

 Difference = 32


 =====================================================
 Time Complexity
 =====================================================

 O(n)

 n = string length


 =====================================================
 Space Complexity
 =====================================================

 O(n)

 Because result string is created


 =====================================================
 Why This Is Good For Interview
 =====================================================

 ✅ ASCII understanding
 ✅ Manual character conversion
 ✅ Traversal logic
 ✅ No predefined uppercase function
 */
