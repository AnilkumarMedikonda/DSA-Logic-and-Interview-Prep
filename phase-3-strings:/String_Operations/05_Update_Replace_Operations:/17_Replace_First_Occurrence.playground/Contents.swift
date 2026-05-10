import UIKit


// 17_Replace_First_Occurrence

/*
 =====================================================
 Approach:
 Traversal + Boolean Flag
 =====================================================

 1. Traverse string
 2. Check character
 3. Replace only first occurrence
 4. Use boolean flag to avoid
    replacing again
 */


var str = "banana"

var oldChar: Character = "a"

var newChar = "X"

var result = ""

var isReplaced = false

// Traverse string
for char in str {
    
    // Replace only first occurrence
    if char == oldChar && !isReplaced {
        
        result += newChar
        
        isReplaced = true
        
    } else {
        
        result += String(char)
    }
}

print(result)

// Output: bXnana


/*
 =====================================================
 Dry Run
 =====================================================

 banana

 b == a ❌
 result = "b"

 a == a ✅
 replace with X
 result = "bX"

 isReplaced = true

 n == a ❌
 result = "bXn"

 remaining 'a'
 will NOT replace
 because isReplaced = true


 Final Result:
 bXnana


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
