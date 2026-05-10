import UIKit

// 15_Replace_Character_At_Index

/*
 =====================================================
 Approach:
 Traversal + Result Building
 =====================================================

 1. Traverse string
 2. Check current index
 3. If current index == replace index:
    add newChar
 4. Else:
    add original character
 */


var str = "Swift"

var replaceIndex = 1

var newChar = "W"

var result = ""

// Traverse string
for i in 0..<str.count {
    
 let strIndex = str.index(str.startIndex, offsetBy: i)
    // Replace character
    if i == replaceIndex {
        result += newChar
    } else {
        result += String(str[strIndex])
    }
}

print(result)

// Output: SWift


/*
 =====================================================
 Dry Run
 =====================================================

 Swift

 i = 0
 add S

 i = 1
 replace w with W

 i = 2
 add i

 i = 3
 add f

 i = 4
 add t


 Final Result:
 SWift


 =====================================================
 Time Complexity
 =====================================================

 O(n)

 n = string length


 =====================================================
 Space Complexity
 =====================================================

 O(n)

 Because result string is created
 */
