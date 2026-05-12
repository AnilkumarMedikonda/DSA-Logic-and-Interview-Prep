import UIKit

// 37_Keep_First_Occurrence_Characters

var str = "programming"

var newStr = ""


// Check duplicate
func isDuplicate(_ ch: Character,
                 result: String) -> Bool {
    
    for char in result {
        
        if char == ch {
            return true
        }
    }
    
    return false
}


// Traverse string
for ch in str {
    
    // Keep first occurrence only
    if !isDuplicate(ch,
                    result: newStr) {
        
        newStr += String(ch)
    }
}

print(newStr)

// Output:
// progamin

/*
=====================================================
Dry Run
=====================================================

programming

p -> add
r -> add
o -> add
g -> add
r -> skip
a -> add
m -> add
m -> skip
i -> add
n -> add
g -> skip

Final Output:
progamin

=====================================================
Time Complexity
=====================================================

O(n²)

=====================================================
Space Complexity
=====================================================

O(n)

Because new string created

=====================================================
Approach
=====================================================

Traverse string.

If character already exists:
skip it.

Otherwise:
append into result.
*/
