import UIKit

// 35_Remove_All_Digits

var str = "Sw1if2t3"

var newStr = ""

// Traverse string
for ch in str {
    
    let asciiValue = ch.asciiValue!
    
    // Skip digits
    if !(asciiValue >= 48 && asciiValue <= 57) {
        
        newStr += String(ch)
    }
}

print(newStr)

// Output:
// Swift

/*
=====================================================
Dry Run
=====================================================

Sw1if2t3

S -> add
w -> add
1 -> skip
i -> add
f -> add
2 -> skip
t -> add
3 -> skip

Final Output:
Swift

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

Check digit ASCII range:
48 -> 57

Skip digits.
Append remaining characters.
*/
