import UIKit

// 06_Count_Words_In_Sentence

var str = "Hello Swift World"

var count = 0

var isWord = false


// Traverse string
for char in str {
    
    // Character found
    if char != " " && isWord == false {
        count += 1
        isWord = true
    }
    
    // Space found
    if char == " " {
        isWord = false
    }
}

print(count)

// Output:
// 3



/*
 =====================================================
 Dry Run
 =====================================================

 "Hello Swift World"


 H -> new word -> count = 1

 e l l o -> continue word


 space -> word ended


 S -> new word -> count = 2

 w i f t -> continue word


 space -> word ended


 W -> new word -> count = 3


 Final Output:
 3


 =====================================================
 Time Complexity
 =====================================================

 O(n)


 =====================================================
 Space Complexity
 =====================================================

 O(1)


 =====================================================
 Approach
 =====================================================

 Traverse string.

 If:
 current character is not space
 AND currently outside a word

 then:
 count new word.
 */
