import UIKit

// 24_Check_Palindrome

/*
 =====================================================
 Method 1:
 Reverse String And Compare
 =====================================================
 */


var str = "madam"

var reverseStr = ""

var i = str.count - 1


// Reverse string
while i >= 0 {
    
    let index = str.index(str.startIndex,
                          offsetBy: i)
    
    reverseStr += String(str[index])
    
    i -= 1
}


// Compare
print(str == reverseStr
      ? "Palindrome"
      : "Not Palindrome")


// Output:
// Palindrome



/*
 =====================================================
 Time Complexity
 =====================================================

 O(n)


 =====================================================
 Space Complexity
 =====================================================

 O(n)

 Because reverse string created
 */



/*
 =====================================================
 Method 2:
 Two Pointer
 (Best For DSA Interview)
 =====================================================
 */


var left = 0

var right = str.count - 1

var isPalindrome = true


// Compare from both ends
while left < right {
    
    let leftIndex = str.index(str.startIndex,
                              offsetBy: left)
    
    let rightIndex = str.index(str.startIndex,
                               offsetBy: right)
    
    // Mismatch found
    if str[leftIndex] != str[rightIndex] {
        isPalindrome = false
        break
    }
    
    
    left += 1
    
    right -= 1
}

print(isPalindrome
      ? "Palindrome"
      : "Not Palindrome")


// Output:
// Palindrome



/*
 =====================================================
 Dry Run
 =====================================================

 madam


 m == m

 a == a

 d == d


 All matched

 Result:
 Palindrome


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

 ✅ Two Pointer pattern
 ✅ Optimized approach
 ✅ No extra string needed
 ✅ Standard DSA technique
 */
