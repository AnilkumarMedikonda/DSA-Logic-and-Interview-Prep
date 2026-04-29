import UIKit

// ==================================================
// Problem: Find sum of all factors of a number
// Example: n = 12 → Factors: 1 2 3 4 6 12 → Sum = 28
// ==================================================



// --------------------------------------------------
// Approach 1: Brute Force (While Loop)
// --------------------------------------------------

// Approach:
// 1. Loop from 1 to n
// 2. Check divisibility
// 3. Add factor to sum

// Time Complexity: O(n)
// Space Complexity: O(1)

var number1 = 12
var i1 = 1
var sum1 = 0

while i1 <= number1 {
    if number1 % i1 == 0 {
        sum1 += i1
    }
    i1 += 1
}

print("Brute Sum ---> \(sum1)")

print("----------------")



// --------------------------------------------------
// Approach 2: Optimized (BEST APPROACH ✅)
// --------------------------------------------------

// Approach:
// 1. Loop till √n
// 2. Add i if it divides n
// 3. Add pair (n / i)
// 4. Avoid duplicates when i == n/i

// Time Complexity: O(√n)
// Space Complexity: O(1)

// ⭐ BEST because:
// - Uses divisor pairs
// - Much faster than O(n)

var number2 = 12
var i2 = 1
var sum2 = 0

while i2 * i2 <= number2 {
    
    if number2 % i2 == 0 {
        sum2 += i2
        
        let pair = number2 / i2
        
        if pair != i2 {   // avoid duplicate
            sum2 += pair
        }
    }
    
    i2 += 1
}

print("Optimized Sum ---> \(sum2)")
