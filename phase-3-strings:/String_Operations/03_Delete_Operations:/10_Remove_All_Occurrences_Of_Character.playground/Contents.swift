import UIKit

// 10_Remove_All_Occurrences_Of_Character

/*
 Problem:
 Remove all occurrences of a character
 from the string.

 Input:
 str = "Swift"
 removeChar = "t"

 Output:
 "Swif"
 */

var str = "Swift"

var removeChar: Character = "t"

var result = ""

// Traverse string
for i in 0..<str.count {
    
    // Get character index
    let index = str.index(str.startIndex, offsetBy: i)
    
    // Current character
    let char = str[index]
    
    // If character is not equal
    // add into result
    if char != removeChar {
        result += String(char)
    }
}

print(result)

// Output: Swif


/*
 =====================================================
 Explanation
 =====================================================

 Step 1:
 Traverse each character in string

 Step 2:
 Compare character with removeChar

 If character is NOT equal:
 append into result

 Else:
 skip character


 =====================================================
 Dry Run
 =====================================================

 str = "Swift"

 S != t ✅
 result = "S"

 w != t ✅
 result = "Sw"

 i != t ✅
 result = "Swi"

 f != t ✅
 result = "Swif"

 t == t ❌
 skip


 Final Output:
 "Swif"


 =====================================================
 Why This Approach Is Best
 =====================================================

 ✅ Easy to explain
 ✅ Safe approach
 ✅ No index shifting issue
 ✅ Best for interviews


 =====================================================
 Time Complexity
 =====================================================

 O(n)


 =====================================================
 Space Complexity
 =====================================================

 O(n)

 Because result string is created
 */
