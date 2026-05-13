import UIKit

// 43_Find_Longest_Word

var str = "Hi Swift Programming"
var maximumCount = Int.min
var maximumWord = ""
var word = ""

// Traverse string
for ch in str {
    
    // Word end
    if ch == " " {
        let count = word.count
        // Update longest word
        if count > maximumCount {
            maximumCount = count
            maximumWord = word
        }
        word = ""
    }
    // Build word
    else {
        word += String(ch)
    }
}


// Check last word
let count = word.count

if count > maximumCount {
    maximumCount = count
    maximumWord = word
}

print(maximumWord)
print(maximumCount)

// Output:
// Programming
// 11

/*
=====================================================
Dry Run
=====================================================

Hi -> 2
Swift -> 5
Programming -> 11

Longest Word:
Programming

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
compare with maximum length.

Update longest word if needed.
*/
