import UIKit

// 23_Reverse_Word_Order

var str = "Hello Swift World"

var words = [String]()

var word = ""

var reverseSentence = ""


// Traverse string
for char in str {
    
    // Word end
    if char == " " {
        
        words.append(word)
        
        word = ""
        
    } else {
        
        word += String(char)
    }
}


// Add last word
words.append(word)

print(words)

// ["Hello", "Swift", "World"]


var i = words.count - 1


// Reverse word order
while i >= 0 {
    
    reverseSentence += "\(words[i]) "
    
    i -= 1
}

print(reverseSentence)

// Output:
// World Swift Hello



/*
 =====================================================
 Dry Run
 =====================================================

 Hello Swift World


 Build:
 Hello


 Space found:
 append "Hello"


 Build:
 Swift


 Space found:
 append "Swift"


 Build:
 World


 Final Array:
 ["Hello", "Swift", "World"]


 Reverse Traversal:
 World Swift Hello


 =====================================================
 Time Complexity
 =====================================================

 O(n)


 =====================================================
 Space Complexity
 =====================================================

 O(n)

 Because words array used


 =====================================================
 Approach
 =====================================================

 Build words manually.

 Store words in array.

 Traverse array backward
 to reverse word order.
 */
