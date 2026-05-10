import UIKit

// 22_Convert_To_Lowercase

/*
 =====================================================
 Approach:
 ASCII Conversion
 =====================================================

 1. Traverse string
 2. Get ASCII value
 3. Check uppercase range
 4. Convert into lowercase
 5. Build result string
 */


var str = "SWIFT"

var result = ""

// Traverse string
for char in str {
    
    // Get ASCII value
    let asciiValue = char.asciiValue!
    
    
    // Check uppercase letters
    if asciiValue >= 65 && asciiValue <= 90 {
        
        // Convert uppercase to lowercase
        let lowerAscii = asciiValue + 32
        
        result += String(Character(UnicodeScalar(lowerAscii)))
        
    } else {
        
        result += String(char)
    }
}

print(result)

// Output: swift


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


 Final Result:
 swift


 =====================================================
 ASCII Difference
 =====================================================

 A -> 65
 a -> 97

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
 ✅ Manual conversion logic
 ✅ Character manipulation
 ✅ No predefined lowercase function
 */
