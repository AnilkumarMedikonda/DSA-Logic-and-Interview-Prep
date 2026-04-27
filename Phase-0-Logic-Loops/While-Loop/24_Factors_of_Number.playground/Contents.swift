import UIKit
// ==================================================
// Problem: Print all factors of a number
// Example: n = 12 → 1 2 3 4 6 12
// ==================================================



// --------------------------------------------------
// Approach 1: Brute Force (While Loop)
// --------------------------------------------------

// Approach:
// 1. Loop from 1 to n
// 2. Check if divisible
// 3. Print factor

// Time Complexity: O(n)
// Space Complexity: O(1)

var number1 = 12
var i = 1

print("Brute Force Factors:")

while i <= number1 {
    if number1 % i == 0 {
        print(i, terminator: " ")
    }
    i += 1
}

print("\n----------------")



// --------------------------------------------------
// Approach 2: Optimized (BEST APPROACH ✅)
// --------------------------------------------------

// Approach:
// 1. Loop from 1 to √n
// 2. If i divides n → print i
// 3. Print pair (n / i)
// 4. Avoid duplicates

// Time Complexity: O(√n)
// Space Complexity: O(1)

// ⭐ BEST because:
// - Uses divisor pairs
// - Much faster than O(n)

let number2 = 12

print("Optimized Factors:")

var j = 1

while j * j <= number2 {
    if number2 % j == 0 {
        print(j, terminator: " ")
        
        let pair = number2 / j
        if pair != j {
            print(pair, terminator: " ")
        }
    }
    j += 1
}
