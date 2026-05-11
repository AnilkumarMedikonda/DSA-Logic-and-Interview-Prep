import UIKit

// 07_Concatenate_Two_Strings

var str1 = "Hello"

var str2 = "World"

var result = ""


// Add first string
for char in str1 {
    
    result += String(char)
}


// Add second string
for char in str2 {
    result += String(char)
}

print(result)

// Output:
// HelloWorld



/*
 =====================================================
 Dry Run
 =====================================================

 str1:
 H -> He -> Hel -> Hell -> Hello


 str2:
 W -> Wo -> Wor -> Worl -> World


 Final Result:
 HelloWorld


 =====================================================
 Time Complexity
 =====================================================

 O(n + m)

 n = str1 length
 m = str2 length


 =====================================================
 Space Complexity
 =====================================================

 O(n + m)

 Because result string created


 =====================================================
 Approach
 =====================================================

 Traverse both strings.

 Append characters one by one
 into result string.
 */
