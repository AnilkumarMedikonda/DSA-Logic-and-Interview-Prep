import UIKit


// 11_Find_A_Character

/*
 Problem:
 Find whether a character exists
 in the string or not.

 Input:
 str = "Swift"
 findChar = "f"

 Output:
 true
 */

var str = "Swift"
var findChar: Character = "f"

for char in str {
    
    if char == findChar {
        print("Found")
        break
    }
}

// Output: true


/*
 =====================================================
 Explanation
 =====================================================

 Step 1:
 Traverse each character in string

 Step 2:
 Compare current character
 with findChar

 If matched:
 isFound = true

 Step 3:
 Break loop after finding character


 =====================================================
 Dry Run
 =====================================================

 str = "Swift"

 S == f ❌
 w == f ❌
 i == f ❌
 f == f ✅

 isFound = true

 Loop stops


 =====================================================
 Why break Is Important
 =====================================================

 Once character is found,
 no need to continue loop.

 Helps optimize performance.


 =====================================================
 Time Complexity
 =====================================================

 O(n)


 =====================================================
 Space Complexity
 =====================================================

 O(1)
 */
