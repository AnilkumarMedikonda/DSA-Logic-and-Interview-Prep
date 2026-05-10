import UIKit

// 31_Check_Palindrome

/*
 =====================================================
 Method 1:
 Reverse String Comparison
 =====================================================

 1. Reverse string manually
 2. Compare original and reversed string
 */


var str1 = "madam"

var reverse = ""


// Reverse string
var i = str1.count - 1

while i >= 0 {
    
    let index = str1.index(str1.startIndex, offsetBy: i)
    
    reverse += String(str1[index])
    
    i -= 1
}

print("Reversed:", reverse)


// Compare strings
if str1 == reverse {
    
    print("Palindrome String")
    
} else {
    
    print("Not Palindrome")
}


/*
 =====================================================
 Dry Run
 =====================================================

 madam

 Reverse:
 madam

 Compare:
 madam == madam
 ✅ Palindrome


 =====================================================
 Time Complexity
 =====================================================

 O(n)


 =====================================================
 Space Complexity
 =====================================================

 O(n)

 Because reversed string created


 =====================================================
 Interview Note
 =====================================================

 ✅ Easy beginner logic
 ❌ Extra space used
 */


// =====================================================
// Method 2:
// Two Pointer Technique
// (Best Interview Approach)
// =====================================================

/*
 1. Use left & right pointers
 2. Compare characters
 3. Move pointers inward
 4. Stop if mismatch found
 */


var str2 = "madam"

var left = 0

var right = str2.count - 1

var isPalindrome = true


// Compare characters
while left < right {
    
    let leftIndex = str2.index(str2.startIndex, offsetBy: left)
    
    let rightIndex = str2.index(str2.startIndex, offsetBy: right)
    
    
    // Mismatch found
    if str2[leftIndex] != str2[rightIndex] {
        
        isPalindrome = false
        
        break
    }
    
    left += 1
    
    right -= 1
}


// Result
if isPalindrome {
    
    print("Palindrome String")
    
} else {
    
    print("Not Palindrome")
}


/*
 =====================================================
 Dry Run
 =====================================================

 madam

 left = 0 -> m
 right = 4 -> m
 ✅ Match

 left = 1 -> a
 right = 3 -> a
 ✅ Match

 Middle reached

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

 No extra string created


 =====================================================
 Why This Is Best For Interview
 =====================================================

 ✅ Two Pointer Pattern
 ✅ Optimized space
 ✅ Early mismatch detection
 ✅ Strong DSA logic
 */
