import UIKit

// 19_Count_Words_Start_With_Vowel

/*
 =====================================================
 Method 1:
 Using components()
 =====================================================
 */


var str1 = "Apple is orange umbrella"

var words = str1.components(separatedBy: " ")

var count1 = 0


// Traverse words
for word in words {
    
    let firstLetter = "\(word.first ?? " ")".uppercased()
    
    // Check vowels
    if firstLetter == "A" ||
       firstLetter == "E" ||
       firstLetter == "I" ||
       firstLetter == "O" ||
       firstLetter == "U" {
        count1 += 1
    }
}

print(count1)

// Output:
// 4



/*
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
 Interview Note
 =====================================================

 ✅ Easy to understand
 ✅ Short code

 ❌ Uses predefined functions
 */


// =====================================================
// Method 2:
// Manual Traversal
// (Best For DSA Interview)
// =====================================================

var str2 = "Apple is orange umbrella"

var count2 = 0


// Traverse string
for i in 0..<str2.count {
    
    let index = str2.index(str2.startIndex,
                           offsetBy: i)
    
    let currentChar = str2[index]
    
    
    // Word start
    if i == 0 ||
       str2[str2.index(before: index)] == " " {
        
        
        // Check vowels
        if currentChar == "a" || currentChar == "e" ||
           currentChar == "i" || currentChar == "o" ||
           currentChar == "u" || currentChar == "A" ||
           currentChar == "E" || currentChar == "I" ||
           currentChar == "O" || currentChar == "U" {
            count2 += 1
        }
    }
}

print(count2)

// Output:
// 4



/*
 =====================================================
 Dry Run
 =====================================================

 Apple is orange umbrella


 A -> vowel word -> 1

 i -> vowel word -> 2

 o -> vowel word -> 3

 u -> vowel word -> 4


 =====================================================
 Time Complexity
 =====================================================

 O(n)


 =====================================================
 Space Complexity
 =====================================================

 O(1)


 =====================================================
 Why This Is Best For Interview
 =====================================================

 ✅ Manual traversal
 ✅ Word boundary logic
 ✅ No predefined split functions
 ✅ Better DSA practice
 */
