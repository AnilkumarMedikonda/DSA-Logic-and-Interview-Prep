import UIKit

// 22_Reverse_Each_Word

/*
 =====================================================
 Method 1:
 Forward Traversal
 (Best For DSA Interview)
 =====================================================
 */


var str1 = "Hello World"

var word = ""

var reverseSentence = ""


// Traverse string
for char in str1 {
    
    
    // Word end
    if char == " " {
        
        var reverseWord = ""
        
        var right = word.count - 1
        
        
        // Reverse current word
        while right >= 0 {
            
            let index = word.index(word.startIndex,
                                   offsetBy: right)
            
            reverseWord += String(word[index])
            
            right -= 1
        }
        
        
        reverseSentence += reverseWord + " "
        
        word = ""
        
    } else {
        
        word += String(char)
    }
}


// Reverse last word
var reverseWord = ""

var right = word.count - 1

while right >= 0 {
    
    let index = word.index(word.startIndex,
                           offsetBy: right)
    
    reverseWord += String(word[index])
    
    right -= 1
}

reverseSentence += reverseWord

print(reverseSentence)

// Output:
// olleH dlroW



/*
 =====================================================
 Time Complexity
 =====================================================

 O(n)


 =====================================================
 Space Complexity
 =====================================================

 O(n)


 =====================================================
 Why This Is Best For Interview
 =====================================================

 ✅ Simple logic
 ✅ Direct traversal
 ✅ Easy dry run
 ✅ Clean word handling
 */



/*
 =====================================================
 Method 2:
 Backward Traversal
 =====================================================
 */


var str2 = "Hello World"

var words = [String]()

var word2 = ""

var i = str2.count - 1


// Traverse from end
while i >= 0 {
    
    let index = str2.index(str2.startIndex,
                           offsetBy: i)
    
    
    // Word end
    if str2[index] == " " {
        
        words.append(word2)
        
        word2 = ""
        
    } else {
        
        word2 += String(str2[index])
    }
    
    i -= 1
}


// Add last word
words.append(word2)

print(words)

// ["dlroW", "olleH"]


var reverseSentence2 = ""

var right2 = words.count - 1


// Restore word order
while right2 >= 0 {
    
    reverseSentence2 += "\(words[right2]) "
    
    right2 -= 1
}

print(reverseSentence2)

// Output:
// olleH dlroW



/*
 =====================================================
 Time Complexity
 =====================================================

 O(n)


 =====================================================
 Space Complexity
 =====================================================

 O(n)


 =====================================================
 Interview Note
 =====================================================
 ✅ Creative logic
 ✅ Good reverse traversal practice

 ❌ More complex
 ❌ Less direct compared to Method 1
 */
