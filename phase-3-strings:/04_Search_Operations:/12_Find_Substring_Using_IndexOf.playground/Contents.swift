import UIKit

// 12_Find_Substring_Using_IndexOf

/*
 =====================================================
 Approach:
 Sliding Window Pattern
 =====================================================

 1. Traverse the main string
 2. Create substring manually
    with findStr length
 3. Compare temp with findStr
 4. If matched:
    store current index
    and stop loop
 */


var str = "HelloWorld"
var findStr = "World"

var foundIndex = -1

// Traverse string
for i in 0..<str.count {
    
    var temp = ""
    
    // Create substring manually
    for j in 0..<findStr.count {
        if i + j < str.count {
            let index = str.index(str.startIndex, offsetBy: i + j)
            temp += String(str[index])
        }
    }
    
    // Match found
    if temp == findStr {
        foundIndex = i
        break
    }
}

print(foundIndex)

// Output: 5


/*
 =====================================================
 Dry Run
 =====================================================

 str = "HelloWorld"
 findStr = "World"

 i = 0
 temp = "Hello"
 ❌

 i = 1
 temp = "elloW"
 ❌

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

 foundIndex = 5


 =====================================================
 Time Complexity
 =====================================================

 O(n * m)

 n = main string length
 m = substring length


 =====================================================
 Space Complexity
 =====================================================

 O(m)

 Because temporary substring is created
 */
