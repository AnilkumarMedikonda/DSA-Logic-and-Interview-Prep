import UIKit
// ==================================================
// Problem: Check if a number is Palindrome
// Example: 121 → Palindrome
//          123 → Not Palindrome
// ==================================================



// --------------------------------------------------
// Approach 1: Reverse Number (BEST APPROACH ✅)
// --------------------------------------------------

// Approach:
// 1. Store original number
// 2. Reverse number using modulo (% 10)
// 3. Compare reversed with original

// Time Complexity: O(d)
// Space Complexity: O(1)

// ⭐ BEST because:
// - No extra space
// - Direct digit manipulation
// - Most preferred in interviews

var original = 121
var n = original
var reverse = 0

while n > 0 {
    let digit = n % 10
    reverse = reverse * 10 + digit
    n /= 10
}

print("Reversed:", reverse)

if reverse == original {
    print("Palindrome")
} else {
    print("Not Palindrome")
}

print("----------------")



// --------------------------------------------------
// Approach 2: String Reverse
// --------------------------------------------------

// Approach:
// 1. Convert number to string
// 2. Reverse string
// 3. Compare with original string

// Time Complexity: O(d)
// Space Complexity: O(d)

// ❌ Not best: uses extra space

let number = 121
let str = String(number)

if str == String(str.reversed()) {
    print("Palindrome (String)")
} else {
    print("Not Palindrome (String)")
}

print("----------------")



// --------------------------------------------------
// Approach 3: Two Pointer (String)
// --------------------------------------------------

// Approach:
// Compare characters from start and end

// Time Complexity: O(d)
// Space Complexity: O(d)

// ❌ Not best: uses extra space

let chars = Array(str)
var left = 0
var right = chars.count - 1
var isPalindrome = true

while left < right {
    if chars[left] != chars[right] {
        isPalindrome = false
        break
    }
    left += 1
    right -= 1
}

print(isPalindrome ? "Palindrome (Two Pointer)" : "Not Palindrome")
