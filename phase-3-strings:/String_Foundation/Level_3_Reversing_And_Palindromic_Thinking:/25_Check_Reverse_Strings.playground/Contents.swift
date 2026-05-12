import UIKit

// 25_Check_Reverse_Strings

/*
 =====================================================
 Method 1:
 Reverse String And Compare
 =====================================================
 */


var str1 = "abc"

var str2 = "cba"

var right = str2.count - 1

var reverseStr = ""


// Traverse from end
while right >= 0 {
    
    let index = str2.index(str2.startIndex,
                           offsetBy: right)
    
    reverseStr += String(str2[index])
    
    right -= 1
}


// Compare strings
print(str1 == reverseStr
      ? "Reverse Strings"
      : "Not Reverse Strings")


// Output:
// Reverse Strings



/*
 =====================================================
 Dry Run
 =====================================================

 str2 = "cba"

 a -> "a"

 b -> "ab"

 c -> "abc"

 Compare:
 abc == abc

 Result:
 Reverse Strings

 =====================================================
 Time Complexity
 =====================================================

 O(n)
 =====================================================
 Space Complexity
 =====================================================
 O(n)

 Because reverse string created

 =====================================================
 Approach
 =====================================================

 Reverse second string.
 Compare reversed string
 with first string.
 */
