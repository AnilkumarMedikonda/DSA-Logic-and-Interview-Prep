import UIKit

// 30_Reverse_String_Skip_Spaces

var str = "a bc d"
var words = Array(str)

var left = 0
var right = words.count - 1

var newStr = ""

// Reverse characters only
while left <= right {
    
    // Skip left space
    if words[left] == " " {
        left += 1
    }
    
    // Skip right space
    else if words[right] == " " {
        right -= 1
    }
    
    // Swap characters
    else {
        words.swapAt(left, right)
        right -= 1
        left += 1
    }
}

print(words)

// Build final string
for word in words {
    newStr += "\(word)"
}

print(newStr)

// Output:
// d cb a

/*
=====================================================
Dry Run
=====================================================

a bc d

left = a
right = d

swap:
d bc a

Spaces remain same position

=====================================================
Time Complexity
=====================================================

O(n)

=====================================================
Space Complexity
=====================================================

O(n)

Because character array created

=====================================================
Approach
=====================================================

Use two pointers.

Skip spaces.
Swap only characters.
*/
