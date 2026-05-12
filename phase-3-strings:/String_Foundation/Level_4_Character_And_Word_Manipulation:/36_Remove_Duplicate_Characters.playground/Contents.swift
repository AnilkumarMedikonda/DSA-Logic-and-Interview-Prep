import UIKit

// 36_Remove_Duplicate_Characters

var str = "banana"

var newStr = ""


// Check duplicate
func isDuplicate(_ ch: Character, result: String) -> Bool {
    
    for char in result {
        if char == ch {
            return true
        }
    }
    
    return false
}


// Traverse string
for ch in str {
    
    // Add only first occurrence
    if !isDuplicate(ch,
                    result: newStr) {
        
        newStr += String(ch)
    }
}

print(newStr)

// Output:
// ban

/*
=====================================================
Dry Run
=====================================================

banana

b -> add
a -> add
n -> add
a -> skip
n -> skip
a -> skip

Final Output:
ban

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

Check whether character
already exists in result.

If not:
append into result.
*/
