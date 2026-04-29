import UIKit

// ==================================================
// Problem: Sum of digits of a number
// Example: 12345 → 1 + 2 + 3 + 4 + 5 = 15
// ==================================================



// --------------------------------------------------
// Approach 1: Modulo (BEST APPROACH ✅)
// --------------------------------------------------

// Approach:
// 1. Extract last digit using n % 10
// 2. Add digit to sum
// 3. Remove last digit using n / 10
// 4. Repeat until n becomes 0

// Time Complexity: O(d)
// Space Complexity: O(1)

// ⭐ BEST because:
// - No extra space
// - Direct digit manipulation
// - Most efficient

var number = 12345
var sum = 0

while number > 0 {
    let digit = number % 10
    sum += digit
    number /= 10
}

print("Modulo Sum:", sum)


print("----------------")



// --------------------------------------------------
// Approach 2: String Conversion
// --------------------------------------------------

// Approach:
// 1. Convert number to string
// 2. Iterate characters
// 3. Convert each to digit
// 4. Add to sum

// Time Complexity: O(d)
// Space Complexity: O(d)

// ❌ Not best: uses extra space

let num = 12345
var sum2 = 0

for char in String(num) {
    if let digit = Int(String(char)) {
        sum2 += digit
    }
}

print("String Sum:", sum2)


print("----------------")



// --------------------------------------------------
// Approach 3: Recursion
// --------------------------------------------------

// Approach:
// 1. Take last digit (n % 10)
// 2. Add recursive result of remaining digits

// Time Complexity: O(d)
// Space Complexity: O(d) (call stack)

// ❌ Not best: uses extra space

func sumDigits(_ n: Int) -> Int {
    if n == 0 { return 0 }
    return (n % 10) + sumDigits(n / 10)
}

print("Recursive Sum:", sumDigits(12345))


print("----------------")



// --------------------------------------------------
// Approach 4: Functional (Reduce)
// --------------------------------------------------

// Approach:
// Convert to string → map digits → reduce

// Time Complexity: O(d)
// Space Complexity: O(d)

// ❌ Not best: extra memory + conversions

let sum4 = String(12345)
    .compactMap { Int(String($0)) }
    .reduce(0, +)

print("Functional Sum:", sum4)
