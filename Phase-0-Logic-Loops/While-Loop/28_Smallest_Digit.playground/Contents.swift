
import UIKit

// ==================================================
// Problem: Find the smallest digit in a number
// Example: 5274 → Smallest Digit = 2
// ==================================================



// --------------------------------------------------
// Approach 1: Modulo Method (BEST APPROACH ✅)
// --------------------------------------------------

// Approach:
// 1. Extract digit using % 10
// 2. Compare with current minimum
// 3. Update minimum
// 4. Remove digit using / 10

// Time Complexity: O(d)
// Space Complexity: O(1)

// ⭐ BEST because:
// - No extra space
// - Direct digit processing

var number = 5274
var temp = number

var minDigit = 9   // max possible digit

while temp > 0 {
    let digit = temp % 10
    
    if digit < minDigit {
        minDigit = digit
    }
    
    temp /= 10
}

print("Smallest Digit ---> \(minDigit)")


print("----------------")



// --------------------------------------------------
// Approach 2: Using Built-in min()
// --------------------------------------------------

var number2 = 5274
var temp2 = number2

var minDigit2 = 9

while temp2 > 0 {
    minDigit2 = min(minDigit2, temp2 % 10)
    temp2 /= 10
}

print("Smallest Digit (min func) ---> \(minDigit2)")


print("----------------")



// --------------------------------------------------
// Approach 3: Using String (Not Recommended ❌)
// --------------------------------------------------

// Time Complexity: O(d)
// Space Complexity: O(d)

let num = 5274
var minDigit3 = 9

for char in String(num) {
    if let digit = Int(String(char)) {
        if digit < minDigit3 {
            minDigit3 = digit
        }
    }
}

print("Smallest Digit (String) ---> \(minDigit3)")
