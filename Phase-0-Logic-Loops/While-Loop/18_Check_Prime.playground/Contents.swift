import UIKit

// ==================================================
// Problem: Check if a number is Prime Number
// Example: 5 → Prime
//          6 → Not Prime
// ==================================================



// --------------------------------------------------
// Approach 1: Brute Force (While Loop)
// --------------------------------------------------

// Approach:
// 1. Start from i = 2
// 2. Check divisibility till number - 1
// 3. If divisible → Not Prime
// 4. Else → Prime

// Time Complexity: O(n)
// Space Complexity: O(1)

var number1 = 6

if number1 <= 1 {
    print("Not Prime (Brute)")
} else {
    
    var i = 2
    var isPrime = true
    
    while i < number1 {
        if number1 % i == 0 {
            isPrime = false
            break
        }
        i += 1
    }
    
    print(isPrime ? "Prime (Brute)" : "Not Prime (Brute)")
}

print("----------------")



// --------------------------------------------------
// Approach 2: Optimized (BEST APPROACH ✅)
// --------------------------------------------------

// Approach:
// 1. Check divisibility only till √n
// 2. If any divisor found → Not Prime
// 3. Else → Prime

// Time Complexity: O(√n)
// Space Complexity: O(1)

// ⭐ BEST because:
// - Fewer iterations
// - Faster than brute force
// - Standard interview solution

var number2 = 5

if number2 <= 1 {
    print("Not Prime (Optimized)")
} else {
    var i = 2
    var isPrime = true
    while i * i <= number2 {
        if number2 % i == 0 {
            isPrime = false
            break
        }
        i += 1
    }
    print(isPrime ? "Prime (Optimized)" : "Not Prime (Optimized)")
}
