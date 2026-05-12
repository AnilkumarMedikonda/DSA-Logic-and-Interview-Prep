import UIKit

// 38_Remove_Consecutive_Duplicates

var str = "aaabbccdaa"

var newStr = ""


// Traverse string
for i in 0..<str.count {
    
    let index = str.index(str.startIndex,
                          offsetBy: i)
    
    
    // Compare with previous character
    if i > 0 {
        
        let previousIndex =
        str.index(str.startIndex,
                  offsetBy: i - 1)
        
        // Add only different character
        if str[index] != str[previousIndex] {
            newStr += String(str[index])
        }
    }    
    // First character
    else {
        newStr += String(str[index])
    }
}

print(newStr)

// Output:
// abcda

/*
=====================================================
Dry Run
=====================================================

aaabbccdaa

a -> add
a -> skip
a -> skip
b -> add
b -> skip
c -> add
c -> skip
d -> add
a -> add
a -> skip

Final Output:
abcda

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

Compare current character
with previous character.

If different:
append into result.
*/
