import UIKit

import UIKit

// ==================================================
// Problem: Count number of digits in a number
// Example: 1234 → 4 digits
// ==================================================



// --------------------------------------------------
// Approach 1: Modulo (Best Approach)
// --------------------------------------------------

// Approach:
// 1. Take number n
// 2. Initialize count = 0
// 3. Extract last digit using n % 10
// 4. Remove digit using n / 10
// 5. Increment count
// 6. Repeat until n becomes 0

// Time Complexity: O(d)
// d = number of digits

// Space Complexity: O(1)

var n = 1234
var count = 0

print("Modulo Approach:")

while n > 0 {
    count += 1
    n /= 10
}

print("Digits count:", count)


print("----------------")



// --------------------------------------------------
// Approach 2: String Conversion
// --------------------------------------------------

// Approach:
// 1. Convert number to string
// 2. Count characters

// Time Complexity: O(d)

// Space Complexity: O(d)

let number = 1234
let str = String(number)

let count2 = str.count

print("String Approach:")
print("Digits count:", count2)
