
import UIKit

// ==================================================
// Problem: Find the largest digit in a number
// Example: 5274 → Largest Digit = 7
// ==================================================



// --------------------------------------------------
// Approach 1: Modulo Method (BEST APPROACH ✅)
// --------------------------------------------------

// Approach:
// 1. Extract digit using % 10
// 2. Compare with current maximum
// 3. Update maximum
// 4. Remove digit using / 10

// Time Complexity: O(d)
// Space Complexity: O(1)

// ⭐ BEST because:
// - No extra space
// - Direct digit processing

var number = 5274
var temp = number

var maxDigit = 0   // minimum possible digit

while temp > 0 {
    let digit = temp % 10
    
    if digit > maxDigit {
        maxDigit = digit
    }
    
    temp /= 10
}

print("Largest Digit ---> \(maxDigit)")


print("----------------")



// --------------------------------------------------
// Approach 2: Using Built-in max()
// --------------------------------------------------

var number2 = 5274
var temp2 = number2

var maxDigit2 = 0

while temp2 > 0 {
    maxDigit2 = max(maxDigit2, temp2 % 10)
    temp2 /= 10
}

print("Largest Digit (max func) ---> \(maxDigit2)")


print("----------------")



// --------------------------------------------------
// Approach 3: Using String (Not Recommended ❌)
// --------------------------------------------------

// Time Complexity: O(d)
// Space Complexity: O(d)

let num = 5274
var maxDigit3 = 0

for char in String(num) {
    if let digit = Int(String(char)) {
        if digit > maxDigit3 {
            maxDigit3 = digit
        }
    }
}

print("Largest Digit (String) ---> \(maxDigit3)")
