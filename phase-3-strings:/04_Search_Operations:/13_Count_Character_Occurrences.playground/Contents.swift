import UIKit

// 13_Count_Character_Occurrences

/*
 =====================================================
 Approach:
 Traversal + Counter
 =====================================================

 1. Traverse each character
 2. Compare with findChar
 3. If matched:
    increase count
 */


var str = "banana"

var findChar: Character = "a"

var count = 0

// Traverse string
for char in str {
    
    // Compare character
    if char == findChar {
        count += 1
    }
}

print(count)

// Output: 3


/*
 =====================================================
 Dry Run
 =====================================================

 banana

 b == a ❌

 a == a ✅
 count = 1

 n == a ❌

 a == a ✅
 count = 2

 n == a ❌

 a == a ✅
 count = 3


 =====================================================
 Time Complexity
 =====================================================

 O(n)

 n = string length


 =====================================================
 Space Complexity
 =====================================================

 O(1)

 No extra space used
 */
