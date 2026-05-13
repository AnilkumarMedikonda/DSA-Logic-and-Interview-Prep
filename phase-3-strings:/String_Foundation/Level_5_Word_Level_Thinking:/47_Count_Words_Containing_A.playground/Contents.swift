import UIKit

// 47_Count_Words_Containing_A

var str = "Apple Swift Banana Cat"

var word = ""

var count = 0


// Check word contains a/A
func containsA(_ str: String) -> Bool {
    for ch in str {
        if ch == "A" || ch == "a" {
            return true
        }
    }
    return false
}


// Traverse string
for ch in str {
    
    // Word end
    if ch == " " {
        if containsA(word) {
            count += 1
        }
        word = ""
    }
    
    // Build word
    else {
        word += String(ch)
    }
}


// Last word
if containsA(word) {
    count += 1
}

print(count)

// Output:
// 3

/*
=====================================================
Dry Run
=====================================================

Apple -> yes
Swift -> no
Banana -> yes
Cat -> yes

Final Count:
3

=====================================================
Time Complexity
=====================================================

O(n)

=====================================================
Space Complexity
=====================================================

O(n)

Because temporary word string created

=====================================================
Approach
=====================================================

Build each word.

Check whether word contains:
a or A

If yes:
increase count.
*/
