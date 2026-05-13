import UIKit

// 46_Words_Start_And_End_Same

var str = "aba madak leved madam test"

var newWord = ""

var count = 0


// Traverse string
for ch in str {
    
    // Word end
    if ch == " " {
        
        let firstIndex = newWord.startIndex
        
        let lastIndex =
        newWord.index(newWord.endIndex,
                      offsetBy: -1)
        
        
        // Compare first and last character
        if newWord[firstIndex] ==
            newWord[lastIndex] {
            
            count += 1
        }
        
        newWord = ""
    }
    
    
    // Build word
    else {
        newWord += String(ch)
    }
}


// Last word
let firstIndex = newWord.startIndex

let lastIndex =
newWord.index(newWord.endIndex,
              offsetBy: -1)


// Compare first and last character
if newWord[firstIndex] ==
    newWord[lastIndex] {
    
    count += 1
}

print(count)

// Output:
// 3

/*
=====================================================
Dry Run
=====================================================

aba -> yes
madak -> no
leved -> no
madam -> yes
test -> yes

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

When word ends:
compare first and last character.

If same:
increase count.
*/
