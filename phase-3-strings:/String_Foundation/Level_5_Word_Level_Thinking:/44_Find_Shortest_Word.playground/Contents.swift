import UIKit


// 44_Find_Shortest_Word

var str = "Hi Swift Programming"

var minCount = Int.max

var minimumWord = ""

var word = ""


// Traverse string
for ch in str {
    
    // Word end
    if ch == " " {
        
        let count = word.count
        
        
        // Update shortest word
        if count < minCount {
            
            minCount = count
            
            minimumWord = word
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

if count < minCount {
    
    minCount = count
    
    minimumWord = word
}

print(minCount)
print(minimumWord)

// Output:
// 2
// Hi

/*
=====================================================
Dry Run
=====================================================

Hi -> 2
Swift -> 5
Programming -> 11

Shortest Word:
Hi

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
compare with minimum length.

Update shortest word if needed.
*/
