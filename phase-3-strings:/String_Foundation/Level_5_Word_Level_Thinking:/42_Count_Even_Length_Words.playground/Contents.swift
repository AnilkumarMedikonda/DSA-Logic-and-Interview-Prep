import UIKit


// 42_Count_Even_Length_Words

var str = "Hi Swift Code"
var newStr = ""
var count = 0
var evenWordsCount = 0

// Traverse string
for ch in str {
    
    // Word end
    if ch == " " {
        
        print("\(newStr) -> \(count)")
        
        // Check even length
        if count % 2 == 0 {
            evenWordsCount += 1
        }
        
        newStr = ""
        count = 0
    }
    
    // Build word
    else {
        newStr += String(ch)
        count += 1
    }
}

// Print last word
print("\(newStr) -> \(count)")

// Check last word
if count % 2 == 0 {
    evenWordsCount += 1
}

print("Even Length Words:", evenWordsCount)

// Output:
// Hi -> 2
// Swift -> 5
// Code -> 4
// Even Length Words: 2

/*
=====================================================
Dry Run
=====================================================

Hi -> 2 -> even
Swift -> 5 -> odd
Code -> 4 -> even

Final Count:
2

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
check word length.

If even:
increase count.
*/
