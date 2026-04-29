import UIKit
// ==================================================
// Problem: Check if a number is Perfect Number
// ==================================================


// --------------------------------------------------
// Approach 1: While Loop (Brute Force)
// --------------------------------------------------

// Approach:
// 1. Start from i = 1
// 2. Loop till i < number
// 3. If divisible → add to sum
// 4. Compare sum with number

// Time Complexity: O(n)
// Space Complexity: O(1)

var number = 28
var i = 1
var sum = 0

while i < number {
    if number % i == 0 {
        sum += i
    }
    i += 1
}

print(sum == number ? "Perfect (While)" : "Not Perfect (While)")


print("----------------")



// --------------------------------------------------
// Approach 2: For Loop (Brute Force)
// --------------------------------------------------

// Time Complexity: O(n)
// Space Complexity: O(1)

let number2 = 28
var sum2 = 0

for i in 1..<number2 {
    if number2 % i == 0 {
        sum2 += i
    }
}

print(sum2 == number2 ? "Perfect (For)" : "Not Perfect (For)")


print("----------------")



// --------------------------------------------------
// Approach 3: Optimized (BEST APPROACH ✅)
// --------------------------------------------------

// Approach:
// 1. Loop till √n
// 2. Add both divisors (i and n/i)
// 3. Avoid duplicates

// Time Complexity: O(√n)
// Space Complexity: O(1)

// ⭐ BEST because:
// - Fewer iterations
// - Efficient divisor pairing

let number3 = 28
var sum3 = 1   // 1 is always a divisor

var j = 2

while j <= Int(sqrt(Double(number3))) {
    if number3 % j == 0 {
        sum3 += j
        
        let pair = number3 / j
        if pair != j {
            sum3 += pair
        }
    }
    j += 1
}

print(sum3 == number3 ? "Perfect (Optimized)" : "Not Perfect (Optimized)")
