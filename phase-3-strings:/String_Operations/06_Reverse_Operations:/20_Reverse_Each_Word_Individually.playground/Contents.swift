import UIKit

// 20_Reverse_Each_Word_Individually

/*
 =====================================================
 Approach:
 Split + Reverse Each Word
 =====================================================

 1. Separate words using space
 2. Reverse each word
 3. Store reversed words
 4. Join all words into sentence
 */


var str = "Hello World"

// Split sentence into words
var words = str.components(separatedBy: " ")

print(words)

// ["Hello", "World"]

var reverseWords = [String]()


// Traverse words
for word in words {
    
    // Convert word into array
    var lettersArray = Array(word)
    
    var left = 0
    var right = lettersArray.count - 1
    
    
    // Reverse word using swap
    while left < right {
        
        lettersArray.swapAt(left, right)
        
        left += 1
        
        right -= 1
    }
    
    
    // Convert array into string
    var reversedWord = ""
    
    for char in lettersArray {
        
        reversedWord += String(char)
    }
    
    
    // Store reversed word
    reverseWords.append(reversedWord)
}


// Build final sentence
var reverseSentence = ""

for word in reverseWords {
    
    reverseSentence += "\(word) "
}

print(reverseSentence)

// Output:
// olleH dlroW


/*
 =====================================================
 Dry Run
 =====================================================

 "Hello World"

 Split:
 ["Hello", "World"]


 Word 1:
 Hello

 Swap:
 o l l e H

 Reversed:
 olleH


 Word 2:
 World

 Swap:
 d l r o W

 Reversed:
 dlroW


 Final Sentence:
 olleH dlroW


 =====================================================
 Time Complexity
 =====================================================

 O(n)

 n = total characters


 =====================================================
 Space Complexity
 =====================================================

 O(n)

 Because arrays and result strings used


 =====================================================
 Why This Is Good For Interview
 =====================================================

 ✅ Word separation
 ✅ Two Pointer reversal
 ✅ Swapping technique
 ✅ String reconstruction
 ✅ Clean modular logic
 */
