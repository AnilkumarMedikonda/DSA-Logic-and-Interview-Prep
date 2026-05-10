import UIKit


// 16_Replace_All_Occurrences

/*
 =====================================================
 Approach:
 Traversal + Result Building
 =====================================================

 1. Traverse string
 2. Compare each character with oldChar
 3. If matched:
    add newChar
 4. Else:
    add original character
 */


var str = "banana"

var oldChar: Character = "a"

var newChar = "X"

var result = ""

// Traverse string
for char in str {
    // Replace character
    if char == oldChar {
        result += newChar
    } else {
        result += String(char)
    }
}

print(result)

// Output: bXnXnX


/*
 =====================================================
 Dry Run
 =====================================================

 banana

 b == a ❌
 result = "b"

 a == a ✅
 result = "bX"

 n == a ❌
 result = "bXn"

 a == a ✅
 result = "bXnX"

 n == a ❌
 result = "bXnXn"

 a == a ✅
 result = "bXnXnX"


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
 */
