import UIKit

// 45_Swap_First_And_Last_Word

var str = "Hello Swift World"

var result = ""

var words = [String]()


// Extract words
for ch in str {
    // Word end
    if ch == " " {
        words.append(result)
        result = ""
    }
    
    // Build word
    else {
        result += String(ch)
    }
}


// Add last word
words.append(result)
print(words)

// ["Hello", "Swift", "World"]


// Swap first and last
words.swapAt(0, words.count - 1)
print(words)

// ["World", "Swift", "Hello"]

result = ""

// Rebuild sentence
for i in 0..<words.count {
    result += words[i]
    // Avoid extra space
    if i != words.count - 1 {
        result += " "
    }
}

print(result)

// Output:
// World Swift Hello

/*
=====================================================
Dry Run
=====================================================

Words:
["Hello", "Swift", "World"]

Swap:
["World", "Swift", "Hello"]

Final Output:
World Swift Hello

=====================================================
Time Complexity
=====================================================

O(n)

=====================================================
Space Complexity
=====================================================

O(n)

Because words array created

=====================================================
Approach
=====================================================

Extract all words.

Swap first and last word.

Rebuild sentence.
*/
