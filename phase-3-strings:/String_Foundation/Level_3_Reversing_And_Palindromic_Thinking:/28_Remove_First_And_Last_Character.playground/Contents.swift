import UIKit

// 28_Remove_First_And_Last_Character
var str = "Swift"
var newStr = ""

// Start after first character
var left = 1

// Stop before last character
var right = str.count - 2

// Traverse middle portion
while left <= right {
    
    let index = str.index(str.startIndex, offsetBy: left)
    newStr += String(str[index])
    
    left += 1
}

print(newStr)

// Output:
// wif

/*
 =====================================================
 Dry Run
 =====================================================

 Swift

 Skip:
 S
 t

 Remaining:
 w i f

 Final Output:
 wif

 =====================================================
 Time Complexity
 =====================================================

 O(n)

 =====================================================
 Space Complexity
 =====================================================

 O(n)

 Because new string created

 =====================================================
 Approach
 =====================================================

 Skip first and last indexes.
 Traverse remaining characters
 and build new string.
 */
