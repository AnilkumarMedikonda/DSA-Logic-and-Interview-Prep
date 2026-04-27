import UIKit


// ==================================================
// Problem: Find product of digits of a number
// Example: 1234 → 1 × 2 × 3 × 4 = 24
// ==================================================

// --------------------------------------------------
// Approach 1: Modulo (Best Approach)
// --------------------------------------------------

// Approach:
// 1. Take number n
// 2. Extract last digit using n % 10
// 3. Multiply with result
// 4. Remove last digit using n / 10
// 5. Repeat until n becomes 0

// Time Complexity: O(d)
// d = number of digits

// Space Complexity: O(1)
// No extra space used

var n = 1234
var result = 1

print("Modulo Approach:")

while n > 0 {
    let digit = n % 10
    result *= digit
    n /= 10
}

print("Product:", result)


print("----------------")



// --------------------------------------------------
// Approach 2: String Conversion
// --------------------------------------------------

// Approach:
// 1. Convert number to string
// 2. Iterate through each character
// 3. Convert character to digit
// 4. Multiply with result

// Time Complexity: O(d)

// Space Complexity: O(d)
// Extra space used for string

let number = 1234
let str = String(number)
var result2 = 1

print("String Approach:")

for char in str {
    if let digit = Int(String(char)) {
        result2 *= digit
    }
}

print("Product:", result2)
