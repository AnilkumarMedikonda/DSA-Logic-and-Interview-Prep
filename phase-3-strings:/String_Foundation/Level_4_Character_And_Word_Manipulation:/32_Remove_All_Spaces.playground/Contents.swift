import UIKit

// 32_Remove_All_Spaces

var str = "Hello Swift World"

var newStr = ""

// Traverse string
for ch in str {
    
    // Skip spaces
    if ch != " " {
        newStr += String(ch)
    }
}

print(newStr)

// Output:
// HelloSwiftWorld

/*
=====================================================
Dry Run
=====================================================

Hello Swift World

space -> skip

Remaining:
HelloSwiftWorld

=====================================================
Time Complexity
=====================================================

O(n)

=====================================================
Space Complexity
=====================================================

O(n)

Because new string created

=====================================================
Approach
=====================================================

Traverse string.

If character is space:
skip it.

Otherwise:
append into result.
*/
