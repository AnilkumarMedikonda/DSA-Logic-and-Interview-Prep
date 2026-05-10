import UIKit

// 19_Reverse_Words_In_Sentence


/*
 =====================================================
 Method 1:
 Prefix Building Approach
 =====================================================

 1. Separate words using space
 2. Add current word before result
 3. Word order becomes reversed
 */


var str1 = "Hello World"

var reverseStr = ""

// Split sentence into words
var words1 = str1.components(separatedBy: " ")

print(words1)

// ["Hello", "World"]


// Reverse word order
for word in words1 {
    
    reverseStr = "\(word) " + reverseStr
}

print("Method 1:", reverseStr)

// Output:
// World Hello


/*
 =====================================================
 Dry Run
 =====================================================

 ["Hello", "World"]

 word = "Hello"

 "Hello " + ""

 result:
 "Hello "


 word = "World"

 "World " + "Hello "

 result:
 "World Hello "


 =====================================================
 Time Complexity
 =====================================================

 O(n²)

 Because prepend operation creates
 new string every iteration


 =====================================================
 Space Complexity
 =====================================================

 O(n)

 Because result string is created


 =====================================================
 Interview Note
 =====================================================

 ✅ Easy beginner logic
 ❌ Less optimized
 */







/*
 =====================================================
 Method 2:
 Reverse Traversal
 (Best Interview Approach)
 =====================================================

 1. Separate words using space
 2. Traverse from end to beginning
 3. Build reversed sentence
 */


var str2 = "Hello World"

// Split sentence into words
var words2 = str2.components(separatedBy: " ")

var result = ""

var i = words2.count - 1

// Reverse traversal
while i >= 0 {
    
    result += words2[i]
    
    if i != 0 {
        result += " "
    }
    
    i -= 1
}

print("Method 2:", result)

// Output:
// World Hello


/*
 =====================================================
 Dry Run
 =====================================================

 ["Hello", "World"]


 i = 1
 add "World"

 result:
 "World"


 i = 0
 add "Hello"

 result:
 "World Hello"


 =====================================================
 Time Complexity
 =====================================================

 O(n)

 n = total characters


 =====================================================
 Space Complexity
 =====================================================

 O(n)

 Because words array and
 result string are used


 =====================================================
 Why This Is Best For Interview
 =====================================================

 ✅ Reverse traversal
 ✅ Optimized approach
 ✅ Clean logic
 ✅ Easy complexity explanation
 ✅ Better than prepend operation
 */
