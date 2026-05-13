import UIKit

// 50_Remove_Extra_Spaces

/*
=====================================================
Method 1: Left/Right Trimming + Traversal
=====================================================
*/

var str1 = "  Hello   Swift   World  "
var left = 0
var right = str1.count - 1
var result1 = ""
var previousSpace1 = false


// Remove leading spaces
while left < str1.count {
    let index = str1.index(str1.startIndex,
                           offsetBy: left)
    
    if str1[index] != " " {
        break
    }
    left += 1
}


// Remove trailing spaces
while right >= 0 {
    let index = str1.index(str1.startIndex,
                           offsetBy: right)
    
    if str1[index] != " " {
        break
    }
    right -= 1
}


// Traverse middle portion
while left <= right {
    
    let index = str1.index(str1.startIndex,
                           offsetBy: left)
    // Current space
    if str1[index] == " " {
        // Add only one space
        if !previousSpace1 {
            result1 += " "
            previousSpace1 = true
        }
    }
    // Normal character
    else {
        result1 += String(str1[index])
        previousSpace1 = false
    }
    left += 1
}

print(result1)
// Output:
// Hello Swift World

/*
=====================================================
Time Complexity
=====================================================

O(n)

=====================================================
Space Complexity
=====================================================

O(n)

=====================================================
Interview Note
=====================================================

✅ Good boundary handling
❌ Multiple loops
*/


/*
=====================================================
Method 2: Single Traversal + Flag
(Best For Interview)
=====================================================
*/

var str2 = "  Hello   Swift   World  "
var result2 = ""
var previousSpace2 = true   

// Traverse string
for ch in str2 {
    // Current space
    if ch == " " {
        // Add only one space
        if !previousSpace2 {
            result2 += " "
            previousSpace2 = true
        }
    }
    // Normal character
    else {
        result2 += String(ch)
        previousSpace2 = false
    }
}


// Remove trailing space
if result2.last == " " {
    result2.removeLast()
}

print(result2)

// Output:
// Hello Swift World

/*
=====================================================
Time Complexity
=====================================================

O(n)

=====================================================
Space Complexity
=====================================================

O(n)

=====================================================
Why This Is Best
=====================================================

✅ Single traversal
✅ Cleaner logic
✅ Better interview approach
*/
