import UIKit

// 09_Remove_Substring
// Result Building Approach (Best Interview Approach)

/*
 Problem:
 Remove a substring manually without using built-in methods.

 Input:
 str = "HelloWorld"
 removeStr = "World"

 Output:
 "Hello"
 */

var str = "HelloWorld"
var removeStr = "World"

var result = ""

var i = 0

while i < str.count {
    
    var temp = ""
    
    // Create substring manually
    for j in 0..<removeStr.count {
        
        if i + j < str.count {
            
            let index = str.index(str.startIndex, offsetBy: i + j)
            
            temp += String(str[index])
        }
    }
    
    // If substring matches
    if temp == removeStr {
        
        // Skip substring length
        i += removeStr.count
        
    } else {
        
        // Add current character
        let index = str.index(str.startIndex, offsetBy: i)
        
        result += String(str[index])
        
        i += 1
    }
}

print(result)

// Output: Hello


/*
 =====================================================
 Explanation
 =====================================================

 Step 1:
 Traverse string using while loop

 Step 2:
 Create temporary substring manually
 with removeStr length

 Step 3:
 Compare temp with removeStr

 If matched:
 Skip all characters of substring

 Else:
 Add current character into result


 =====================================================
 Dry Run
 =====================================================

 str = "HelloWorld"
 removeStr = "World"

 i = 0
 temp = "Hello"
 ❌ Not Match
 result = "H"

 i = 1
 temp = "elloW"
 ❌ Not Match
 result = "He"

 i = 2
 temp = "lloWo"
 ❌

 i = 3
 temp = "loWor"
 ❌

 i = 4
 temp = "oWorl"
 ❌

 i = 5
 temp = "World"
 ✅ Match Found

 Skip 5 characters

 Final Result:
 "Hello"


 =====================================================
 Why This Approach Is Best For Interview
 =====================================================

 ✅ Manual traversal
 ✅ Sliding window thinking
 ✅ No built-in substring removal
 ✅ Easy to explain
 ✅ Strong DSA logic


 =====================================================
 Time Complexity
 =====================================================

 O(n * m)

 n = main string length
 m = remove substring length


 =====================================================
 Space Complexity
 =====================================================

 O(n)

 Because result string is created
 */
