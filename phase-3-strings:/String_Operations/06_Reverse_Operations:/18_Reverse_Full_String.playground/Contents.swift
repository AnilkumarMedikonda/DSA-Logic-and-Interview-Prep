import UIKit

// 18_Reverse_Full_String

// 18_Reverse_Full_String

/*
 =====================================================
 Method 1:
 Prefix Building Approach
 =====================================================

 1. Traverse string
 2. Add current character
    before existing result
 */


var str1 = "Swift"

var reverseStr = ""

// Traverse string
for char in str1 {
    reverseStr = "\(char)" + reverseStr
}

print(reverseStr)

// Output: tfiwS


/*
 =====================================================
 Dry Run
 =====================================================

 Swift

 S + ""
 result = "S"

 w + "S"
 result = "wS"

 i + "wS"
 result = "iwS"

 f + "iwS"
 result = "fiwS"

 t + "fiwS"
 result = "tfiwS"


 =====================================================
 Time Complexity
 =====================================================

 O(n²)

 Because string prepend operation
 creates new string every iteration


 =====================================================
 Space Complexity
 =====================================================

 O(n)

 Because result string is created
 */





/*
 =====================================================
 Method 2:
 Fully Manual Reverse Traversal
 =====================================================

 1. Start from last index
 2. Move backward manually
 3. Add characters into result
 */


var str2 = "Swift"

var result = ""

var i = str2.count - 1

while i >= 0 {
    let index = str2.index(str2.startIndex, offsetBy: i)
    result += String(str2[index])
    i -= 1
}

print(result)

// Output: tfiwS


/*
 =====================================================
 Dry Run
 =====================================================

 Swift

 i = 4 -> t
 result = "t"

 i = 3 -> f
 result = "tf"

 i = 2 -> i
 result = "tfi"

 i = 1 -> w
 result = "tfiw"

 i = 0 -> S
 result = "tfiwS"


 =====================================================
 Time Complexity
 =====================================================

 O(n)


 =====================================================
 Space Complexity
 =====================================================

 O(n)

 Because result string is created
 */


// =====================================================
// Interview Recommendation
// =====================================================

/*
 Method 1:
 Easy logic but less optimized

 Method 2:
 Better DSA interview approach
 because reverse traversal is efficient
 and avoids prepend operations
 */



var str = "Swift"
var chars = Array(str)
var l = 0
var r = chars.count - 1


while l < r {
    let temp = chars[l]
    chars[l] = chars[r]
    chars[r] = temp
     l += 1
     r -= 1
}

var resultValue = ""

for cha in chars {
    resultValue += "\(cha)"
}

print(resultValue)
