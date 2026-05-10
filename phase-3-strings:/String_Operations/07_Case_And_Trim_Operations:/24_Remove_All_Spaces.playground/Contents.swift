import UIKit

// 24_Remove_All_Spaces

/*
 =====================================================
 Method 1:
 Simple Traversal
 (Best Interview Approach)
 =====================================================

 1. Traverse string
 2. Ignore spaces
 3. Append non-space characters
 */


var str1 = "   Swift Programming   "

var result1 = ""

// Traverse string
for char in str1 {
    
    // Skip spaces
    if char != " " {
        
        result1 += String(char)
    }
}

print("Method 1:", result1)

// Output:
// SwiftProgramming


/*
 =====================================================
 Time Complexity:
 O(n)

 Space Complexity:
 O(n)

 =====================================================

 Best interview approach because:

 ✅ Very simple
 ✅ Easy to explain
 ✅ Clean traversal
 ✅ No unnecessary logic
 ✅ Most optimized thinking
 */







/*
 =====================================================
 Method 2:
 Two Pointer Traversal
 =====================================================

 1. Remove leading spaces
 2. Remove trailing spaces
 3. Skip middle spaces
 */


var str2 = "   Swift Programming   "

var result2 = ""


// Left pointer
var left = 0

// Right pointer
var right = str2.count - 1


// Remove leading spaces
while left < str2.count {
    
    let index = str2.index(str2.startIndex, offsetBy: left)
    
    if str2[index] != " " {
        break
    }
    
    left += 1
}


// Remove trailing spaces
while right >= 0 {
    
    let index = str2.index(str2.startIndex, offsetBy: right)
    
    if str2[index] != " " {
        break
    }
    
    right -= 1
}


// Remove remaining spaces
while left <= right {
    
    let index = str2.index(str2.startIndex, offsetBy: left)
    
    if str2[index] != " " {
        
        result2 += String(str2[index])
    }
    
    left += 1
}

print("Method 2:", result2)

// Output:
// SwiftProgramming


/*
 =====================================================
 Time Complexity:
 O(n)

 Space Complexity:
 O(n)

 =====================================================

 Good for showing:
 ✅ Two Pointer understanding
 ✅ Boundary handling

 But logic is longer and
 unnecessary for this problem.
 */

/*
 =====================================================
 Interview Recommendation
 =====================================================

 Method 1 is BEST for interview
 because:

 ✅ Cleaner logic
 ✅ Less code
 ✅ Easier explanation
 ✅ Direct solution

 Method 2 is more useful for:
 Trim Leading & Trailing Spaces
 */
